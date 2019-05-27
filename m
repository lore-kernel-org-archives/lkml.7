Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3CBC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9062184C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558966920;
	bh=kG7V+mXLimU7X9W6lFfIq5A6UNQxpn5WT9PMt5ll0oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EBcja9cx45vZxd+bMzZ9y/fGLZMoiCNSKTzp3oUMTEZPAK7GtXKncqnjNJSAdjNnf
	 H0qjEwvTkm9ETpCITEgOu9v73hHQdfxza250HkNovWTuI3ZhcGh0oxLb/3VwdrR1iR
	 /Lo+x7ZP0GSBaXs7h9E7NHPutaHZjBIQO/HTZ3q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfE0OV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:21:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfE0OV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:21:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25D96AEF3;
        Mon, 27 May 2019 14:21:58 +0000 (UTC)
Date:   Mon, 27 May 2019 16:21:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: implement MADV_STOCKPILE (kswapd from
 user space)
Message-ID: <20190527142156.GE1658@dhcp22.suse.cz>
References: <155895155861.2824.318013775811596173.stgit@buzz>
 <20190527141223.GD1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527141223.GD1658@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-05-19 16:12:23, Michal Hocko wrote:
> [Cc linux-api. Please always cc this list when proposing a new user
>  visible api. Keeping the rest of the email intact for reference]
> 
> On Mon 27-05-19 13:05:58, Konstantin Khlebnikov wrote:
[...]
> > This implements manual kswapd-style memory reclaim initiated by userspace.
> > It reclaims both physical memory and cgroup pages. It works in context of
> > task who calls syscall madvise thus cpu time is accounted correctly.

I do not follow. Does this mean that the madvise always reclaims from
the memcg the process is member of?
-- 
Michal Hocko
SUSE Labs
