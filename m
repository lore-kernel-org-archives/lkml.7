Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2CAC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579CD208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfFYJLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:11:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbfFYJLi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:11:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43415C1EB20B;
        Tue, 25 Jun 2019 09:11:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 46C705D9D6;
        Tue, 25 Jun 2019 09:11:34 +0000 (UTC)
Date:   Tue, 25 Jun 2019 11:11:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 4/7] perf diff: Use hists to manage basic blocks per
 symbol
Message-ID: <20190625091134.GD9574@krava>
References: <1561041402-29444-1-git-send-email-yao.jin@linux.intel.com>
 <1561041402-29444-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561041402-29444-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 25 Jun 2019 09:11:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 10:36:39PM +0800, Jin Yao wrote:

SNIP

> +
> +static void *block_entry_zalloc(size_t size)
> +{
> +	return zalloc(size + sizeof(struct hist_entry));
> +}
> +
> +static void block_entry_free(void *he)
> +{
> +	struct block_info *bi = ((struct hist_entry *)he)->block_info;
> +
> +	block_info__put(bi);
> +	free(he);
> +}

so if we carry block_info in 'struct hist_entry' we don't need
to use our own allocation in the 2nd level hist entries.. just
for the first level to carry the new 'struct block_hists'

the block_info should be released in hist_entry__delete then,
same as for other *info pointers

the rest of the patchset looks ok to me

thanks,
jirka

> +
> +struct hist_entry_ops block_entry_ops = {
> +	.new    = block_entry_zalloc,
> +	.free   = block_entry_free,
> +};
> +
> +static int process_block_per_sym(struct hist_entry *he)
> +{
> +	struct annotation *notes;
> +	struct cyc_hist *ch;
> +	struct block_hist *bh;
> +
> +	if (!he->ms.map || !he->ms.sym)
> +		return 0;
> +
> +	notes = symbol__annotation(he->ms.sym);
> +	if (!notes || !notes->src || !notes->src->cycles_hist)
> +		return 0;
> +
> +	bh = container_of(he, struct block_hist, he);
> +	init_block_hist(bh);
> +
> +	ch = notes->src->cycles_hist;
> +	for (unsigned int i = 0; i < symbol__size(he->ms.sym); i++) {
> +		if (ch[i].num_aggr) {
> +			struct block_info *bi;
> +			struct hist_entry *he_block;
> +
> +			bi = block_info__new();
> +			if (!bi)
> +				return -1;
> +
> +			init_block_info(bi, he->ms.sym, &ch[i], i);
> +			he_block = hists__add_entry_block(&bh->block_hists,
> +							  &block_entry_ops,
> +							  &dummy_al, bi);
> +			if (!he_block) {
> +				block_info__put(bi);
> +				return -1;
> +			}
> +		}
> +	}
> +
> +	return 0;

SNIP
