Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF00FCA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A47222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571388932;
	bh=BkTUX5ZhNxJJ7MAAACqIMUomtLgTABx9BtKZ/Ip6ANA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZOKyRhhH8HpY6+t1QBnfgyAKhet8aa8bTewpvCHJ7L7RJefYaZdUO5Lmp3Zm2NN7e
	 79J+1IP2qFjMqvFg9oSHgk6CIdGN54aVGYGA8d+P+iEYXe3Qb5Ka9wDq5XOigCNvfq
	 8BgzWsR/8ofLBhgbLauwTwZOzobiw+bT3ZpzKi9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394801AbfJRIzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:55:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731444AbfJRIza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:55:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BE5BB715;
        Fri, 18 Oct 2019 08:55:29 +0000 (UTC)
Date:   Fri, 18 Oct 2019 10:55:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Qian Cai <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Message-ID: <20191018085528.GG5017@dhcp22.suse.cz>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
 <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
 <20191017100106.GF24485@dhcp22.suse.cz>
 <1571335633.5937.69.camel@lca.pw>
 <20191017182759.GN24485@dhcp22.suse.cz>
 <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
 <33946728-bdeb-494a-5db8-e279acebca47@redhat.com>
 <20191018082459.GE5017@dhcp22.suse.cz>
 <f065d998-7fa3-ef9a-c2f4-5b9116f5596b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f065d998-7fa3-ef9a-c2f4-5b9116f5596b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-10-19 10:38:21, David Hildenbrand wrote:
> On 18.10.19 10:24, Michal Hocko wrote:
> > On Fri 18-10-19 10:13:36, David Hildenbrand wrote:
> > [...]
> > > However, if the compound page spans multiple pageblocks
> > 
> > Although hugetlb pages spanning pageblocks are possible this shouldn't
> > matter in__test_page_isolated_in_pageblock because this function doesn't
> > really operate on pageblocks as the name suggests.  It is simply
> > traversing all valid RAM ranges (see walk_system_ram_range).
> 
> As long as the hugepages don't span memory blocks/sections, you are right. I
> have no experience with gigantic pages in this regard.

They can clearly span sections (1GB is larger than 128MB). Why do you
think it matters actually? walk_system_ram_range walks RAM ranges and no
allocation should span holes in RAM right?
-- 
Michal Hocko
SUSE Labs
