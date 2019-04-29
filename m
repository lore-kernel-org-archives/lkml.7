Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C4C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A240521655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556537428;
	bh=SmrQcGl85sj4/A8uZ60ItQyeotMZqaGBWMZGdslJPnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w1KW7AL3zcqzWk3yC9t2N4YJwHlNeFEThHWos0h+tVoo0D8+GTSWtsyoaQbP0MHIr
	 jYPjsYLemtiQyUVsB1NvXsHVCKts9j5RFVzSDGSh0iR072vy2DClTTO5h5V71g0wVL
	 wPlQ80ECu5ik6XkZQAeSbpPgLk85BZi3+jMoGbN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfD2La1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:30:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbfD2La1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:30:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90B80AE84;
        Mon, 29 Apr 2019 11:30:25 +0000 (UTC)
Date:   Mon, 29 Apr 2019 07:30:22 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH] memcg: make it work on sparse non-0-node systems
Message-ID: <20190429112916.GI21837@dhcp22.suse.cz>
References: <359d98e6-044a-7686-8522-bdd2489e9456@suse.cz>
 <20190429105939.11962-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429105939.11962-1-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-04-19 12:59:39, Jiri Slaby wrote:
[...]
>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
>  {
> -	/*
> -	 * This needs node 0 to be always present, even
> -	 * in the systems supporting sparse numa ids.
> -	 */
> -	return !!lru->node[0].memcg_lrus;
> +	return !!lru->node[first_online_node].memcg_lrus;
>  }
>  
>  static inline struct list_lru_one *

How come this doesn't blow up later - e.g. in memcg_destroy_list_lru
path which does iterate over all existing nodes thus including the
node 0.
-- 
Michal Hocko
SUSE Labs
