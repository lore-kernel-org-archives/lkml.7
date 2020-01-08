Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8143BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FCE206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXYX0Y2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgAHOfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:35:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgAHOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578494132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fP+WPZXzfTrcd6wkGC25b1jea+qaX/5G0Sorwuc2/9o=;
        b=iXYX0Y2slOdtiqHLYimPUSe6gCR0YYAt92PSQN3edcZxMnIDYkroqUHPzS3KYMfnRTwHJ5
        eHw2TSlUlVABeVDSzqYRY26fktqDavvPqIHLNQLGumomFsBmY4TiH2un/KGUtsa9CN/TEP
        s2btbIstJQtNWbqNJYGMTp3K5LpIaSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-4AOAtzb6MzC3zwH2BoJp3g-1; Wed, 08 Jan 2020 09:35:30 -0500
X-MC-Unique: 4AOAtzb6MzC3zwH2BoJp3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55C971005502;
        Wed,  8 Jan 2020 14:35:28 +0000 (UTC)
Received: from krava (ovpn-204-186.brq.redhat.com [10.40.204.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B07886C5E;
        Wed,  8 Jan 2020 14:35:25 +0000 (UTC)
Date:   Wed, 8 Jan 2020 15:35:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, tmricht@linux.ibm.com
Subject: Re: [PATCH] perf report: Fix no libunwind compiled warning break
 s390 issue
Message-ID: <20200108143522.GE387467@krava>
References: <20200107191745.18415-1-yao.jin@linux.intel.com>
 <20200108102708.GC360164@krava>
 <7b88fdcc-9603-d3e1-d43b-b8fb8b394f70@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b88fdcc-9603-d3e1-d43b-b8fb8b394f70@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 09:02:02PM +0800, Jin, Yao wrote:
> 
> 
> On 1/8/2020 6:27 PM, Jiri Olsa wrote:
> > On Wed, Jan 08, 2020 at 03:17:45AM +0800, Jin Yao wrote:
> > > Commit 800d3f561659 ("perf report: Add warning when libunwind not compiled in")
> > > breaks the s390 platform. S390 uses libdw-dwarf-unwind for call chain
> > > unwinding and had no support for libunwind.
> > > 
> > > So the warning "Please install libunwind development packages during the perf build."
> > > caused the confusion even if the call-graph is displayed correctly.
> > > 
> > > This patch adds checking for HAVE_DWARF_SUPPORT, which is set when
> > > libdw-dwarf-unwind is compiled in.
> > > 
> > > Fixes: 800d3f561659 ("perf report: Add warning when libunwind not compiled in")
> > > 
> > > Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > 
> > perfect, I have the same change prepared for sending, but it's
> > together with making libdw default dwarf unwinder, which I'm still
> > not sure we want to do, so it all got posponed ;-)
> >  > would you guys be ok with that? with having libdw picked up as
> default dwarf unwinder..
> > 
> 
> I've roughly compared the performance between libunwind-dev and libdw-dev.
> While in my test (on KBL desktop), for the same perf report command-line, it
> looks the perf built with libunwind-dev is much faster than the perf built
> with libdw-dev.

ok, that's valid point.. the reason we start discussing it, was that
libunwind does not seem to support compressed ELF debug sections,
which works via libdw unwind

> 
> The command line is as following:
> 
> perf record --call-graph dwarf ./div
> perf report -g graph --stdio

I'll try to do some profiling and check with outr contact in libdw
to comment/check on that

thanks,
jirka

