Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB932C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7013020672
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="arU+bgeb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aetN80Dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgACJ7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:59:34 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60481 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgACJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:59:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CDD3022076;
        Fri,  3 Jan 2020 04:59:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 03 Jan 2020 04:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=BNgr96S65iOJ9G2yDQbQ1c8xzGK
        igz/QMDidnP3P37E=; b=arU+bgeb2BO8DYXXWCXl7/+4IrzAlARbshkM5Tw2s5+
        6KVXNPwEA++wwmUx2oUOHG0nnGW90WsR/rKlF+nfCGA5zF8g3lXW8kO7HNNPE2hY
        +rROFyj56oXiy+zgdjlIo8EX3+JqGU5PqTkI1zLuKvOTWwOGMfplIW/vzQclCL26
        IDqpEiiRZqx6VciNyErfVmO530HQ8QUAXXyYqn09mLf7tIfHvc8vmsK5NgN4ZxTE
        4mUAW5zVreXganmrFGd6bq0j81zILqaXkYw+oXgE947GcYjQXlSl/vbMPlZiLUPm
        cABA+Ab3NB2ALBzFJCKHroiTG5tVNi2k5wDMfOi0Iiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=BNgr96
        S65iOJ9G2yDQbQ1c8xzGKigz/QMDidnP3P37E=; b=aetN80Dtu7bBjgoeFrCD0H
        zliFRaeoQkJUJSgsu+1EAOI67h6pXLmP86eGoUOeLpE6D5k0NZD5h8TQfI53pV99
        Nihb7JjqLhViqbVI3HGBeEKhdIzwHhSq7TGR3FGs8sEWTviRP0NXn86w02DYu0Vc
        94aiIebNcrm30ItY8mafXh33g41Fqavr0UUVWYWtD6jAU265i5uAWXbboiksrtFc
        tMXQ4st8aA0jPmaSJW17Iacxc7lhnlc0sZeexeAAYuo/WcThtZFWiUCLvEIFv/PM
        /1qdJgh8Vxz8Hkoe8G7OVj3xa7XF4l52X5boB8ykZ+gKHs4UpT+OPNKPZArOoMLg
        ==
X-ME-Sender: <xms:hBAPXl77-qninetVJ-xycYGKY5SIB2kFEEwcd4fkmj9bRu_R0I_P4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegfedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hBAPXlsmHKjnWtRCBdcU0Ag76PvSifWbi1i6fYdtDsYVBqhT0DUFCA>
    <xmx:hBAPXvMfyWWcqwV03SSjASDMNGNJ_pEcin4APwFPN75a9Lz5uiutoA>
    <xmx:hBAPXhocIGUq4-w0kHcTR614Lh2yN30CxsQJ0KnaMDFkmL1wrpfXUw>
    <xmx:hBAPXqnP1aKXli5-_KDbIF-dWbyPAeOgtX_zdd6xw4toLVjPvGV0og>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1D82C3060741;
        Fri,  3 Jan 2020 04:59:32 -0500 (EST)
Date:   Fri, 3 Jan 2020 10:59:30 +0100
From:   Greg KH <greg@kroah.com>
To:     Matthew Hanzelik <mrhanzelik@gmail.com>
Cc:     gregkh@linuxfoundation.com, christian.gromm@microchip.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: most: core: Fix SPDX License Identifier
 style issue
Message-ID: <20200103095930.GA882552@kroah.com>
References: <20191227084155.xpmv2thwrrsij5kx@mandalore.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227084155.xpmv2thwrrsij5kx@mandalore.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 03:41:55AM -0500, Matthew Hanzelik wrote:
> Fixed a style issue with the SPDX License Identifier style.
> 
> Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
> ---
> Changes in v2:
>   - Fix trailing space in patch diff
> 
>  drivers/staging/most/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/most/core.h b/drivers/staging/most/core.h
> index 49859aef98df..1380e7586376 100644
> --- a/drivers/staging/most/core.h
> +++ b/drivers/staging/most/core.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * most.h - API for component and adapter drivers
>   *
> --
> 2.24.1
> 

This does not apply to linux-next, please rebase it if it is still
needed and resend.

thanks,

greg k-h
