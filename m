Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1FDC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1717205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576050469;
	bh=x/KDftEKkwxca2mTfxUK9YkXt3X5uKEmkL+Dbr1vmOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p0LbDifGn3S3+/0kYEWX7AQ+WGyxGFN7EijObcuV7MRcX4CfmnausW9KYMcJJ29H4
	 E+4DTz9xXIyR+SVyv577S+JK1NVfgZY1xiEZEXQI1uD67j8b4Br6fltLrxni49xET4
	 LkqQSLXZhWLiF8VTxRkHIPBoQbBUh/QQxv+Y3G4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfLKHrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfLKHrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:47:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A10F205C9;
        Wed, 11 Dec 2019 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576050467;
        bh=x/KDftEKkwxca2mTfxUK9YkXt3X5uKEmkL+Dbr1vmOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZaE58V0atREkU41bZa5s566hWtv3h3F9C7ZusTZnCcNqXOgxi5K7oYvw6UXEngw5
         j1ITUJiqowuXGmnrZLK2fjbPByk0i5y18pMsFy9K7p41DdzSCT5wo9kfJSBmNnmB2n
         Krx8aVz4tfLSRX/1ymaGXzwjx2Ho6u8lAebxu0Gk=
Date:   Wed, 11 Dec 2019 08:47:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kusanagi Kouichi <slash@ac.auone-net.jp>
Subject: Re: [PATCH AUTOSEL 4.14 121/130] debugfs: Fix !DEBUG_FS
 debugfs_create_automount
Message-ID: <20191211074745.GG398293@kroah.com>
References: <20191210220301.13262-1-sashal@kernel.org>
 <20191210220301.13262-121-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210220301.13262-121-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 05:02:52PM -0500, Sasha Levin wrote:
> From: Kusanagi Kouichi <slash@ac.auone-net.jp>
> 
> [ Upstream commit 4250b047039d324e0ff65267c8beb5bad5052a86 ]
> 
> If DEBUG_FS=n, compile fails with the following error:
> 
> kernel/trace/trace.c: In function 'tracing_init_dentry':
> kernel/trace/trace.c:8658:9: error: passing argument 3 of 'debugfs_create_automount' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  8658 |         trace_automount, NULL);
>       |         ^~~~~~~~~~~~~~~
>       |         |
>       |         struct vfsmount * (*)(struct dentry *, void *)
> In file included from kernel/trace/trace.c:24:
> ./include/linux/debugfs.h:206:25: note: expected 'struct vfsmount * (*)(void *)' but argument is of type 'struct vfsmount * (*)(struct dentry *, void *)'
>   206 |      struct vfsmount *(*f)(void *),
>       |      ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
> 
> Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
> Link: https://lore.kernel.org/r/20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/debugfs.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Not needed, please drop from everywhere.

thanks,

greg k-h
