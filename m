Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9DC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9718921A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569484041;
	bh=SexXtBxe0vFpZYLYMqOQ4zuv5u6WZB62sLtBHFyNw18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1samKKY0DBptKdYVHyVRdUmmct5k5XyJU0+3zA4zOp3iJBs/sf1rC87bb18RQmXZ6
	 3Zp23x945h69cKG3zLsvw5ufgJ2aU+pnslc0WLn+fuSnHrvspRfcUP479/9dabshMA
	 yfs1EcKT7Jh3sk48KHxFmbVIDj7svoyfB4HCng/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfIZHrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:47:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:40082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbfIZHrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:47:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3F94AE0C;
        Thu, 26 Sep 2019 07:47:18 +0000 (UTC)
Date:   Thu, 26 Sep 2019 09:47:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] memory_hotplug: Add a bounds check to __add_pages
Message-ID: <20190926074718.GF20255@dhcp22.suse.cz>
References: <20190926013406.16133-1-alastair@au1.ibm.com>
 <20190926013406.16133-2-alastair@au1.ibm.com>
 <20190926073951.GA17200@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926073951.GA17200@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-09-19 09:40:05, Oscar Salvador wrote:
> On Thu, Sep 26, 2019 at 11:34:05AM +1000, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > @@ -291,6 +307,10 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> >  	unsigned long nr, start_sec, end_sec;
> >  	struct vmem_altmap *altmap = restrictions->altmap;
> >  
> > +	err = check_hotplug_memory_addressable(pfn, nr_pages);
> > +	if (err)
> > +		return err;
> > +
> 
> I am probably off here because 1) I am jumping blind in a middle of a discussion and
> 2) I got back from holydays yesterday, so bear with me.
> 
> Would not be better to just place the check in add_memory_resource instead?

This was the previous version of the patch. The argument is that we do
not want each add_pages user to think of this special handling.
-- 
Michal Hocko
SUSE Labs
