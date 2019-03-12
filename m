Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CCB2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552427538;
	bh=ng/07YWOnNdmXJEMpq4aJq3vqE4XAZcZUlAhcC5+G0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UgHXZOdrAUgwmwe1DZ7wHnuwbn/b2sqtxKyCBEZzpn1lvAe6W8rp1GqGurBK8lhvw
	 qRJWstfrHqvT8a6Wwi8cY/U5Yoa016obqvrNZMTsR+U9593eSOLp1ZC/xTJlWrurpO
	 Lyf6OKM7hEc1tAasnHZpIHctfPxA1UalxlZA9lSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfCLVwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:52:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCLVwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:52:16 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60C34CBA;
        Tue, 12 Mar 2019 21:52:15 +0000 (UTC)
Date:   Tue, 12 Mar 2019 14:52:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-Id: <20190312145214.9c8f0381cf2ff2fc2904e2d8@linux-foundation.org>
In-Reply-To: <CAPcyv4g-z8nkM1B65oR-3PT_RFQbmQMsM-J-P0-nzyvvJ8gVog@mail.gmail.com>
References: <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
        <20190131041641.GK5061@redhat.com>
        <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
        <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
        <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
        <20190307094654.35391e0066396b204d133927@linux-foundation.org>
        <20190307185623.GD3835@redhat.com>
        <CAPcyv4gkxmmkB0nofVOvkmV7HcuBDb+1VLR9CSsp+m-QLX_mxA@mail.gmail.com>
        <20190312152551.GA3233@redhat.com>
        <CAPcyv4iYzTVpP+4iezH1BekawwPwJYiMvk2GZDzfzFLUnO+RgA@mail.gmail.com>
        <20190312190606.GA15675@redhat.com>
        <CAPcyv4g-z8nkM1B65oR-3PT_RFQbmQMsM-J-P0-nzyvvJ8gVog@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 12:30:52 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

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
> merge staging, am I off base there?

You're correct.  We chose to go this way because the HMM code is so
large and all-over-the-place that developing it in a standalone tree
seemed impractical - better to feed it into mainline piecewise.

This decision very much assumed that HMM users would definitely be
merged, and that it would happen soon.  I was skeptical for a long time
and was eventually persuaded by quite a few conversations with various
architecture and driver maintainers indicating that these HMM users
would be forthcoming.

In retrospect, the arrival of HMM clients took quite a lot longer than
was anticipated and I'm not sure that all of the anticipated usage
sites will actually be using it.  I wish I'd kept records of
who-said-what, but I didn't and the info is now all rather dissipated.

So the plan didn't really work out as hoped.  Lesson learned, I would
now very much prefer that new HMM feature work's changelogs include
links to the driver patchsets which will be using those features and
acks and review input from the developers of those driver patchsets.

