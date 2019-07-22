Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C68C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EC7216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="x4c1PalM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfGVTia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:38:30 -0400
Received: from vern.gendns.com ([98.142.107.122]:35662 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfGVTia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LvrizSarOsPAb9vVguaC1c4EvHZiUvxBbSJXBNo806k=; b=x4c1PalMLmb8KUFfxSJm/lArFZ
        dnwLGVd2J3S6mppK2s8QEl2Vv7AFYyYRClfoOIb1hekQzkFl7bzLZUptxb/Sd8sx1P8vfm2PqxLaB
        qXfUiqAajT/Ey98TlS77KIrQ5cmJSUD4UpHxUY7ippIHI5LoWiC5ErEJk+TY13XefBPf+NwFoQbti
        BsLk+6EJJGObuYxYCCHc93EfpIaw3pBq3d9+Dnk5I8L2whAqzvN7OnpRXc7frOzhWjs2TrkhSBXf+
        QCEQiBDo1w9cS2drB8hhICauaYLW6iqCmEGycgr7IgfGeygnK6Z4tbg6U2XX+t0WFmA4Sy4M73DU9
        wSXvKBBQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51322 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hpe8h-007Oce-4U; Mon, 22 Jul 2019 15:38:27 -0400
Subject: Re: [v5.3-rc1 regression] Hitting a kernel BUG() when trying to load
 a module on DaVinci SoC
To:     Jessica Yu <jeyu@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Jian Cheng <cj.chengjian@huawei.com>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Adam Ford <aford173@gmail.com>
References: <CAMRc=MdaLPcy4fJOEbcXAriHLHrXUZD6Bh5X2Eq+2OBvcC4cOQ@mail.gmail.com>
 <20190722161006.GA4297@linux-8ccs>
From:   David Lechner <david@lechnology.com>
Message-ID: <b822e119-2f80-6aa1-cd45-93cdd6cb2680@lechnology.com>
Date:   Mon, 22 Jul 2019 14:38:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722161006.GA4297@linux-8ccs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/19 11:10 AM, Jessica Yu wrote:
> +++ Bartosz Golaszewski [22/07/19 14:12 +0200]:
>> Hi,
>>
>> with v5.3-rc1 I'm hitting the following BUG() when trying to load the
>> gpio-backlight module:
>>
>> kernel BUG at kernel/module.c:1919!
>> Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: systemd Tainted: G        W
>> 5.2.0-rc2-00005-g7dabaa5ce05a #19
>> Hardware name: DaVinci DA850/OMAP-L138/AM18x EVM
>> PC is at frob_text.constprop.16+0x2c/0x34
>> LR is at load_module+0x1888/0x21b4
>> pc : [<c0081bbc>]    lr : [<c0083c4c>]    psr: 20000013
>> sp : c6837e58  ip : c6b4fa80  fp : bf00574c
>> r10: c0601008  r9 : bf005740  r8 : c0493e38
>> r7 : c00807f8  r6 : 00000000  r5 : 00000001  r4 : c6837f38
>> r3 : 00000fff  r2 : bf000000  r1 : 00004b80  r0 : bf005818
>> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 0005317f  Table: c6b78000  DAC: 00000051
>> Process systemd (pid: 1, stack limit = 0x(ptrval))
>> Stack: (0xc6837e58 to 0xc6838000)
>> 7e40:                                                       bf005740 c6492a90
>> 7e60: 00000001 c6bf5788 00000003 c6837f38 bf0058c0 bf0058a8 bf00a495 c0493e38
>> 7e80: 00000000 c05368c0 00000001 00000000 c0580030 c0574b28 00000000 00000000
>> 7ea0: 00000000 00000000 00000000 00000000 6e72656b 00006c65 00000000 00000000
>> 7ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 7ee0: 00000000 00000000 00000000 aefb2bb8 7fffffff c0601008 00000000 00000004
>> 7f00: b6cee714 c00091e4 c6836000 00000000 005bc668 c00847b0 7fffffff 00000000
>> 7f20: 00000003 00000000 0000b2d0 c884e000 0000b2d0 00000000 c8852dcb c88533a0
>> 7f40: c884e000 0000b2d0 c8858cb8 c8858b34 c88568d4 000058c0 00006190 000023b8
>> 7f60: 00006713 00000000 00000000 00000000 000023a8 00000024 00000025 00000019
>> 7f80: 0000001d 00000011 00000000 aefb2bb8 00000000 00000000 00000000 00000000
>> 7fa0: 0000017b c0009000 00000000 00000000 00000004 b6cee714 00000000 00000000
>> 7fc0: 00000000 00000000 00000000 0000017b 00000000 00000000 00000001 005bc668
>> 7fe0: be907b00 be907af0 b6ce66b0 b6c3fac0 60000010 00000004 00000000 00000000
>> [<c0081bbc>] (frob_text.constprop.16) from [<c0083c4c>]
>> (load_module+0x1888/0x21b4)
>> [<c0083c4c>] (load_module) from [<c00847b0>] (sys_finit_module+0xbc/0xdc)
>> [<c00847b0>] (sys_finit_module) from [<c0009000>] (ret_fast_syscall+0x0/0x50)
>> Exception stack(0xc6837fa8 to 0xc6837ff0)
>> 7fa0:                   00000000 00000000 00000004 b6cee714 00000000 00000000
>> 7fc0: 00000000 00000000 00000000 0000017b 00000000 00000000 00000001 005bc668
>> 7fe0: be907b00 be907af0 b6ce66b0 b6c3fac0
>> Code: e1a01621 e1a00002 eafe4531 e7f001f2 (e7f001f2)
>> ---[ end trace 2cbefb0005882c52 ]---
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> ---[ end Kernel panic - not syncing: Attempted to kill init!
>> exitcode=0x0000000b ]---
>>
>> I bisected it to commit 06bd260e836d ("modules: fix BUG when load
>> module with rodata=n") with commit 7dabaa5ce05a ("modules: fix compile
>> error if don't have strict module rwx") on top to make it build.
>>
>> Let me know if you need me to provide more info.
>>
>> Best regards,
>> Bartosz Golaszewski
> 
> Hi Bartosz,
> 
> Thanks for reporting this, I was able to reproduce this on qemu.
> 
> This is due to hitting the BUG_ON() in frob_text() due to layout->base
> and/or layout->text_size not being page-aligned. These values are
> always page-aligned when CONFIG_STRICT_MODULE_RWX=y, but in commit
> 2eef1399a86 ("modules: fix BUG when load module with rodata=n"), the
> frob_text()+set_memory_x() calls got moved *outside* of the
> STRICT_MODULE_RWX block since some arches (like x86 and arm64)
> allocate non-executable module memory via module_alloc(), so naturally
> the module text needed to be made executable at a later stage of
> load_module(), regardless of whether STRICT_MODULE_RWX is set or not.
> In your case, you must've had CONFIG_STRICT_MODULE_RWX=n and so we
> were calling frob_text() with non-page-aligned values, triggering the
> BUG_ON().
> 
> In any case, could you please try and see if the following patch fixes
> the issue for you?
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 5933395af9a0..cd8df516666d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -64,14 +64,9 @@
> 
> /*
>   * Modules' sections will be aligned on page boundaries
> - * to ensure complete separation of code and data, but
> - * only when CONFIG_STRICT_MODULE_RWX=y
> + * to ensure complete separation of code and data
>   */
> -#ifdef CONFIG_STRICT_MODULE_RWX
> # define debug_align(X) ALIGN(X, PAGE_SIZE)
> -#else
> -# define debug_align(X) (X)
> -#endif
> 
> /* If this is set, the section belongs in the init part of the module */
> #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))

Works for me.

Tested-by: David Lechner <david@lechnology.com>
