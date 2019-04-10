Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D8EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F78120830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5zH16cO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfDJE3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:29:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43392 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfDJE3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:29:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so560176plp.10;
        Tue, 09 Apr 2019 21:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hg+vFG8Wc2AnyBt417MjCD1cA4puKAPw8Dp8WcpXUwY=;
        b=d5zH16cOgagXTRWao1Drpafdr5F1jPtn68THcAdHmYphnhHH79uNFPAY2NdyJwx5+E
         c1Iu6AMmt3ebhcifAkhbTrUKVs6Y6na26WReQL22HaC5JHKSRy9OaYU3+fsYXMZl9EE3
         AZ+WB9LXKyHpuc5ScrufnXJNq0s2Eq1jJ4V6QtzAW7K7FrS+na0Ab6pT1hqsZiPexr/B
         VyHePZRDiAi2SRZwkGGR4pD2zqtvoKlRcSkfiIY4s4MBc/HAD68MeAcsZxRNO3MBFIsV
         vgsECk6ATQJYKcbbSIxiYwI1OFFeIKVZMZFHwKI8xa1od8EccsKNNwXELaQksrwpkSn5
         rMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hg+vFG8Wc2AnyBt417MjCD1cA4puKAPw8Dp8WcpXUwY=;
        b=k/OFrtAFUBnmFSx/oSH4x9KTGajdY9UBMeuquGCuguCjuMMaVQvt4vVo3g0PmkIDml
         Sv50kitr/XNtcOaiGOBQqt0pgMsbJ5jfJPwPpoPCeSHbszzw5JfO7ps7r1HtnrLcqVK8
         BXdF566R6sbfkHjVM9IN2HNGZgWDsgpeLvsMvZn6zWEOjFzgD9v4Ew2mdC8L+if5Up++
         TVnm+BWkXmsrvleGYNNpf1iyVh89BLFutyE93Ad6YdiLUgk1hvzVuYVdswBwgTPKpZeg
         zO5fUpAbSn5v02D6ZCwgVB6fwmVOy9t4iJot+V12Xpi1O782in2uXUte9vLRiaIsDSHH
         9wAA==
X-Gm-Message-State: APjAAAXvVcHE5gT8J/B/yju1JMN6SkykmN8ckFMtY0eD7KX0Cxfcv8Yr
        gv3Z0R6cLfvgbfJDkFMujZM=
X-Google-Smtp-Source: APXvYqzTIZZiXzM02bx8TqtJKxpOHo+96RkG1lcMyQ+na5eSpfNRZeMjXs0lIfKgMzjDbuFr2Ssmxw==
X-Received: by 2002:a17:902:a583:: with SMTP id az3mr41728742plb.205.1554870550774;
        Tue, 09 Apr 2019 21:29:10 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id y23sm49258200pfn.25.2019.04.09.21.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 21:29:10 -0700 (PDT)
Date:   Tue, 9 Apr 2019 21:29:07 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model" attribute
Message-ID: <20190410042906.GC3032@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> Use "of_device_id.data" to specify the machine driver
> instead of "model" DTS attribute.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)

> +	priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> +						   0);

Would you please send a separate patch to replace "pdev->dev"?
