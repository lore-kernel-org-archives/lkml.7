Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BFCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A516B218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfCVGNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:13:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:60802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfCVGNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:13:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7FFBAE5A;
        Fri, 22 Mar 2019 06:13:22 +0000 (UTC)
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: regression (bisected): "modprobe parport_pc" hangs in current mainline
Date:   Fri, 22 Mar 2019 07:13:23 +0100
Message-ID: <1572645.oXzt2vILsi@alaris>
Organization: SuSE
In-Reply-To: <CADVatmNVM3a=L6McdCsr5xzCwZnW6N4r9Cf55gjQZjsGGosBDg@mail.gmail.com>
References: <20190313064557.GA14531@unicorn.suse.cz> <20190320211813.GE29968@unicorn.suse.cz> <CADVatmNVM3a=L6McdCsr5xzCwZnW6N4r9Cf55gjQZjsGGosBDg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 March 2019 23:43 Sudip Mukherjee wrote:
> HI Michal,
> 
> On Wed, Mar 20, 2019 at 9:18 PM Michal Kubecek <mkubecek@suse.cz> wrote:
> > On Wed, Mar 20, 2019 at 09:30:59AM +0000, Sudip Mukherjee wrote:
> > > Sorry, I didn't get the chance to look at it yet and have kept it
> > > pending for this weekend. But just had a quick look and I was
> > > wondering if the machine on which you are trying the modprobe has
> > > an
> > > actual parallel port or the machine is not having any parallel
> > > port.
> > > And also will you be able to send me a dmesg please.
> > 
> > Attaching dmesg output from a virtual machine which doesn't seem to
> > have a (virtual) parallel port. This part:
> > 
> > [   63.962283] parport_pc 00:05: reported by Plug and Play ACPI
> > [   63.962469] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> > [   64.061723] ppdev: user-space parallel port driver
> > 
> > was after I manually killed "/sbin/modprobe -q -- parport_lowlevel"
> > which was started during boot.
> 
> Thanks for testing. I am unable to reproduce the problem in VM or in
> machine, with or without parallel port. But from your logs it looks
> like you have an alias set for "parport_lowlevel". When parport module
> is being loaded if it does not find any port in its list, it will try
> to load "parport_lowlevel" and that is where you are getting the
> deadlock. "parport_lowlevel" is not a real module, but instead should
> be an alias pointing to some real module. I tried by setting an alias
> of parport_lowlevel" as parport_pc but still could not get the
> problem.
> Can you please check in your VM or machine what do you have the alias
> as? It should be either in "/etc/modprobe.conf" or some conf file in
> "/etc/modprobe.d" folder.

You are right, this is in /etc/modprobe.d/00-system which is part of
suse-module-tools package:

-----------------------------------------------------------------------
alias parport_lowlevel    parport_pc
# disable DMA for parallel port (bnc#180390)
# Please note, the dma= and irq= options require that the io= option also be
# specified.
options parport_pc dma=none
# options parport_pc io=0x378 irq=none
# If you have multiple parallel ports, specify them this way:
# options parport_pc io=0x378,0x278  irq=none,none
-----------------------------------------------------------------------

"bnc#180390" means https://bugzilla.suse.com/show_bug.cgi?id=180390

There is a git repository for suse-module-tools package on github but
unfortunately it starts in 2017 and as comment 98 in the bug above
shows that the alias line was already in place in 2008, the reason
won't be found in OBS history either.

Anyway, when I comment out the alias line, "modprobe parport_pc"
succeeds immediately and loads parport, parport_pc and ppdev.

> And also, will you be able to test a debug patch on your VM?

Yes, definitely.

Michal


