Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA0C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAFE2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564377649;
	bh=3H4Qq+X2h7U7AUDwFAS5XVO9Z9CyMul1Qd23T2fsMsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iO9vI7u+AP0d857pgF1gOuWOk9KohTwnw7D7R3M1ANq8YdWy79Fjqb9sUqavftIME
	 gENBjNMEn5JbUF1aZmqicxJHZvm2oEOa4kkEuK/xrS+MYJe/520TzIY2K7NucLwZj+
	 w6ZlrKgGT4clWaCTpMwDY6X09xfxxPtjaQnpEG5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfG2FUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfG2FUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:20:48 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615ED2070D;
        Mon, 29 Jul 2019 05:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564377647;
        bh=3H4Qq+X2h7U7AUDwFAS5XVO9Z9CyMul1Qd23T2fsMsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xeRP+kmlFnXNNMsvae3POjeVUJRyZct6auKZ2KdLUBCmT0cquuBKdt2ZU3Rp/NOnW
         6ax8RY110UEFQIvXDW9OmBAFC6GMoZ6aV/b8Uu4KS4UPNyM09R8P/ZkZ7Y+lQ70pYV
         yiwkeNt00ytfknpsYm6vJq0vpSbCfvu8WcJEDX7g=
Date:   Mon, 29 Jul 2019 08:20:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] infiniband: mlx5: a possible null-pointer dereference in
 set_roce_addr()
Message-ID: <20190729052043.GJ4674@mtr-leonro.mtl.com>
References: <f99031cc-795e-92bd-9310-29c669ada7dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f99031cc-795e-92bd-9310-29c669ada7dc@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:16:30AM +0800, Jia-Ju Bai wrote:
> In set_roce_addr(), there is an if statement on line 589 to check whether
> gid is NULL:
>     if (gid)
>
> When gid is NULL, it is used on line 613:
>     return mlx5_core_roce_gid_set(..., gid->raw, ...);
>
> Thus, a possible null-pointer dereference may occur.
>
> This bug is found by a static analysis tool STCheck written by us.
>
> I do not know how to correctly fix this bug, so I only report it.

You should fix the tool, gid and gid->raw are the same pointers in C.

In this case, "mlx5_core_roce_gid_set(..., gid->raw, ...);" will be
equal to "mlx5_core_roce_gid_set(..., NULL, ...);" and
mlx5_core_roce_gid_set() is designed to handle this case.

Thanks

>
>
> Best wishes,
> Jia-Ju Bai
