Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0471CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82BD216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfHLP25 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbfHLP24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:28:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E86B5208C2;
        Mon, 12 Aug 2019 15:28:54 +0000 (UTC)
Date:   Mon, 12 Aug 2019 11:28:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [Linux 5.2.x]
 /sys/kernel/debug/tracing/events/power/cpu_idle/id: BUG: kernel NULL
 pointer dereference, address: 0000000000000000
Message-ID: <20190812112853.53ecc122@gandalf.local.home>
In-Reply-To: <20190811153326.GA8036@eldamar.local>
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de>
        <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de>
        <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de>
        <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
        <alpine.DEB.2.21.1908110822110.7324@nanos.tec.linutronix.de>
        <20190811094630.GA18925@eldamar.local>
        <alpine.DEB.2.21.1908111456430.7324@nanos.tec.linutronix.de>
        <20190811153326.GA8036@eldamar.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2019 17:33:26 +0200
Salvatore Bonaccorso <carnil@debian.org> wrote:

> Thomas,
> 
> On Sun, Aug 11, 2019 at 02:58:15PM +0200, Thomas Gleixner wrote:
> > Salvatore,
> > 
> > On Sun, 11 Aug 2019, Salvatore Bonaccorso wrote:  
> > > On Sun, Aug 11, 2019 at 08:22:35AM +0200, Thomas Gleixner wrote:  
> > > > On Sat, 10 Aug 2019, Paul Menzel wrote:  
> > > > > For the record. It is also reproducible with Linux 5.2.6, and trying to print
> > > > > the file contents with cat already fails.
> > > > > 
> > > > > ```
> > > > > $ sudo ls -l /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > > > -r--r--r-- 1 root root 0 Aug 10 23:05
> > > > > /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > > > $ sudo cat /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > > > Killed
> > > > > ```  
> > > 
> > > This seems to be related to https://bugs.debian.org/934304 (in
> > > particular https://bugs.debian.org/934304#29). The mentioned patch
> > > features/all/lockdown/0031-tracefs-Restrict-tracefs-when-the-kernel-is-locked-d.patch
> > > is a backport of https://patchwork.kernel.org/patch/11069661/ with
> > > only change that it is converted back to the non-LSM lockdown API.  
> > 
> > So that's a debian kernel specific issue?  
> 
> "yes". A kernel build without the above patch does not exhibit the
> issue. So the issue is specific to that lockdown patch ("tracefs:
> Restrict tracefs when the kernel is locked down").
> 
> Steven and Matthew are both CC'ed.

From what I understand, Matthew's "lockdown" work is to prevent the
system from doing anything to see what is happening in the kernel. This
includes tracefs. This looks like it is working as designed.

Perhaps it's something in debian setup that needs to keep tracefs from
being selected as "lockdown", otherwise anything that tries to access
it, will have these issues.

-- Steve

