Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC88C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C7620717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576532449;
	bh=ruUT+VAe97HdLME9lXqEj3uZFWN+Ifd7Sth1BEzZspI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ulu2OMD5kyV71Wl8ogW1BlnI8nPRGdAd2w25uq1xexvF9XxRWsdQL8GA4WI1n3WoV
	 5WK5LQQPGcGVjDsqPvKFVHUYZVO8BwSmLimX9WvtjsFV5ADCeSMB7tIU25RV4xwBXm
	 hLCjm6u8GoVOLO2p2b+2mTtijFHG7SWI0RjSQ+/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfLPVks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:40:48 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33293 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPVkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:40:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so2294333otp.0;
        Mon, 16 Dec 2019 13:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/B4Ufn2vEQWN8qDF+PdKshh4CtUrJHulKoVBKykf+I=;
        b=Zz2eHCOpOrwmvLx8SlHSB/N0MYMpPJ1LTgvO5RAE2hN/QNmBS8txJ7qgnDc08N6iSE
         PiK5GZxaCwLpdtf5+d92Q4OVcC0Wpb3E1Lro4xKrft4fl8b4dVVDPCd3i+bV1lnKY4bx
         OkMDdBAc8ICAHIHL7Kzjc42w//0l7l3xqnu4Fg4H/vL0kNIqBnGPW8PDs1Nubyh4xalz
         OLIgweCj86tSSdWlUINeNQumluc+lzWpGFufmQZj296JQTA3t2LV1RGHdRVNdym9ckbx
         2lvg9QWAc9e6J2s76h5QHP15tuze7C7TnZhTcQbybojK+eB9SJ+/RnmustsG6lInX4x7
         rTrw==
X-Gm-Message-State: APjAAAXFzkMnJXyE0DBzxaF8oCaHx8jW6wnoYV6riS8eBaBOpMb1Pr3T
        0lKDND0EVctK7EI5IqEmmA==
X-Google-Smtp-Source: APXvYqxx/YyPyFV09xDlJezz/+Zd9ug5RlT5+zsybfzBCYv9hYcK/r6VQMlyDfmf4Beo5bdrVmC4+A==
X-Received: by 2002:a9d:7c97:: with SMTP id q23mr17133632otn.253.1576532446957;
        Mon, 16 Dec 2019 13:40:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i25sm97492otc.67.2019.12.16.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:40:46 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:40:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] ASoC: dt-bindings: fsl_asrc: add compatible
 string for imx8qm & imx8qxp
Message-ID: <20191216214045.GA6988@bogus>
References: <b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Dec 2019 20:00:18 +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx8qm-asrc" for imx8qm platform,
> "fsl,imx8qxp-asrc" for imx8qxp platform.
> 
> There are two asrc modules in imx8qm & imx8qxp, the clock mapping is
> different for each other, so add new property "fsl,asrc-clk-map"
> to distinguish them.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2
> -none
> 
> changes in v3
> -use only one compatible string "fsl,imx8qm-asrc",
> -add new property "fsl,asrc-clk-map".
> 
> changes in v4
> -add "fsl,imx8qxp-asrc"
> 
> changes in v5
> -refine the comments for compatible
> 
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
