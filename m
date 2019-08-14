Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDFFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FDF208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hgI799Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHNLDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:03:52 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35746 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfHNLDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:03:52 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EBDEE5C004F;
        Wed, 14 Aug 2019 13:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1565780629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+qnFbGtGsBoI06RuDeq2XvqPu5SKHuKdbyype/t5fw=;
        b=hgI799WtcMNEQuwaU/xBtLvzbOMKG140rFlj52Xnp+/uaD37LtZnWXYmQKB7r5qoPGW/6g
        HrlgwxigfioiacwLCzd02Rrd0wj63zXrEkWSGNsOYESfloYMujDsb0DJ0NH8HoOdRT0Auf
        YWjsYI2r6L8mvxJw/Auzh7E4/S4RHvo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Aug 2019 13:03:49 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Robert Chiras <robert.chiras@nxp.com>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/15] dt-bindings: display: Add max-res property for
 mxsfb
In-Reply-To: <1565779731-1300-10-git-send-email-robert.chiras@nxp.com>
References: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com>
 <1565779731-1300-10-git-send-email-robert.chiras@nxp.com>
Message-ID: <491aff3d08f24ab4d79a4f8c139d2e44@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-14 12:48, Robert Chiras wrote:
> Add new optional property 'max-res', to limit the maximum supported
> resolution by the MXSFB_DRM driver.

I would also mention the reason why we need this.

I guess this needs a vendor prefix as well (fsl,max-res). I also would
like to have the ack of the device tree folks here.

--
Stefan

> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt
> b/Documentation/devicetree/bindings/display/mxsfb.txt
> index 472e1ea..55e22ed 100644
> --- a/Documentation/devicetree/bindings/display/mxsfb.txt
> +++ b/Documentation/devicetree/bindings/display/mxsfb.txt
> @@ -17,6 +17,12 @@ Required properties:
>  Required sub-nodes:
>    - port: The connection to an encoder chip.
>  
> +Optional properties:
> +- max-res:	an array with a maximum of two integers, representing the
> +		maximum supported resolution, in the form of
> +		<maxX>, <maxY>; if one of the item is <0>, the default
> +		driver-defined maximum resolution for that axis is used
> +
>  Example:
>  
>  	lcdif1: display-controller@2220000 {
