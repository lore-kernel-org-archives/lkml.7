Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43FFC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923E120862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aziml0Df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfEYPd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 11:33:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58770 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfEYPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 11:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WbqNo38oKnDgLfSlhou/YoifuG7iR4GfTM4BUKO+d6k=; b=Aziml0Df0lZtGqU4JQOokX4zeR
        W84UhKbObsOL6zhpEJztqvHhfHJiX1SE+rFAwG8XC7jNWzineA9cArXQvuYmMQxcq7ea7sEOLYLg+
        KSsYL+jkmVP2/jNyJgXgQzKDsmQU8QfgZXIKHL/MCgA1QsJJ20n2GzGmaMgDUOLm9ScDjzmxIV2wA
        rU93BaaR3mFTlUXz7dE+b3GSQNWfQhXaY77rHjTD+NLb55urKX10c9bTW48hfHL24tspy6aiUb0MA
        6FzB6TlYhpvEny2/wQPl6yvV3Jz6l+rZo3XgmDdJkrhJRl7J6rp8Rp0zOMYzqKkkbTF061YaC+9Xo
        yw0rxJYg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUYfb-0005u5-Bb; Sat, 25 May 2019 15:33:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: lib/test_overflow.c causes WARNING and tainted kernel
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <9fa84db9-084b-cf7f-6c13-06131efb0cfa@infradead.org>
 <CAGXu5j+yRt_yf2CwvaZDUiEUMwTRRiWab6aeStxqodx9i+BR4g@mail.gmail.com>
Message-ID: <e2646ac0-c194-4397-c021-a64fa2935388@infradead.org>
Date:   Sat, 25 May 2019 08:33:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+yRt_yf2CwvaZDUiEUMwTRRiWab6aeStxqodx9i+BR4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/19 7:53 PM, Kees Cook wrote:
> Hi!
> 
> On Wed, Mar 13, 2019 at 2:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> This is v5.0-11053-gebc551f2b8f9, MAR-12 around 4:00pm PT.
>>
>> In the first test_kmalloc() in test_overflow_allocation():
>>
>> [54375.073895] test_overflow: ok: (s64)(0 << 63) == 0
>> [54375.074228] WARNING: CPU: 2 PID: 5462 at ../mm/page_alloc.c:4584 __alloc_pages_nodemask+0x33f/0x540
>> [...]
>> [54375.079236] ---[ end trace 754acb68d8d1a1cb ]---
>> [54375.079313] test_overflow: kmalloc detected saturation
> 
> Yup! This is expected and operating as intended: it is exercising the
> allocator's detection of insane allocation sizes. :)
> 
> If we want to make it less noisy, perhaps we could add a global flag
> the allocators could check before doing their WARNs?
> 
> -Kees

I didn't like that global flag idea.  I also don't like the kernel becoming
tainted by this test.

Would it make sense to change the WARN_ON_ONCE() to a call to warn_alloc()
instead?  or use a plain raw printk_once()?

warn_alloc() does the _NOWARN check and does rate limiting.


--- lnx-51-rc2.orig/mm/page_alloc.c
+++ lnx-51-rc2/mm/page_alloc.c
@@ -4581,7 +4581,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, u
 	 * so bail out early if the request is out of bound.
 	 */
 	if (unlikely(order >= MAX_ORDER)) {
-		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
+		warn_alloc(gfp_mask, NULL,
+				"page allocation failure: order:%u", order);
 		return NULL;
 	}
 


-- 
~Randy
