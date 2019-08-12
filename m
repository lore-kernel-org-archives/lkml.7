Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C386C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5543E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfHLIfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:35:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHLIfw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:35:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 615A67733E;
        Mon, 12 Aug 2019 08:35:52 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 76A0E6012D;
        Mon, 12 Aug 2019 08:35:50 +0000 (UTC)
Date:   Mon, 12 Aug 2019 10:35:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf diff: Report noisy for cycles diff
Message-ID: <20190812083549.GB11752@krava>
References: <20190809233029.12265-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809233029.12265-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 12 Aug 2019 08:35:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 07:30:29AM +0800, Jin Yao wrote:

SNIP

> +
> +		init_stats(&pair->diff.stats);
> +		init_spark_values(pair->diff.svals, NUM_SPARKS);
> +
> +		for (int i = 0; i < pair->block_info->num; i++) {
> +			u64 val;
> +
> +			if (i >= he->block_info->num || i >= NUM_SPARKS)
> +				break;
> +
> +			val = labs(pair->block_info->cycles_spark[i] -
> +				     he->block_info->cycles_spark[i]);
> +
> +			update_spark_value(pair->diff.svals, NUM_SPARKS,
> +					   &pair->diff.stats, val);
> +			update_stats(&pair->diff.stats, val);
> +		}
>  	}
>  }
>  
> @@ -1250,6 +1292,8 @@ static const struct option options[] = {
>  		    "Show period values."),
>  	OPT_BOOLEAN('F', "formula", &show_formula,
>  		    "Show formula."),
> +	OPT_BOOLEAN('n', "noisy", &show_noisy,
> +		    "Show cycles noisy - WARNING: use only with -c cycles."),

this should be more 'cycles' specific like --cycles-noisy or --cycles-hist?

also I dont think we should use 'n' for this, just the long option

jirka
