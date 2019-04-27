Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7FDC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F78205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="E2eCgiTv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rRiwhF29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfD0Ggw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:36:52 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51181 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbfD0Ggv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:36:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 152DF7CDB;
        Sat, 27 Apr 2019 02:36:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 27 Apr 2019 02:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DKAjq/gGrlYprf/NV0stO8d1N6u
        LGlAbOoomccpBBdM=; b=E2eCgiTvjiOnkPckMXIUfYmctojTnPJuZlGqH1XdnbR
        wn/CEWyNf6ns8ChtGUXlqtaws1t2oi21G3o1p8NlDAswyf2lE25EqdLJATZQf7o3
        ngNP4jKvyVL5yzTXEmpteGi6z1KF7BksHFayRuYoq93pNEVyGhOmeuk19nUNWERA
        pNkH2Mj5X66aY0HNZM1eU8geNS6Xq2IdOs5eO+CEX29TRKR2ARp3bP22TRvch8z0
        7H3I7IliAD6Lc+ql2fZmerQ+Fu4aYAdn/gM/Z3ULkZ9fXcWOW7zyDjnKA7JzwTaz
        sMzYuuWJO2tpdEB4HsvKOL282Nlb3gkF+sMzROu4wUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DKAjq/
        gGrlYprf/NV0stO8d1N6uLGlAbOoomccpBBdM=; b=rRiwhF29YA0foUJ5Td+ROq
        G7J27nEMxDblwwc7LdbcMNkspsoJluyacsN7U2GruHuDKj9672d9QJIj9J1FNr5P
        xcX1qr7xrq30b6KjATfWZ7qWdl5fSEwZ/g8hTstR3lp44mqq/u//T7pluUCrNxkE
        ZL64k56XGd9jvv0OwOOIl/To0kpz/BsiQislYai4TNIhUAB8TSCamvvSZlWZV/L3
        iRfyEOhFBg04RPT97gOUvsjK70+86OPXEfLbAukg0kvFp2YjKqm8FaVmiwfBPfLc
        v9xA5e28YYFq490n71WazA8Qhx5bjnqWPpVx3IDaj6YwUJuFaPTQ+CWzSnrNpkAA
        ==
X-ME-Sender: <xms:gfjDXDwZsQ_-WUSptZDFndxKkkOwcwY5YHlCEXXNxYTmUbzTcUMuaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheejgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:gfjDXM3jEUlfji_eNDdT-p3gDaFx2hD_apUjmrIS33K9ta_xnNQwhA>
    <xmx:gfjDXMnCzjwEWGrV3KWt5Mi_IcC2fS1qRHhJUb26B4Uh3fUfcRhjVA>
    <xmx:gfjDXD9XVLFAU_iT9AXqKmNNOieybgPpDkm8sK2gZQoyBSgmUQhZOA>
    <xmx:gvjDXC9VVBBX-XLg5kpCG_kkVLIo906x2ssrYAT8wofs_ERg7N3zXA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9FFE310319;
        Sat, 27 Apr 2019 02:36:48 -0400 (EDT)
Date:   Sat, 27 Apr 2019 08:36:46 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Cristiano Borges Cardoso <cristianoborgescardoso@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Bhanusree Pola <bhanusreemahesh@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Jules Irenge <jbi.octave@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the v4l-dvb
 tree
Message-ID: <20190427063646.GE15324@kroah.com>
References: <20190426160658.4929d1ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426160658.4929d1ad@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 04:06:58PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got conflicts in:
> 
>   drivers/staging/media/zoran/Kconfig
>   drivers/staging/media/zoran/videocodec.c
>   drivers/staging/media/zoran/videocodec.h
>   drivers/staging/media/zoran/zoran.h
>   drivers/staging/media/zoran/zoran_card.c
>   drivers/staging/media/zoran/zoran_card.h
>   drivers/staging/media/zoran/zoran_device.c
>   drivers/staging/media/zoran/zoran_device.h
>   drivers/staging/media/zoran/zoran_driver.c
>   drivers/staging/media/zoran/zoran_procfs.c
>   drivers/staging/media/zoran/zoran_procfs.h
>   drivers/staging/media/zoran/zr36016.c
>   drivers/staging/media/zoran/zr36016.h
>   drivers/staging/media/zoran/zr36050.c
>   drivers/staging/media/zoran/zr36050.h
>   drivers/staging/media/zoran/zr36057.h
>   drivers/staging/media/zoran/zr36060.c
>   drivers/staging/media/zoran/zr36060.h
> 
> between commit:
> 
>   8dce4b265a53 ("media: zoran: remove deprecated driver")
> 
> from the v4l-dvb tree and various commits from the staging tree.

Yeah! glad the driver is now gone, sorry for the merge issues.

greg k-h
