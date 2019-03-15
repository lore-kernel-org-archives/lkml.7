Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB478C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8590B218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfCOPg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:36:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:36124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbfCOPg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:36:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D88DDAC44;
        Fri, 15 Mar 2019 15:36:53 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Simon Schricker <sschricker@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] [RESEND] Do not modify perf bias performance setting by default at boot
Date:   Fri, 15 Mar 2019 16:36:53 +0100
Message-ID: <2947538.dvgdW3vLlg@house>
In-Reply-To: <CAJZ5v0h3zLrqqMXzt_cqGV1rBR0muosZwy1Zu3fV9O1kqGc6gw@mail.gmail.com>
References: <6369897.qxlu8PgE1t@house> <CAJZ5v0h3zLrqqMXzt_cqGV1rBR0muosZwy1Zu3fV9O1kqGc6gw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Thursday, March 14, 2019 11:08:03 PM CET Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2019 at 3:42 PM Thomas Renninger <trenn@suse.de> wrote:
> > This is a revert of mainline git commits:
> > commit b51ef52df71cb28e9d90cd1d48b79bf19f0bab06
> > commit 17edf2d79f1ea6dfdb4c444801d928953b9f98d6
> > commit abe48b108247e9b90b4c6739662a2e5c765ed114
> 
> I'm not quite convinced that reverting these is the right thing to do here.

Ok, I try harder.
 
> > It is about this kernel message showing up on quite a lot servers:
> > [    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> > [    0.076003] ENERGY_PERF_BIAS: View and update with
> > x86_energy_perf_policy(8)
> What happens on boot is a matter of convention and the convention by
> which the EPB is set to "neutral" at that point has been used for
> quite a while.  Changing it now may confuse some users or even worse.

SUSE has this patch included for quite a while (in all kind of
SLE 12 SP flavors), possibly other distributions as well.
Unfortunately the patch got removed recently, because my commit (this one)
was ignored by Len a while ago.

I also like to see more examples of BIOSes not initializing this value.
This message is rare (so the setting back does not happen often, probably
only wrongly with latest BIOSes overriding intended BIOS performance settings 
on servers).

On my workstation the BIOS initializes perf bias to:
cpupower info
analyzing CPU 0:
perf-bias: 7

I could grep through quite some dozens of machines..., but these are mostly
servers and probably show either "zero"/"performance" or "6"/"normal" because
the Linux kernel overrides the INTENDED performance perf bias value to 6.

So we (SUSE) are going with this patch forever.
Otherwise we would run into a similar support nightmare we ran into, when
Intel decided to ignore CPU idle states as exported by BIOS through ACPI.
BIOS documentation of all big server vendors mentioned "performance" settings.
With a kernel update these BIOS C states settings have been ignored (some long 
latency once were not exported on purpose).

The list of breaking conventions and specifications is long...
People mostly blame the "bad BIOS developer". In this case things have been
broke by the kernel.
It's now (with the resume patch) broken in way, that "performance" setting
in the mainline kernel is unusable for years already.

Can we please get this finally properly fixed!

> That is a bug.  There is no reason to change the EPB on CPU
> offline/online and I agree that this needs to be fixed.  The reverts
> would make this problem go away, but that's not the only possible way
> to fix it.

It is the only proper way to fix this.
 
> Moreover, what is done during system-wide resume appears to be a bug
> too.  Whatever EPB value is there during suspend should be saved and
> it should be restored during resume. Reverting the commits above will
> not fix that particular issue.

Someone could have a look what happens on a recent system
after suspend (with this patch on top).
I do not have laptops to test suspend/resume with latest kernels.
These broken patches have been added a bit too quickly.

I doubt much BIOSes "forgot to initialize this value" and I have my doubts
that resume let's the CPU fall back to "uninitialized" value.
I more expect BIOS resets performance value after resume and the kernel is
doing it all wrong.
Hm, in fact this could be proofed by modifying perf bias value, do a suspend
resume cyle. If the value is kept we should avoid another try of complicating
things and simply reverting touching perf bias value altogether, correct?

BIOS probably does not store perf BIAS value and re-applies it after
suspend resume. Some might re-set it to the intial value (performance..., 
D'oh).

        Thomas
