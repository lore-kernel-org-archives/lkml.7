Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C815C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AA4208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfDXQVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:21:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48226 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731056AbfDXQVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:21:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA662A78;
        Wed, 24 Apr 2019 09:21:53 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F2A13F557;
        Wed, 24 Apr 2019 09:21:52 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] sdei: enable dbg in '_sdei_handler'
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     huawei.libin@huawei.com, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
 <1555070699-3685-3-git-send-email-wangxiongfeng2@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <57b2e233-89e4-c7de-32ac-705e88a1d1ae@arm.com>
Date:   Wed, 24 Apr 2019 17:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555070699-3685-3-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng Wang,

On 12/04/2019 13:04, Xiongfeng Wang wrote:
> When we monitor a sdei_event callback using 'kprobe', the singlestep
> handler can not be called because dbg is masked in sdei_handler.

For a good reason: the debug hardware may be in use single-stepping the kernel, or worse:
in use by a KVM guest.

The DAIF flags are all set because none of these things are safe for an
SDEI-event/NMI-handler. We haven't done KVM's guest exit work yet, so things like the
debug hardware belong to the guest.

Its not safe to take an exception from NMI context, avoid it at all costs!


> This patch enable dbg in '_sdei_handler'.

This is very bad as the debug hardware may have been in use by something else. A malicious
guest can now cause you to take breakpoint/watchpoint exceptions.


> When SDEI events interrupt the userspace, 'vbar_el1' contains
> 'tramp_vectors' if CONFIG_UNMAP_KERNEL_AT_EL0 is enabled. So we need to
> restore 'vbar_el1' with kernel vectors, otherwise we will go to the
> wrong place when brk exception or dbg exception happens.

This is the tip of the iceberg. You may have been partway through KVM's world-switch,
you'd need to temporarily save/restore the host context. This ends up being a
parody-world-switch, which has to be kept in-sync with KVM. We didn't go this way because
its fragile and unmaintainable.


> SDEI events may interrupt 'kernel_entry' before we save 'spsr_el1' and
> 'elr_el1', and dbg exception will corrupts these two registers. So we
> also need to save and restore these two registers.

(or don't do anything that would cause them to get clobbered)


> If SDEI events interrupt an instruction being singlestepped, the
> instruction in '_sdei_handler' will begin to be singlestepped after we
> enable dbg. So we need to disable singlestep in the beginning of
> _sdei_handler if we find out we interrupt a singlestep process.

And now the arch code's do_debug_exception() is re-rentrant, which it doesn't expect.

The kprobes core code can't be kprobed, but it can be interrupted by NMI. If you can
kprobe the NMI, you've made the kprobes core re-entrant too. A quick look shows
raw_spin_lock() that could deadlock, and it passes values around with a per-cpu variable.

You could interrupt any part of the krpobes machinery with an SDEI event, take a kprobe,
then take a critical SDEI event, and a third kprobe.

I don't see how its possible to make this safe without re-writing kprobes to be NMI safe.


> diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
> index ea94cf8..9dd9cf6 100644
> --- a/arch/arm64/kernel/sdei.c
> +++ b/arch/arm64/kernel/sdei.c

> -	if (elr != read_sysreg(elr_el1)) {
> -		/*
> -		 * We took a synchronous exception from the SDEI handler.
> -		 * This could deadlock, and if you interrupt KVM it will
> -		 * hyp-panic instead.
> -		 */
> -		pr_warn("unsafe: exception during handler\n");
> -	}

This is here to catch a WARN_ON() firing and not killing the system. Its not safe to take
an exception from the NMI handler.


Why do you need to kprobe an NMI handler?


Thanks,

James
