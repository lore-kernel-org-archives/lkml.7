Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B549C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D6220665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfGVM0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:26:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:41638 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfGVM0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:26:07 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hpXOG-0001lV-Ct; Mon, 22 Jul 2019 15:26:04 +0300
Subject: Re: [PATCH] [v3] page flags: prioritize kasan bits over last-cpuid
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20190722115520.3743282-1-arnd@arndb.de>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <40fa8d23-e53e-48c3-a2d9-1d1f8ecee0c1@virtuozzo.com>
Date:   Mon, 22 Jul 2019 15:26:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722115520.3743282-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/19 2:55 PM, Arnd Bergmann wrote:
> ARM64 randdconfig builds regularly run into a build error, especially
> when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
> 
>  #error "KASAN: not enough bits in page flags for tag"
> 
> The last-cpuid bits are already contitional on the available space,
> so the result of the calculation is a bit random on whether they
> were already left out or not.
> 
> Adding the kasan tag bits before last-cpuid makes it much more likely
> to end up with a successful build here, and should be reliable for
> randconfig at least, as long as that does not randomize NR_CPUS
> or NODES_SHIFT but uses the defaults.
> 
> In order for the modified check to not trigger in the x86 vdso32 code
> where all constants are wrong (building with -m32), enclose all the
> definitions with an #ifdef.
> 
> Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
> Link: https://lore.kernel.org/lkml/20190618095347.3850490-1-arnd@arndb.de/
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
