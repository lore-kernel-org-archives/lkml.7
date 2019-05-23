Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0050C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A205B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfEWMsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbfEWMsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:48:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB16721019;
        Thu, 23 May 2019 12:48:13 +0000 (UTC)
Date:   Thu, 23 May 2019 08:48:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RDMA/mlx5: Use DIV_ROUND_UP_ULL macro to allow 32 bit
 to build
Message-ID: <20190523084812.325454f6@gandalf.local.home>
In-Reply-To: <20190523065803.GB30439@unicorn.suse.cz>
References: <20190522145450.25ff483d@gandalf.local.home>
        <20190523065803.GB30439@unicorn.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 08:58:03 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index abac70ad5c7c..40d4c5f7ea43 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -2344,7 +2344,7 @@ static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
> >  	/* Allocation size must a multiple of the basic block size
> >  	 * and a power of 2.
> >  	 */
> > -	act_size = roundup(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
> > +	act_size = DIV_ROUND_UP_ULL(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
> >  	act_size = roundup_pow_of_two(act_size);
> >  
> >  	dm->size = act_size;  
> 
> This seems wrong: roundup() rounds up to a multiple of second argument
> but DIV_ROUND_UP_ULL() would divide with rounding up.

Yeah, the macros are a bit confusing. There's unfortunately no
roundup_64() (perhaps we should make one?)

#define roundup(x, y) (					\
{							\
	typeof(y) __y = y;				\
	(((x) + (__y - 1)) / __y) * __y;		\
}							\
)


#define DIV_ROUND_DOWN_ULL(ll, d) \
	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })

#define DIV_ROUND_UP_ULL(ll, d)		DIV_ROUND_DOWN_ULL((ll) + (d) - 1, (d))


roundup(a, b) == ((a + b - 1) / b) * b

DIV_ROUND_UP_ULL(a, b) DIV_ROUND_DOWN_ULL(a + b - 1, b)
 = (a + b - 1) / b

Hmm, looks like you are right (damn, I thought I did this before
posting the patch, but I must have miscalculated something). It does
look like we are missing a "* b" in there.

I think I'll go and just add a roundup_64()!

Thanks for pointing this out.

-- Steve
