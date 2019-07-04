Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A316FC06514
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7294F21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562221680;
	bh=N2XXHkGwjIDYSWFPldcogFR7T90EltyDN1A8ixT4iAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LtxUt+FmcmBXyn9fTrNHKrubsaF5l5RGrxJ8RsfXUB9X6YBFY4srOaPHC4hfCxsz0
	 FQxza3gNNuQuyl4F+vpnk9dcWas57wFsfLZujq897G/GSCQorXl1bZuVvM/BAeL6tt
	 EsrC0gFly8wrbnQOHnHch6RcefZIpr5ycaEBi2GY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGDG17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDG17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:27:59 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9992421850;
        Thu,  4 Jul 2019 06:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562221678;
        bh=N2XXHkGwjIDYSWFPldcogFR7T90EltyDN1A8ixT4iAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IajMpTxvQdieihszIioDkhkftkA+GyeaXsmP/AIlIsrIiixrs0z+cXOHwyXLA8C2S
         ZacrJNI46bYEwLHAoYYeIMIqjFVYER3sRrz6XtdFF2kEA5uDsK9RlDv3iOcjSIIZMA
         a+5HXDiqWkfwyfUWvUbpRtM0jqtPExxValunROoQ=
Date:   Thu, 4 Jul 2019 09:27:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the rdma tree
Message-ID: <20190704062754.GG4727@mtr-leonro.mtl.com>
References: <20190704124738.1e88cb69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704124738.1e88cb69@canb.auug.org.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:47:38PM +1000, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>
>   drivers/infiniband/hw/mlx5/cq.c
>
> between commit:
>
>   e39afe3d6dbd ("RDMA: Convert CQ allocations to be under core responsibility")
>
> from the rdma tree and commit:
>
>   38164b771947 ("net/mlx5: mlx5_core_create_cq() enhancements")
>
> from the mlx5-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/infiniband/hw/mlx5/cq.c
> index bfe3efdd77d7,4efbbd2fce0c..000000000000
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@@ -891,7 -891,8 +891,8 @@@ int mlx5_ib_create_cq(struct ib_cq *ibc
>   	int entries = attr->cqe;
>   	int vector = attr->comp_vector;
>   	struct mlx5_ib_dev *dev = to_mdev(ibdev);
> + 	u32 out[MLX5_ST_SZ_DW(create_cq_out)];
>  -	struct mlx5_ib_cq *cq;
>  +	struct mlx5_ib_cq *cq = to_mcq(ibcq);
>   	int uninitialized_var(index);
>   	int uninitialized_var(inlen);
>   	u32 *cqb = NULL;

Thanks, it looks good.



