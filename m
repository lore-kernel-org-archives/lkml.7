Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA82BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B61A206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4M+viem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfG3IBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:01:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36955 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfG3IBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:01:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so18890503pgd.4;
        Tue, 30 Jul 2019 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qb+k+IflEc/XKNcEL8wcO85r4kdnoHed1qavVtD26A4=;
        b=T4M+viemc2mgjfoNgtBEbNrHi4++XWQ1uuVWtDnxMAEaopanQDFqANVTDntykuRyXa
         9pZUS5u1W7nk6GgXn3SPzeeZFaWUO85khfULWHtP3yWfiLB8wybXW+0u4iiLBaJMoIMM
         SOfbUcjwoVIhXdd0okwNsq9zD6/9P5P5di1gGcRXBpKCWvIq43/WcA8idHuP5g0x2CxI
         e7Hc/Nyfg4nexZ1FF3Y+ojiLY2luk9hegwrPLtoRUuWqyc++n8JjWycagPdu1B4qxXVW
         6K4zagiDF/4BJ9ldNK1SXzKBB5df8FyWejHkCAsxEJhfuKT4y7iRzHF7EWTs8AyEoVW+
         OOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qb+k+IflEc/XKNcEL8wcO85r4kdnoHed1qavVtD26A4=;
        b=aCejX5ZmQyf2re7pOzURneEAqCE28UGxYhW7YQR0gOA7dPPsze5hsxHKIohEDch56j
         ElUSbus/GN0OGTm6DrEEf/XRESZETdv51gmdIA7t9n+lrU1chlhxsWUE0zKWeymnZ0Pl
         texdFAoVt9lRUser14vpiJUDeJtMU4lbMv9RZrwFbL4kf+kM8DTPRXlalfEbYiN7Itj4
         CDulklwkxgJtXemS2+RmU31mroH8tasj/zQ6WZjedMnfEsITkCQ5NK+f3if1F/5t49lq
         iqHV9Ukz0No2xQEhh3BJaqUYGyuGPP9Raf0FZmD6cz/moBYpH6Udh4OJGMYgF6ulpn4f
         TkMg==
X-Gm-Message-State: APjAAAW0mQURZZFBfKewXpU0dDxvG4Xkc4ibNCnjrBk9hrwitfGQ1tFq
        VUmN7stagEc2A0iGYOxQSRs=
X-Google-Smtp-Source: APXvYqzaK5prno8UGLcxc2Eoqgvtduo5CAG6Z3vyHnKkjPt+3dikjtKC/5TlXGUB1Mx5Ga6cXlzL5A==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr117813485pjt.29.1564473703136;
        Tue, 30 Jul 2019 01:01:43 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id u7sm56293369pfm.96.2019.07.30.01.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 01:01:42 -0700 (PDT)
Date:   Tue, 30 Jul 2019 01:01:36 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, viorel.suman@nxp.com,
        timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca,
        tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: Introduce compatible strings
 for 7ULP and 8MQ
Message-ID: <20190730080135.GB5892@Asurada>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-8-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-8-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:24:29PM +0300, Daniel Baluta wrote:
> For i.MX7ULP and i.MX8MQ register map is changed. Add two new compatbile
> strings to differentiate this.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2b38036a4883..b008e9cfedc1 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -8,7 +8,8 @@ codec/DSP interfaces.
>  Required properties:
>  
>    - compatible		: Compatible list, contains "fsl,vf610-sai",
> -			  "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
> +			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
> +			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai".

A nit, could have that 'or' :)

>  
>    - reg			: Offset and length of the register set for the device.
>  
> -- 
> 2.17.1
> 
