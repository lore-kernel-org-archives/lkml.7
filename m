Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4ECC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B134206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551644609;
	bh=Won9H3KBUZBNmZpy5bq359dTcp35G24QzNI5pcOjsqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f+M1fB6vtRy4+fwfzi84ikoNI5pEaKQP8caaJXapc48MUYrwStFhQVJls0Fxn6eDY
	 sBR/jeOubG4A3c1+AwrzWh0Jx/Z45wOGsLFpHOkQ1XFrqZ4WU3kKqpEaVR4W3dZB4G
	 7rgJDxpAKgdiPDVCqiZ3NMwoV641RCbLD7BtZZRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCCUX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:23:27 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45708 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCCUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:23:26 -0500
Received: by mail-yw1-f65.google.com with SMTP id r188so2507001ywb.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=As7imqn3G4dxOZMTUK1PJuwiWK8PE0mTgXX3jRyo/mE=;
        b=PSER5JQuMcFr+IYCCl6AvZPkH3wNCh/d1kYhRRC2IGZ7rgBi6JQmIsWQumr8Y5Usw7
         +TaoBXv5V2ZCxTVrJcVQZWQ/nqGhehfZwFc9RaDcK+PKtS/24b/p+ZQhgEsSA1QQivTy
         0nfiRdzl6hyAKGjuZVhlOnbJI+oUiH6gkvF4stmCoLlLF5QUtXPAunnWgdd3nX6nvnOO
         cp+doxa0+b5Ovm1p1Q509VT49harZPMoxRmWQaQ40zegr6o68FpHmn+f0vF8L7e4jiX+
         DPUi09FG8652vgzpKyuFjdbCpQBy+bLgkjIyqOFOjte9uszc0jz9JxA5a/CsrNHdGRgx
         7Sqg==
X-Gm-Message-State: APjAAAUOKHhPjbLB/W8rLvuKnE/4/+BOB9R8r8ES4SRFJvH0wH2V4wkg
        OCsOO1pFDB9GD4vtxNl5V0M=
X-Google-Smtp-Source: APXvYqwYGXWilhVaSLcWu2+oaWU1dfZicPRpeAXuyKxB4d2KVdrQJ5vtsyreEA0QyueGU4qpmjRY7g==
X-Received: by 2002:a81:9b05:: with SMTP id s5mr11783129ywg.351.1551644605744;
        Sun, 03 Mar 2019 12:23:25 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::ffe8])
        by smtp.gmail.com with ESMTPSA id p13sm1614143ywe.80.2019.03.03.12.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:23:25 -0800 (PST)
Date:   Sun, 3 Mar 2019 15:23:23 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/12] percpu: add block level scan_hint
Message-ID: <20190303202323.GB4868@dennisz-mbp.dhcp.thefacebook.com>
References: <20190228021839.55779-1-dennis@kernel.org>
 <20190228021839.55779-8-dennis@kernel.org>
 <AM0PR04MB44813651B653B5269C5C211D88700@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB44813651B653B5269C5C211D88700@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 06:01:42AM +0000, Peng Fan wrote:
