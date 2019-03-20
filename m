Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A26DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71D0213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfCTORD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:17:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:59682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbfCTORD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:17:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC334ACE8;
        Wed, 20 Mar 2019 14:17:00 +0000 (UTC)
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
Date:   Wed, 20 Mar 2019 15:17:00 +0100
Message-ID: <2885751.XIsKOnZRY2@house>
In-Reply-To: <CAJZ5v0if=ypE-0j6baq4uTkDp5Ew_WO68oqL0dOi+tZhoP-4mQ@mail.gmail.com>
References: <6369897.qxlu8PgE1t@house> <3100343.nkNWlhakcz@house> <CAJZ5v0if=ypE-0j6baq4uTkDp5Ew_WO68oqL0dOi+tZhoP-4mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael,

I top post the general things and answer in only a few sentences embedded in 
context below:

I very much honour your work and your neutral opinions and reasoning and
I always have.

This patch is a resend and while I try to come up with alternative hacks, 
there still is no solution, not even a suggestion.

I sent the patch 3 years ago:
https://lkml.org/lkml/2016/2/26/675
And I found this when doing performance analysis with Mel (Gorman).

This time Hannes (Reinicke) stumbled over it, while he was working on 
performance tests on NVE over fabrics.

We need this fixed and I am going to repush this into our kernel(s) now.

On Monday, March 18, 2019 11:57:08 PM CET Rafael J. Wysocki wrote:
> On Mon, Mar 18, 2019 at 2:22 PM Thomas Renninger <trenn@suse.de> wrote:
> > On Monday, March 18, 2019 12:40:46 PM CET Rafael J. Wysocki wrote:
> > > On Mon, Mar 18, 2019 at 12:15 PM Thomas Renninger <trenn@suse.de> wrote:
> > ...

...

> > > > > It may not match every setup perfectly, but at least it
> > > > > is consistent.  Why exactly is it worse than whatever the BIOS has
> > > > > set?
> > > > 
> > > > Because there may be BIOS settings for the CPU which justify
> > > > initialization
> > > > of the Perf BIAS value by BIOS.
> > > 
> > > Well, the EPB is there for users to set it via the OS.  The BIOS
> > > setting is not guaranteed to work for all users anyway.
> > 
> > Who says that?
> 
> I do.

And this is the reason you do not see much patches from myself anymore over
the last years.
It's certainly not your fault. I had quite some discussions with Len about
specification and BIOS breakages.

Especially in the CPU powersave area, idle states and cpufreq drivers, Intel
was doing it differently all time long the last 5 years. Ignoring their own
specifications, ignoring possible BIOS settings and changing kernel and 
userspace interfaces all the time.

And now I have the discussion again...
While it is related to this patch, it gets off topic.
I guess there should be a more general thread on lkml:
"Do not change APIs every second day"
Up to userspace, but also to BIOS.

> And then we can get back to the initial setting discussion.

Let's stick to this topic in this thread.
There is no reason to not find a proper fix for this meanwhile.

Overriding the BIOS setting should IMO only take place:
- if lifetime of CPU could be affected as you mentioned. But in this case the
  affected CPUs should be matched
- if we expect that there are BIOSes which "want to set this value to 6,
  but may have forgotten to do so", as mentioned in the original patch
  from Len. BIOSes where this is the case should get a quirk to set it to 6.

Still, ideally the whole overriding and the message should vanish IMO.

Last time I sent this patch your answer was:
"I need to talk to Len about that,"
https://lkml.org/lkml/2016/3/4/371

But as this is x86 kernel core code, I guess this should be discussed and 
pushed by the general x86 maintainers anyway. Sigh.

     Thomas
