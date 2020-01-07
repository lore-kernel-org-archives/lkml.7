Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD08BC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9F02087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXO+Giyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgAGJ5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:57:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41569 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgAGJ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578391062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJTdSZMyEb+Dqypz7jjPA/TCQrPtQYbIPnT3NNnPf2Y=;
        b=QXO+GiyqTeJOjTo3aZEBLZM88HZz/PUOS8FXYJxfJNf+nMF/2HmGNYuBszuFASnJ3SSxkN
        gjAJH3/EZqKEz4w0i+cJQkywwnJLBjtJRVjli1HXNe/T7amW6meLfyXykhgiueO1e7MEq7
        IcIoxh1k2D7+ROpKsfTLfgJVbT4C6Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-_fnASorKNXqM7tyA8BnwUA-1; Tue, 07 Jan 2020 04:57:39 -0500
X-MC-Unique: _fnASorKNXqM7tyA8BnwUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3C8D18552AE;
        Tue,  7 Jan 2020 09:57:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C91D0272B4;
        Tue,  7 Jan 2020 09:57:35 +0000 (UTC)
Date:   Tue, 7 Jan 2020 10:57:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/3] perf util: Move block_pair_cmp to block-info
Message-ID: <20200107095733.GD290055@krava>
References: <20200106194525.12228-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106194525.12228-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 03:45:23AM +0800, Jin Yao wrote:
> block_pair_cmp() is a function which is used to compare
> two blocks. Moving it from builtin-diff.c to block-info.c
> to let it be used by other builtins.
> 
> In block_pair_cmp, there is a minor change. It checks valid
> for map, dso and sym first. If they are invalid, we will not
> compare the address because the address might not make sense.

please separate the change as well, it's hard to track
what you did when the whole function is moved

> 
>  v2:
>  ---
>  New patch created in v2
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-diff.c    | 17 -----------------
>  tools/perf/util/block-info.c | 23 +++++++++++++++++++++++
>  tools/perf/util/block-info.h |  2 ++
>  3 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index f8b6ae557d8b..5ff1e21082cb 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -572,23 +572,6 @@ static void init_block_hist(struct block_hist *bh)
>  	bh->valid = true;
>  }
>  
> -static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
> -{
> -	struct block_info *bi_a = a->block_info;
> -	struct block_info *bi_b = b->block_info;
> -	int cmp;
> -
> -	if (!bi_a->sym || !bi_b->sym)
> -		return -1;
> -
> -	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
> -
> -	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
> -		return 0;
> -
> -	return -1;
> -}
> -
>  static struct hist_entry *get_block_pair(struct hist_entry *he,
>  					 struct hists *hists_pair)
>  {
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index c4b030bf6ec2..18a445938681 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -475,3 +475,26 @@ float block_info__total_cycles_percent(struct hist_entry *he)
>  
>  	return 0.0;
>  }
> +
> +int block_pair_cmp(struct hist_entry *pair, struct hist_entry *he)
> +{
> +	struct block_info *bi_p = pair->block_info;
> +	struct block_info *bi_h = he->block_info;
> +	struct map_symbol *ms_p = &pair->ms;
> +	struct map_symbol *ms_h = &he->ms;
> +	int cmp;
> +
> +	if (!ms_p->map || !ms_p->map->dso || !ms_p->sym ||
> +	    !ms_h->map || !ms_h->map->dso || !ms_h->sym) {
> +		return -1;
> +	}
> +
> +	cmp = strcmp(ms_p->sym->name, ms_h->sym->name);
> +	if (cmp)
> +		return -1;

should this return cmp? also you don't mention this change in the changelog

thanks,
jirka

