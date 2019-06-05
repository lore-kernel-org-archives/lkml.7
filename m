Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC85C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C8A206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfFELoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:44:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbfFELof (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:44:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A94D85538;
        Wed,  5 Jun 2019 11:44:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 788CB5D6A9;
        Wed,  5 Jun 2019 11:44:18 +0000 (UTC)
Date:   Wed, 5 Jun 2019 13:44:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per
 symbol
Message-ID: <20190605114417.GB5868@krava>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 05 Jun 2019 11:44:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:36:14PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 43623fa..d1641da 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -79,6 +79,9 @@ struct hist_entry_diff {
>  
>  		/* HISTC_WEIGHTED_DIFF */
>  		s64	wdiff;
> +
> +		/* PERF_HPP_DIFF__CYCLES */
> +		s64	cycles;
>  	};
>  };
>  
> @@ -143,6 +146,9 @@ struct hist_entry {
>  	struct branch_info	*branch_info;
>  	long			time;
>  	struct hists		*hists;
> +	void			*block_hists;
> +	int			block_idx;
> +	int			block_num;
>  	struct mem_info		*mem_info;
>  	struct block_info	*block_info;

could you please not add the new block* stuff in here,
and instead use the "c2c model" and use yourr own struct
on top of hist_entry? we are trying to librarize this
stuff and keep only necessary things in here..

you're already using hist_entry_ops, so should be easy

something like:

	struct block_hist_entry {
		void			*block_hists;
		int			block_idx;
		int			block_num;
		struct block_info	*block_info;

		struct hist_entry	he;
	};



jirka
