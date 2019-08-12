Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1A2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD622085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565619801;
	bh=8AlBzaLTBUeMaPF+z5eAFEPn04v1rCfb+CInk+uno2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xkrJ8J7TypIIR96O33OKVP5UzgkG2v8hxisuQAoV0s/uURPR0lJyu8YwLi0RE2Fr7
	 2iUxItmDkFIqT2CjumslaNHt7dN68nBd3qbYkmx0PJLu+twTxZPuNRpAq911LG2VsG
	 u9yNlTOgC9Gb/t8Xt8ImsrYLweuf/1W1oAxvegEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHLOXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbfHLOXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:23:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941B8206DF;
        Mon, 12 Aug 2019 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565619799;
        bh=8AlBzaLTBUeMaPF+z5eAFEPn04v1rCfb+CInk+uno2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wJdlEeqHv6g/8l7H/+leKevtKgFe4G3bPF6vMlNaCQAfAfdQEZpEda9Iix/p9FDL
         0zs4WVj+nO+lO4b+E1HQHs+51hyLceU7AXjAUuZDQKz7N3rvpIOYJ7IKQxxhyieDVY
         DRQcfx2ccDsfEWQKJIPBmYMSpjSEriGSw6KhxeIg=
Date:   Mon, 12 Aug 2019 16:23:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alessio Balsini <balsini@android.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH 4.9.y 4.14.y] IB/mlx5: Fix leaking stack memory to
 userspace
Message-ID: <20190812142316.GA12869@kroah.com>
References: <20190812105136.151840-1-balsini@android.com>
 <20190812105503.153253-1-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812105503.153253-1-balsini@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:55:03AM +0100, Alessio Balsini wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> commit 0625b4ba1a5d4703c7fb01c497bd6c156908af00 upstream.
> 
> mlx5_ib_create_qp_resp was never initialized and only the first 4 bytes
> were written.
> 
> Fixes: 41d902cb7c32 ("RDMA/mlx5: Fix definition of mlx5_ib_create_qp_resp")

This commit only showed up in the following kernel releases:
	4.17 4.18.7 4.19

so why is this "fix" commit needed in anything older than 4.17?

That's why I did not backport it to older kernels, as I do not think it
is needed there.  Do you?

thanks,

greg k-h
