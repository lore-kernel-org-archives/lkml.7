Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF6AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7302064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdMUMkTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLSIvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:51:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35691 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbfLSIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576745475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXOA8NC/2sPcKXBC5NpS+YvRND3RBrMHfvXBPn3tTBA=;
        b=WdMUMkTfVC2LYBoqjXuHLj+Gy4MFGkSHsIUOee7J5PRNhJZ7zbgvehlE9c795AnkMbRizH
        UZCt0dM/EwRik42ThbM5oEDcBuS72osjBUymFxyJfQ+qAfJ2NK+Qmge1Lg7+ZM9dmJZyHG
        q06UdbQF3zeZHxY0nusTjwbR5148j0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-1KZxtNynO06HPcm10fKMIA-1; Thu, 19 Dec 2019 03:51:11 -0500
X-MC-Unique: 1KZxtNynO06HPcm10fKMIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30FA81005512;
        Thu, 19 Dec 2019 08:51:10 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9A5F7D991;
        Thu, 19 Dec 2019 08:51:08 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:51:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "fujita.yuya@fujitsu.com" <fujita.yuya@fujitsu.com>
Cc:     'Peter Zijlstra' <peterz@infradead.org>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Arnaldo Carvalho de Melo' <acme@kernel.org>,
        'Jiri Olsa' <jolsa@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tools: Fix variable name's inconsistency in
 hists__for_each macro
Message-ID: <20191219085106.GA8141@krava>
References: <OSAPR01MB1588E1C47AC22043175DE1B2E8520@OSAPR01MB1588.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSAPR01MB1588E1C47AC22043175DE1B2E8520@OSAPR01MB1588.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 08:08:32AM +0000, fujita.yuya@fujitsu.com wrote:
> From: Yuya Fujita <fujita.yuya@fujitsu.com>
> 
> Variable names are inconsistent in hists__for_each macro.
> Due to this inconsistency, the macro replaces its second argument with "fmt" 
> regardless of its original name.
> So far it works because only "fmt" is passed to the second argument.

hum, I think it works because all the instances that use these macros
have 'fmt' variable passed in

> However, this behavior is not expected and should be fixed.
> 
> Fixes: f0786af536bb ("perf hists: Introduce hists__for_each_format macro")
> Fixes: aa6f50af822a ("perf hists: Introduce hists__for_each_sort_list macro")

nice ;-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> Signed-off-by: Yuya Fujita <fujita.yuya@fujitsu.com>
> ---
>  tools/perf/util/hist.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 4528690..0aa63ae 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -339,10 +339,10 @@ static inline void perf_hpp__prepend_sort_field(struct perf_hpp_fmt *format)
>  	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
>  
>  #define hists__for_each_format(hists, format) \
> -	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
> +	perf_hpp_list__for_each_format((hists)->hpp_list, format)
>  
>  #define hists__for_each_sort_list(hists, format) \
> -	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
> +	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
>  
>  extern struct perf_hpp_fmt perf_hpp__format[];
>  
> -- 
> 1.7.1
> 

