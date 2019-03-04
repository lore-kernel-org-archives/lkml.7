Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71878C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D8F20657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfCDP1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:27:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfCDP1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:27:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BF583082E6A;
        Mon,  4 Mar 2019 15:27:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 17AC14A3;
        Mon,  4 Mar 2019 15:27:33 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:27:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 10/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190304152733.GM19809@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-11-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-11-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 04 Mar 2019 15:27:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:49AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 6040eb49ea23..ba8a58f2cdd0 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -593,6 +593,40 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
>  	return he;
>  }
>  
> +static unsigned random_max(unsigned high)
> +{
> +	unsigned thresh = -high % high;
> +	for (;;) {
> +		unsigned r = random();
> +		if (r >= thresh)
> +			return r % high;
> +	}
> +}
> +
> +static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
> +{
> +	struct res_sample *r;
> +	int j;
> +
> +	if (!he->res_samples) {
> +		he->res_samples = calloc(sizeof(struct res_sample),
> +					symbol_conf.res_sample);
> +		if (!he->res_samples)
> +			return;
> +	}

please allocate this in hist_entry__init

thanks,
jirka
