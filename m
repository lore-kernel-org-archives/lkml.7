Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC7BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE332054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561540701;
	bh=G50Wt3kpwtn1YHbHvuBbNnS6AkIBfNzAyhM7Bc8epX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Go8+Uou75xNfhbiCbvBNarxCS4rRZTiHFG6AjX+Oe0Xtkl9ef8glaFQmMpG9blOW8
	 IRhmFqDEPTx520jrPtPYkNirBZvQhKB0MvsZHZDkxdL/DQM+RsaHfg4aNYDPpb1e9O
	 oGYf/hQf3qio7ztMYh964NbmGoZoxxr7XUUfW54Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFZJST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:18:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZJST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:18:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEA71ACBC;
        Wed, 26 Jun 2019 09:18:17 +0000 (UTC)
Date:   Wed, 26 Jun 2019 11:18:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Jackson <pj@sgi.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 3/3] oom: decouple mems_allowed from
 oom_unkillable_task
Message-ID: <20190626091759.GP17798@dhcp22.suse.cz>
References: <20190624212631.87212-1-shakeelb@google.com>
 <20190624212631.87212-3-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624212631.87212-3-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-06-19 17:12:10, Hillf Danton wrote:
> 
> On Mon, 24 Jun 2019 14:27:11 -0700 (PDT) Shakeel Butt wrote:
> > 
> > @@ -1085,7 +1091,8 @@ bool out_of_memory(struct oom_control *oc)
> >  	check_panic_on_oom(oc, constraint);
> >  
> >  	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> > -	    current->mm && !oom_unkillable_task(current, oc->nodemask) &&
> > +	    current->mm && !oom_unkillable_task(current) &&
> > +	    has_intersects_mems_allowed(current, oc) &&
> For what?

This is explained in the changelog I believe - see the initial section
about the history and motivation for the check. This patch removes it
from oom_unkillable_task so we have to check it explicitly here.

> >  	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
> >  		get_task_struct(current);
> >  		oc->chosen = current;
> > -- 
> > 2.22.0.410.gd8fdbe21b5-goog

-- 
Michal Hocko
SUSE Labs
