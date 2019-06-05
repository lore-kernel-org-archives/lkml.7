Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207B3C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F6D20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfFELpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfFELpA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:45:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0D1C3091797;
        Wed,  5 Jun 2019 11:44:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id B12105D6A9;
        Wed,  5 Jun 2019 11:44:51 +0000 (UTC)
Date:   Wed, 5 Jun 2019 13:44:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per
 symbol
Message-ID: <20190605114450.GF5868@krava>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 05 Jun 2019 11:45:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:36:14PM +0800, Jin Yao wrote:

SNIP

>  		data__for_each_file_new(i, d) {
>  			pair = get_pair_data(he, d);
>  			if (!pair)
> @@ -510,6 +683,9 @@ static void hists__precompute(struct hists *hists)
>  			case COMPUTE_WEIGHTED_DIFF:
>  				compute_wdiff(he, pair);
>  				break;
> +			case COMPUTE_CYCLES:
> +				process_block_per_sym(pair, d);
> +				break;
>  			default:
>  				BUG_ON(1);
>  			}
> @@ -713,6 +889,14 @@ hist_entry__cmp_wdiff_idx(struct perf_hpp_fmt *fmt __maybe_unused,
>  					   sort_compute);
>  }
>  
> +static int64_t
> +hist_entry__cmp_cycles_idx(struct perf_hpp_fmt *fmt __maybe_unused,
> +			   struct hist_entry *left __maybe_unused,
> +			   struct hist_entry *right __maybe_unused)
> +{
> +	return 0;
> +}

this is hist_entry__cmp_nop.. please use it instead and
explain in comment why for COMPUTE_CYCLES we need the
default sort

jirka
