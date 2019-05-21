Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7334C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CFD208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfEUPnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:43:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:37486 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfEUPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:43:43 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hT6vS-00073c-UC; Tue, 21 May 2019 18:43:39 +0300
Subject: Re: [PATCH v2] mm/kasan: Print frame description for stack bugs
To:     Marco Elver <elver@google.com>, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
References: <20190520154751.84763-1-elver@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <ebec4325-f91b-b392-55ed-95dbd36bbb8e@virtuozzo.com>
Date:   Tue, 21 May 2019 18:43:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190520154751.84763-1-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/19 6:47 PM, Marco Elver wrote:

> +static void print_decoded_frame_descr(const char *frame_descr)
> +{
> +	/*
> +	 * We need to parse the following string:
> +	 *    "n alloc_1 alloc_2 ... alloc_n"
> +	 * where alloc_i looks like
> +	 *    "offset size len name"
> +	 * or "offset size len name:line".
> +	 */
> +
> +	char token[64];
> +	unsigned long num_objects;
> +
> +	if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +				  &num_objects))
> +		return;
> +
> +	pr_err("\n");
> +	pr_err("this frame has %lu %s:\n", num_objects,
> +	       num_objects == 1 ? "object" : "objects");
> +
> +	while (num_objects--) {
> +		unsigned long offset;
> +		unsigned long size;
> +
> +		/* access offset */
> +		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +					  &offset))
> +			return;
> +		/* access size */
> +		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +					  &size))
> +			return;
> +		/* name length (unused) */
> +		if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
> +			return;
> +		/* object name */
> +		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +					  NULL))
> +			return;
> +
> +		/* Strip line number, if it exists. */

   Why?

> +		strreplace(token, ':', '\0');
> +

...

> +
> +	aligned_addr = round_down((unsigned long)addr, sizeof(long));
> +	mem_ptr = round_down(aligned_addr, KASAN_SHADOW_SCALE_SIZE);
> +	shadow_ptr = kasan_mem_to_shadow((void *)aligned_addr);
> +	shadow_bottom = kasan_mem_to_shadow(end_of_stack(current));
> +
> +	while (shadow_ptr >= shadow_bottom && *shadow_ptr != KASAN_STACK_LEFT) {
> +		shadow_ptr--;
> +		mem_ptr -= KASAN_SHADOW_SCALE_SIZE;
> +	}
> +
> +	while (shadow_ptr >= shadow_bottom && *shadow_ptr == KASAN_STACK_LEFT) {
> +		shadow_ptr--;
> +		mem_ptr -= KASAN_SHADOW_SCALE_SIZE;
> +	}
> +

I suppose this won't work if stack grows up, which is fine because it grows up only on parisc arch.
But "BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROUWSUP))" somewhere wouldn't hurt.


