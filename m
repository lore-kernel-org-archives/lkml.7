Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16028C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E252C206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ldVoOTRc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8LAQXuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKUQmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:42:44 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33849 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbfKUQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:42:43 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 89500224AC;
        Thu, 21 Nov 2019 11:42:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Nov 2019 11:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=zrVwxdFX3/ZNrNFnru4HMvi21Hw
        FhrUN+tgF4NYvm+I=; b=ldVoOTRcvpZzw2MzugDxCmWgfxhQrIEKhcHdjBJAHVr
        fn1dn+RtMopJVqiQcNW5Ruv8pOLILuT8D9Gbq5Y04W7NzDj48NKBgqBR4ym6uJJV
        MyeUGqVvbVfb4xZ7pM1SujEO94Hav9k39QCncAk6Wf7qs7fnpcslYCCTdfbODSdh
        iTKdCsRy96ApepngZkaJn9P+N0zj1oHMhOx7+pqc1coGgpbtxVT25nvFvWITEtn4
        MUjsScsenn64irKMg57kYHxdQopNS5qJ2VC1CCFUtLr5rklRSSCclJmX6Wq89Ddp
        8rhXAV16BDeNjAWgml49KtRJg8XKoIYy3zKUe0c+vDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zrVwxd
        FX3/ZNrNFnru4HMvi21HwFhrUN+tgF4NYvm+I=; b=j8LAQXufgvyDNkV59H5Uoz
        q3tuRqZQ4h0HO/uafOsah0WmyV2k0vRa5s10nJ2hbpsbpDa6pK+wHzGxo1SuZUMf
        OV30pgh6YkaQNGQK4rFCXfzwS6JahE7rvtXWZORG+y1KGCJhJQ6HyrxSxJcRPKrX
        E2eqCEabQi/DWJoxQduO//iCqAlQVTQmaHZmEX5ZNT3kJy5UQ2CH4KtP1YBbZVSb
        qp3zdZZCv6Q/5/2DXptbNNc49vN1u5o3Go+/B9QAqVD2pRq0AmI3G+2uMjlSoQlQ
        3GHCMBoFiJNQbiM51bMPDtsqAEAB7r+SQDXhRV4FLyycQc3XfMtplYVSUzLeGWUg
        ==
X-ME-Sender: <xms:gr7WXeI_2O5T-5FtKbDmbv4BxNztZ9v0_aiM6NzHeRf-aieLKAK9rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucfkphepvddujedrieekrdegledrjedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gr7WXasK0vP2vyLRO2meXYCFhWm1pYZ9stvYQYOxt6tyDjWfZ9CSoA>
    <xmx:gr7WXUKwWMUeWsqHbyziYUyQNfp5kFHSYXSDKtlHmDk66Fxz5GNFKw>
    <xmx:gr7WXWDA5NAb--dfHtk33gCKyLFaRhwizGlmLcM_Z53OoP5TFUC-wA>
    <xmx:gr7WXZqIqRk5givgOqJL-BC3juABe6Tma1eJ4cLh4pCVRUh3iuWH-g>
Received: from localhost (unknown [217.68.49.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id A55DE8005B;
        Thu, 21 Nov 2019 11:42:41 -0500 (EST)
Date:   Thu, 21 Nov 2019 17:42:39 +0100
From:   Greg KH <greg@kroah.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] drivers: usb: Kconfig: cleanup indentions
Message-ID: <20191121164239.GE651886@kroah.com>
References: <20191121151408.22401-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121151408.22401-1-info@metux.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 04:14:08PM +0100, Enrico Weigelt, metux IT consult wrote:
> Make the code look a little bit nicer.

That is really vague.

What exactly are you doing here, and why?

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/usb/dwc3/Kconfig | 30 +++++++++++++++---------------
>  drivers/usb/misc/Kconfig | 24 ++++++++++++------------
>  2 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 556a876c7896..7695841a108f 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -97,24 +97,24 @@ config USB_DWC3_KEYSTONE
>  	  Say 'Y' or 'M' here if you have one such device
>  
>  config USB_DWC3_MESON_G12A
> -       tristate "Amlogic Meson G12A Platforms"
> -       depends on OF && COMMON_CLK
> -       depends on ARCH_MESON || COMPILE_TEST
> -       default USB_DWC3
> -       select USB_ROLE_SWITCH
> +	tristate "Amlogic Meson G12A Platforms"
> +	depends on OF && COMMON_CLK
> +	depends on ARCH_MESON || COMPILE_TEST
> +	default USB_DWC3
> +	select USB_ROLE_SWITCH
>  	select REGMAP_MMIO

I think this change is already in my tree, right?  Please don't
duplicate work that others already did.

thanks,

greg k-h
