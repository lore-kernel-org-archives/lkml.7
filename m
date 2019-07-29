Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444A0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1701420578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfG2Okx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:40:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfG2Okw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:40:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5294BACA8;
        Mon, 29 Jul 2019 14:40:51 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [RFC PATCH 13/16] RISC-V: KVM: Add timer functionality
References: <20190729115544.17895-1-anup.patel@wdc.com>
        <20190729115544.17895-14-anup.patel@wdc.com>
X-Yow:  HOORAY, Ronald!!  Now YOU can marry LINDA RONSTADT too!!
Date:   Mon, 29 Jul 2019 16:40:50 +0200
In-Reply-To: <20190729115544.17895-14-anup.patel@wdc.com> (Anup Patel's
        message of "Mon, 29 Jul 2019 11:57:42 +0000")
Message-ID: <mvmpnlsc39p.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29 2019, Anup Patel <Anup.Patel@wdc.com> wrote:

> From: Atish Patra <atish.patra@wdc.com>
>
> The RISC-V hypervisor specification doesn't have any virtual timer
> feature.
>
> Due to this, the guest VCPU timer will be programmed via SBI calls.
> The host will use a separate hrtimer event for each guest VCPU to
> provide timer functionality. We inject a virtual timer interrupt to
> the guest VCPU whenever the guest VCPU hrtimer event expires.
>
> The following features are not supported yet and will be added in
> future:
> 1. A time offset to adjust guest time from host time
> 2. A saved next event in guest vcpu for vm migration

I'm getting this error:

In file included from <command-line>:
./include/clocksource/timer-riscv.h:12:30: error: unknown type name ‘u32’
   12 | void riscv_cs_get_mult_shift(u32 *mult, u32 *shift);
      |                              ^~~
./include/clocksource/timer-riscv.h:12:41: error: unknown type name ‘u32’
   12 | void riscv_cs_get_mult_shift(u32 *mult, u32 *shift);
      |                                         ^~~
make[1]: *** [scripts/Makefile.build:301: include/clocksource/timer-riscv.h.s] Error 1

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
