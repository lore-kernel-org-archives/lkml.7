Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21C7C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67632171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405926AbfHIJuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:50:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405953AbfHIJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:50:07 -0400
Received: from p200300ddd71876457e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7645:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hw1X0-0003bf-Nf; Fri, 09 Aug 2019 11:49:54 +0200
Date:   Fri, 9 Aug 2019 11:49:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86/kernel/cpu/umwait.c - remove unused variable
In-Reply-To: <20190809004438.GA56628@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1908091147290.21433@nanos.tec.linutronix.de>
References: <79734.1565272329@turing-police> <alpine.DEB.2.21.1908082158580.2882@nanos.tec.linutronix.de> <141835.1565295884@turing-police> <alpine.DEB.2.21.1908082229010.2882@nanos.tec.linutronix.de> <20190809004438.GA56628@romley-ivt3.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-718199243-1565344194=:21433"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-718199243-1565344194=:21433
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 8 Aug 2019, Fenghua Yu wrote:
> On Thu, Aug 08, 2019 at 10:32:38PM +0200, Thomas Gleixner wrote:
> > Valdis,
> > 
> > On Thu, 8 Aug 2019, Valdis Klētnieks wrote:
> > > On Thu, 08 Aug 2019 22:04:03 +0200, Thomas Gleixner said: It isn't 
> > > clear that whatever is doing the device_initcall()s will be able to 
> > > do any reasonable recovery if we return an error, so any error 
> > > recovery is going to have to happen before the function returns. It 
> > > might make sense to do an 'if (ret) return;' before going further in 
> > > the function, but given the comment a few lines further down about 
> > > ignoring errors, it was apparently considered more important to 
> > > struggle through and register stuff in sysfs even if umwait was 
> > > broken....
> > 
> > I missed that when going through it.
> > 
> > The right thing to do is to have a cpu_offline callback which clears 
> > the umwait MSR. That covers also the failure in the cpu hotplug setup. 
> > Then handling an error return makes sense and keeps everything in a 
> > workable shape.
> 
> When cpu is offline, the MSR won't be used. We don't need to clear it, right?

Groan. If soemthing goes wrong when registering the hotplug callback, what
undoes the MSR setup which might have happened and what takes care of it on
cpus coming online later? Exactly nothing. Then you have a non-consistent
behaviour.

Make stuff symmmetric and correct and not optimized for the sunshine case.

Thanks,

	tglx
--8323329-718199243-1565344194=:21433--
