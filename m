Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2214C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1F321783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573536984;
	bh=CW4sS9ZPA3e9y0ZdHYZKfrs0TKR4gsGmIeBwQhd1j90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dkeU1dqLmeqSHY0T59shOGUMXSU223iiPzFuFJzJlvHqNAFLgz8avoCTDBWNMagTW
	 mmGWh5P/k4F3QhzcZf2z/3kFr0PuveYmhpvPGfUl5cQkvp+Up0fl7j90cY9/FPqGet
	 ByirLNOwqn5BOHpu4p4bTebKFvrUjoavVI6B83V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKLFgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfKLFgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:36:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492902084F;
        Tue, 12 Nov 2019 05:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573536982;
        bh=CW4sS9ZPA3e9y0ZdHYZKfrs0TKR4gsGmIeBwQhd1j90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wtI1maEd82Pp6yDxs99RQuT5aQA5mTHES/PlrMy6wHbRHwuJIFX98qqnxkPPon1Dv
         5VOv3lteVsN4LPCXlVKTRhUB0etdtWUlQ+Bqvu6Uq3vi/JJYxuzfjphx3P6PltT4I7
         yQwC9Q2b0zcBkMtkizz9cZG4zLyuwZewl36MMDr8=
Date:   Tue, 12 Nov 2019 06:36:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: ep93xx: Avoid soc_device_to_device()
Message-ID: <20191112053619.GA1210104@kroah.com>
References: <20191111223722.2364-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191111223722.2364-1-afaerber@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:37:22PM +0100, Andreas Färber wrote:
> ep93xx_init_soc() uses soc_device_to_device() to return a device
> to ep93xx_init_devices(), where it is passed on to its callers,
> who all ignore the return value. As this helper is deprecated,
> change the return type of ep93xx_init_devices() to void and
> have ep93xx_init_soc() return the soc_device instead.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  arch/arm/mach-ep93xx/core.c     | 12 ++++--------
>  arch/arm/mach-ep93xx/platform.h |  2 +-
>  2 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
