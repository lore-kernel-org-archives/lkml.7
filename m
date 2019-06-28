Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2B8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A796B206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfF1FHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:07:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1FHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:07:48 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgj6s-0001zy-0d; Fri, 28 Jun 2019 07:07:42 +0200
Date:   Fri, 28 Jun 2019 07:07:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        david.e.box@linux.intel.com,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, x86@kernel.org
Subject: Re: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel
 panic during early boot
In-Reply-To: <CAD8Lp46XnwQu4NWaXurz5ZcBs7dGb1gY=0Fy83w9EC9_V-7Oeg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906280707020.32342@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de> <20190627085419.27854-1-drake@endlessm.com> <alpine.DEB.2.21.1906271546010.32342@nanos.tec.linutronix.de> <CAD8Lp46XnwQu4NWaXurz5ZcBs7dGb1gY=0Fy83w9EC9_V-7Oeg@mail.gmail.com>
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

On Fri, 28 Jun 2019, Daniel Drake wrote:
> On Thu, Jun 27, 2019 at 10:07 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Nah. That extra timer works thing is just another bandaid.
> >
> > What I had in mind is something like the below. That's on top of
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
> >
> > Be warned. It's neither compiled nor tested, so keep a fire extinguisher
> > handy. If it explodes you own the pieces.
> 
> Thanks, it works, and makes sense!
> 
> I'll add a commit message and send it as a patch, just one quick
> function naming question... did you mean apic_and_tsc_needs_pit() or
> apic_needs_pit()? That's the only compile fix needed.

I'd say apic_needs_pit(). Less places to change :)

Thanks,

	tglx
