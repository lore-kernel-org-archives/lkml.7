Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140C0C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29A320706
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 10:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKXKU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 05:20:27 -0500
Received: from foss.arm.com ([217.140.110.172]:38022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfKXKU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 05:20:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE5855D;
        Sun, 24 Nov 2019 02:20:25 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 908363F52E;
        Sun, 24 Nov 2019 02:20:24 -0800 (PST)
Date:   Sun, 24 Nov 2019 10:20:22 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Helge Deller <deller@gmx.de>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Richard Fontana <rfontana@redhat.com>,
        Armijn Hemel <armijn@tjaldur.nl>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 06/12] parisc: Replace cpu_up/down with
 device_online/offline
Message-ID: <20191124102021.k4oi3r4rgorikxnc@e107158-lin.cambridge.arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-7-qais.yousef@arm.com>
 <20191120110933.wjtmpc4pmqmxhmma@e107158-lin.cambridge.arm.com>
 <057185a2-e876-4237-c0bf-8754d302fdfc@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <057185a2-e876-4237-c0bf-8754d302fdfc@gmx.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/19 20:51, Helge Deller wrote:
> On 20.11.19 12:09, Qais Yousef wrote:
> > On 10/30/19 15:38, Qais Yousef wrote:
> >> The core device API performs extra housekeeping bits that are missing
> >> from directly calling cpu_up/down.
> >>
> >> See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> >> serialization during LPM") for an example description of what might go
> >> wrong.
> >>
> >> This also prepares to make cpu_up/down a private interface for anything
> >> but the cpu subsystem.
> >>
> >> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> >> CC: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> >> CC: Helge Deller <deller@gmx.de>
> >> CC: Richard Fontana <rfontana@redhat.com>
> >> CC: Armijn Hemel <armijn@tjaldur.nl>
> >> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> CC: Thomas Gleixner <tglx@linutronix.de>
> >> CC: linux-parisc@vger.kernel.org
> >> CC: linux-kernel@vger.kernel.org
> >> ---
> >>
> >> Couldn't compile test this one.
> >>
> >> I'm not confident that this is a correct patch to be honest. This __init
> >> indicates we're booting the secondary cpus and that might be too early in the
> >> process to use the core API..?
> >
> > Helge, James
> >
> > Do you have any comment on this? I have no means to test it and I'd
> > appreciate if you can spin it through one of your systems.
> 
> I pulled your cpu-hp-cleanup branch from git://linux-arm.org/linux-qy
> and compiled a 32- and a 64-bit parisc kernel.
> 
> I faced one compile warning:
> linux-2.6/kernel/cpu.c: In function ‘hibernation_bringup_sleep_cpu’:
> linux-2.6/kernel/cpu.c:1237:1: warning: control reaches end of non-void function [-Wreturn-type]
> 
> Other than that the 32- and 64-bit SMP kernel booted nicely.
> You may add to the series:
> Acked-by: Helge Deller <deller@gmx.de>   # parisc

Great! Thanks for testing it and reporting the warning.

Cheers

--
Qais Yousef

> 
> Thanks,
> Helge
> 
> 
> >>
> >>  arch/parisc/kernel/processor.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
> >> index 13f771f74ee3..4dde5fe78f0c 100644
> >> --- a/arch/parisc/kernel/processor.c
> >> +++ b/arch/parisc/kernel/processor.c
> >> @@ -212,7 +212,9 @@ static int __init processor_probe(struct parisc_device *dev)
> >>  #ifdef CONFIG_SMP
> >>  	if (cpuid) {
> >>  		set_cpu_present(cpuid, true);
> >> -		cpu_up(cpuid);
> >> +		lock_device_hotplug();
> >> +		device_online(get_cpu_device(cpuid));
> >> +		unlock_device_hotplug();
> >>  	}
> >>  #endif
> >>
> >> --
> >> 2.17.1
> >>
> 
