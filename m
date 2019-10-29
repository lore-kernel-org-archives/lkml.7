Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81646CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 02:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B1B21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 02:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDPnGskH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfJ2CZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 22:25:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25904 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727987AbfJ2CZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 22:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572315949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cg6FL8Z4Oi0Duw5nqpZmkZl+hK4mK8GPQGyMFpvz9kE=;
        b=FDPnGskH2/WbXLNHgSXiuFZs0oQq0oWG29wOFjsLe6sZL4Wqo2/+yMSut8e3p2gq2A5W9z
        y4oBVmxrkAMIF69z92xY7pAMQ1PDf8+VbzBVr3grCJYyVCzLUowYtVBrLRTD+2eLxp5Vhx
        XMo0NdZRqzM5SWiIk+IbRiYDlk2qrXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-8x8w1UA6NZOwtEZSwEzdbg-1; Mon, 28 Oct 2019 22:25:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35EC28017DD;
        Tue, 29 Oct 2019 02:25:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C23295C1D6;
        Tue, 29 Oct 2019 02:25:38 +0000 (UTC)
Date:   Tue, 29 Oct 2019 10:25:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Speed up for_each_sg() loop macro
Message-ID: <20191029022533.GE22088@ming.t460p>
References: <20191025213359.7538-1-sultan@kerneltoast.com>
MIME-Version: 1.0
In-Reply-To: <20191025213359.7538-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8x8w1UA6NZOwtEZSwEzdbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 02:33:58PM -0700, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
>=20
> Scatterlists are chained in predictable arrays of up to
> SG_MAX_SINGLE_ALLOC sg structs in length. Using this knowledge, speed up
> for_each_sg() by using constant operations to determine when to simply
> increment the sg pointer by one or get the next sg array in the chain.
>=20
> Rudimentary measurements with a trivial loop body show that this yields
> roughly a 2x performance gain.
>=20
> The following simple test module proves the correctness of the new loop
> definition by testing all the different edge cases of sg chains:
> #include <linux/module.h>
> #include <linux/scatterlist.h>
> #include <linux/slab.h>
>=20
> static int __init test_for_each_sg(void)
> {
> =09static const gfp_t gfp_flags =3D GFP_KERNEL | __GFP_NOFAIL;
>         struct scatterlist *sg;
>         struct sg_table *table;
>         long old =3D 0, new =3D 0;
>         unsigned int i, nents;
>=20
>         table =3D kmalloc(sizeof(*table), gfp_flags);
>         for (nents =3D 1; nents <=3D 3 * SG_MAX_SINGLE_ALLOC; nents++) {
>                 BUG_ON(sg_alloc_table(table, nents, gfp_flags));
>                 for (sg =3D table->sgl; sg; sg =3D sg_next(sg))
>                         old ^=3D (long)sg;
>                 for_each_sg(table->sgl, sg, nents, i)
>                         new ^=3D (long)sg;
>                 sg_free_table(table);
>         }
>=20
>         BUG_ON(old !=3D new);
>         kfree(table);
>         return 0;
> }
> module_init(test_for_each_sg);
>=20
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  include/linux/scatterlist.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 556ec1ea2574..73f7fd6702d7 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -146,7 +146,10 @@ static inline void sg_set_buf(struct scatterlist *sg=
, const void *buf,
>   * Loop over each sg element, following the pointer to a new list if nec=
essary
>   */
>  #define for_each_sg(sglist, sg, nr, __i)=09\
> -=09for (__i =3D 0, sg =3D (sglist); __i < (nr); __i++, sg =3D sg_next(sg=
))
> +=09for (__i =3D 0, sg =3D (sglist); __i < (nr);=09=09\
> +=09     likely(++__i % (SG_MAX_SINGLE_ALLOC - 1) ||=09\
> +=09=09    (__i + 1) >=3D (nr)) ? sg++ :=09=09=09\
> +=09=09    (sg =3D sg_chain_ptr(sg + 1)))
> =20

sg_alloc_table_chained() may put a small sglist as the first chunk, then
chained with big one, and your patch breaks such usage.


Thanks,
Ming

