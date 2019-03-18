Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0597DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C101820811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfCRNWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:22:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:41446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfCRNWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:22:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6529FAF6A;
        Mon, 18 Mar 2019 13:22:11 +0000 (UTC)
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
Date:   Mon, 18 Mar 2019 14:22:10 +0100
Message-ID: <3100343.nkNWlhakcz@house>
In-Reply-To: <CAJZ5v0jAY8OcTMKu4fn7NKVn0E+MqnWSUbSBLUjg0+2adnJ+7Q@mail.gmail.com>
References: <6369897.qxlu8PgE1t@house> <2616815.TtRSCVe66q@house> <CAJZ5v0jAY8OcTMKu4fn7NKVn0E+MqnWSUbSBLUjg0+2adnJ+7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 18, 2019 12:40:46 PM CET Rafael J. Wysocki wrote:
> On Mon, Mar 18, 2019 at 12:15 PM Thomas Renninger <trenn@suse.de> wrote:

...
 
> And who's BIOS, really?  I guess you mean the OEM?  Note, however,
> that the user and the OEM may not agree on that, but whatever.

I mean both!
The OEM.
And the user who might choose a "performance" BIOS setting.

> > > Yes, the kernel replaces whatever the original BIOS setting is with
> > > its own one.
> > 
> > No, it only replaces the "performance" (0) value with "normal" (6).
> > This does not makes sense and is broken.

Both know it better than this...

> OK, fair enough.
> 
> I guess it would have been better to set it to 6 unconditionally.

No, I guess keeping the original value is the only sane thing to do.
Sorry, Rafael, I have to insist on this.
There might be secrets Len and you cannot share with public, but you
should at least explain this privately then in a way that the current
code could somehow make sense. I absolutely cannot see that.

> What about the systems that will misbehave when it is left at 0?

Good question.
What exactly happens there? The CPU is faster in general?
And may consume a tiny bit more of power.
I had reports that Turbo Mode is not entered on some server CPUs when
perf BIAS is switched back to normal mode.
It is hard to identify what Intel implemented in microcode, but it's not
that much altogether. It would be nice if Intel would be a bit more verbose
about this and show some performance vs powersave figures.

> > > It may not match every setup perfectly, but at least it
> > > is consistent.  Why exactly is it worse than whatever the BIOS has
> > > set?
> > 
> > Because there may be BIOS settings for the CPU which justify
> > initialization
> > of the Perf BIAS value by BIOS.
> 
> Well, the EPB is there for users to set it via the OS.  The BIOS
> setting is not guaranteed to work for all users anyway.

Who says that? Is this documented?

I would say it is exactly the other way around. Energy Perf BIAS hint is
a MSR which must be changed in Ring 0 kernel environment.

x86_energy_perf_policy is a nice tool to play with and to try out what
this value is for. But for example in secure boot mode userspace must not
modify this HW setting in any way.
So it would not be possible for a secure booted server to switch this
setting back to performance mode.
 
> > What sense does it make to unconditionally set perf BIAS value from
> > performance to balanced?
> > Why is this done?
> 
> Basically, for HW health reasons AFAICS.
>  
> Apparently, on some systems EPB=0 is (was?) special and means (meant?)
> very aggressive use of turbo etc. which is not healthy in general.

Hmm, maybe you want to explain this privately.
Performance is a valid setting.
x86_energy_perf_policy tool has a "performance" string for this and I expect it is very used.
I would switch to it if I am constantly connected to AC.
man x86_energy_perf_policy
also does not tell the user anything about "be careful with performance setting"

And until today every CPU online/offline cycle or machine resume cycle switches
the value back to performance (if kernel tried to switch to 6).

...
 
> > There may be BIOSes initialzing it via BIOS options. And this is a very
> > valid thing to do.
> 
> Yes, and there may be BIOSes leaving it at 0 with the assumption that
> the OS will adjust it.  The kernel cannot know which is the case.

Correct. The kernel cannot know.

You know this better than anyone else:
- A specific Microsoft version is doing it wrong.
- We adopt.
- Microsoft is doing it correctly with the next version
- We are busted

I am ok with leaving the message as a hint, I would still check
ACPI prefered profile variable that we are not running on a server.
On these systems the message would be wrong rather sure and performance is intended.

...

> > No. You must not ignore BIOS settings. Even worse, you must not override
> > these without any sane reason.
> 
> While there are BIOS settings that better should not be overridden,
> the EPB is not one of them.

Again: Why or where is this documented?

> > Your assumption above might be right. But we want to do it better, right?
> > 
> > ...
> > 
> > > The system-wide resume part will still not be working properly after
> > > the reverts.
> > 
> > But it must never blindly (unconditionally) be set to specific value.
> > Correct?
> 
> Yes.  I've already said that.

How about below solution then for the initial boot up sequence?
 
> > You mean the kernel should store the pre-hibernation perf BIAS value
> > in NVRAM and write it back when waking up again?
> 
> Or in the image and yes, it should write it back.

Can you point me to a similar case where a variable is stored through
hibernation?
If it's not too much I can try to come up with an (compiled but untested) patch.

> > This would make sense.
> > 
> > It would also mean perf BIAS never really worked, at least did not survive
> > suspend.
> 
> Right.
> 
> > On servers (no hibernation) it would works but is overridden
> > to a value you typically do not want to have on a server...
> > So the current situation is rather broken in the kernel.
> 
> Well, you can say so, but fixing it really means something more than
> reverting the commits that your patch is reverting and *that* is my
> point.
> 
> Yes, I think that this needs to be fixed.
> 
> No, I don't think that the reverts you are proposing are the way to go here.

Why?
It is the first step to go.

You are missing the save and restore part?
But these never existed anyway.

       Thomas


Patch compile tested only on a specific .config as an RFC:

--- arch/x86/kernel/cpu/intel.c.orig	2019-03-18 13:41:08.380418119 +0100
+++ arch/x86/kernel/cpu/intel.c	2019-03-18 14:03:40.092490953 +0100
@@ -9,6 +9,7 @@
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/acpi.h>
 
 #include <asm/cpufeature.h>
 #include <asm/pgtable.h>
@@ -611,10 +612,12 @@
 	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
 		return;
 
-	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
-	pr_warn_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
-	epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
-	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
+	if (acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER ||
+	    acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER)
+		return;
+
+	pr_info_once("ENERGY_PERF_BIAS: has value: 'performance'\n");
+	pr_info_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
 }
 
 static void intel_bsp_resume(struct cpuinfo_x86 *c)

