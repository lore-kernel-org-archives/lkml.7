Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DF120830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfCDAsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:48:11 -0500
Received: from ozlabs.org ([203.11.71.1]:57037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDAsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:48:09 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44CLwl2kdsz9sDn; Mon,  4 Mar 2019 11:48:07 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9580b71b5a7863c24a9bd18bcd2ad759b86b1eff
X-Patchwork-Hint: ignore
In-Reply-To: <d273fd9f1cc7ee36e1ee4da20631d507c39efe6d.1551267823.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicolai Stange <nstange@suse.de>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: powerpc/32: Clear on-stack exception marker upon exception return
Message-Id: <44CLwl2kdsz9sDn@ozlabs.org>
Date:   Mon,  4 Mar 2019 11:48:07 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-27 at 11:45:30 UTC, Christophe Leroy wrote:
> Clear the on-stack STACK_FRAME_REGS_MARKER on exception exit in order
> to avoid confusing stacktrace like the one below.
> 
> Call Trace:
> [c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
> [c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
> [c0e9dd10] [c0895130] memchr+0x24/0x74
> [c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
> [c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
> [c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
> --- interrupt: c0e9df00 at 0x400f330
>     LR = init_stack+0x1f00/0x2000
> [c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
> [c0e9df20] [c0c27e44] early_irq_init+0x38/0x108
> [c0e9df50] [c0c15434] start_kernel+0x310/0x488
> [c0e9dff0] [00003484] 0x3484
> 
> With this patch the trace becomes:
> 
> Call Trace:
> [c0e9dca0] [c01c42c0] print_address_description+0x64/0x2bc (unreliable)
> [c0e9dcd0] [c01c46a4] kasan_report+0xfc/0x180
> [c0e9dd10] [c0895150] memchr+0x24/0x74
> [c0e9dd30] [c00a9e58] msg_print_text+0x124/0x574
> [c0e9dde0] [c00ab730] console_unlock+0x114/0x4f8
> [c0e9de40] [c00adc80] vprintk_emit+0x188/0x1c4
> [c0e9de80] [c00ae3e4] printk+0xa8/0xcc
> [c0e9df20] [c0c27e44] early_irq_init+0x38/0x108
> [c0e9df50] [c0c15434] start_kernel+0x310/0x488
> [c0e9dff0] [00003484] 0x3484
> 
> Cc: stable@vger.kernel.org
> Cc: Nicolai Stange <nstange@suse.de>
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9580b71b5a7863c24a9bd18bcd2ad759

cheers
