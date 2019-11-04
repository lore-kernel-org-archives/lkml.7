Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04EC21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKDINU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:13:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:42010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfKDINU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:13:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9D74AD8C;
        Mon,  4 Nov 2019 08:13:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A653C1E4809; Mon,  4 Nov 2019 09:13:17 +0100 (CET)
Date:   Mon, 4 Nov 2019 09:13:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@suse.de>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC] mm: gup: add helper page_try_gup_pin(page)
Message-ID: <20191104081317.GB22379@quack2.suse.cz>
References: <20191103112113.8256-1-hdanton@sina.com>
 <20191104043420.15648-1-hdanton@sina.com>
 <8df14660-2ce3-eda8-dc33-c4d092915656@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df14660-2ce3-eda8-dc33-c4d092915656@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 03-11-19 22:09:03, John Hubbard wrote:
> On 11/3/19 8:34 PM, Hillf Danton wrote:
> > future, we have options for instance that gupers periodically release
> > their references and re-pin pages after data sync the same way as the
> > current flusher does.
> > 
> 
> That's one idea. I don't see it as viable, given the behavior of, say,
> a compute process running OpenCL jobs on a GPU that is connected via
> a network or Infiniband card--the idea of "pause" really looks more like
> "tear down the complicated multi-driver connection, writeback, then set it
> all up again", I suspect. (And if we could easily interrupt the job, we'd
> probably really be running with a page-fault-capable GPU plus and IB card
> that does ODP, plus HMM, and we wouldn't need to gup-pin anyway...)
> 
> Anyway, this is not amenable to quick fixes, because the problem is
> a couple of missing design pieces. Which we're working on putting in.
> But meanwhile, smaller changes such as this one are just going to move
> the problems to different places, rather than solving them. So it's best
> not to do that.

Yeah, fully agreed here. Quick half baked fixes will make the current messy
situation even worse...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
