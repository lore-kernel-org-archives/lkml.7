Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482CC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F40421479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKW0r3hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGBQRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:17:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46583 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBQRp (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:17:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so94156qkm.13
        for <Linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=owT7iiI8vkm974BCBYw+8cxC5GSnYrxvuTmdBmM24+M=;
        b=ZKW0r3hhf+wwjNUDrS2vcBaK6pEzCpNQkDYr0ABd+6Gkb6ZFsnd3A25JHGIErjIDco
         adCK50lOrTUl8bAt2dDHoPKngsGtdTaI5X65ApKQPLL2oxotzcWKLHQC7/rO7k8g4N8W
         d68GfKRTsPaYuQIrgnl2UJoxQe3jNpXhIPIa9wZ54bwBDIXFM/0KKhmfYOBG1Y0DwfVE
         YLqralVNQEWRThHkV1JZmAGeOmtjS3TmOc/aeTDq2invupn2ZG1J8ENv9Dd1npNqGsKf
         a9DMJl7Ikwb31pqRyNHYF+o3zKgDfRAmimM3F64R0EaOik8JNnuCGqE86XAdFP2PXgqr
         pLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=owT7iiI8vkm974BCBYw+8cxC5GSnYrxvuTmdBmM24+M=;
        b=dCFPL2LesaDk/PCVW4lsWhHPIrnTkrq44Y1OrLF0dfyK5ZKs2OwcxjOoCCM5SLNQ9J
         phE4qkDd0XI4ELtBAdIwyLEOtkn9TQgRv4MvBkHtRDTvplRUgP83x+m7BmMydmWVpjkF
         A0nfmQZUjJySlI9ocgSLApQmFqyJaaZ7KD22Hjwb3OatW8VcYbKw79T8ZT0FSEXAVfUr
         pMubhml3xhAqZrkcbOH7KPFw2ckldQY8kFXvyK4zA2PbmTaS2qN1d8acXbe+I3bbeAI+
         KKQR1E54VG5eqTTiwJn9/GD6oYj6VQwUW9MvpYmxVtQUE3vAON6FapqPTZAd5OOkCtv1
         1wow==
X-Gm-Message-State: APjAAAXgoYTp2cjAAOIWkoHVujKBDE0ytQ5g9Z89MTJp1xD1cDRtxB0a
        6di/EsqYt9Jfs8PZYztZvD4=
X-Google-Smtp-Source: APXvYqy0Y70MtpoXaBobMYePQAxDL7x5ROzzgQ9hepn2X71BiO3Zy++fRRZBwUgTHkfRjl8yGWIsCA==
X-Received: by 2002:a37:4f8f:: with SMTP id d137mr26764999qkb.410.1562084263900;
        Tue, 02 Jul 2019 09:17:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id n3sm6056821qkk.54.2019.07.02.09.17.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 09:17:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7465741153; Tue,  2 Jul 2019 13:17:39 -0300 (-03)
Date:   Tue, 2 Jul 2019 13:17:39 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 5/7] perf diff: Link same basic blocks among different
 data
Message-ID: <20190702161739.GK15462@kernel.org>
References: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
 <1561713784-30533-6-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561713784-30533-6-git-send-email-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 28, 2019 at 05:23:02PM +0800, Jin Yao escreveu:
