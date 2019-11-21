Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA8FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E112F206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKUWWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:22:21 -0500
Received: from relay.sw.ru ([185.231.240.75]:56098 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKUWWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:22:21 -0500
Received: from [192.168.15.154]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iXuq2-0007vl-St; Fri, 22 Nov 2019 01:22:11 +0300
Subject: Re: [PATCH v4 1/2] kasan: detect negative size in memory operation
 function
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <b2ba5228-dec0-9acf-49e9-d57f156814ef@virtuozzo.com>
Date:   Fri, 22 Nov 2019 01:20:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/19 9:53 AM, Walter Wu wrote:
> KASAN missed detecting size is a negative number in memset(), memcpy(),
> and memmove(), it will cause out-of-bounds bug. So needs to be detected
> by KASAN.
> 
> If size is a negative number, then it has a reason to be defined as
> out-of-bounds bug type.
> Casting negative numbers to size_t would indeed turn up as
> a large size_t and its value will be larger than ULONG_MAX/2,
> so that this can qualify as out-of-bounds.
> 
> KASAN report is shown below:
> 
>  BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
>  Read of size 18446744073709551608 at addr ffffff8069660904 by task cat/72
> 
>  CPU: 2 PID: 72 Comm: cat Not tainted 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   dump_backtrace+0x0/0x288
>   show_stack+0x14/0x20
>   dump_stack+0x10c/0x164
>   print_address_description.isra.9+0x68/0x378
>   __kasan_report+0x164/0x1a0
>   kasan_report+0xc/0x18
>   check_memory_region+0x174/0x1d0
>   memmove+0x34/0x88
>   kmalloc_memmove_invalid_size+0x70/0xa0
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
> 
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
