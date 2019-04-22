Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68855C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EE820859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555965609;
	bh=+E6AcO99oC+EPSmFKIRbenP2qwQLiocqqT3bQtyTwr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hk0E+0ITYzhjT3OEyd0JjvLiQQoQg4ILuSSjvIgngSrcantjc/xsV0gnaEwklJ+Pz
	 HzWWTqDAjb86tgf/YheuRnUTXWqAsdH5ur+l/JhVvNGuFWk4r/SLu3yZbOr8PPOc/U
	 UFG9MDdvAJvjRQKXgRGSijEbzNA2McWxHvo0FGnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfDVUkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbfDVUkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:40:06 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D02720859;
        Mon, 22 Apr 2019 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555965606;
        bh=+E6AcO99oC+EPSmFKIRbenP2qwQLiocqqT3bQtyTwr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/qeJ2WhMuKfjFuMn72/CuVRgkk5zWvxGy2KgWNW5vDevEls7cKT4GDyja0ZQiuTy
         VnTzfO1CqcTyjDNQc7X5/WWmv2sRDlfJmtnPf1uSZsuRAe6RSjzymjb897LhkqyCi3
         Oo/nJaajvrwnwxQuG7nPQq4V2Q9wU2KTEqzGQ8E8=
Date:   Mon, 22 Apr 2019 22:40:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>
Subject: Re: [PATCH AUTOSEL 5.0 70/98] tty: fix NULL pointer issue when
 tty_port ops is not set
Message-ID: <20190422204002.GA5474@kroah.com>
References: <20190422194205.10404-1-sashal@kernel.org>
 <20190422194205.10404-70-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422194205.10404-70-sashal@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 03:41:37PM -0400, Sasha Levin wrote:
> From: Fabien Dessenne <fabien.dessenne@st.com>
> 
> [ Upstream commit f4e68d58cf2b20a581759bbc7228052534652673 ]
> 
> Unlike 'client_ops' which is initialized to 'default_client_ops', the
> port operations 'ops' may be left to NULL.
> Check the 'ops' value before checking the 'ops->x' value.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
> ---
>  drivers/tty/tty_port.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Nope, I have a revert for this in my tree for 5.2-rc1, no need for this
in any stable tree, it doesn't do anything :)

Please drop it from all branches, thanks.

greg k-h
