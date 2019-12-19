Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A71AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F289724650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw9wxP6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfLSMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:43:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbfLSMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576759409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOZwCoYhA0ovno73Gb/H4aB3/N/RoYDfpKLGyNWS1+I=;
        b=Zw9wxP6Shotk1QXekBvSBi4lRoUCD1vMEzYZpVHMAoOzCmc41xBwKDd6ebJ0s+YOFnMdm6
        Ic/axY1E2CT99hBptvQKO7P5hMe6SPcD7ip9hirvs1IbKwJGPEec32J6lVCjRRZ58kBkbO
        b41LCKItCWJ/sRcK59JxfErZWxxXBn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-AhKXorT3PHOWwWn12zjKSw-1; Thu, 19 Dec 2019 07:43:26 -0500
X-MC-Unique: AhKXorT3PHOWwWn12zjKSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 039C0184BEC0;
        Thu, 19 Dec 2019 12:43:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C6DB19C58;
        Thu, 19 Dec 2019 12:43:22 +0000 (UTC)
Date:   Thu, 19 Dec 2019 13:43:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 4/4] perf report: support hotkey to let user select
 any event for sorting
Message-ID: <20191219124320.GA31264@krava>
References: <20191219060929.3714-1-yao.jin@linux.intel.com>
 <20191219060929.3714-4-yao.jin@linux.intel.com>
 <20191219091008.GB8141@krava>
 <c1f18601-41d5-451d-4278-b7adb08674c3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f18601-41d5-451d-4278-b7adb08674c3@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 08:38:39PM +0800, Jin, Yao wrote:
> 
> 
> On 12/19/2019 5:10 PM, Jiri Olsa wrote:
> > On Thu, Dec 19, 2019 at 02:09:29PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > +		case '0' ... '9':
> > > +			if (!symbol_conf.event_group ||
> > > +			    evsel->core.nr_members < 2) {
> > > +				snprintf(buf, sizeof(buf),
> > > +					 "Sort by index only available with group events!");
> > > +				helpline = buf;
> > > +				continue;
> > > +			}
> > > +
> > > +			symbol_conf.group_sort_idx = key - '0';
> > > +
> > > +			if (symbol_conf.group_sort_idx >= evsel->core.nr_members) {
> > > +				snprintf(buf, sizeof(buf),
> > > +					 "Max event group index to sort is %d (index from 0 to %d)",
> > > +					 evsel->core.nr_members - 1,
> > > +					 evsel->core.nr_members - 1);
> > > +				helpline = buf;
> > > +				continue;
> > > +			}
> > > +
> > > +			key = K_RELOAD;
> > > +			goto out_free_stack;
> > >   		case 'a':
> > >   			if (!hists__has(hists, sym)) {
> > >   				ui_browser__warning(&browser->b, delay_secs * 2,
> > > -- 
> > > 2.17.1
> > > 
> > 
> > maybe also something like this to eliminate unneeded refresh?
> > 
> > jirka
> > 
> > 
> > ---
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index 22e76bd1a2d9..9f5dd48500a2 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -2947,6 +2947,9 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
> >   				continue;
> >   			}
> > +			if (key - '0' == symbol_conf.group_sort_idx)
> > +				continue;
> > +
> >   			symbol_conf.group_sort_idx = key - '0';
> >   			if (symbol_conf.group_sort_idx >= evsel->core.nr_members) {
> > 
> 
> Hi Jiri,
> 
> Thanks, I think it's a good improvement. It can avoid the unnecessary
> refresh.
> 
> If no more comments on this patch-set, I will add this improvement and then
> post v6.

sure, I don't have any more comments

jirka

