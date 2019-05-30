Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A35C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8271E25B8F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559199076;
	bh=piYix+pjeAnUxECw6J/1yYX/JmsLwkopdsKMeiiw7Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h7n4SejfGzJCl9Kt53PAErJ/v5CB1XRpmUtjntglJI0dUhgGWCI/E3KUn0xcPZW5u
	 EPx6bNQMo9MR4g8NKmDzr93Oo05rsEzfFYudLie0KcZ8Veqv9WlEtk3GEd9zGQ8KFJ
	 nPIbskBU8Cpep3+rFdDNzcI25Zy/oep4a/HDfikY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfE3GvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:51:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:51150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3GvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:51:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15D2EACF8;
        Thu, 30 May 2019 06:51:14 +0000 (UTC)
Date:   Thu, 30 May 2019 08:51:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190530065111.GC6703@dhcp22.suse.cz>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190530061221.GA6703@dhcp22.suse.cz>
 <20190530064453.GA110128@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530064453.GA110128@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-05-19 23:44:53, Chris Down wrote:
> Michal Hocko writes:
> > Maybe I am missing something so correct me if I am wrong but the new
> > calculation actually means that we always allow to scan even min
> > protected memcgs right?
> 
> We check if the memcg is min protected as a precondition for coming into
> this function at all, so this generally isn't possible. See the
> mem_cgroup_protected MEMCG_PROT_MIN check in shrink_node.

OK, that is the part I was missing, I got confused by checking the min
limit as well here. Thanks for the clarification. A comment would be
handy or do we really need to consider min at all?

> (Of course, it's possible we race with going within protection thresholds
> again, but this patch doesn't make that any better or worse than the
> previous situation.)

Yeah.

With the above clarified. The code the resulting code is much easier to
follow and the overal logic makes sense to me.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
