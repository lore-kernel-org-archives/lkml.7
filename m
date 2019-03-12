Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698EC2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfCLUel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:34:41 -0400
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:56731 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbfCLUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:34:40 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl6.internode.on.net with ESMTP; 13 Mar 2019 07:04:36 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1h3o6e-0001QJ-6W; Wed, 13 Mar 2019 07:34:36 +1100
Date:   Wed, 13 Mar 2019 07:34:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-ID: <20190312203436.GE23020@dastard>
References: <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
 <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
 <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
 <20190307094654.35391e0066396b204d133927@linux-foundation.org>
 <20190307185623.GD3835@redhat.com>
 <CAPcyv4gkxmmkB0nofVOvkmV7HcuBDb+1VLR9CSsp+m-QLX_mxA@mail.gmail.com>
 <20190312152551.GA3233@redhat.com>
 <CAPcyv4iYzTVpP+4iezH1BekawwPwJYiMvk2GZDzfzFLUnO+RgA@mail.gmail.com>
 <20190312190606.GA15675@redhat.com>
 <CAPcyv4g-z8nkM1B65oR-3PT_RFQbmQMsM-J-P0-nzyvvJ8gVog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g-z8nkM1B65oR-3PT_RFQbmQMsM-J-P0-nzyvvJ8gVog@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:30:52PM -0700, Dan Williams wrote:
> On Tue, Mar 12, 2019 at 12:06 PM Jerome Glisse <jglisse@redhat.com> wrote:
> > On Tue, Mar 12, 2019 at 09:06:12AM -0700, Dan Williams wrote:
> > > On Tue, Mar 12, 2019 at 8:26 AM Jerome Glisse <jglisse@redhat.com> wrote:
> [..]
> > > > Spirit of the rule is better than blind application of rule.
> > >
> > > Again, I fail to see why HMM is suddenly unable to make forward
> > > progress when the infrastructure that came before it was merged with
> > > consumers in the same development cycle.
> > >
> > > A gate to upstream merge is about the only lever a reviewer has to
> > > push for change, and these requests to uncouple the consumer only
> > > serve to weaken that review tool in my mind.
> >
> > Well let just agree to disagree and leave it at that and stop
> > wasting each other time
> 
> I'm fine to continue this discussion if you are. Please be specific
> about where we disagree and what aspect of the proposed rules about
> merge staging are either acceptable, painful-but-doable, or
> show-stoppers. Do you agree that HMM is doing something novel with
> merge staging, am I off base there? I expect I can find folks that
> would balk with even a one cycle deferment of consumers, but can we
> start with that concession and see how it goes? I'm missing where I've
> proposed something that is untenable for the future of HMM which is
> addressing some real needs in gaps in the kernel's support for new
> hardware.

/me quietly wonders why the hmm infrastructure can't be staged in a
maintainer tree development branch on a kernel.org and then
all merged in one go when that branch has both infrastructure and
drivers merged into it...

i.e. everyone doing hmm driver work gets the infrastructure from the
dev tree, not mainline. That's a pretty standard procedure for
developing complex features, and it avoids all the issues being
argued over right now...

Cheers,

Dave/
-- 
Dave Chinner
david@fromorbit.com
