Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288BAC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E986A20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551565938;
	bh=UbjHW6XPL5wQPVxW1t/s5Yo/2fEa4uwxJmK59Dg7X9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KGiDsf1ZFyUhK/yWEMMhCNwlaZX34Bt1YH34/s5+6lToTSmui57fnUZBAT846kT7S
	 Fe1vwUyfNXlcPN0iljd333ykv9WIYEfOG6uHrQOGPwslxBRt4H7hRSs9dh+wmISh4f
	 U/3F3MeFIebL437T+dSFuv8VmH0PF+oJ6/IPzpMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfCBWcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:32:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36059 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfCBWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 17:32:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so1447499qtb.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 14:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ynw/EvoworPJ989NZsNSzILz66FhFYqpbBC7pk+xT7U=;
        b=saPq5kPxyPowJ7gZpcV63ZJpHhG2cSKyUJ2fJplpleHVAB9krpJPXKIlEW9E12kdZ5
         OYUhmNHJW1xo4BI3eW7f8vc1vFofqy1oy0sUd6To63CmKz/LZdtZLFEtKWb5LGmc4v4y
         DhF2i8kkYN3LDpZHRl63DFdgOKwSkZL0PnFWwi2vf0kGJKUgR5ZCqYjGnn8w8DFWNa0z
         Us8WTiChw9I7jQ7A1Jzdf/RUPlrwWUUmqVuPLRmCLW/pFfRjUoNL7UxmaKUeNTYt1cIl
         zSa3VvkB6QfMMzW23qqEkGU76CEFfPj1sKmpjUZBQ+QFtUIOEWJat96eJg7kIQQav0CR
         DnwA==
X-Gm-Message-State: APjAAAWtmGAa9+VqcG9KZt+y7su5RMNNYDUaCpvixt8UVfIRNDiXV/XN
        CjvXgyEp81AHP8hV2JYd3Ug=
X-Google-Smtp-Source: APXvYqyMnRrTY/rJ7tqd3eagSVQMAyxb3YUIFTb5AVwqUuAhQUTpRs2XW5as4SxeN37npC1Hp+rD5A==
X-Received: by 2002:ac8:26a7:: with SMTP id 36mr9672393qto.234.1551565934889;
        Sat, 02 Mar 2019 14:32:14 -0800 (PST)
Received: from dennisz-mbp.home ([2604:2000:1406:13e:1c79:146b:53ab:5b76])
        by smtp.gmail.com with ESMTPSA id z9sm1118594qkj.33.2019.03.02.14.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 14:32:13 -0800 (PST)
Date:   Sat, 2 Mar 2019 17:32:11 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] percpu: manage chunks based on contig_bits instead
 of free_bytes
Message-ID: <20190302223211.GC1196@dennisz-mbp.home>
References: <20190228021839.55779-1-dennis@kernel.org>
 <20190228021839.55779-5-dennis@kernel.org>
 <AM0PR04MB4481BE90E46F3635B7131CED88770@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB4481BE90E46F3635B7131CED88770@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 01:48:20PM +0000, Peng Fan wrote:
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
> > Subject: [PATCH 04/12] percpu: manage chunks based on contig_bits instead
> > of free_bytes
> > 
> > When a chunk becomes fragmented, it can end up having a large number of
> > small allocation areas free. The free_bytes sorting of chunks leads to
> > unnecessary checking of chunks that cannot satisfy the allocation.
> > Switch to contig_bits sorting to prevent scanning chunks that may not be able
> > to service the allocation request.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  mm/percpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index b40112b2fc59..c996bcffbb2a 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -234,7 +234,7 @@ static int pcpu_chunk_slot(const struct pcpu_chunk
> > *chunk)
> >  	if (chunk->free_bytes < PCPU_MIN_ALLOC_SIZE || chunk->contig_bits
> > == 0)
> >  		return 0;
> > 
> > -	return pcpu_size_to_slot(chunk->free_bytes);
> > +	return pcpu_size_to_slot(chunk->contig_bits * PCPU_MIN_ALLOC_SIZE);
> >  }
> > 
> >  /* set the pointer to a chunk in a page struct */
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 
> Not relevant to this patch, another optimization to percpu might be good
> to use per chunk spin_lock, not gobal pcpu_lock.
> 

Percpu memory itself is expensive and for the most part shouldn't be
part of the critical path. Ideally, we don't have multiple chunks being
allocated simultaneously because once an allocation is given out, the
chunk is pinned until all allocations are freed.

Thanks,
Dennis
