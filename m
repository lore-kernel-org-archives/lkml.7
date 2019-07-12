Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FEFC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFFD2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfGLHRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:17:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43771 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfGLHRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:17:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so3906328pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 00:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HXsmvvgoYnPg11ObtkwJ6+EqE/8B+1DtT9GF/thKYqI=;
        b=MWgO6EQKNROUZVUyfVy4xAEUxy6t8HS6dh288+v0wwKxcMQSAklHS0xuRiyZY6eME6
         MgxH9kQcRm6TKlTTGQOKQGLht7Y/+x9N07KvyUuPAFz1Ip8z8oSgaisMugwnJBIAXfL8
         teIsRjYEOFY1puFjNXzlQmyXpue+E+QiXmEnxGY6PEoPwmkTOeto7mljCXVc5uKAI9a7
         acmViAd6DexY5ZMM2kpWOTuaCEPhTXu1cxncKHy8gsQENwwCv/48+hzF3Barse+Q3cLi
         dalrKzgEgqKxU4ls5dumFuQ+fFsZ+lrTKTGrcy0lOlna/foAF8PaRoQr544DbJNJe7oh
         nc1w==
X-Gm-Message-State: APjAAAUsbzKdh4eTFDpC4dwrZps2HvQJ+cN1p+Cfz1ORCfiqu6OAkY1B
        FGabhkYc/ZzqUv/JQ3ddBU0=
X-Google-Smtp-Source: APXvYqwoOS3vz69Q4xBB7TZBqppk4aiQHJz8Tbu2nOMyKRHJFlOisywyLYZ9OrRWHRbIew30Kk/oxA==
X-Received: by 2002:a63:6ec6:: with SMTP id j189mr9352493pgc.168.1562915857427;
        Fri, 12 Jul 2019 00:17:37 -0700 (PDT)
Received: from sultan-box.localdomain ([2601:200:c001:5f40:3dac:1a9b:f47c:b78e])
        by smtp.gmail.com with ESMTPSA id r6sm12610256pjb.22.2019.07.12.00.17.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 00:17:36 -0700 (PDT)
Date:   Fri, 12 Jul 2019 00:17:18 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Allocate a contiguous array instead of
 chaining
Message-ID: <20190712071718.GA17944@sultan-box.localdomain>
References: <20190712063657.17088-1-sultan@kerneltoast.com>
 <20190712065613.GA3036@ming.t460p>
 <alpine.DEB.2.21.1907120901190.11639@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907120901190.11639@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 09:06:40AM +0200, Thomas Gleixner wrote:
> On Fri, 12 Jul 2019, Ming Lei wrote:
> > vmalloc() may sleep, so it is impossible to be called in atomic context.
> 
> Allocations from atomic context should be avoided wherever possible and you
> really have to have a very convincing argument why an atomic allocation is
> absolutely necessary. I cleaned up quite some GFP_ATOMIC users over the
> last couple of years and all of them were doing it for the very wrong
> reasons and mostly just to silence the warning which is triggered with
> GFP_KERNEL when called from a non-sleepable context.
> 
> So I suggest to audit all call sites first and figure out whether they
> really must use GFP_ATOMIC and if possible clean them up, remove the GFP
> argument and then do the vmalloc thing on top.

Hello Thomas and Ming,

It looks like the following call sites are atomic:
drivers/crypto/qce/ablkcipher.c:92:	ret = sg_alloc_table(&rctx->dst_tbl, rctx->dst_nents, gfp);
drivers/crypto/ccp/ccp-crypto-aes-cmac.c:110:	ret = sg_alloc_table(&rctx->data_sg, sg_count, gfp);
drivers/crypto/ccp/ccp-crypto-sha.c:103:		ret = sg_alloc_table(&rctx->data_sg, sg_count, gfp);
drivers/spi/spi-pl022.c:1035:	ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_ATOMIC);
drivers/spi/spi-pl022.c:1039:	ret = sg_alloc_table(&pl022->sgt_tx, pages, GFP_ATOMIC);

The crypto ones are conditionally made atomic depending on the presence of
CRYPTO_TFM_REQ_MAY_SLEEP.

Additionally, the following allocation could be problematic with kvmalloc:
net/ceph/crypto.c:180:		ret = sg_alloc_table(sgt, chunk_cnt, GFP_NOFS);

This is a snippet from kvmalloc:
	/*
	 * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
	 * so the given set of flags has to be compatible.
	 */
	if ((flags & GFP_KERNEL) != GFP_KERNEL)
		return kmalloc_node(size, flags, node);

Use of GFP_NOFS in net/ceph/crypto.c would cause kvmalloc to fall back to
kmalloc_node, which could cause problems if the allocation size is too large for
kmalloc_node to reasonably accomodate.

Also, it looks like the vmalloc family doesn't have kvmalloc's GFP_KERNEL check.
Is this intentional, or does vmalloc really not require GFP_KERNEL context?

Thanks,
Sultan
