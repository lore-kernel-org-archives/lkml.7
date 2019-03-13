Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C677C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 00:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D410E214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfCMAKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 20:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56339 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfCMAKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 20:10:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74AB4883B8;
        Wed, 13 Mar 2019 00:10:22 +0000 (UTC)
Received: from redhat.com (ovpn-116-53.phx2.redhat.com [10.3.116.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94B3C60CA0;
        Wed, 13 Mar 2019 00:10:21 +0000 (UTC)
Date:   Tue, 12 Mar 2019 20:10:19 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-ID: <20190313001018.GA3312@redhat.com>
References: <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
 <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
 <20190307094654.35391e0066396b204d133927@linux-foundation.org>
 <20190307185623.GD3835@redhat.com>
 <CAPcyv4gkxmmkB0nofVOvkmV7HcuBDb+1VLR9CSsp+m-QLX_mxA@mail.gmail.com>
 <20190312152551.GA3233@redhat.com>
 <CAPcyv4iYzTVpP+4iezH1BekawwPwJYiMvk2GZDzfzFLUnO+RgA@mail.gmail.com>
 <20190312190606.GA15675@redhat.com>
 <CAPcyv4g-z8nkM1B65oR-3PT_RFQbmQMsM-J-P0-nzyvvJ8gVog@mail.gmail.com>
 <20190312145214.9c8f0381cf2ff2fc2904e2d8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190312145214.9c8f0381cf2ff2fc2904e2d8@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 13 Mar 2019 00:10:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:52:14PM -0700, Andrew Morton wrote:
> On Tue, 12 Mar 2019 12:30:52 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Tue, Mar 12, 2019 at 12:06 PM Jerome Glisse <jglisse@redhat.com> wrote:
> > > On Tue, Mar 12, 2019 at 09:06:12AM -0700, Dan Williams wrote:
> > > > On Tue, Mar 12, 2019 at 8:26 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > [..]
> > > > > Spirit of the rule is better than blind application of rule.
> > > >
> > > > Again, I fail to see why HMM is suddenly unable to make forward
> > > > progress when the infrastructure that came before it was merged with
> > > > consumers in the same development cycle.
> > > >
> > > > A gate to upstream merge is about the only lever a reviewer has to
> > > > push for change, and these requests to uncouple the consumer only
> > > > serve to weaken that review tool in my mind.
> > >
> > > Well let just agree to disagree and leave it at that and stop
> > > wasting each other time
> > 
> > I'm fine to continue this discussion if you are. Please be specific
> > about where we disagree and what aspect of the proposed rules about
> > merge staging are either acceptable, painful-but-doable, or
> > show-stoppers. Do you agree that HMM is doing something novel with
> > merge staging, am I off base there?
> 
> You're correct.  We chose to go this way because the HMM code is so
> large and all-over-the-place that developing it in a standalone tree
> seemed impractical - better to feed it into mainline piecewise.
> 
> This decision very much assumed that HMM users would definitely be
> merged, and that it would happen soon.  I was skeptical for a long time
> and was eventually persuaded by quite a few conversations with various
> architecture and driver maintainers indicating that these HMM users
> would be forthcoming.
> 
> In retrospect, the arrival of HMM clients took quite a lot longer than
> was anticipated and I'm not sure that all of the anticipated usage
> sites will actually be using it.  I wish I'd kept records of
> who-said-what, but I didn't and the info is now all rather dissipated.
> 
> So the plan didn't really work out as hoped.  Lesson learned, I would
> now very much prefer that new HMM feature work's changelogs include
> links to the driver patchsets which will be using those features and
> acks and review input from the developers of those driver patchsets.

This is what i am doing now and this patchset falls into that. I did
post the ODP and nouveau bits to use the 2 new functions (dma map and
unmap). I expect to merge both ODP and nouveau bits for that during
the next merge window.

Also with 5.1 everything that is upstream is use by nouveau at least.
They are posted patches to use HMM for AMD, Intel, Radeon, ODP, PPC.
Some are going through several revisions so i do not know exactly when
each will make it upstream but i keep working on all this.

So the guideline we agree on:
    - no new infrastructure without user
    - device driver maintainer for which new infrastructure is done
      must either sign off or review of explicitly say that they want
      the feature I do not expect all driver maintainer will have
      the bandwidth to do proper review of the mm part of the infra-
      structure and it would not be fair to ask that from them. They
      can still provide feedback on the API expose to the device
      driver.
    - driver bits must be posted at the same time as the new infra-
      structure even if they target the next release cycle to avoid
      inter-tree dependency
    - driver bits must be merge as soon as possible

Thing we do not agree on:
    - If driver bits miss for any reason the +1 target directly
      revert the new infra-structure. I think it should not be black
      and white and the reasons why the driver bit missed the merge
      window should be taken into account. If the feature is still
      wanted and the driver bits missed the window for simple reasons
      then it means that we push everything by 2 release ie the
      revert is done in +1 then we reupload the infra-structure in
      +2 and finaly repush the driver bit in +3 so we loose 1 cycle.
      Hence why i would rather that the revert would only happen if
      it is clear that the infrastructure is not ready or can not
      be use in timely (over couple kernel release) fashion by any
      drivers.

Cheers,
Jérôme
