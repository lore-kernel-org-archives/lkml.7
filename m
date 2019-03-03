Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621EEC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1AB206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551644550;
	bh=jiivNQWQK1Fnf0sHv0X9wYaomYxwkoOUTfLFXMWK1lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GrM6rPF1C1b9fL8LCBP2g+nDN6ovgjtm/n/xLzaHN/QGPZgZULiVSJ/z0T7YGqHBR
	 eknViabSrMRY9xYSXTnfZENwYpOUDsROvpZrvv66ORngHxFh/+03kTO3Y+54oD2Ay2
	 pglKNdZLv9vMThnhYiLAf8u1/35/jMXD/zrrsiIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfCCUW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:22:28 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37557 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfCCUW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:22:28 -0500
Received: by mail-yw1-f66.google.com with SMTP id k14so2521874ywe.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vWYe/SH4n5pQhn73EX2h3fENGFvia3GnHd1Qq7AyZVI=;
        b=jYIT3kBJsp7Si2SMxh+Wc+Sr+apRFp2L49FpGQlrEq4CR/18x/rVo2PxuanL23Jy4K
         uzpUIRFYJP55mK9QDTEbzsTsIc2LsaQXsZMGdF2mB9Ejfoqtim0aL+nKzA1iCoAoJxuu
         I/Z6BzVGm3j2fOraGFlCwnH0oaMMROTIljcD6HJxrKO/iCDSLK6U3daAe6oI9RsCyNf7
         vZiomG2B+tF3TfaOPtm3tDmvCFsX805PeZwlpWmf2Pt4QU8WuFDTuYXQm9gVKJLDgcL4
         NenB+AMAsGmwjMeGh2omjPMbtQCN6PYMjjvYoE7+Sfnl8GUJe+KKFfaPXRvXrYrfqsrZ
         J4pA==
X-Gm-Message-State: APjAAAVC6pFj4Srd/ln5w+BCMca/bYqenVWwinNIgXlro/bbCX1iVjI9
        bs1IWrKF1kx4rnYRn2WP+lU=
X-Google-Smtp-Source: APXvYqxxnI4dFXphPrO3Xa618uZXKK+o6d9sqai/0+WFqAOeBHgY3P8K43unCfLjgEIACijg+vNZOA==
X-Received: by 2002:a25:ed5:: with SMTP id 204mr12057601ybo.171.1551644546486;
        Sun, 03 Mar 2019 12:22:26 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::ffe8])
        by smtp.gmail.com with ESMTPSA id g82sm1811658ywg.60.2019.03.03.12.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:22:25 -0800 (PST)
Date:   Sun, 3 Mar 2019 15:22:23 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/12] percpu: convert chunk hints to be based on
 pcpu_block_md
Message-ID: <20190303202223.GA4868@dennisz-mbp.dhcp.thefacebook.com>
References: <20190228021839.55779-1-dennis@kernel.org>
 <20190228021839.55779-12-dennis@kernel.org>
 <AM0PR04MB44813FA493D26E2E157FCAF388700@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB44813FA493D26E2E157FCAF388700@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 08:18:49AM +0000, Peng Fan wrote:
