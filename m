Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF897C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A242C20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551566091;
	bh=j/5yPxjUOOb8Xi3Z1hmvmvQinempqm47r5Il1QckDRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ESbMaXp8y84eeNI435TvFTP0w6Tp9UQ1YUMKPY/GA9GnhcfI1Az4VbHvi+IVSywul
	 qwuH3pEXbzoMK5i1UV5BlohoMKjcvxuFncMe67Cnz1hl7gY28b9ROh4eZB0uqrz9vb
	 YHnWD5aD7ekKXHaM9ESubsnL3nC1ykm3mbve/KUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfCBWeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:34:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35825 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfCBWet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 17:34:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id z13so875699qki.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 14:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HHwXXkQwEVEt0XYjQBHBCmyn0vtaYqap/APJoabLufg=;
        b=oFWYK+R8qhjP2Mycec1/PiUcSWO8lo2Ymn+8Q2ms+yJ4ITJQZZi1mCPnn4I2aYFdGi
         kUIXfyoFjoHAtpLTaq2XzBMCrEKLNkii6R68cp9gGkfQASsllcoIAptRc94oETZLmh4c
         +j6FJwmPTbDyDWjbI7+Q579mHf+bdv0uxxZlPCo3R/WT0EoPOwoNs1pBAZvdLpxH8cwt
         6JQ73JPa/N5uinr8JV3vdf6+EL7AOO9+JQ2a8ie5EZRiqmnSSFpl0U6LMJrz/zgyxDNN
         CVvf6fjDfKMHfKjnltH8qZyg5VradmGQdO18MczYJMynoJjqvOGIkokcZUrez+zatDyI
         P+eA==
X-Gm-Message-State: APjAAAVzYbIwh6f4F9fpHuRMG1A4rxRCEt+0poXRePykwULRloFyTpkw
        k7YHJYOXL43E+lxv34JrKBY=
X-Google-Smtp-Source: APXvYqxpDKqBLQNo7Odyu7aKGFbxEYo/zMor7ikPx4gbbRIk9T2XSyn9Bp7fkDuT4fX1Er5macpyTg==
X-Received: by 2002:a37:98d:: with SMTP id 135mr9018707qkj.333.1551566088499;
        Sat, 02 Mar 2019 14:34:48 -0800 (PST)
Received: from dennisz-mbp.home ([2604:2000:1406:13e:1c79:146b:53ab:5b76])
        by smtp.gmail.com with ESMTPSA id 14sm1134860qkf.23.2019.03.02.14.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 14:34:47 -0800 (PST)
Date:   Sat, 2 Mar 2019 17:34:45 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/12] percpu: relegate chunks unusable when failing
 small allocations
Message-ID: <20190302223445.GD1196@dennisz-mbp.home>
References: <20190228021839.55779-1-dennis@kernel.org>
 <20190228021839.55779-6-dennis@kernel.org>
 <AM0PR04MB4481502C6D96166F594994CA88770@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB4481502C6D96166F594994CA88770@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 01:55:54PM +0000, Peng Fan wrote:
> Hi Dennis,
> 
> > -----Original Message-----
> > From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> > Behalf Of Dennis Zhou
> > Sent: 2019年2月28日 10:19
> > To: Dennis Zhou <dennis@kernel.org>; Tejun Heo <tj@kernel.org>; Christoph
> > Lameter <cl@linux.com>
> > Cc: Vlad Buslov <vladbu@mellanox.com>; kernel-team@fb.com;
> > linux-mm@kvack.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH 05/12] percpu: relegate chunks unusable when failing small
> > allocations
> > 
> > In certain cases, requestors of percpu memory may want specific alignments.
> > However, it is possible to end up in situations where the contig_hint matches,
> > but the alignment does not. This causes excess scanning of chunks that will fail.
> > To prevent this, if a small allocation fails (< 32B), the chunk is moved to the
> > empty list. Once an allocation is freed from that chunk, it is placed back into
> > rotation.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  mm/percpu.c | 35 ++++++++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index c996bcffbb2a..3d7deece9556 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -94,6 +94,8 @@
> > 
> >  /* the slots are sorted by free bytes left, 1-31 bytes share the same slot */
> >  #define PCPU_SLOT_BASE_SHIFT		5
> > +/* chunks in slots below this are subject to being sidelined on failed alloc */
> > +#define PCPU_SLOT_FAIL_THRESHOLD	3
> > 
> >  #define PCPU_EMPTY_POP_PAGES_LOW	2
> >  #define PCPU_EMPTY_POP_PAGES_HIGH	4
> > @@ -488,6 +490,22 @@ static void pcpu_mem_free(void *ptr)
> >  	kvfree(ptr);
> >  }
> > 
> > +static void __pcpu_chunk_move(struct pcpu_chunk *chunk, int slot,
> > +			      bool move_front)
> > +{
> > +	if (chunk != pcpu_reserved_chunk) {
> > +		if (move_front)
> > +			list_move(&chunk->list, &pcpu_slot[slot]);
> > +		else
> > +			list_move_tail(&chunk->list, &pcpu_slot[slot]);
> > +	}
> > +}
> > +
> > +static void pcpu_chunk_move(struct pcpu_chunk *chunk, int slot) {
> > +	__pcpu_chunk_move(chunk, slot, true);
> > +}
> > +
> >  /**
> >   * pcpu_chunk_relocate - put chunk in the appropriate chunk slot
> >   * @chunk: chunk of interest
> > @@ -505,12 +523,8 @@ static void pcpu_chunk_relocate(struct pcpu_chunk
> > *chunk, int oslot)  {
> >  	int nslot = pcpu_chunk_slot(chunk);
> > 
> > -	if (chunk != pcpu_reserved_chunk && oslot != nslot) {
> > -		if (oslot < nslot)
> > -			list_move(&chunk->list, &pcpu_slot[nslot]);
> > -		else
> > -			list_move_tail(&chunk->list, &pcpu_slot[nslot]);
> > -	}
> > +	if (oslot != nslot)
> > +		__pcpu_chunk_move(chunk, nslot, oslot < nslot);
> >  }
> > 
> >  /**
> > @@ -1381,7 +1395,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t
> > align, bool reserved,
> >  	bool is_atomic = (gfp & GFP_KERNEL) != GFP_KERNEL;
> >  	bool do_warn = !(gfp & __GFP_NOWARN);
> >  	static int warn_limit = 10;
> > -	struct pcpu_chunk *chunk;
> > +	struct pcpu_chunk *chunk, *next;
> >  	const char *err;
> >  	int slot, off, cpu, ret;
> >  	unsigned long flags;
> > @@ -1443,11 +1457,14 @@ static void __percpu *pcpu_alloc(size_t size,
> > size_t align, bool reserved,
> >  restart:
> >  	/* search through normal chunks */
> >  	for (slot = pcpu_size_to_slot(size); slot < pcpu_nr_slots; slot++) {
> > -		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> > +		list_for_each_entry_safe(chunk, next, &pcpu_slot[slot], list) {
> >  			off = pcpu_find_block_fit(chunk, bits, bit_align,
> >  						  is_atomic);
> > -			if (off < 0)
> > +			if (off < 0) {
> > +				if (slot < PCPU_SLOT_FAIL_THRESHOLD)
> > +					pcpu_chunk_move(chunk, 0);
> >  				continue;
> > +			}
> > 
> >  			off = pcpu_alloc_area(chunk, bits, bit_align, off);
> >  			if (off >= 0)
> 
> For the code: Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 
> But I did not understand well why choose 32B? If there are
> more information, better put in commit log.
> 

There isn't I just picked a small allocation size.

Thanks,
Dennis
