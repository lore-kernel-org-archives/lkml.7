Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60068C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D815208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF1JTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:19:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1JTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:19:23 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgn2L-0007wp-35; Fri, 28 Jun 2019 11:19:17 +0200
Date:   Fri, 28 Jun 2019 11:19:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, "lkp@01.org" <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [LKP] [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
In-Reply-To: <20190628063231.GA7766@shbuild999.sh.intel.com>
Message-ID: <alpine.DEB.2.21.1906280929010.32342@nanos.tec.linutronix.de>
References: <20190620021856.GP7221@shao2-debian> <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de> <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com> <alpine.DEB.2.21.1906250821220.32342@nanos.tec.linutronix.de> <f5c36f89-61bf-a82e-3d3b-79720b2da2ef@intel.com>
 <alpine.DEB.2.21.1906251330330.32342@nanos.tec.linutronix.de> <20190628063231.GA7766@shbuild999.sh.intel.com>
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

Feng,

On Fri, 28 Jun 2019, Feng Tang wrote:
> On Tue, Jun 25, 2019 at 07:32:03PM +0800, Thomas Gleixner wrote:
> > the head of that branch is:
> > 
> >       4f3f6d6a7f8e ("x86/apic/x2apic: Add conditional IPI shorthands support")
> > 
> > This is WIP and force pushed. There are no incremental changes. Could you
> > please check again?
> 
> Since you can't reproduce it yet, we've added some debug hook to get more
> info, like dmesg below:
> 
> [  288.866069] IRR[7]: 0x1000
> [  289.890274] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1502 setup_local_APIC+0x2d1/0x4f0

> [  290.182418] queued = 0x1000 acked = 0
> [  290.189159] IRR[7]: 0x1000
> 
> Which shows the IRR[7] was set 0x1000, IIUC, it means vector
> 0xec, which is for LAPIC timer, and ISRs are all 0 before and
> after the loop.

Ahhhh. That makes a lot of sense now.

That interrupt is in the IRR, but not in the ISR. So the acknowledge
attempts are useless because the ack only clears an pending ISR and the IRR
is not propagated because in the state in which this happens the entry is
masked.

That function just 'works' by chance not by design. I'll stare into it and
fix it up for real.

Thank you very much for that information. Your debug was spot on!

      tglx
