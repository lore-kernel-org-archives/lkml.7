Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5A02084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfCRLPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:15:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:47232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfCRLPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:15:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E504DACFA;
        Mon, 18 Mar 2019 11:15:43 +0000 (UTC)
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
Date:   Mon, 18 Mar 2019 12:15:43 +0100
Message-ID: <2616815.TtRSCVe66q@house>
In-Reply-To: <CAJZ5v0jS=9+O1J9w=a1K4U5UbXPKegVM-xKKwZN9XY4ObkQJkQ@mail.gmail.com>
References: <6369897.qxlu8PgE1t@house> <2947538.dvgdW3vLlg@house> <CAJZ5v0jS=9+O1J9w=a1K4U5UbXPKegVM-xKKwZN9XY4ObkQJkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 18, 2019 11:26:10 AM CET Rafael J. Wysocki wrote:
> On Fri, Mar 15, 2019 at 4:36 PM Thomas Renninger <trenn@suse.de> wrote:
> > Hi Rafael,
> >
 
...

> > On my workstation the BIOS initializes perf bias to:
> > cpupower info
> > analyzing CPU 0:
> > perf-bias: 7
> > 
> > I could grep through quite some dozens of machines..., but these are
> > mostly
> > servers and probably show either "zero"/"performance" or "6"/"normal"
> > because the Linux kernel overrides the INTENDED performance perf bias
> > value to 6.
> The perf bias Intended by whom?

The instance who should be in charge to set/init such a value:
BIOS?
 
> Yes, the kernel replaces whatever the original BIOS setting is with
> its own one.

No, it only replaces the "performance" (0) value with "normal" (6).
This does not makes sense and is broken.

> It may not match every setup perfectly, but at least it
> is consistent.  Why exactly is it worse than whatever the BIOS has
> set?

Because there may be BIOS settings for the CPU which justify initialization
of the Perf BIAS value by BIOS.

What sense does it make to unconditionally set perf BIAS value from
performance to balanced?
Why is this done?
 
> > So we (SUSE) are going with this patch forever.
> > 
> > Otherwise we would run into a similar support nightmare we ran into, when
> > Intel decided to ignore CPU idle states as exported by BIOS through ACPI.
> > BIOS documentation of all big server vendors mentioned "performance"
> > settings. With a kernel update these BIOS C states settings have been
> > ignored (some long latency once were not exported on purpose).
> > 
> > The list of breaking conventions and specifications is long...
> > People mostly blame the "bad BIOS developer". In this case things have
> > been
> > broke by the kernel.
> 
> I agree that the kernel should not modify the EPB on system-wide
> resume and on CPU online, but I don't see why changing the BIOS
> setting at init time is a problem really.

I would agree if we differ a tablet/laptop system and set the performance
value to normal/powersave.
And on a server we set it from normal/powersave to performance.

But we should not touch this value anyway.
Again: Why should the kernel touch it?

There may be BIOSes initialzing it via BIOS options. And this is a very valid 
thing to do.

> > It's now (with the resume patch) broken in way, that "performance" setting
> 
> So the point seems to be that the BIOS setting should be preserved or
> people are not able to configure the systems for performance through
> setting things in the BIOS.
> However, that only means that setting
> things in the BIOS is not sufficient to configure a system for
> performance and that has always been the case AFAICS, with or without
> the EPB.

?!?
If the kernel unconditionally, without documentation overrides such values...
(and in this case only because of a workaround of some buggy BIOSes not 
initialzing this value)...

> If you want to configure a system for performance, you need to do that
> not just in the BIOS, but also in the OS (and, quite arguably, I would
> expect the latter to be sufficient).

No. You must not ignore BIOS settings. Even worse, you must not override
these without any sane reason.

Your assumption above might be right. But we want to do it better, right?

...
 
> The system-wide resume part will still not be working properly after
> the reverts.

But it must never blindly (unconditionally) be set to specific value.
Correct?

You mean the kernel should store the pre-hibernation perf BIAS value
in NVRAM and write it back when waking up again?
This would make sense.

It would also mean perf BIAS never really worked, at least did not survive
suspend. On servers (no hibernation) it would works but is overridden
to a value you typically do not want to have on a server...
So the current situation is rather broken in the kernel.


      Thomas