> 
> 
> > -----Original Message-----
> > From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> > Behalf Of Dennis Zhou
> > Sent: 2019年2月28日 10:19
> > To: Dennis Zhou <dennis@kernel.org>; Tejun Heo <tj@kernel.org>; Christoph
> > Lameter <cl@linux.com>
> > Cc: Vlad Buslov <vladbu@mellanox.com>; kernel-team@fb.com;
> > linux-mm@kvack.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH 11/12] percpu: convert chunk hints to be based on
> > pcpu_block_md
> > 
> > As mentioned in the last patch, a chunk's hints are no different than a block
> > just responsible for more bits. This converts chunk level hints to use a
> > pcpu_block_md to maintain them. This lets us reuse the same hint helper
> > functions as a block. The left_free and right_free are unused by the chunk's
> > pcpu_block_md.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  mm/percpu-internal.h |   5 +-
> >  mm/percpu-stats.c    |   5 +-
> >  mm/percpu.c          | 120 +++++++++++++++++++------------------------
> >  3 files changed, 57 insertions(+), 73 deletions(-)
> > 
> > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h index
> > 119bd1119aa7..0468ba500bd4 100644
> > --- a/mm/percpu-internal.h
> > +++ b/mm/percpu-internal.h
> > @@ -39,9 +39,7 @@ struct pcpu_chunk {
> > 
> >  	struct list_head	list;		/* linked to pcpu_slot lists */
> >  	int			free_bytes;	/* free bytes in the chunk */
> > -	int			contig_bits;	/* max contiguous size hint */
> > -	int			contig_bits_start; /* contig_bits starting
> > -						      offset */
> > +	struct pcpu_block_md	chunk_md;
> >  	void			*base_addr;	/* base address of this chunk */
> > 
> >  	unsigned long		*alloc_map;	/* allocation map */
> > @@ -49,7 +47,6 @@ struct pcpu_chunk {
> >  	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
> > 
> >  	void			*data;		/* chunk data */
> > -	int			first_bit;	/* no free below this */
> >  	bool			immutable;	/* no [de]population allowed */
> >  	int			start_offset;	/* the overlap with the previous
> >  						   region to have a page aligned
> > diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c index
> > b5fdd43b60c9..ef5034a0464e 100644
> > --- a/mm/percpu-stats.c
> > +++ b/mm/percpu-stats.c
> > @@ -53,6 +53,7 @@ static int find_max_nr_alloc(void)  static void
> > chunk_map_stats(struct seq_file *m, struct pcpu_chunk *chunk,
> >  			    int *buffer)
> >  {
> > +	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> >  	int i, last_alloc, as_len, start, end;
> >  	int *alloc_sizes, *p;
> >  	/* statistics */
> > @@ -121,9 +122,9 @@ static void chunk_map_stats(struct seq_file *m,
> > struct pcpu_chunk *chunk,
> >  	P("nr_alloc", chunk->nr_alloc);
> >  	P("max_alloc_size", chunk->max_alloc_size);
> >  	P("empty_pop_pages", chunk->nr_empty_pop_pages);
> > -	P("first_bit", chunk->first_bit);
> > +	P("first_bit", chunk_md->first_free);
> >  	P("free_bytes", chunk->free_bytes);
> > -	P("contig_bytes", chunk->contig_bits * PCPU_MIN_ALLOC_SIZE);
> > +	P("contig_bytes", chunk_md->contig_hint * PCPU_MIN_ALLOC_SIZE);
> >  	P("sum_frag", sum_frag);
> >  	P("max_frag", max_frag);
> >  	P("cur_min_alloc", cur_min_alloc);
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 7cdf14c242de..197479f2c489 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -233,10 +233,13 @@ static int pcpu_size_to_slot(int size)
> > 
> >  static int pcpu_chunk_slot(const struct pcpu_chunk *chunk)  {
> > -	if (chunk->free_bytes < PCPU_MIN_ALLOC_SIZE || chunk->contig_bits
> > == 0)
> > +	const struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> > +
> > +	if (chunk->free_bytes < PCPU_MIN_ALLOC_SIZE ||
> > +	    chunk_md->contig_hint == 0)
> >  		return 0;
> > 
> > -	return pcpu_size_to_slot(chunk->contig_bits * PCPU_MIN_ALLOC_SIZE);
> > +	return pcpu_size_to_slot(chunk_md->contig_hint *
> > PCPU_MIN_ALLOC_SIZE);
> >  }
> > 
> >  /* set the pointer to a chunk in a page struct */ @@ -592,54 +595,6 @@
> > static inline bool pcpu_region_overlap(int a, int b, int x, int y)
> >  	return false;
> >  }
> > 
> > -/**
> > - * pcpu_chunk_update - updates the chunk metadata given a free area
> > - * @chunk: chunk of interest
> > - * @bit_off: chunk offset
> > - * @bits: size of free area
> > - *
> > - * This updates the chunk's contig hint and starting offset given a free area.
> > - * Choose the best starting offset if the contig hint is equal.
> > - */
> > -static void pcpu_chunk_update(struct pcpu_chunk *chunk, int bit_off, int bits)
> > -{
> > -	if (bits > chunk->contig_bits) {
> > -		chunk->contig_bits_start = bit_off;
> > -		chunk->contig_bits = bits;
> > -	} else if (bits == chunk->contig_bits && chunk->contig_bits_start &&
> > -		   (!bit_off ||
> > -		    __ffs(bit_off) > __ffs(chunk->contig_bits_start))) {
> > -		/* use the start with the best alignment */
> > -		chunk->contig_bits_start = bit_off;
> > -	}
> > -}
> > -
> > -/**
> > - * pcpu_chunk_refresh_hint - updates metadata about a chunk
> > - * @chunk: chunk of interest
> > - *
> > - * Iterates over the metadata blocks to find the largest contig area.
> > - * It also counts the populated pages and uses the delta to update the
> > - * global count.
> > - *
> > - * Updates:
> > - *      chunk->contig_bits
> > - *      chunk->contig_bits_start
> > - */
> > -static void pcpu_chunk_refresh_hint(struct pcpu_chunk *chunk) -{
> > -	int bit_off, bits;
> > -
> > -	/* clear metadata */
> > -	chunk->contig_bits = 0;
> > -
> > -	bit_off = chunk->first_bit;
> > -	bits = 0;
> > -	pcpu_for_each_md_free_region(chunk, bit_off, bits) {
> > -		pcpu_chunk_update(chunk, bit_off, bits);
> > -	}
> > -}
> > -
> >  /**
> >   * pcpu_block_update - updates a block given a free area
> >   * @block: block of interest
> > @@ -753,6 +708,29 @@ static void pcpu_block_update_scan(struct
> > pcpu_chunk *chunk, int bit_off,
> >  	pcpu_block_update(block, s_off, e_off);  }
> > 
> > +/**
> > + * pcpu_chunk_refresh_hint - updates metadata about a chunk
> > + * @chunk: chunk of interest
> > + *
> > + * Iterates over the metadata blocks to find the largest contig area.
> > + * It also counts the populated pages and uses the delta to update the
> > + * global count.
> > + */
> > +static void pcpu_chunk_refresh_hint(struct pcpu_chunk *chunk) {
> > +	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> > +	int bit_off, bits;
> > +
> > +	/* clear metadata */
> > +	chunk_md->contig_hint = 0;
> > +
> > +	bit_off = chunk_md->first_free;
> > +	bits = 0;
> > +	pcpu_for_each_md_free_region(chunk, bit_off, bits) {
> > +		pcpu_block_update(chunk_md, bit_off, bit_off + bits);
> > +	}
> > +}
> > +
> >  /**
> >   * pcpu_block_refresh_hint
> >   * @chunk: chunk of interest
> > @@ -800,6 +778,7 @@ static void pcpu_block_refresh_hint(struct
> > pcpu_chunk *chunk, int index)  static void
> > pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
> >  					 int bits)
> >  {
> > +	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> >  	int nr_empty_pages = 0;
> >  	struct pcpu_block_md *s_block, *e_block, *block;
> >  	int s_index, e_index;	/* block indexes of the freed allocation */
> > @@ -910,8 +889,9 @@ static void pcpu_block_update_hint_alloc(struct
> > pcpu_chunk *chunk, int bit_off,
> >  	 * contig hint is broken.  Otherwise, it means a smaller space
> >  	 * was used and therefore the chunk contig hint is still correct.
> >  	 */
> > -	if (pcpu_region_overlap(chunk->contig_bits_start,
> > -				chunk->contig_bits_start + chunk->contig_bits,
> > +	if (pcpu_region_overlap(chunk_md->contig_hint_start,
> > +				chunk_md->contig_hint_start +
> > +				chunk_md->contig_hint,
> >  				bit_off,
> >  				bit_off + bits))
> >  		pcpu_chunk_refresh_hint(chunk);
> > @@ -930,9 +910,10 @@ static void pcpu_block_update_hint_alloc(struct
> > pcpu_chunk *chunk, int bit_off,
> >   *
> >   * A chunk update is triggered if a page becomes free, a block becomes free,
> >   * or the free spans across blocks.  This tradeoff is to minimize iterating
> > - * over the block metadata to update chunk->contig_bits.
> > chunk->contig_bits
> > - * may be off by up to a page, but it will never be more than the available
> > - * space.  If the contig hint is contained in one block, it will be accurate.
> > + * over the block metadata to update chunk_md->contig_hint.
> > + * chunk_md->contig_hint may be off by up to a page, but it will never
> > + be more
> > + * than the available space.  If the contig hint is contained in one
> > + block, it
> > + * will be accurate.
> >   */
> >  static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int
> > bit_off,
> >  					int bits)
> > @@ -1026,8 +1007,9 @@ static void pcpu_block_update_hint_free(struct
> > pcpu_chunk *chunk, int bit_off,
> >  	if (((end - start) >= PCPU_BITMAP_BLOCK_BITS) || s_index != e_index)
> >  		pcpu_chunk_refresh_hint(chunk);
> >  	else
> > -		pcpu_chunk_update(chunk, pcpu_block_off_to_off(s_index, start),
> > -				  end - start);
> > +		pcpu_block_update(&chunk->chunk_md,
> > +				  pcpu_block_off_to_off(s_index, start),
> > +				  end);
> >  }
> > 
> >  /**
> > @@ -1082,6 +1064,7 @@ static bool pcpu_is_populated(struct pcpu_chunk
> > *chunk, int bit_off, int bits,  static int pcpu_find_block_fit(struct pcpu_chunk
> > *chunk, int alloc_bits,
> >  			       size_t align, bool pop_only)
> >  {
> > +	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> >  	int bit_off, bits, next_off;
> > 
> >  	/*
> > @@ -1090,12 +1073,12 @@ static int pcpu_find_block_fit(struct pcpu_chunk
> > *chunk, int alloc_bits,
> >  	 * cannot fit in the global hint, there is memory pressure and creating
> >  	 * a new chunk would happen soon.
> >  	 */
> > -	bit_off = ALIGN(chunk->contig_bits_start, align) -
> > -		  chunk->contig_bits_start;
> > -	if (bit_off + alloc_bits > chunk->contig_bits)
> > +	bit_off = ALIGN(chunk_md->contig_hint_start, align) -
> > +		  chunk_md->contig_hint_start;
> > +	if (bit_off + alloc_bits > chunk_md->contig_hint)
> >  		return -1;
> > 
> > -	bit_off = chunk->first_bit;
> > +	bit_off = chunk_md->first_free;
> >  	bits = 0;
> >  	pcpu_for_each_fit_region(chunk, alloc_bits, align, bit_off, bits) {
> >  		if (!pop_only || pcpu_is_populated(chunk, bit_off, bits, @@ -1190,6
> > +1173,7 @@ static unsigned long pcpu_find_zero_area(unsigned long *map,
> > static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
> >  			   size_t align, int start)
> >  {
> > +	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> >  	size_t align_mask = (align) ? (align - 1) : 0;
> >  	unsigned long area_off = 0, area_bits = 0;
> >  	int bit_off, end, oslot;
> > @@ -1222,8 +1206,8 @@ static int pcpu_alloc_area(struct pcpu_chunk
> > *chunk, int alloc_bits,
> >  	chunk->free_bytes -= alloc_bits * PCPU_MIN_ALLOC_SIZE;
> > 
> >  	/* update first free bit */
> > -	if (bit_off == chunk->first_bit)
> > -		chunk->first_bit = find_next_zero_bit(
> > +	if (bit_off == chunk_md->first_free)
> > +		chunk_md->first_free = find_next_zero_bit(
> >  					chunk->alloc_map,
> >  					pcpu_chunk_map_bits(chunk),
> >  					bit_off + alloc_bits);
> > @@ -1245,6 +1229,7 @@ static int pcpu_alloc_area(struct pcpu_chunk
> > *chunk, int alloc_bits,
> >   */
> >  static void pcpu_free_area(struct pcpu_chunk *chunk, int off)  {
> > +	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> >  	int bit_off, bits, end, oslot;
> > 
> >  	lockdep_assert_held(&pcpu_lock);
> > @@ -1264,7 +1249,7 @@ static void pcpu_free_area(struct pcpu_chunk
> > *chunk, int off)
> >  	chunk->free_bytes += bits * PCPU_MIN_ALLOC_SIZE;
> > 
> >  	/* update first free bit */
> > -	chunk->first_bit = min(chunk->first_bit, bit_off);
> > +	chunk_md->first_free = min(chunk_md->first_free, bit_off);
> > 
> >  	pcpu_block_update_hint_free(chunk, bit_off, bits);
> > 
> > @@ -1285,6 +1270,9 @@ static void pcpu_init_md_blocks(struct pcpu_chunk
> > *chunk)  {
> >  	struct pcpu_block_md *md_block;
> > 
> > +	/* init the chunk's block */
> > +	pcpu_init_md_block(&chunk->chunk_md,
> > pcpu_chunk_map_bits(chunk));
> > +
> >  	for (md_block = chunk->md_blocks;
> >  	     md_block != chunk->md_blocks + pcpu_chunk_nr_blocks(chunk);
> >  	     md_block++)
> > @@ -1352,7 +1340,6 @@ static struct pcpu_chunk * __init
> > pcpu_alloc_first_chunk(unsigned long tmp_addr,
> >  	chunk->nr_populated = chunk->nr_pages;
> >  	chunk->nr_empty_pop_pages = chunk->nr_pages;
> > 
> > -	chunk->contig_bits = map_size / PCPU_MIN_ALLOC_SIZE;
> >  	chunk->free_bytes = map_size;
> > 
> >  	if (chunk->start_offset) {
> > @@ -1362,7 +1349,7 @@ static struct pcpu_chunk * __init
> > pcpu_alloc_first_chunk(unsigned long tmp_addr,
> >  		set_bit(0, chunk->bound_map);
> >  		set_bit(offset_bits, chunk->bound_map);
> > 
> > -		chunk->first_bit = offset_bits;
> > +		chunk->chunk_md.first_free = offset_bits;
> > 
> >  		pcpu_block_update_hint_alloc(chunk, 0, offset_bits);
> >  	}
> > @@ -1415,7 +1402,6 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t
> > gfp)
> >  	pcpu_init_md_blocks(chunk);
> > 
> >  	/* init metadata */
> > -	chunk->contig_bits = region_bits;
> >  	chunk->free_bytes = chunk->nr_pages * PAGE_SIZE;
> > 
> >  	return chunk;
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 
> Nitpick, how about name a function __pcpu_md_update,
> and let pcpu_chunk_update and pcpu_block_update to
> call __pcpu_md_update. If you prefer, I could submit
> a patch.
> 

I don't have a preference. But I do not really want to have 2 functions
that just wrap the same function. I think overall it'll make sense to
rename it, but I haven't thought about what to rename it to as it'll
probably be influence by the possible direction that percpu ends up
going.

Thanks,
Dennis
