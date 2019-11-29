Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C42BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060142075C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575059938;
	bh=3j6IK3gxqY18H5UQcdg7xU+JmmBLUysPA21rIMmh5fU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=feDcHRKQsCd6aNjs0V5oFE8otLIWOhoRmvhpHSFVk5aOAxfpW9knONl8J4P0bTxGi
	 9I9KdrRNyMRpcRbaIgS04ukvRrMQsRO1V3RcmXqmMMj1V9Yr5bHqoNjQJnkZlnFje5
	 8mJPGgADLNUoaa41rTFsP++lF9eWOmFWbgnH1MQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK2Ui5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 15:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfK2Ui4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 15:38:56 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63DDC206E0;
        Fri, 29 Nov 2019 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575059936;
        bh=3j6IK3gxqY18H5UQcdg7xU+JmmBLUysPA21rIMmh5fU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qV3h/3xTQ4pdqUCltsB75EBgxN3PCKpGciLrJaHiUCV+NW8rJ8ZgbyKsa7MFv8TWd
         +PPQmAofot13Vq7BHsmPMtXxr0yIZhXB5DfZt4U3ZfA7CWZ1nPGhqVQvOYHRWLfUJD
         3+PoY61aLbEbq15dzIpc/ZBouQssPIkmsYTymve0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3926B35227A4; Fri, 29 Nov 2019 12:38:56 -0800 (PST)
Date:   Fri, 29 Nov 2019 12:38:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] torture: Replace cpu_up/down with
 device_online/offline
Message-ID: <20191129203856.GN2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-13-qais.yousef@arm.com>
 <20191127214725.GG2889@paulmck-ThinkPad-P72>
 <20191128165611.7lmjaszjl4gbo7u2@e107158-lin.cambridge.arm.com>
 <20191128170025.ii3vqbj4jpcyghut@e107158-lin.cambridge.arm.com>
 <20191128210246.GJ2889@paulmck-ThinkPad-P72>
 <20191129091344.hf5demtjytv5dw5q@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129091344.hf5demtjytv5dw5q@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 09:13:45AM +0000, Qais Yousef wrote:
> On 11/28/19 13:02, Paul E. McKenney wrote:
> > On Thu, Nov 28, 2019 at 05:00:26PM +0000, Qais Yousef wrote:
> > > On 11/28/19 16:56, Qais Yousef wrote:
> > > > On 11/27/19 13:47, Paul E. McKenney wrote:
> > > > > On Mon, Nov 25, 2019 at 11:27:52AM +0000, Qais Yousef wrote:
> > > > > > The core device API performs extra housekeeping bits that are missing
> > > > > > from directly calling cpu_up/down.
> > > > > > 
> > > > > > See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> > > > > > serialization during LPM") for an example description of what might go
> > > > > > wrong.
> > > > > > 
> > > > > > This also prepares to make cpu_up/down a private interface for anything
> > > > > > but the cpu subsystem.
> > > > > > 
> > > > > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > > > > CC: Davidlohr Bueso <dave@stgolabs.net>
> > > > > > CC: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > CC: Josh Triplett <josh@joshtriplett.org>
> > > > > > CC: linux-kernel@vger.kernel.org
> > > > > 
> > > > > Looks fine from an rcutorture viewpoint, but why not provide an API
> > > > > that pulled lock_device_hotplug() and unlock_device_hotplug() into the
> > > > > online/offline calls?
> > > > 
> > > > I *think* the right way to do what you say is by doing lock_device_hotplug()
> > > > inside device_{online, offline}() - which affects all drivers not just the CPU.
> > 
> > Or there could be a CPU-specific wrapper function that did the needed
> > locking.  (Whether this is worth it or not of course depends on the
> > number of invocations.)
> 
> Okay I see what you mean now. driver/base/memory.c have {add,remove}_memory()
> that does what you say. I think we can replicate this in driver/base/cpu.c too.
> 
> I can certainly do that, better as an improvement on top as I need to audit the
> code to make sure the critical sections weren't relying on this lock to protect
> something else beside the online/offline operation.

Works for me!

							Thanx, Paul
