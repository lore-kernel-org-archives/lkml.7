Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C37C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A5121955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563811997;
	bh=YESwXr/23+tUMNPNSNkTKju+yV9A+0aSz9fnZXS5BT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Z3dHG3j91SZIaFIJrFsAm/Quu4pqeWD3X12cHWZcrFU2GrlP3vjtsFH215XD6C0i
	 8v9K7vQhZuJIWnXkLLQE+VTl3dXGGaOriHbi7Y2u01FFWilZcji1nRr7pmESXTfG9/
	 N08iiCGOH+i37uQ4lSVCji9TwAR3EtpfRejm+XoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfGVQNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfGVQNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:13:16 -0400
Received: from linux-8ccs (ip5f5adbdb.dynamic.kabel-deutschland.de [95.90.219.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B678A2190D;
        Mon, 22 Jul 2019 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563811994;
        bh=YESwXr/23+tUMNPNSNkTKju+yV9A+0aSz9fnZXS5BT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ux7Rigm9dIbOnkGPjMpTMmodGF142GxlClSS5kI987dDqAFs1CjIwJYZ5gMA4/sKj
         S6A14ZW42ehF9//AI3XdQp5z1x2Est7CieUQaXv1zdEMPTFwp+nNd1a/6N1AL1lUX7
         PvEb7uzwQiytxDf8acNDri7BXTG4e9kF4UeoD1DM=
Date:   Mon, 22 Jul 2019 18:13:08 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Martin Kaiser <lists@kaiser.cx>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: next-20190722, imx25: Oops when loading a module
Message-ID: <20190722161307.GB4297@linux-8ccs>
References: <20190722101312.2nakxrfy7yn4a4ro@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190722101312.2nakxrfy7yn4a4ro@viti.kaiser.cx>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Martin Kaiser [22/07/19 12:13 +0200]:
>Dear all,
>
>I run next-20190722 on an arm imx25 system and came across an issue that might
>be worth reporting. I am no sure to whom, though. Please let me know if I got
>that wrong.
>
>Loading a module, no matter which one, causes a segfault and a dump such as
>
>[root@host ]# insmod /mnt/kernel/iio/potentiometer/max5432.ko
>[   63.043683] Internal error: Oops - undefined instruction: 0 [#1] ARM
>[   63.050123] Modules linked in:
>[   63.053266] CPU: 0 PID: 170 Comm: insmod Tainted: G        W         5.3.0-rc1-next-20190722+ #3104
>[   63.062344] Hardware name: Freescale i.MX25 (Device Tree Support)
>[   63.068529] PC is at frob_text.constprop.15+0x2c/0x40
>[   63.073639] LR is at load_module+0x10dc/0x125c
>[   63.078115] pc : [<c0072ffc>]    lr : [<c0071f8c>]    psr: 00000013
>[   63.084407] sp : d3303e30  ip : d3303e40  fp : d3303e3c
>[   63.089654] r10: 00000000  r9 : d3303e98  r8 : 00000018
>[   63.094903] r7 : 00000001  r6 : bf0006cc  r5 : d3303f20  r4 : bf0006c0
>[   63.101454] r3 : bf000000  r2 : 18000000  r1 : 00000180  r0 : bf0007a0
>[   63.108013] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>[   63.115176] Control: 0005317f  Table: 93330000  DAC: 00000051
>[   63.120961] Process insmod (pid: 170, stack limit = 0x90da5324)
>[   63.126917] Stack: (0xd3303e30 to 0xd3304000)
>[   63.131318] 3e20:                                     d3303f0c d3303e40 c0071f8c c0072fe0
>[   63.139546] 3e40: bf0006c0 d3309920 00002cc0 ffffffff 00000002 00000002 d3309900 00000000
>[   63.147776] 3e60: 001a77e2 bf00289b bf0008a0 c067c9c8 0000025f c07df990 d3303ecc d3303e88
>[   63.155999] 3e80: c00d7688 c00d689c 00000000 00000000 00000000 00000000 00000000 00000000
>[   63.164225] 3ea0: 6e72656b 00006c65 00000000 00000000 00000000 00000000 00000000 00000000
>[   63.172453] 3ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 ba520d2b
>[   63.180681] 3ee0: c00721a8 00001aed 0120abad 00000000 c0883028 d4c17aed 001a77e2 d3302000
>[   63.188912] 3f00: d3303fa4 d3303f10 c0072270 c0070ec0 c0034324 c0677478 d32f1640 00000051
>[   63.197142] 3f20: d4c16788 d4c16a80 d4c16000 00001aed d4c16dd8 d4c16cd5 d4c177f0 000008a0
>[   63.205368] 3f40: 00000950 00000850 000009b4 00000000 00000000 00000000 00000840 0000001b
>[   63.213590] 3f60: 0000001c 00000011 0000000d 00000009 00000000 ba520d2b c01030f4 00000000
>[   63.221819] 3f80: 00000000 00001aed 00000080 c00091e4 d3302000 00000000 00000000 d3303fa8
>[   63.230046] 3fa0: c0009000 c007211c 00000000 00000000 012090c0 00001aed 001a77e2 00000000
>[   63.238273] 3fc0: 00000000 00000000 00001aed 00000080 00000001 be90de0c 001a77e2 00000000
>[   63.246499] 3fe0: be90dac0 be90dab0 0001ec34 00009b30 60000010 012090c0 00000000 00000000
>[   63.254694] Backtrace:
>[   63.257232] [<c0072fd0>] (frob_text.constprop.15) from [<c0071f8c>] (load_module+0x10dc/0x125c)
>[   63.265999] [<c0070eb0>] (load_module) from [<c0072270>] (sys_init_module+0x164/0x194)
>[   63.273970]  r10:d3302000 r9:001a77e2 r8:d4c17aed r7:c0883028 r6:00000000 r5:0120abad
>[   63.281823]  r4:00001aed
>[   63.284410] [<c007210c>] (sys_init_module) from [<c0009000>] (ret_fast_syscall+0x0/0x50)
>[   63.292529] Exception stack(0xd3303fa8 to 0xd3303ff0)
>[   63.297624] 3fa0:                   00000000 00000000 012090c0 00001aed 001a77e2 00000000
>[   63.305851] 3fc0: 00000000 00000000 00001aed 00000080 00000001 be90de0c 001a77e2 00000000
>[   63.314067] 3fe0: be90dac0 be90dab0 0001ec34 00009b30
>[   63.319170]  r10:00000000 r9:d3302000 r8:c00091e4 r7:00000080 r6:00001aed r5:00000000
>[   63.327021]  r4:00000000
>[   63.329603] Code: 1a000002 e5901008 e1b02a01 0a000000 (e7f001f2)
>[   63.335742] ---[ end trace c38bbcd6af0938a2 ]---
>Segmentation fault
>[root@host ]#
>
>It seems that this is realated to strict module rwx.
>The config below crashes:
>
>CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
># CONFIG_STRICT_MODULE_RWX is not set
>
>If I enable CONFIG_STRICT_MODULE_RWX, modules can be loaded and unloaded without problems.
>
>Best regards,
>
>   Martin

Hi Martin,

Thank you for reporting this. Could you please try the patch I posted here:

  https://lore.kernel.org/lkml/20190722161006.GA4297@linux-8ccs/

And let me know if that fixes the issue for you?

Thanks,

Jessica
