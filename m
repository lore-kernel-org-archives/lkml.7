Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BECAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2918720850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553162022;
	bh=Vt2c+8V/rp62lNuA24Q/fll7XGy7Xyaes4pvurW1C0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CLgNWKijGF2sCpslNgArGJ4S1yERVSB9y8lkNl+IXwk1yEmG1YJi+4mT0EnxzgK+J
	 yN1PRKxMTnhwW4+/4q8uaMKj6YRiaqhCKllJH9cznXnFhzeZ2bnIQrixQzqFx72hqw
	 oVR7arYlBrWi8ajrs1v8wimp664f695IZYvjI+6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfCUJxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:53:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728049AbfCUJxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:53:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67D92B0BE;
        Thu, 21 Mar 2019 09:53:38 +0000 (UTC)
Date:   Thu, 21 Mar 2019 10:53:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [External] Re: mm/cma.c: High latency for cma allocation
Message-ID: <20190321095337.GM8696@dhcp22.suse.cz>
References: <SG2PR02MB3098E44824F5AA69BC04F935E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190318130757.GG8924@dhcp22.suse.cz>
 <SG2PR02MB309886996889791555D5B53EE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190318134242.GI8924@dhcp22.suse.cz>
 <SG2PR02MB30986F43403B92F31499E42AE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190318142916.GK8924@dhcp22.suse.cz>
 <SG2PR02MB3098DCB820E3367B09DDA45AE8400@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB30981381635A6BC3783D42CDE8400@SG2PR02MB3098.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR02MB30981381635A6BC3783D42CDE8400@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you please fix your email client? The broken quoting is just
irritating.

On Tue 19-03-19 11:45:03, Pankaj Suryawanshi wrote:
[...]
> I have tried for latency count for 385MB:
> 
> reclaim- reclaim_clean_pages_from_list()
> migrate- migrate_pages()
> migrateranges- isolate_migratepages_range()
> overall - __alloc_contig_migrate_range()
> 
> Note: output is in us
> 
> [ 1151.420923] LATENCY reclaim= 43 migrate=128 migrateranges=23
> [ 1151.421209] LATENCY reclaim= 11 migrate=253 migrateranges=14
> [ 1151.427856] LATENCY reclaim= 45 migrate=12 migrateranges=12
> [ 1151.434485] LATENCY reclaim= 44 migrate=33 migrateranges=12
> [ 1151.440975] LATENCY reclaim= 45 migrate=0 migrateranges=11
> [ 1151.447513] LATENCY reclaim= 39 migrate=35 migrateranges=11
> [ 1151.453919] LATENCY reclaim= 46 migrate=0 migrateranges=12
> [ 1151.460474] LATENCY reclaim= 39 migrate=41 migrateranges=11
> [ 1151.466947] LATENCY reclaim= 54 migrate=32 migrateranges=17
> [ 1151.473464] LATENCY reclaim= 45 migrate=21 migrateranges=12
> [ 1151.480016] LATENCY reclaim= 41 migrate=39 migrateranges=12
> [ 1151.486551] LATENCY reclaim= 41 migrate=36 migrateranges=12
> [ 1151.493199] LATENCY reclaim= 13 migrate=188 migrateranges=12
> [ 1151.500034] LATENCY reclaim= 60 migrate=94 migrateranges=13
> [ 1151.506686] LATENCY reclaim= 78 migrate=9 migrateranges=12
> [ 1151.513313] LATENCY reclaim= 33 migrate=147 migrateranges=12
> [ 1151.519839] LATENCY reclaim= 52 migrate=98 migrateranges=12
> [ 1151.526556] LATENCY reclaim= 46 migrate=126 migrateranges=12
> [ 1151.533254] LATENCY reclaim= 22 migrate=230 migrateranges=12
> [ 1151.540145] LATENCY reclaim= 0 migrate=305 migrateranges=13
> [ 1151.546997] LATENCY reclaim= 1 migrate=301 migrateranges=13
> [ 1151.553686] LATENCY reclaim= 40 migrate=201 migrateranges=12
> [ 1151.560395] LATENCY reclaim= 35 migrate=149 migrateranges=12
> [ 1151.567076] LATENCY reclaim= 77 migrate=43 migrateranges=16
> [ 1151.573836] LATENCY reclaim= 34 migrate=190 migrateranges=12
> [ 1151.580510] LATENCY reclaim= 51 migrate=120 migrateranges=12
> [ 1151.587240] LATENCY reclaim= 33 migrate=147 migrateranges=13
> [ 1151.594036] LATENCY reclaim= 20 migrate=241 migrateranges=13
> [ 1151.600749] LATENCY reclaim= 75 migrate=41 migrateranges=13
> [ 1151.607402] LATENCY reclaim= 77 migrate=32 migrateranges=12
> [ 1151.613956] LATENCY reclaim= 72 migrate=35 migrateranges=12
> [ 1151.620642] LATENCY reclaim= 59 migrate=162 migrateranges=12
> [ 1151.627181] LATENCY reclaim= 76 migrate=9 migrateranges=11
> [ 1151.633795] LATENCY reclaim= 80 migrate=0 migrateranges=12
> [ 1151.640278] LATENCY reclaim= 87 migrate=18 migrateranges=12
> [ 1151.646758] LATENCY reclaim= 82 migrate=10 migrateranges=11
> [ 1151.653307] LATENCY reclaim= 71 migrate=31 migrateranges=12
> [ 1151.659911] LATENCY reclaim= 61 migrate=77 migrateranges=12
> [ 1151.666514] LATENCY reclaim= 94 migrate=42 migrateranges=15
> [ 1151.673089] LATENCY reclaim= 67 migrate=59 migrateranges=12
> [ 1151.679655] LATENCY reclaim= 81 migrate=14 migrateranges=12
> [ 1151.686253] LATENCY reclaim= 49 migrate=93 migrateranges=12
> [ 1151.692815] LATENCY reclaim= 61 migrate=54 migrateranges=12
> [ 1151.699438] LATENCY reclaim= 42 migrate=99 migrateranges=10
> [ 1151.705881] OVERALL overall=285157

cumulative numbers are

reclaim:2222 migrate:3995 migrateranges:552 sum:6217

So those code paths you were measuring were contributing to the overal
latency only marginally (~2%).
 
> cma_alloc latency is = 297385 us

As I've said earlier I would just use perf with the call graph support
and look at the time distribution to see where the bottleneck is.
-- 
Michal Hocko
SUSE Labs
