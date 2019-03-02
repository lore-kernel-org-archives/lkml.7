Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAED2C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8723420863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551565503;
	bh=9oUzuq/END+rJ6ORwm/tDJlYRNvy/pAxpcVf+4oyvas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H3C4CFKgxjvilyrL2eSU1VwTgYmB1pc7HeGjx+akSQMQkCE+t08JV+nRl8GSsrp15
	 FjTr45e+v9tZaqmt7Kd7Z9kLDXixji9dHS8TEPranKA1l7ijRd4fTbR6Op0U5QYJ2J
	 Lp5/37heB5GpKivOcgH+7ABBXSS2MGzq7wOBsn9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCBWZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:25:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40485 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfCBWZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 17:25:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id h28so861004qkk.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 14:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xKjx14ks+fWUvz6Cb9F2qKJQJcDxCcs/XzD8Ta06PU0=;
        b=cCs9uCDnVaOwEWtBVyXIIozGVk3efIfPTYJWh/0fmTEim4gnvv8kJxUrbxhWzJYJ5r
         ugYUk9SZ7pdhcISv3U66MiId5sYZ/9ejK8Py8EsF4NFPmMayMD/qtreo4aT0oeyyqRNF
         R694pxNh4V3+SgVWhW5Zwx3w0rHuQRIEI7lJ2P/9oBSbzoczK5I/Bk9puQnb33aqRMT6
         HD+WbOQ7XrzNpyONe/mSfPWXSJ3Dm+x3vw37dvX8ODb1oG1jnGCWHzWSN+w9+aBWD2g2
         w1pN0r1rNNLWjXBt2SxkDBSU6Knd/jB0a8VQkERdBkrtPz3CCkYPPqKthZb5uAdHIppD
         rMYQ==
X-Gm-Message-State: APjAAAUfetjK8MHVWSs9iRrhRmw6SglLQgRI7EdLk/+Rfp+Lo7oahyHI
        WSzOwDdv0LY7fC8L7CJ17vk=
X-Google-Smtp-Source: APXvYqy6DH2DpgZ3sH+xX5QSmETeNxgwWRy6TyEl9pk8fnp2y4mphBL2u51Df8wqWBI2NdDUVlphWg==
X-Received: by 2002:a37:a247:: with SMTP id l68mr8593537qke.96.1551565500403;
        Sat, 02 Mar 2019 14:25:00 -0800 (PST)
Received: from dennisz-mbp.home ([2604:2000:1406:13e:1c79:146b:53ab:5b76])
        by smtp.gmail.com with ESMTPSA id m88sm1031315qte.68.2019.03.02.14.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 14:24:59 -0800 (PST)
Date:   Sat, 2 Mar 2019 17:24:57 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/12] percpu: introduce helper to determine if two
 regions overlap
Message-ID: <20190302222457.GB1196@dennisz-mbp.home>
References: <20190228021839.55779-1-dennis@kernel.org>
 <20190228021839.55779-4-dennis@kernel.org>
 <AM0PR04MB44816A833E192E37072B641988770@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB44816A833E192E37072B641988770@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 01:37:37PM +0000, Peng Fan wrote:
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
> > Subject: [PATCH 03/12] percpu: introduce helper to determine if two regions
> > overlap
> > 
> > While block hints were always accurate, it's possible when spanning across
> > blocks that we miss updating the chunk's contig_hint. Rather than rely on
> > correctness of the boundaries of hints, do a full overlap comparison.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  mm/percpu.c | 31 +++++++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 69ca51d238b5..b40112b2fc59 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -546,6 +546,24 @@ static inline int pcpu_cnt_pop_pages(struct
> > pcpu_chunk *chunk, int bit_off,
> >  	       bitmap_weight(chunk->populated, page_start);  }
> > 
> > +/*
> > + * pcpu_region_overlap - determines if two regions overlap
> > + * @a: start of first region, inclusive
> > + * @b: end of first region, exclusive
> > + * @x: start of second region, inclusive
> > + * @y: end of second region, exclusive
> > + *
> > + * This is used to determine if the hint region [a, b) overlaps with
> > +the
> > + * allocated region [x, y).
> > + */
> > +static inline bool pcpu_region_overlap(int a, int b, int x, int y) {
> > +	if ((x >= a && x < b) || (y > a && y <= b) ||
> > +	    (x <= a && y >= b))
> 
> I think this could be simplified:
>  (a < y) && (x < b) could be used to do overlap check.
> 

I'll change it to be the negative.

Thanks,
Dennis

> 
> > +		return true;
> > +	return false;
> > +}
> > +
> >  /**
> >   * pcpu_chunk_update - updates the chunk metadata given a free area
> >   * @chunk: chunk of interest
> > @@ -710,8 +728,11 @@ static void pcpu_block_update_hint_alloc(struct
> > pcpu_chunk *chunk, int bit_off,
> >  					PCPU_BITMAP_BLOCK_BITS,
> >  					s_off + bits);
> > 
> > -	if (s_off >= s_block->contig_hint_start &&
> > -	    s_off < s_block->contig_hint_start + s_block->contig_hint) {
> > +	if (pcpu_region_overlap(s_block->contig_hint_start,
> > +				s_block->contig_hint_start +
> > +				s_block->contig_hint,
> > +				s_off,
> > +				s_off + bits)) {
> >  		/* block contig hint is broken - scan to fix it */
> >  		pcpu_block_refresh_hint(chunk, s_index);
> >  	} else {
> > @@ -764,8 +785,10 @@ static void pcpu_block_update_hint_alloc(struct
> > pcpu_chunk *chunk, int bit_off,
> >  	 * contig hint is broken.  Otherwise, it means a smaller space
> >  	 * was used and therefore the chunk contig hint is still correct.
> >  	 */
> > -	if (bit_off >= chunk->contig_bits_start  &&
> > -	    bit_off < chunk->contig_bits_start + chunk->contig_bits)
> > +	if (pcpu_region_overlap(chunk->contig_bits_start,
> > +				chunk->contig_bits_start + chunk->contig_bits,
> > +				bit_off,
> > +				bit_off + bits))
> >  		pcpu_chunk_refresh_hint(chunk);
> >  }
> > 
> > --
> > 2.17.1
> 
