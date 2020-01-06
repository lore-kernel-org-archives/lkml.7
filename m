Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0535C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9BC207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3JpZSEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAFMDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:03:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgAFMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578312180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WEjX5gvYAvJHVpESl9GK6SDy3RKQJYRnf+u4rZKlbzI=;
        b=J3JpZSEjuPKxr2wi7LgNYXJGS9im/mituLLJelshoRwBqQGWf7M4Rvqy4xCAqPbDdMjOzB
        xCl2K6UcfRbuLgJOnIoR0FAswSMmpclC8W6S2t3wwIe82bmvEnTEknhLynTKTZAK6E5jNR
        +HkSw/Eajzen+mkCu3o5TFlNXtwbAgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-cIWXXGxSNWGllFfQbk5GSQ-1; Mon, 06 Jan 2020 07:02:57 -0500
X-MC-Unique: cIWXXGxSNWGllFfQbk5GSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42ECF8018AE;
        Mon,  6 Jan 2020 12:02:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6B317D555;
        Mon,  6 Jan 2020 12:02:52 +0000 (UTC)
Date:   Mon, 6 Jan 2020 13:02:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        adrian.hunter@intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] perf tools: intel-pt: fix endless record after being
 terminated
Message-ID: <20200106120250.GD207350@krava>
References: <20200102074211.19901-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102074211.19901-1-liwei391@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 03:42:11PM +0800, Wei Li wrote:
> In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
> be set and the event list will be disabled by evlist__disable() once.
> 
> While in auxtrace_record.read_finish(), the related events will be
> enabled again, if they are continuous, the recording seems to be endless.
> 
> If the intel_pt event is disabled, we don't enable it again here.
> 
> Before the patch:
> huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
> intel_pt//u -p 46803
> ^C^C^C^C^C^C
> 
> After the patch:
> huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
> intel_pt//u -p 48591
> ^C[ perf record: Woken up 0 times to write data ]
> Warning:
> AUX data lost 504 times out of 4816!
> 
> [ perf record: Captured and wrote 2024.405 MB perf.data ]
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/arch/x86/util/intel-pt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 20df442fdf36..1e96afcd8646 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -1173,9 +1173,13 @@ static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
> -			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
> -							     idx);
> +		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
> +			if (evsel->disabled)
> +				return 0;
> +			else
> +				return perf_evlist__enable_event_idx(
> +						ptr->evlist, evsel, idx);

what's the logic behind enabling the event in here?

thanks,
jirka

