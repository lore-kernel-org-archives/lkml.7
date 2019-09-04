Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671FEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5C222CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567611483;
	bh=AKawEZgQyjTKSRtTHeHh9Xyr+24+V3DlM/zrWOKaALU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GMSWisYIxrRuMAxJzFndE6vDds86ZwKJbk9argzld6hIb4Zj0TTG4dferf3AxCOPo
	 hs1O2g7sf9l73lh1M5pluIMQ+GZ0b1W2pnb06r01tBpkc2C8A4SA5XAOIMFvaOcWmH
	 oHTjUtsQ7NN7kmRkJ5PhUwV8UjDQMnz3olzaoiYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfIDPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:38:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfIDPiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:38:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50AEAB01E;
        Wed,  4 Sep 2019 15:38:00 +0000 (UTC)
Date:   Wed, 4 Sep 2019 17:37:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        carmenjackson@google.com, mayankgupta@google.com,
        dancol@google.com, rostedt@goodmis.org, minchan@kernel.org,
        akpm@linux-foundation.org, kernel-team@android.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Message-ID: <20190904153759.GC3838@dhcp22.suse.cz>
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz>
 <20190904153258.GH240514@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904153258.GH240514@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-09-19 11:32:58, Joel Fernandes wrote:
> On Wed, Sep 04, 2019 at 10:45:08AM +0200, Michal Hocko wrote:
> > On Tue 03-09-19 16:09:05, Joel Fernandes (Google) wrote:
> > > Useful to track how RSS is changing per TGID to detect spikes in RSS and
> > > memory hogs. Several Android teams have been using this patch in various
> > > kernel trees for half a year now. Many reported to me it is really
> > > useful so I'm posting it upstream.
> > > 
> > > Initial patch developed by Tim Murray. Changes I made from original patch:
> > > o Prevent any additional space consumed by mm_struct.
> > > o Keep overhead low by checking if tracing is enabled.
> > > o Add some noise reduction and lower overhead by emitting only on
> > >   threshold changes.
> > 
> > Does this have any pre-requisite? I do not see trace_rss_stat_enabled in
> > the Linus tree (nor in linux-next).
> 
> No, this is generated automatically by the tracepoint infrastructure when a
> tracepoint is added.

OK, I was not aware of that.

> > Besides that why do we need batching in the first place. Does this have a
> > measurable overhead? How does it differ from any other tracepoints that we
> > have in other hotpaths (e.g.  page allocator doesn't do any checks).
> 
> We do need batching not only for overhead reduction,

What is the overhead?

> but also for reducing
> tracing noise. Flooding the traces makes it less useful for long traces and
> post-processing of traces. IOW, the overhead reduction is a bonus.

This is not really anything special for this tracepoint though.
Basically any tracepoint in a hot path is in the same situation and I do
not see a point why each of them should really invent its own way to
throttle. Maybe there is some way to do that in the tracing subsystem
directly.
-- 
Michal Hocko
SUSE Labs
