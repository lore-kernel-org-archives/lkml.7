Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE560C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B78B2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568790945;
	bh=zszdlfJeNxbiy0155BDIQhySAFtcatKebLAzMMiwG3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MLplP5/WZiQm4C7Y0h4XSzVnz6mcnaNdtohHoeBWOaQVrTdtDoug/Vuj1sesx8UuS
	 rUQ7+qN28BtCWtwu8flrNdWt3wB0KEc5oqC4ph6gy8/WEiKW4d5gl/goudW8y1DtQ9
	 skGitluJNAMWpIrHxesdu/cwK/7xoaNgx+XCqFpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfIRHPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:15:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfIRHPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E90D9B735;
        Wed, 18 Sep 2019 07:15:41 +0000 (UTC)
Date:   Wed, 18 Sep 2019 09:15:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: threads-max observe limits
Message-ID: <20190918071541.GB12770@dhcp22.suse.cz>
References: <20190917100350.GB1872@dhcp22.suse.cz>
 <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
 <20190917153830.GE1872@dhcp22.suse.cz>
 <87ftku96md.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftku96md.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-09-19 12:26:18, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Tue 17-09-19 17:28:02, Heinrich Schuchardt wrote:
> >> 
> >> On 9/17/19 12:03 PM, Michal Hocko wrote:
> >> > Hi,
> >> > I have just stumbled over 16db3d3f1170 ("kernel/sysctl.c: threads-max
> >> > observe limits") and I am really wondering what is the motivation behind
> >> > the patch. We've had a customer noticing the threads_max autoscaling
> >> > differences btween 3.12 and 4.4 kernels and wanted to override the auto
> >> > tuning from the userspace, just to find out that this is not possible.
> >> 
> >> set_max_threads() sets the upper limit (max_threads_suggested) for
> >> threads such that at a maximum 1/8th of the total memory can be occupied
> >> by the thread's administrative data (of size THREADS_SIZE). On my 32 GiB
> >> system this results in 254313 threads.
> >
> > This is quite arbitrary, isn't it? What would happen if the limit was
> > twice as large?
> >
> >> With patch 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
> >> a user cannot set an arbitrarily high number for
> >> /proc/sys/kernel/threads-max which could lead to a system stalling
> >> because the thread headers occupy all the memory.
> >
> > This is still a decision of the admin to make.  You can consume the
> > memory by other means and that is why we have measures in place. E.g.
> > memcg accounting.
> >
> >> When developing the patch I remarked that on a system where memory is
> >> installed dynamically it might be a good idea to recalculate this limit.
> >> If you have a system that boots with let's say 8 GiB and than
> >> dynamically installs a few TiB of RAM this might make sense. But such a
> >> dynamic update of thread_max_suggested was left out for the sake of
> >> simplicity.
> >> 
> >> Anyway if more than 100,000 threads are used on a system, I would wonder
> >> if the software should not be changed to use thread-pools instead.
> >
> > You do not change the software to overcome artificial bounds based on
> > guessing.
> >
> > So can we get back to the justification of the patch. What kind of
> > real life problem does it solve and why is it ok to override an admin
> > decision?
> > If there is no strong justification then the patch should be reverted
> > because from what I have heard it has been noticed and it has broken
> > a certain deployment. I am not really clear about technical details yet
> > but it seems that there are workloads that believe they need to touch
> > this tuning and complain if that is not possible.
> 
> Taking a quick look myself.
> 
> I am completely mystified by both sides of this conversation.
> 
> a) The logic to set the default number of threads in a system
>    has not changed since 2.6.12-rc2 (the start of the git history).
> 
> The implementation has changed but we should still get the same
> value.  So anyone seeing threads_max autoscaling differences
> between kernels is either seeing a bug in the rewritten formula
> or something else weird is going on.
> 
> Michal is it a very small effect your customers are seeing?
> Is it another bug somewhere else?

I am still trying to get more information. Reportedly they see a
different auto tuned limit between two kernel versions which results in
an applicaton complaining. As already mentioned this might be a side
effect of something else and this is not yet fully analyzed. My main
point for bringing up this discussion is ...

> b) Not being able to bump threads_max to the physical limit of
>    the machine is very clearly a regression.

... exactly this part. The changelog of the respective patch doesn't
really exaplain why it is needed except of "it sounds like a good idea
to be consistent".
-- 
Michal Hocko
SUSE Labs
