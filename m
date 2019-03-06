Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE78FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7650720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfCFQXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:23:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCFQXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:23:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B033680F7A;
        Wed,  6 Mar 2019 16:23:16 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 746F55C28C;
        Wed,  6 Mar 2019 16:23:15 +0000 (UTC)
Date:   Wed, 6 Mar 2019 11:23:13 -0500
From:   Phil Auld <pauld@redhat.com>
To:     bsegall@google.com
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
Message-ID: <20190306162313.GB8786@pauld.bos.csb>
References: <20190301145209.GA9304@pauld.bos.csb>
 <xm26ef7mzew2.fsf@bsegall-linux.svl.corp.google.com>
 <20190304190510.GB5366@lorien.usersys.redhat.com>
 <xm268sxtyx5u.fsf@bsegall-linux.svl.corp.google.com>
 <20190305200554.GA8786@pauld.bos.csb>
 <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 06 Mar 2019 16:23:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 12:45:34PM -0800 bsegall@google.com wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > Interestingly, if I limit the number of child cgroups to the number of 
> > them I'm actually putting processes into (16 down from 2500) the problem
> > does not reproduce.
> 
> That is indeed interesting, and definitely not something we'd want to
> matter. (Particularly if it's not root->a->b->c...->throttled_cgroup or
> root->throttled->a->...->thread vs root->throttled_cgroup, which is what
> I was originally thinking of)
> 

The locking may be a red herring.

The setup is root->throttled->a where a is 1-2500. There are 4 threads in
each of the first 16 a groups.  The parent, throttled, is where the 
cfs_period/quota_us are set. 

I wonder if the problem is the walk_tg_tree_from() call in unthrottle_cfs_rq(). 

The distribute_cfg_runtime looks to be O(n * m) where n is number of 
throttled cfs_rqs and m is the number of child cgroups. But I'm not 
completely clear on how the hierarchical cgroups play together here. 

I'll pull on this thread some. 

Thanks for your input.


Cheers,
Phil

-- 
