Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E72FECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245B121835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570620270;
	bh=4Fmcfm0KoFdBw5yYG0RqxVWrs++/JYc4VaSHXoV5tes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rQtU1GbPZdgHI3hdQAqdjgD1gxj2euO7nvQrHLPkNMXb4hZzkc/bU9mJJaF1ALkyf
	 W1a8ul4IRu+oP9EzDi0rFlwl28av3DMap9gSes4gZOxltVbnJsz1E7wlxPRVvYP+8g
	 fk4wnl9X32rLAGXE/22ftn6NaV8neWxJq1+7FsWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfJILY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:24:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727035AbfJILY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:24:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C333AF05;
        Wed,  9 Oct 2019 11:24:26 +0000 (UTC)
Date:   Wed, 9 Oct 2019 13:24:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Alexey Dobriyan <adobriyan@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix access of uninitialized memmaps in
 fs/proc/page.c
Message-ID: <20191009112424.GY6681@dhcp22.suse.cz>
References: <20191009091205.11753-1-david@redhat.com>
 <20191009093756.GV6681@dhcp22.suse.cz>
 <67aeaacc-d850-5c81-bd17-e95c7f7f75df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67aeaacc-d850-5c81-bd17-e95c7f7f75df@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-10-19 12:19:59, David Hildenbrand wrote:
[...]
> > pfn_to_online_page makes sense because offline pages are not really in a
> > defined state. This would be worth a patch of its own. I remember there
> 
> The issue is, once I check for pfn_to_online_page(), these functions
> can't handle ZONE_DEVICE at all anymore. Especially in regards to
> memory_failure() I don't think this is acceptable.

Could you be more specific please? I am not sure I am following.

> So while I
> (personally) only care about adding pfn_to_online_page() checks, the
> in-this-sense-fragile-subsection ZONE_DEVICE implementation requires me
> to introduce a temporary check for initialized memmaps.
> 
> > was a discussion about the uninitialized zone device memmaps. It would
> > be really good to summarize this discussion in the changelog and
> > conclude why the explicit check is really good and what were other
> > alternatives considered.
> 
> Yeah, I also expressed my feelings and the issues to be solved by
> ZONE_DEVICE people in https://lkml.org/lkml/2019/9/6/114. However, the
> discussion stalled and nobody really proposed a solution or followed up.

I will try to get back to that discussion but is there any technical
reason that prevents any conclusion or it is just stuck on a lack of
time of the participants?

-- 
Michal Hocko
SUSE Labs
