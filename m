Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7EFC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FFC214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576050319;
	bh=ORoZNGYLwU3ulSzICh6bzHMq1V1v92C9tqa77JQUmCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EMbqxFRjq5TAummFkaZjsdAFITKyiKxQgn9EKcWAhsx1z/DSuve3DM54MgyBPW/oJ
	 sKagt7kmbT0eUmfofhWcib8kLxuO7gIbRrvc+CGzoQ61ATBD8+QMbE+tOfTCgh6qLV
	 Tjt+7IFi1xz8KrJU+j7HyoX4csrxBPovbOfBNIx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfLKHpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfLKHpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:45:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AAAA20637;
        Wed, 11 Dec 2019 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576050316;
        bh=ORoZNGYLwU3ulSzICh6bzHMq1V1v92C9tqa77JQUmCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kB9SJhnssCAG6VbTJh99wkwijYY/4H1H/oQWmyPW7d/wM/kDHzp4hPhd5/7mFbbBJ
         Iv/yizG2h1MVCDL8D6hj6dFVGpVuhzQ82JwCbGo3FCmT+vbu8bc7yPcB3eLQ5n+yeS
         moX5bNIbwlCJLcVu1jslaVL3SjvCm6J9dYuMaTKc=
Date:   Wed, 11 Dec 2019 08:45:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.9 75/91] RDMA/qib: Validate ->show()/store()
 callbacks before calling them
Message-ID: <20191211074514.GD398293@kroah.com>
References: <20191210223035.14270-1-sashal@kernel.org>
 <20191210223035.14270-75-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210223035.14270-75-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 05:30:19PM -0500, Sasha Levin wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
> 
> [ Upstream commit 7ee23491b39259ae83899dd93b2a29ef0f22f0a7 ]
> 
> The permissions of the read-only or write-only sysfs files can be
> changed (as root) and the user can then try to read a write-only file or
> write to a read-only file which will lead to kernel crash here.
> 
> Protect against that by always validating the show/store callbacks.
> 
> Link: https://lore.kernel.org/r/d45cc26361a174ae12dbb86c994ef334d257924b.1573096807.git.viresh.kumar@linaro.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/infiniband/hw/qib/qib_sysfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Good catch, I was looking for this one but somehow the stable tag got
dropped from it.

greg k-h
