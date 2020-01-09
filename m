Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED7C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FD52072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hg6MqCx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgAIITE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:19:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24976 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728349AbgAIITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578557942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+jC2Bp1qn6bLQ3vA2T/zmebaTYNwmfqXn+CX9gTxrZM=;
        b=Hg6MqCx3lDeTGaaAm2YkD4le5ewVAK8qKh5C8pp540yzkxzsVUUuBG604+yFttoMIqmVoD
        +COB60yG/zuvICSs7jjDoiBczUtGIjzLCMINaJSPQHXPoKweoQh5XPsviOoKd0B6NI3PwN
        Y48N01MF5f5Ouwhn58hDJWGw8yDqg9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-SqfnLCrIMLeF42RDHVY7rQ-1; Thu, 09 Jan 2020 03:18:59 -0500
X-MC-Unique: SqfnLCrIMLeF42RDHVY7rQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E0AE1005512;
        Thu,  9 Jan 2020 08:18:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EE838060D;
        Thu,  9 Jan 2020 08:18:54 +0000 (UTC)
Date:   Thu, 9 Jan 2020 09:18:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 8/9] perf top: Add --all-cgroups option
Message-ID: <20200109081852.GB52936@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-9-namhyung@kernel.org>
 <20200108222458.GF12995@krava>
 <CAM9d7ch7t9GDu=emb9MYdTSB8hPb0adAy1iOdjyXSXVXTpGBFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch7t9GDu=emb9MYdTSB8hPb0adAy1iOdjyXSXVXTpGBFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:55:21PM +0900, Namhyung Kim wrote:
> On Thu, Jan 9, 2020 at 7:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jan 07, 2020 at 10:35:00PM +0900, Namhyung Kim wrote:
> > > The --all-cgroups option is to enable cgroup profiling support.  It
> > > tells kernel to record CGROUP events in the ring buffer so that perf
> > > report can identify task/cgroup association later.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/Documentation/perf-top.txt | 4 ++++
> > >  tools/perf/builtin-top.c              | 9 +++++++++
> > >  2 files changed, 13 insertions(+)
> > >
> > > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> > > index 5596129a71cf..c75507f50071 100644
> > > --- a/tools/perf/Documentation/perf-top.txt
> > > +++ b/tools/perf/Documentation/perf-top.txt
> > > @@ -266,6 +266,10 @@ Default is to monitor all CPUS.
> > >       Record events of type PERF_RECORD_NAMESPACES and display it with the
> > >       'cgroup_id' sort key.
> > >
> > > +--cgroup::
> > > +     Record events of type PERF_RECORD_CGROUP and display it with the
> > > +     'cgroup' sort key.
> >
> > should be '--all-cgroups' ?
> 
> Oops, you're right.
> 
> >
> > anyway, we dont have '--cgroups', why not use just this?
> 
> I chose it for consistency since perf record has '--cgroup' option.

I see.. and we have that substring recognition so I suppose --cgroups
would screw the existing --cgroup option, ok

jirka

