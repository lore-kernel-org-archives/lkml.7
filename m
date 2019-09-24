Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54497C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449920872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569326643;
	bh=xezlHRUXwqPLp/EWIjhR9Lv2YlL6Zeb7pC28N/EHRiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ZyfVJwb15MxJF7YkNx3wG5zHyZiZUEHE97tvUceobP6A90jBw9BIORWOjZ9SgJFY
	 6kfsUWg0dsK0z6oiK2giB8w06FyN60WI6cOCNvhcjJWEaFn/ecBcNC1w024bklSowc
	 ZfWke6/vps2jSb8Zj7nCgAsOY9xZX+oyfiXwhWLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504863AbfIXMEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:04:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439102AbfIXMEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:04:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0E30ACC3;
        Tue, 24 Sep 2019 12:04:00 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:04:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab, memcontrol: undefined reference to
 `memcg_kmem_get_cache'
Message-ID: <20190924120400.GN23050@dhcp22.suse.cz>
References: <DB7PR02MB397977A2959BFFA89AA67538BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR02MB397977A2959BFFA89AA67538BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 24-09-19 08:46:48, Mircea CIRJALIU - MELIU wrote:
> Having CONFIG_MEMCG turned off causes these issues:
> 	mm/slub.o: In function `slab_pre_alloc_hook':
> 	/home/mircea/build/mm/slab.h:425: undefined reference to `memcg_kmem_get_cache'
> 	mm/slub.o: In function `slab_post_alloc_hook':
> 	/home/mircea/build/mm/slab.h:444: undefined reference to `memcg_kmem_put_cache'

You should be adding your Sign-off-by to every patch you post to the
kernel mailing list (see Documentation/SubmittingPatches).

It is also really important to mention which tree does this apply to and
ideally also note which change has broken the code. In this particular
case I have tried the current Linus tree (4c07e2ddab5b) and
$ grep 'CONFIG_SLUB\|CONFIG_MEMCG' .config
# CONFIG_MEMCG is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB=y
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set

which means CONFIG_MEMCG_KMEM is not enabled as well. And the
compilation succeeds. What is your config file?
-- 
Michal Hocko
SUSE Labs
