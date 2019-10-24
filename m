Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD78321655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2RLgaYAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404981AbfJXOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:01:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57888 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbfJXOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PH0bJrrct13OtBTiOhljVf6qdjT6mdvYcPf9jH5za6c=; b=2RLgaYAnVgKkblXMxNOUOTT9h
        Rf0uLT0nhkvEeARLz7h2ThZy4ujzXWuOBkzpxifosRltObEf80IMz5QgLfdeC0d6jNqDukg48j+if
        pHXxZG1qAnNWADM5BxidUvMc/IpsphlN+8wZa87kZvfRkuKO/9qMiLcTorpq3jIh7yeYmRk/Wfv/O
        cjKFvhyRl+byyl5Hyco98nsR/Cs7wTluom3VUW+8ygFQWrK4GBjwVS2YptzkPhPwaqqijnBYMtFIr
        V4oQHkSOTGhcXOmWnmNz5myXFQ1hww4jTEwYNhyst6XUQTbfT2VEsEjkBDs2fNfkJkR0y0+7DsMav
        yo2yGNM3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNdgK-0000Aw-NU; Thu, 24 Oct 2019 14:01:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBD44306DEB;
        Thu, 24 Oct 2019 16:00:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FE462B1D7CA3; Thu, 24 Oct 2019 16:01:39 +0200 (CEST)
Date:   Thu, 24 Oct 2019 16:01:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v2 1/4] perf: Allow using AUX data in perf samples
Message-ID: <20191024140139.GF4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
 <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:58:09PM +0300, Alexander Shishkin wrote:
> @@ -11213,6 +11367,9 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (event->attr.aux_output && !perf_get_aux_event(event, group_leader))
>  		goto err_locked;
>  
> +	if (event->attr.aux_sample_size && !perf_get_aux_event(event, group_leader))
> +		goto err_locked;
> +

Either aux_sample_size and aux_output are mutually exclusive, or you're
leaking a refcount on group_leader. The first wants a check, the second
wants error path fixes.

>  	/*
>  	 * Must be under the same ctx::mutex as perf_install_in_context(),
>  	 * because we need to serialize with concurrent event creation.
