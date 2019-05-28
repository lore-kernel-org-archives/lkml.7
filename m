Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6560CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CA920717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559028228;
	bh=Pz7mMJLhEW7Zp0fSOykIhfE4492MoQ1wmZVAGawqZJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2VZgQx/PU04Q20QRh982rUAsylWmoOsv2qg+EuhzaW1xHgVKZC+XclDEx8vYUzhCC
	 GSNI9fWdSmNkRlyKm8hajLzwmGs3rWxFqziycmpj7JoNWCoh7QGaJWuogv/7K3eB55
	 HAo8DhqWlfZ9jThd/f62P7N8/HY2iO66LlL2VuNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfE1HXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:23:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfE1HXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7A0CADC1;
        Tue, 28 May 2019 07:23:45 +0000 (UTC)
Date:   Tue, 28 May 2019 09:23:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 5/7] mm: introduce external memory hinting API
Message-ID: <20190528072344.GO1658@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-6-minchan@kernel.org>
 <20190521153113.GA2235@redhat.com>
 <20190527074300.GA6879@google.com>
 <20190527151201.GB8961@redhat.com>
 <20190527233306.GE6879@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527233306.GE6879@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-05-19 08:33:06, Minchan Kim wrote:
> On Mon, May 27, 2019 at 05:12:02PM +0200, Oleg Nesterov wrote:
> > On 05/27, Minchan Kim wrote:
> > >
> > > > another problem is that pid_task(pid) can return a zombie leader, in this case
> > > > mm_access() will fail while it shouldn't.
> > >
> > > I'm sorry. I didn't notice that. However, I couldn't understand your point.
> > > Why do you think mm_access shouldn't fail even though pid_task returns
> > > a zombie leader?
> > 
> > The leader can exit (call sys_exit(), not sys_exit_group()), this won't affect
> > other threads. In this case the process is still alive even if the leader thread
> > is zombie. That is why we have find_lock_task_mm().
> 
> Thanks for clarification, Oleg. Then, Let me have a further question.
> 
> It means process_vm_readv, move_pages have same problem too because find_task_by_vpid
> can return a zomebie leader and next line checks for mm_struct validation makes a
> failure. My understand is correct? If so, we need to fix all places.

Isn't that a problem of most callers of get_task_mm? Shouldn't we fix it
turning it into find_lock_task_mm?
-- 
Michal Hocko
SUSE Labs
