Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8625C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF382215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfK2JNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:13:49 -0500
Received: from foss.arm.com ([217.140.110.172]:45060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2JNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:13:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB2BE30E;
        Fri, 29 Nov 2019 01:13:48 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C57BB3F68E;
        Fri, 29 Nov 2019 01:13:47 -0800 (PST)
Date:   Fri, 29 Nov 2019 09:13:45 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] torture: Replace cpu_up/down with
 device_online/offline
Message-ID: <20191129091344.hf5demtjytv5dw5q@e107158-lin.cambridge.arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-13-qais.yousef@arm.com>
 <20191127214725.GG2889@paulmck-ThinkPad-P72>
 <20191128165611.7lmjaszjl4gbo7u2@e107158-lin.cambridge.arm.com>
 <20191128170025.ii3vqbj4jpcyghut@e107158-lin.cambridge.arm.com>
 <20191128210246.GJ2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191128210246.GJ2889@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/19 13:02, Paul E. McKenney wrote:
> On Thu, Nov 28, 2019 at 05:00:26PM +0000, Qais Yousef wrote:
> > On 11/28/19 16:56, Qais Yousef wrote:
> > > On 11/27/19 13:47, Paul E. McKenney wrote:
> > > > On Mon, Nov 25, 2019 at 11:27:52AM +0000, Qais Yousef wrote:
> > > > > The core device API performs extra housekeeping bits that are missing
> > > > > from directly calling cpu_up/down.
> > > > > 
> > > > > See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> > > > > serialization during LPM") for an example description of what might go
> > > > > wrong.
> > > > > 
> > > > > This also prepares to make cpu_up/down a private interface for anything
> > > > > but the cpu subsystem.
> > > > > 
> > > > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > > > CC: Davidlohr Bueso <dave@stgolabs.net>
> > > > > CC: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > CC: Josh Triplett <josh@joshtriplett.org>
> > > > > CC: linux-kernel@vger.kernel.org
> > > > 
> > > > Looks fine from an rcutorture viewpoint, but why not provide an API
> > > > that pulled lock_device_hotplug() and unlock_device_hotplug() into the
> > > > online/offline calls?
> > > 
> > > I *think* the right way to do what you say is by doing lock_device_hotplug()
> > > inside device_{online, offline}() - which affects all drivers not just the CPU.
> 
> Or there could be a CPU-specific wrapper function that did the needed
> locking.  (Whether this is worth it or not of course depends on the
> number of invocations.)

Okay I see what you mean now. driver/base/memory.c have {add,remove}_memory()
that does what you say. I think we can replicate this in driver/base/cpu.c too.

I can certainly do that, better as an improvement on top as I need to audit the
code to make sure the critical sections weren't relying on this lock to protect
something else beside the online/offline operation.

Thanks!

--
Qais Yousef
