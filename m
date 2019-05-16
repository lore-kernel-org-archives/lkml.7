Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD6CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF15820848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558014976;
	bh=CMrAya67APClJ/68LrKlSJfxPmlq08xvMoQncjUiriQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MGgR6oUJ8RvDr5T79K7ESq8V2H3zRuCvt8s9IKzwmQOmwyai8yRiJlSCNveVLHZ4f
	 vnnDexo3w6bnwoNaIaWIr4fABaUkDs8IeBMokf34jITWx8R0WtnlLVhegkxHM3UikC
	 5csQ+2sSWxkiNLR+ckprxnpbFhQJEfpQJiq4s+ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfEPN4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfEPN4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:56:14 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BE520657;
        Thu, 16 May 2019 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558014973;
        bh=CMrAya67APClJ/68LrKlSJfxPmlq08xvMoQncjUiriQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKnhejlcoJIBtFe+BrgT0i+D7pC46ev8qFyn4Jx5fQUjqLHCHGjV39hcJqDZT7eoq
         Le2XkGouGgX3HLOkgMGPo1jzXFjEXKffs3zcUT/krMPy1kiipvB1vZAgYJJmwy/lcK
         tp/6Aw0P32V24zcDp8VTeNtKhT+jDEyj1TEdAUZU=
Date:   Thu, 16 May 2019 16:56:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/nldev: add check for null return from call to
 nlmsg_put
Message-ID: <20190516135610.GB6026@mtr-leonro.mtl.com>
References: <20190516131215.20411-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516131215.20411-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 02:12:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> It is possible that nlmsg_put can return a null pointer, currently
> this will lead to a null pointer dereference when passing a null
> nlh pointer to nlmsg_end.  Fix this by adding a null pointer check.
>
> Addresses-Coverity: ("Dereference null return value")
> Fixes: cb7e0e130503 ("RDMA/core: Add interface to read device namespace sharing mode")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/core/nldev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 69188cbbd99b..4dc43b6c5a28 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1367,6 +1367,10 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>  			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
>  					 RDMA_NLDEV_CMD_SYS_GET),
>  			0, 0);

It is impossible situation due to "0" in payload field above.

> +	if (!nlh) {
> +		nlmsg_free(msg);
> +		return -EMSGSIZE;
> +	}
>
>  	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
>  			 (u8)ib_devices_shared_netns);
> --
> 2.20.1
>
