Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B0BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C821F206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566297935;
	bh=MkUD7cGniTgpnelZS0RWQEIGaB0Pe7Up2fGAH52lcrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hp6g+ILUymfKSXVPHbLParsiyvCjiKXyM0Y1KkwzdObY1ePfVQp3rq/PnYCvHKI1O
	 GsOu5iV6UaDGue/dJiW1OT1IlCzhkeaF4iyaYH+O9ILn4oK1MtHofwbN1tYt01VUUv
	 JsqYH/3E8nVGsGtzBJB5rKWp3m6FZheKgPKZLJJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfHTKpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:45:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbfHTKpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:45:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69F2AADD9;
        Tue, 20 Aug 2019 10:45:33 +0000 (UTC)
Date:   Tue, 20 Aug 2019 12:45:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 00/14] per memcg lru_lock
Message-ID: <20190820104532.GP3111@dhcp22.suse.cz>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-08-19 17:48:23, Alex Shi wrote:
> This patchset move lru_lock into lruvec, give a lru_lock for each of
> lruvec, thus bring a lru_lock for each of memcg.
> 
> Per memcg lru_lock would ease the lru_lock contention a lot in
> this patch series.
> 
> In some data center, containers are used widely to deploy different kind
> of services, then multiple memcgs share per node pgdat->lru_lock which
> cause heavy lock contentions when doing lru operation.

Having some real world workloads numbers would be more than useful
for a non trivial change like this. I believe googlers have tried
something like this in the past but then didn't have really a good
example of workloads that benefit. I might misremember though. Cc Hugh.

-- 
Michal Hocko
SUSE Labs