> The target is to compare the performance difference (cycles
> diff) for the same basic blocks in different data files.
> 
> The same basic block means same function, same start address
> and same end address. This patch finds the same basic blocks
> from different data files and link them together and resort
> by the cycles diff.
> 
>  v3:
>  ---
>  The block stuffs are maintained by new structure 'block_hist',
>  so this patch is update accordingly.
> 
>  v2:
>  ---
>  Since now the basic block hists is changed to per symbol,
>  the patch only links the basic block hists for the same
>  symbol in different data files.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-diff.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 83b8c0f..823f162 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -641,6 +641,85 @@ static int process_block_per_sym(struct hist_entry *he)
>  	return 0;
>  }
>  
> +static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
> +{
> +	struct block_info *bi_a = a->block_info;
> +	struct block_info *bi_b = b->block_info;
> +	int cmp;
> +
> +	if (!bi_a->sym || !bi_b->sym)
> +		return -1;
> +
> +	if (bi_a->sym->name && bi_b->sym->name) {
> +		cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
> +		if ((!cmp) && (bi_a->start == bi_b->start) &&
> +		    (bi_a->end == bi_b->end)) {
> +			return 0;
> +		}


builtin-diff.c:658:17: error: address of array 'bi_a->sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
        if (bi_a->sym->name && bi_b->sym->name) {
            ~~~~~~~~~~~^~~~ ~~
builtin-diff.c:658:36: error: address of array 'bi_b->sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
        if (bi_a->sym->name && bi_b->sym->name) {

Because:

struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
{
        size_t namelen = strlen(name) + 1;
        struct symbol *sym = calloc(1, (symbol_conf.priv_size +
                                        sizeof(*sym) + namelen));


So it will be at least a strlen(sym->name) == 0, i.e. we can use it
without checking anything.

I'm chanign it to do the cmp straight away


> +	}
> +
> +	return -1;
> +}
> +
> +static struct hist_entry *get_block_pair(struct hist_entry *he,
> +					 struct hists *hists_pair)
> +{
> +	struct rb_root_cached *root = hists_pair->entries_in;
> +	struct rb_node *next = rb_first_cached(root);
> +	int cmp;
> +
> +	while (next != NULL) {
> +		struct hist_entry *he_pair = rb_entry(next, struct hist_entry,
> +						      rb_node_in);
> +
> +		next = rb_next(&he_pair->rb_node_in);
> +
> +		cmp = block_pair_cmp(he_pair, he);
> +		if (!cmp)
> +			return he_pair;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void compute_cycles_diff(struct hist_entry *he,
> +				struct hist_entry *pair)
> +{
> +	pair->diff.computed = true;
> +	if (pair->block_info->num && he->block_info->num) {
> +		pair->diff.cycles =
> +			pair->block_info->cycles_aggr / pair->block_info->num_aggr -
> +			he->block_info->cycles_aggr / he->block_info->num_aggr;
> +	}
> +}
> +
> +static void block_hists_match(struct hists *hists_base,
> +			      struct hists *hists_pair)
> +{
> +	struct rb_root_cached *root = hists_base->entries_in;
> +	struct rb_node *next = rb_first_cached(root);
> +
> +	while (next != NULL) {
> +		struct hist_entry *he = rb_entry(next, struct hist_entry,
> +						 rb_node_in);
> +		struct hist_entry *pair = get_block_pair(he, hists_pair);
> +
> +		next = rb_next(&he->rb_node_in);
> +
> +		if (pair) {
> +			hist_entry__add_pair(pair, he);
> +			compute_cycles_diff(he, pair);
> +		}
> +	}
> +}
> +
> +static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
> +{
> +	/* Skip the calculation of column length in output_resort */
> +	he->filtered = true;
> +	return 0;
> +}
> +
>  static void hists__precompute(struct hists *hists)
>  {
>  	struct rb_root_cached *root;
> @@ -653,6 +732,7 @@ static void hists__precompute(struct hists *hists)
>  
>  	next = rb_first_cached(root);
>  	while (next != NULL) {
> +		struct block_hist *bh, *pair_bh;
>  		struct hist_entry *he, *pair;
>  		struct data__file *d;
>  		int i;
> @@ -681,6 +761,16 @@ static void hists__precompute(struct hists *hists)
>  				break;
>  			case COMPUTE_CYCLES:
>  				process_block_per_sym(pair);
> +				bh = container_of(he, struct block_hist, he);
> +				pair_bh = container_of(pair, struct block_hist,
> +						       he);
> +
> +				if (bh->valid && pair_bh->valid) {
> +					block_hists_match(&bh->block_hists,
> +							  &pair_bh->block_hists);
> +					hists__output_resort_cb(&pair_bh->block_hists,
> +								NULL, filter_cb);
> +				}
>  				break;
>  			default:
>  				BUG_ON(1);
> -- 
> 2.7.4

-- 

- Arnaldo
