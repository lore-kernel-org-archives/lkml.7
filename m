Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E58C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E37721D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxuCoPGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLSJKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:10:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726599AbfLSJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576746628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgxdERWusgCVoVX2TmS5fp7YoRXvnvTPjNGdBWD39mE=;
        b=SxuCoPGYQvSHTFb9lChyJx0g2CcxXSJX6rTavGbjUjOn4mvCJA6V5Cudw1EA/2Uku5qc8y
        8ggXPXdck/j/Ef3gyu8Az75vlFpc/SX5s5DWiMsOqRHaydDfnGERRfkK6Lvz0lqxa+nMux
        26jkRvQKECcj15FnoVVYhZxniJIRnSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-glZHnc3aNOeL0ogUdGryMA-1; Thu, 19 Dec 2019 04:10:17 -0500
X-MC-Unique: glZHnc3aNOeL0ogUdGryMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BBD2DC55;
        Thu, 19 Dec 2019 09:10:13 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B6067C823;
        Thu, 19 Dec 2019 09:10:10 +0000 (UTC)
Date:   Thu, 19 Dec 2019 10:10:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 4/4] perf report: support hotkey to let user select
 any event for sorting
Message-ID: <20191219091008.GB8141@krava>
References: <20191219060929.3714-1-yao.jin@linux.intel.com>
 <20191219060929.3714-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219060929.3714-4-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:09:29PM +0800, Jin Yao wrote:

SNIP

> +		case '0' ... '9':
> +			if (!symbol_conf.event_group ||
> +			    evsel->core.nr_members < 2) {
> +				snprintf(buf, sizeof(buf),
> +					 "Sort by index only available with group events!");
> +				helpline = buf;
> +				continue;
> +			}
> +
> +			symbol_conf.group_sort_idx = key - '0';
> +
> +			if (symbol_conf.group_sort_idx >= evsel->core.nr_members) {
> +				snprintf(buf, sizeof(buf),
> +					 "Max event group index to sort is %d (index from 0 to %d)",
> +					 evsel->core.nr_members - 1,
> +					 evsel->core.nr_members - 1);
> +				helpline = buf;
> +				continue;
> +			}
> +
> +			key = K_RELOAD;
> +			goto out_free_stack;
>  		case 'a':
>  			if (!hists__has(hists, sym)) {
>  				ui_browser__warning(&browser->b, delay_secs * 2,
> -- 
> 2.17.1
> 

maybe also something like this to eliminate unneeded refresh?

jirka


---
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 22e76bd1a2d9..9f5dd48500a2 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2947,6 +2947,9 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 				continue;
 			}
 
+			if (key - '0' == symbol_conf.group_sort_idx)
+				continue;
+
 			symbol_conf.group_sort_idx = key - '0';
 
 			if (symbol_conf.group_sort_idx >= evsel->core.nr_members) {

