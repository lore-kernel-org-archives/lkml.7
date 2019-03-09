Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB98C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB61820836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCIRV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:21:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCIRV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:21:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D952C7C2B;
        Sat,  9 Mar 2019 17:21:27 +0000 (UTC)
Received: from krava (ovpn-204-64.brq.redhat.com [10.40.204.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 49AAC1001DE6;
        Sat,  9 Mar 2019 17:21:24 +0000 (UTC)
Date:   Sat, 9 Mar 2019 18:21:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 04/11] perf data: Make perf_data__size to work over
 directory
Message-ID: <20190309172123.GB6378@krava>
References: <20190308134745.5057-1-jolsa@kernel.org>
 <20190308134745.5057-5-jolsa@kernel.org>
 <20190308173305.GE10690@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308173305.GE10690@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 09 Mar 2019 17:21:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 02:33:05PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 08, 2019 at 02:47:38PM +0100, Jiri Olsa escreveu:
> > Making perf_data__size to return proper size
> > for directory data.
> > 
> > Link: http://lkml.kernel.org/n/tip-t4dm8cctat2ginmy2bb08xe8@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/data.c | 17 +++++++++++++++++
> >  tools/perf/util/data.h |  6 +-----
> >  2 files changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index d568975c5ee3..498c531e2cb9 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -393,3 +393,20 @@ int perf_data__switch(struct perf_data *data,
> >  	free(new_filepath);
> >  	return ret;
> >  }
> > +
> > +unsigned long perf_data__size(struct perf_data *data)
> > +{
> > +	u64 size = data->file.size;
> > +	int i;
> > +
> > +	if (!data->is_dir)
> > +		return size;
> 
> So you do the sum over dir.files[i] _plus_ what is in data->file.size,
> what is in data->file.size? Zero for the dir case? Or some non-per-cpu
> metadata?

yes, saw the updated changelong, thanks

jirka
