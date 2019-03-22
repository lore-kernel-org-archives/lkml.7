Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01537218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553272422;
	bh=vBMmIYWinP9ID3nsFNnw8dW/txhV8eRk56kGmRTCOuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VAcjk5r37dhFjs3XyEGYmmYDA+vHSx18zESY6QB/+0ONxh6c9/faatqWVW1D2vKzc
	 vR89q/0ZQ8EajtWfUagmdkU9IqgMGSCi4wMEX4GMMzyLx8ruLvq903kdHHBQSEH6Fc
	 PZvi/48yMd7tfksTdHp1f2qzQzMhphaUfGIyS2AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCVQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:33:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:16971 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfCVQdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:33:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:33:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="142975999"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Mar 2019 09:33:39 -0700
Date:   Fri, 22 Mar 2019 10:34:41 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/5] mm: Attempt to migrate page in lieu of discard
Message-ID: <20190322163440.GB31194@localhost.localdomain>
References: <20190321200157.29678-1-keith.busch@intel.com>
 <20190321200157.29678-4-keith.busch@intel.com>
 <CAHbLzkqGGJ7dFiZkR-=yvGEF0AM4JbBe6pxGFbSe9tSnC7wgzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqGGJ7dFiZkR-=yvGEF0AM4JbBe6pxGFbSe9tSnC7wgzQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:58:16PM -0700, Yang Shi wrote:
> On Thu, Mar 21, 2019 at 1:03 PM Keith Busch <keith.busch@intel.com> wrote:
> > +               if (!PageCompound(page)) {
> > +                       if (migrate_demote_mapping(page)) {
> > +                                unlock_page(page);
> > +                                if (likely(put_page_testzero(page)))
> > +                                        goto free_it;
> > +
> > +                                /*
> > +                                * Speculative reference will free this page,
> > +                                * so leave it off the LRU.
> > +                                */
> > +                                nr_reclaimed++;
> > +                                continue;
> > +                        }
> > +               }
> 
> It looks the reclaim path would fall through if the migration is
> failed. But, it looks, with patch #4, you may end up trying reclaim an
> anon page on swapless system if migration is failed?

Right, and add_to_swap() will fail and the page jumps to activate_locked
label, placing it back where it was before.

> And, actually I have the same question with Yan Zi. Why not just put
> the demote candidate into a separate list, then migrate all the
> candidates in bulk with migrate_pages()?

The page is already locked at the point we know we want to migrate it.