> Hi Dennis
> 
> > -----Original Message-----
> > From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> > Behalf Of Dennis Zhou
> > Sent: 2019年2月28日 10:19
> > To: Dennis Zhou <dennis@kernel.org>; Tejun Heo <tj@kernel.org>; Christoph
> > Lameter <cl@linux.com>
> > Cc: Vlad Buslov <vladbu@mellanox.com>; kernel-team@fb.com;
> > linux-mm@kvack.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH 07/12] percpu: add block level scan_hint
> > 
> > Fragmentation can cause both blocks and chunks to have an early first_firee
> > bit available, but only able to satisfy allocations much later on. This patch
> > introduces a scan_hint to help mitigate some unnecessary scanning.
> > 
> > The scan_hint remembers the largest area prior to the contig_hint. If the
> > contig_hint == scan_hint, then scan_hint_start > contig_hint_start.
> > This is necessary for scan_hint discovery when refreshing a block.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  mm/percpu-internal.h |   9 ++++
> >  mm/percpu.c          | 101
> > ++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 103 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h index
> > b1739dc06b73..ec58b244545d 100644
> > --- a/mm/percpu-internal.h
> > +++ b/mm/percpu-internal.h
> > @@ -9,8 +9,17 @@
> >   * pcpu_block_md is the metadata block struct.
> >   * Each chunk's bitmap is split into a number of full blocks.
> >   * All units are in terms of bits.
> > + *
> > + * The scan hint is the largest known contiguous area before the contig hint.
> > + * It is not necessarily the actual largest contig hint though.  There
> > + is an
> > + * invariant that the scan_hint_start > contig_hint_start iff
> > + * scan_hint == contig_hint.  This is necessary because when scanning
> > + forward,
> > + * we don't know if a new contig hint would be better than the current one.
> >   */
> >  struct pcpu_block_md {
> > +	int			scan_hint;	/* scan hint for block */
> > +	int			scan_hint_start; /* block relative starting
> > +						    position of the scan hint */
> >  	int                     contig_hint;    /* contig hint for block */
> >  	int                     contig_hint_start; /* block relative starting
> >  						      position of the contig hint */ diff --git
> > a/mm/percpu.c b/mm/percpu.c index 967c9cc3a928..df1aacf58ac8 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -320,6 +320,34 @@ static unsigned long pcpu_block_off_to_off(int index,
> > int off)
> >  	return index * PCPU_BITMAP_BLOCK_BITS + off;  }
> > 
> > +/*
> > + * pcpu_next_hint - determine which hint to use
> > + * @block: block of interest
> > + * @alloc_bits: size of allocation
> > + *
> > + * This determines if we should scan based on the scan_hint or first_free.
> > + * In general, we want to scan from first_free to fulfill allocations
> > +by
> > + * first fit.  However, if we know a scan_hint at position
> > +scan_hint_start
> > + * cannot fulfill an allocation, we can begin scanning from there
> > +knowing
> > + * the contig_hint will be our fallback.
> > + */
> > +static int pcpu_next_hint(struct pcpu_block_md *block, int alloc_bits)
> > +{
> > +	/*
> > +	 * The three conditions below determine if we can skip past the
> > +	 * scan_hint.  First, does the scan hint exist.  Second, is the
> > +	 * contig_hint after the scan_hint (possibly not true iff
> > +	 * contig_hint == scan_hint).  Third, is the allocation request
> > +	 * larger than the scan_hint.
> > +	 */
> > +	if (block->scan_hint &&
> > +	    block->contig_hint_start > block->scan_hint_start &&
> > +	    alloc_bits > block->scan_hint)
> > +		return block->scan_hint_start + block->scan_hint;
> > +
> > +	return block->first_free;
> > +}
> > +
> >  /**
> >   * pcpu_next_md_free_region - finds the next hint free area
> >   * @chunk: chunk of interest
> > @@ -415,9 +443,11 @@ static void pcpu_next_fit_region(struct pcpu_chunk
> > *chunk, int alloc_bits,
> >  		if (block->contig_hint &&
> >  		    block->contig_hint_start >= block_off &&
> >  		    block->contig_hint >= *bits + alloc_bits) {
> > +			int start = pcpu_next_hint(block, alloc_bits);
> > +
> >  			*bits += alloc_bits + block->contig_hint_start -
> > -				 block->first_free;
> > -			*bit_off = pcpu_block_off_to_off(i, block->first_free);
> > +				 start;
> 
> This might not relevant to this patch.
> Not sure it is intended or not.
> For `alloc_bits + block->contig_hink_start - [block->first_free or start]`
> If the reason is to let pcpu_is_populated return a proper next_off when pcpu_is_populated
> fail, it makes sense. If not, why not just use *bits += alloc_bits.
> 

This is how the iterator works. Without it, it doesn't.

Thanks,
Dennis
