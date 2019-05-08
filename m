Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005C9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA0220578
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+Ul5cwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfEHKwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:52:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38906 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfEHKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:52:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so2653783wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DoWEPa4D0OSvUEE47Yf9/XCh/YlhwJezOh6SvUkD/So=;
        b=u+Ul5cwr0LHrvRJAV8/UQGYNtmubpCurdF0qaFRziyaHRzUGD6Y/L0UlfSkj+vxy+j
         zn7dF41uHi61sPTf/01CP49pUeP9CcJHr8S1mnHGmwaG8+7akA4E9w3K/gldUhi9e0sz
         eY3qKDrJrnI3XCep2e5GdaRz9C/G2WGz4nOpsSuzt+24jxj59yNLVrfE6Ag8+mhkKfu0
         E4HNTqt7IbqI5Cj0E/OxZMxQnfdDxco7L3KvEoxZJX/NmOXFc4yk+rthsRpw50DmiFwK
         LXCiOrlPrOvofI70WPvNgOOgZX7p5IUEYA3aeTsVUayLC9XFFEkp1hPrdMG8yYthKRdV
         Gg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DoWEPa4D0OSvUEE47Yf9/XCh/YlhwJezOh6SvUkD/So=;
        b=lPF75f9wCETXQ8z4scmGVQq/A+GlXLV+sPdGia5bxydKEG8Vgff8rVQPlvgHxTO2gM
         nNcPogxNXe41s69g1RuciEgmxDFUQOZeGrRrpQxwGQtMLLDdS3fzULGNAVTmKHZgaGis
         vfcAQOTU1chkuLyofwEoxhWPI22wHxeCrI4JBIlZDVrNgNhIS3OAsCFq4JzBumcRgBTW
         B5RwaI6GJifg7HRtFHa7rMDMHp5CqowK0SvF6HsZjI25owwpKZoi1wv6qRglSozKPdXv
         ikmi3ads/B1vViFmwanYX4PhZ2xf60NM2/wGIXHtyhhysUf1vKCDbt4zh8UfNjOYX9ZL
         Df7w==
X-Gm-Message-State: APjAAAUTx0XOBhi0Mbrq8I7EjE+JWcgO1uern9h+r6PB3sj3g9FYduSp
        qACIkLehis+xDyT6/5M+8d3MAQ==
X-Google-Smtp-Source: APXvYqx8cs/kEeM8xskGvtE+5ioqNdy7RohTccspIxj99TLUIQ0478a8fiv4of2TD3GtPVekCIc/ZA==
X-Received: by 2002:a1c:9cd5:: with SMTP id f204mr2473691wme.145.1557312751725;
        Wed, 08 May 2019 03:52:31 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id c139sm2333188wmd.26.2019.05.08.03.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:52:31 -0700 (PDT)
Date:   Wed, 8 May 2019 11:52:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: imx6sx: add MQS register definition for iomuxc gpr
Message-ID: <20190508105229.GO3995@dell>
References: <1556445161-29477-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556445161-29477-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Apr 2019, S.j. Wang wrote:

> Add macros to define masks and bits for imx6sx MQS registers
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
