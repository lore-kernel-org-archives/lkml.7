Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D671DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12E52166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfHIThx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:37:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57627 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfHIThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:37:50 -0400
Received: from p200300ddd71876457e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7645:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwAhl-00050b-Lr; Fri, 09 Aug 2019 21:37:37 +0200
Date:   Fri, 9 Aug 2019 21:37:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86/kernel/cpu/umwait.c - remove unused variable
In-Reply-To: <20190809153056.GB56628@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1908092136510.21433@nanos.tec.linutronix.de>
References: <79734.1565272329@turing-police> <alpine.DEB.2.21.1908082158580.2882@nanos.tec.linutronix.de> <141835.1565295884@turing-police> <alpine.DEB.2.21.1908082229010.2882@nanos.tec.linutronix.de> <20190809004438.GA56628@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1908091147290.21433@nanos.tec.linutronix.de> <20190809153056.GB56628@romley-ivt3.sc.intel.com>
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

On Fri, 9 Aug 2019, Fenghua Yu wrote:
> On Fri, Aug 09, 2019 at 11:49:49AM +0200, Thomas Gleixner wrote:
> > Groan. If soemthing goes wrong when registering the hotplug callback, what
> > undoes the MSR setup which might have happened and what takes care of it on
> > cpus coming online later? Exactly nothing. Then you have a non-consistent
> > behaviour.
> > 
> > Make stuff symmmetric and correct and not optimized for the sunshine case.
> 
> I see.
> 
> Just want to make sure I understand it correctly:
> 
> sysfs_create_group() should not be called if cpuhp_setup_state() has
>  error.
> 
> Otherwise, the sysadmin can change the MSR through the sysfs interface.
> After that, a CPU is online and its MSR is not updated because cpu_online
> is not installed. Then this online CPU has different MSR value from
> the other CPUs.
> 
> Is that right?

Yes. You need to enforce safe and consistent behaviour.

Thanks,

	tglx
