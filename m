Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9A8C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3858320818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLOsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:48:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKLOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:48:21 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUXSl-0004ha-50; Tue, 12 Nov 2019 15:48:11 +0100
Date:   Tue, 12 Nov 2019 15:48:10 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
cc:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rmk+kernel@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] arm: kernel: initialize broadcast hrtimer based clock
 event device
In-Reply-To: <20191112120625.20173-1-benjamin.gaignard@st.com>
Message-ID: <alpine.DEB.2.21.1911121547490.1833@nanos.tec.linutronix.de>
References: <20191112120625.20173-1-benjamin.gaignard@st.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019, Benjamin Gaignard wrote:

> On platforms implementing CPU power management, the CPUidle subsystem
> can allow CPUs to enter idle states where local timers logic is lost on power
> down. To keep the software timers functional the kernel relies on an
> always-on broadcast timer to be present in the platform to relay the
> interrupt signalling the timer expiries.
> 
> For platforms implementing CPU core gating that do not implement an always-on
> HW timer or implement it in a broken way, this patch adds code to initialize
> the kernel hrtimer based clock event device upon boot (which can be chosen as
> tick broadcast device by the kernel).
> It relies on a dynamically chosen CPU to be always powered-up. This CPU then
> relays the timer interrupt to CPUs in deep-idle states through its HW local
> timer device.
> 
> Having a CPU always-on has implications on power management platform
> capabilities and makes CPUidle suboptimal, since at least a CPU is kept
> always in a shallow idle state by the kernel to relay timer interrupts,
> but at least leaves the kernel with a functional system with some working
> power management capabilities.
> 
> The hrtimer based clock event device is unconditionally registered, but
> has the lowest possible rating such that any broadcast-capable HW clock
> event device present will be chosen in preference as the tick broadcast
> device.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
