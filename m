Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92104C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677CA206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559744827;
	bh=xQ+fTzSfXc1FsjIDSZCo7lmhvl4x3PaKsTL5+6fMl8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=McLFQK/1U7aEk8RJCR4FeV2EKqr3phFT7LmQtMuMl31uQfP4FzAVvxAP5Gbdt9F3J
	 Bpm73yzfIIep/+/l1x+upstHCu4VuyUiX3i52vWcc+q2sNHfP36/a7V98UeJCnoxlO
	 +gQ5UPMq77/7aI667HMcEz8l6X9zWpK7LypQ0QyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfFEO1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:27:06 -0400
Received: from casper.infradead.org ([85.118.1.10]:35550 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfFEO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lTJZ7yvx2GJn/5Ucl0IpHbkLAJMz/sLGSpI28ny4Qgc=; b=FHC+epX7Epn/9PMwVZpDGE2gYh
        9bs1PVFxV3ddPcqxWbVbtVC9OvlXVaEiKv7KY+VxKkSrmsSsDkzj5tmUjb8EDKG8oWktusbeahEJ5
        FssgsPLunzGe9XEtRZSi2BN5xyscJyO5DT53Ckr5gmpQA/jNeap7pVsE2s+NGqS3/u+C4Lh2y+5UV
        I5zbYGpJnOYqJuDMjEJ6EQ1Eydk7ocvjOoR4FJzl8d0Cq0E6oi6ptgdgGh+ae2j49nUnzwfKBCYsY
        s5kdPlghAB5sehdD5+zOGJ9trAFcZkO1kaKYvY6mRU10ueKpF2KKukOhKDCj5KAIQ5PTDwdB9p+8S
        H759F1ug==;
Received: from [179.182.172.34] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYWsO-0002Er-6a; Wed, 05 Jun 2019 14:26:52 +0000
Date:   Wed, 5 Jun 2019 11:26:45 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hans Verkuil <hansverk@cisco.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
Subject: Re: [PATCH v4 2/3] media: uapi: Add RGB bus format for the
 GiantPlus GPM940B0 panel
Message-ID: <20190605112645.5b357630@coco.lan>
In-Reply-To: <20190603153511.24384-2-paul@crapouillou.net>
References: <20190603153511.24384-1-paul@crapouillou.net>
        <20190603153511.24384-2-paul@crapouillou.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon,  3 Jun 2019 17:35:10 +0200
Paul Cercueil <paul@crapouillou.net> escreveu:

> The GiantPlus GPM940B0 is a 24-bit TFT panel where the RGB components
> are transferred sequentially on a 8-bit bus.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: New patch
>     
>     v3: No change
>     
>     v4: Add only MEDIA_BUS_FMT_RGB888_3X8, as we don't have to care about
>         endianness

Same comment as on version 3:

You should also patch the documentation text at:

	Documentation/media/uapi/v4l/subdev-formats.rst

In order to describe the new format that will be included.


> 
>  include/uapi/linux/media-bus-format.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
> index 2a6b253cfb05..16c1fa2d89a4 100644
> --- a/include/uapi/linux/media-bus-format.h
> +++ b/include/uapi/linux/media-bus-format.h
> @@ -34,7 +34,7 @@
>  
>  #define MEDIA_BUS_FMT_FIXED			0x0001
>  
> -/* RGB - next is	0x101c */
> +/* RGB - next is	0x101d */
>  #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
> @@ -55,6 +55,7 @@
>  #define MEDIA_BUS_FMT_RGB888_1X24		0x100a
>  #define MEDIA_BUS_FMT_RGB888_2X12_BE		0x100b
>  #define MEDIA_BUS_FMT_RGB888_2X12_LE		0x100c
> +#define MEDIA_BUS_FMT_RGB888_3X8		0x101c
>  #define MEDIA_BUS_FMT_RGB888_1X7X4_SPWG		0x1011
>  #define MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA	0x1012
>  #define MEDIA_BUS_FMT_ARGB8888_1X32		0x100d



Thanks,
Mauro
