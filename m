Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E641AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF7D20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCGUWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:22:00 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:46896 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfCGUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:22:00 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-81-108-nat.elisa-mobile.fi [85.76.81.108])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id E358220090;
        Thu,  7 Mar 2019 22:21:56 +0200 (EET)
Date:   Thu, 7 Mar 2019 22:21:56 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Tom Li <tomli@tomli.me>, James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Message-ID: <20190307202156.GB30189@darkstar.musicnaut.iki.fi>
References: <20190208083038.GA1433@localhost.localdomain>
 <orbm3i5xrn.fsf@lxoliva.fsfla.org>
 <20190211125506.GA21280@localhost.localdomain>
 <orimxq3q9j.fsf@lxoliva.fsfla.org>
 <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
 <orva1jj9ht.fsf@lxoliva.fsfla.org>
 <20190217235951.GA20700@darkstar.musicnaut.iki.fi>
 <orpnrpj2rk.fsf@lxoliva.fsfla.org>
 <alpine.LFD.2.21.1902180227090.15915@eddie.linux-mips.org>
 <orlg1ryyo2.fsf@lxoliva.fsfla.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orlg1ryyo2.fsf@lxoliva.fsfla.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 07, 2019 at 03:41:01AM -0300, Alexandre Oliva wrote:
> On Feb 17, 2019, "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> 
> >  Is there an MMIO completion barrier missing there somewhere by any chance 
> > causing an IRQ that has been handled already to be redelivered because an 
> > MMIO write meant to clear the IRQ at its origin at handler's completion 
> > has not reached its destination before interrupts have been reenabled in 
> > the issuing CPU?  Just a thought.
> 
> I've finally got a chance to bisect the IRQ14 (nobody cared) regression
> on my yeeloong.  It took me to MIPS: Enforce strong ordering for MMIO
> accessors (commit 3d474dacae72ac0f28228b328cfa953b05484b7f).

This is interesting, thanks for the research, but I'm afraid it doesn't seem
to be the root cause.

While your patch seems to help also on Mini-PC (only briefly tested with
a dozen of reboots), there's still excessive amount of interrupts during
the boot - I'm getting something like 50000-70000, while with the old
IDE driver it's around 2500.

~ # cat /proc/irq/14/spurious 
count 57805
unhandled 57799
last_unhandled 4294673092 ms
~ # cat /proc/interrupts 
           CPU0       
  2:          0    XT-PIC   2  cascade
  3:        174    XT-PIC   3  ttyS0
  5:      14653    XT-PIC   5  timer
 11:          0    XT-PIC  11  ehci_hcd:usb1, ohci_hcd:usb2
 14:      57805    XT-PIC  14  pata_amd
 15:          0    XT-PIC  15  pata_amd
 18:          0      MIPS   2  cascade
 22:          0      MIPS   6  cascade
ERR:          0

Could you check your /proc/interrupts counters after the boot with
your change?

A.
