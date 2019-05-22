Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2AAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5FA20675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfEVMTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:19:16 -0400
Received: from relay.sw.ru ([185.231.240.75]:49986 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfEVMTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:19:15 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hTQDA-0003Xw-1H; Wed, 22 May 2019 15:19:12 +0300
Subject: Re: [PATCH v3] mm/kasan: Print frame description for stack bugs
To:     Marco Elver <elver@google.com>, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
References: <20190522100048.146841-1-elver@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e607a134-bea0-f662-2aa7-4755708c8aa5@virtuozzo.com>
Date:   Wed, 22 May 2019 15:19:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190522100048.146841-1-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 1:00 PM, Marco Elver wrote:
> This adds support for printing stack frame description on invalid stack
> accesses. The frame description is embedded by the compiler, which is
> parsed and then pretty-printed.
> 
> Currently, we can only print the stack frame info for accesses to the
> task's own stack, but not accesses to other tasks' stacks.
> 
> Example of what it looks like:
> 
> [   17.924050] page dumped because: kasan: bad access detected
> [   17.924908]
> [   17.925153] addr ffff8880673ef98a is located in stack of task insmod/2008 at offset 106 in frame:
> [   17.926542]  kasan_stack_oob+0x0/0xf5 [test_kasan]
> [   17.927932]
> [   17.928206] this frame has 2 objects:
> [   17.928783]  [32, 36) 'i'
> [   17.928784]  [96, 106) 'stack_array'
> [   17.929216]
> [   17.930031] Memory state around the buggy address:
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198435
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
