Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5532072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZhjKRIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLQJGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:06:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726382AbfLQJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576573570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FEYHhjqqv4OFSsRgZGLpQc4haRSqVvbSHTPCJUn5Mg=;
        b=GZhjKRIAKLu1h871nOkHTfC6RbIMlaksQT3stsaWoOn/jrzDMywJSt9CzGI21CWS4N2HbB
        +TfL2J14x6QMfjfy/FK9rScmephMqyfYR4Ldhmn7xT6bVK5GiYvHT6hqWaAzxdh6+jWOhL
        KOQ3W0iTajnMcY2K6vIK3op363I6bGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-tnhlqQ-HO2qtMCU16hMGMw-1; Tue, 17 Dec 2019 04:06:07 -0500
X-MC-Unique: tnhlqQ-HO2qtMCU16hMGMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C4A2189CD04;
        Tue, 17 Dec 2019 09:06:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 722B35C1D6;
        Tue, 17 Dec 2019 09:06:03 +0000 (UTC)
Date:   Tue, 17 Dec 2019 10:06:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/3] perf report: Change sort order by a specified
 event in group
Message-ID: <20191217090600.GA24766@krava>
References: <20191212123337.23600-1-yao.jin@linux.intel.com>
 <20191216073113.GB18240@krava>
 <fcedac74-7fb4-1c3b-67a3-9af24c256f40@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcedac74-7fb4-1c3b-67a3-9af24c256f40@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:47:01AM +0800, Jin, Yao wrote:
> 
> 
> On 12/16/2019 3:31 PM, Jiri Olsa wrote:
> > On Thu, Dec 12, 2019 at 08:33:35PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/Documentation/perf-report.txt |   4 +
> > >   tools/perf/builtin-report.c              |  10 +++
> > >   tools/perf/ui/hist.c                     | 108 +++++++++++++++++++----
> > >   tools/perf/util/symbol_conf.h            |   1 +
> > >   4 files changed, 108 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > > index 8dbe2119686a..9ade613ef020 100644
> > > --- a/tools/perf/Documentation/perf-report.txt
> > > +++ b/tools/perf/Documentation/perf-report.txt
> > > @@ -371,6 +371,10 @@ OPTIONS
> > >   	Show event group information together. It forces group output also
> > >   	if there are no groups defined in data file.
> > > +--group-sort-idx::
> > > +	Sort the output by the event at the index n in group. If n is invalid,
> > > +	sort by the first event. WARNING: This should be used with --group.
> > 
> > --group in record or report?
> > 
> 
> This --group is in perf-report. So even if it's not created with -e '{}' in
> perf-record, it still supports to show event information together.
> 
> > you can also create groups with -e '{}', not just --group option
> > 
> > I wonder you could check early on 'evlist->nr_groups' and fail
> > if there's no group defined if the option is enabled
> > 
> 
> Maybe we don't need to check that because it supports the case of no group
> defined.
> 
> For example,
> perf record -e cycles,instructions
> perf report --group --group-sort-idx 1 --stdio

hum, --group will force evlist->nr_groups == 1, right?

so we could warn/fail on (group-sort-idx && !evlist->nr_groups)


SNIP

> 
> Thanks. Can we say something as following?
> 
> --group-sort-idx::
> 	Sort the output by the event at the index n in group. If n is invalid, sort
> by the first event. It can support multiple groups with different amount of
> events. WARNING: This should be used with perf report --group.

if the events are already grouped you dont need --group ;-) how about:

	This should be used on grouped events.

thanks,
jirka

