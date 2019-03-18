Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6B12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552904784;
	bh=1lWAI09ZU/BhDjj4WsNNy50wthYI4f2l8IVfVOr8y8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0kVJZ9fL9eWywsn50ZyUYM2+MmNI0kVO+kwv23hJ1zTHT6q1UChzt3clxzCcamoQV
	 wTMYRaZu7gkdW4NP+8O6Oa4DhbN0P2EagDCVcSSuIzEJZ8GLV1PcqI0qIKe5yWCeQq
	 9HuJHc/1Gjk6c9nvM1tDeVr5ayTeURQe7VsebTTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfCRK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:26:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46526 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCRK0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:26:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id c18so13889716otl.13;
        Mon, 18 Mar 2019 03:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UB5+VDaMkJ6XffH9lcsh5IN6zc7Cp893+Z5eIvmeNgw=;
        b=dlC28rqkR01p5LSrHfDyptRNr9fikd80nBguEBBMwYYOAzCVzjumM+vngXUhFArPia
         IxpQ/+iCuOHq5bInnXoisXMCRuuXEKtd18iR5myDTWSypv5SkVMa5f1jJ33TpI9eHDrK
         O8FJfrLpiP5itdaEI1KjOC/pEhpN69GDWZIR+deS+9+6N/t4x050lxXQ/QqhFdVQ1uxV
         6ei3EwlF9ygnkUq7NftpDmOgPFws/LCh6mSucb7joKXZ283CS0+buKqJhiPD2Y6NemMc
         lmxjFrLm/YkuKxLhPEDSXZfrFACNDf2UddNPF7Nb9xYYhFH1CqGcJ8o6Bszafhraw3F+
         p4hQ==
X-Gm-Message-State: APjAAAUh5Y9XJcsc2bWk4P1piAAFy+SNNK7qeI+/edhEwrDegA8mxPjz
        nfTXOHwBVIfLxpC01ipRshn1QzBdHOm3YqD84jI=
X-Google-Smtp-Source: APXvYqzn7Nvured89JQCuRJ6QkJBCyEqQ1EC88wXX8Nsd03tgM1nf0dutCh8fwEj7XpXAZFd6DmtwDp9koyyl/oAovc=
X-Received: by 2002:a9d:36a:: with SMTP id 97mr217490otv.124.1552904781212;
 Mon, 18 Mar 2019 03:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <6369897.qxlu8PgE1t@house> <CAJZ5v0h3zLrqqMXzt_cqGV1rBR0muosZwy1Zu3fV9O1kqGc6gw@mail.gmail.com>
 <2947538.dvgdW3vLlg@house>
In-Reply-To: <2947538.dvgdW3vLlg@house>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Mar 2019 11:26:10 +0100
Message-ID: <CAJZ5v0jS=9+O1J9w=a1K4U5UbXPKegVM-xKKwZN9XY4ObkQJkQ@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] Do not modify perf bias performance setting by
 default at boot
