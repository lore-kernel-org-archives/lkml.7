Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A823C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C611D20733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpXqPYXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLPHbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:31:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42431 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbfLPHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576481483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Yw4w2BnQfb0LhmPh6/jp9x4s1/vGv88hML1wBHaEOc=;
        b=cpXqPYXd75la6Mdf7Rcy5rU2kwT+8mOIWMGzke3RwNyYrtz4GcKxLkx+4SeZF3HShhOLh2
        xf+YJbYlw9Qo5VFarG1OY1XVyuuHExI5JKhXd+Vss6yB4L2nPZKnUADbr1ue+wI5GXcAV7
        UL7BSF5Zo6CAKEhSEbQtRGaSC6qE1cQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-jFi8KeRIPM-1pGSC3Og_rA-1; Mon, 16 Dec 2019 02:31:19 -0500
X-MC-Unique: jFi8KeRIPM-1pGSC3Og_rA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B014800D53;
        Mon, 16 Dec 2019 07:31:18 +0000 (UTC)
Received: from krava (ovpn-204-81.brq.redhat.com [10.40.204.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC39160BFB;
        Mon, 16 Dec 2019 07:31:15 +0000 (UTC)
Date:   Mon, 16 Dec 2019 08:31:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/3] perf report: Change sort order by a specified
 event in group
Message-ID: <20191216073113.GB18240@krava>
References: <20191212123337.23600-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212123337.23600-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 08:33:35PM +0800, Jin Yao wrote:

SNIP

> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-report.txt |   4 +
>  tools/perf/builtin-report.c              |  10 +++
>  tools/perf/ui/hist.c                     | 108 +++++++++++++++++++----
>  tools/perf/util/symbol_conf.h            |   1 +
>  4 files changed, 108 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 8dbe2119686a..9ade613ef020 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -371,6 +371,10 @@ OPTIONS
>  	Show event group information together. It forces group output also
>  	if there are no groups defined in data file.
>  
> +--group-sort-idx::
> +	Sort the output by the event at the index n in group. If n is invalid,
> +	sort by the first event. WARNING: This should be used with --group.

--group in record or report?

you can also create groups with -e '{}', not just --group option

I wonder you could check early on 'evlist->nr_groups' and fail
if there's no group defined if the option is enabled

also what happens when we have more groups?

I think the option is easy to use as it is, just needs to be explained
consequences for more groups with different amount of events

SNIP

> +
> +static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
> +				 hpp_field_fn get_field, int idx)
> +{
> +	struct evsel *evsel = hists_to_evsel(a->hists);
> +	u64 *fields_a, *fields_b;
> +	int cmp, nr_members, ret, i;
> +
> +	cmp = field_cmp(get_field(a), get_field(b));
> +	if (!perf_evsel__is_group_event(evsel))
> +		return cmp;
> +
> +	nr_members = evsel->core.nr_members;
> +	ret = pair_fields_alloc(a, b, get_field, nr_members,
> +				&fields_a, &fields_b);
> +	if (ret) {
> +		ret = cmp;
> +		goto out;
> +	}
> +
> +	if (idx >= 1 && idx < nr_members) {

do we need to continue here if idx is out of the limit?
I'm not sure but mybe in that case the comparison above
should be enough?

thanks,
jirka