To:     Thomas Renninger <trenn@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Simon Schricker <sschricker@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 4:36 PM Thomas Renninger <trenn@suse.de> wrote:
>
> Hi Rafael,
>
> On Thursday, March 14, 2019 11:08:03 PM CET Rafael J. Wysocki wrote:
> > On Thu, Mar 14, 2019 at 3:42 PM Thomas Renninger <trenn@suse.de> wrote:
> > > This is a revert of mainline git commits:
> > > commit b51ef52df71cb28e9d90cd1d48b79bf19f0bab06
> > > commit 17edf2d79f1ea6dfdb4c444801d928953b9f98d6
> > > commit abe48b108247e9b90b4c6739662a2e5c765ed114
> >
> > I'm not quite convinced that reverting these is the right thing to do here.
>
> Ok, I try harder.
>
> > > It is about this kernel message showing up on quite a lot servers:
> > > [    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> > > [    0.076003] ENERGY_PERF_BIAS: View and update with
> > > x86_energy_perf_policy(8)
> > What happens on boot is a matter of convention and the convention by
> > which the EPB is set to "neutral" at that point has been used for
> > quite a while.  Changing it now may confuse some users or even worse.
>
> SUSE has this patch included for quite a while (in all kind of
> SLE 12 SP flavors), possibly other distributions as well.
> Unfortunately the patch got removed recently, because my commit (this one)
> was ignored by Len a while ago.
>
> I also like to see more examples of BIOSes not initializing this value.
> This message is rare (so the setting back does not happen often, probably
> only wrongly with latest BIOSes overriding intended BIOS performance settings
> on servers).
>
> On my workstation the BIOS initializes perf bias to:
> cpupower info
> analyzing CPU 0:
> perf-bias: 7
>
> I could grep through quite some dozens of machines..., but these are mostly
> servers and probably show either "zero"/"performance" or "6"/"normal" because
> the Linux kernel overrides the INTENDED performance perf bias value to 6.

The perf bias Intended by whom?

Yes, the kernel replaces whatever the original BIOS setting is with
its own one.  It may not match every setup perfectly, but at least it
is consistent.  Why exactly is it worse than whatever the BIOS has
set?

> So we (SUSE) are going with this patch forever.
>
> Otherwise we would run into a similar support nightmare we ran into, when
> Intel decided to ignore CPU idle states as exported by BIOS through ACPI.
> BIOS documentation of all big server vendors mentioned "performance" settings.
> With a kernel update these BIOS C states settings have been ignored (some long
> latency once were not exported on purpose).
>
> The list of breaking conventions and specifications is long...
> People mostly blame the "bad BIOS developer". In this case things have been
> broke by the kernel.

I agree that the kernel should not modify the EPB on system-wide
resume and on CPU online, but I don't see why changing the BIOS
setting at init time is a problem really.

> It's now (with the resume patch) broken in way, that "performance" setting

So the point seems to be that the BIOS setting should be preserved or
people are not able to configure the systems for performance through
setting things in the BIOS.  However, that only means that setting
things in the BIOS is not sufficient to configure a system for
performance and that has always been the case AFAICS, with or without
the EPB.

If you want to configure a system for performance, you need to do that
not just in the BIOS, but also in the OS (and, quite arguably, I would
expect the latter to be sufficient).

> in the mainline kernel is unusable for years already.
>
> Can we please get this finally properly fixed!
>
> > That is a bug.  There is no reason to change the EPB on CPU
> > offline/online and I agree that this needs to be fixed.  The reverts
> > would make this problem go away, but that's not the only possible way
> > to fix it.
>
> It is the only proper way to fix this.

I beg to differ.

The system-wide resume part will still not be working properly after
the reverts.

> > Moreover, what is done during system-wide resume appears to be a bug
> > too.  Whatever EPB value is there during suspend should be saved and
> > it should be restored during resume. Reverting the commits above will
> > not fix that particular issue.
>
> Someone could have a look what happens on a recent system
> after suspend (with this patch on top).
> I do not have laptops to test suspend/resume with latest kernels.
> These broken patches have been added a bit too quickly.
>
> I doubt much BIOSes "forgot to initialize this value" and I have my doubts
> that resume let's the CPU fall back to "uninitialized" value.
> I more expect BIOS resets performance value after resume and the kernel is
> doing it all wrong.
> Hm, in fact this could be proofed by modifying perf bias value, do a suspend
> resume cyle. If the value is kept we should avoid another try of complicating
> things and simply reverting touching perf bias value altogether, correct?

No, AFAICS.

If the EPB value has been modified from user space after initializing
the system, that new value should be preserved across system-side
suspend/resume (and hibernation) and also (arguably) across CPU
online/offline.  Not the BIOS-set value, but the new one set by user
space.  The only way to guarantee the preservation of it across
suspend/resume is to save it at suspend time and restore it during
resume.  Relying on the BIOS to avoid touching it may be a bit overly
optimistic.

> BIOS probably does not store perf BIAS value and re-applies it after
> suspend resume. Some might re-set it to the intial value (performance...,
> D'oh).

Right.

Thanks,
Rafael
