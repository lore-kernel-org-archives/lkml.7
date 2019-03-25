Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E75C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3790F20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553542210;
	bh=8LWf69VxGPFVJfE+wvVvjSfwNHcnPBOuBo8RKaHc8lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=afYibU+b37kCx1ixnLRPoissFGktGZ3D+jq6Vwr7QlS8NvZ2P6xd72gsvq9b9VxzI
	 M1KRVkJQJPX6dKeyyR7XscOSeEHzZby0+M1X8XfCmx8FgSKU3esbIsAIhhGD/0xkI4
	 o+nSUDUlNjAqpU4bCWnVRAXBxu2kfSWgRi/zA2kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfCYTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:30:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39678 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfCYTaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:30:08 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so5144316oih.6;
        Mon, 25 Mar 2019 12:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZY2eg4/4XIiB14rL+iCO/iZZDg7Am/+m25Q6A/UFf70=;
        b=qGVUCaujThvOo8NnISIemn/2lErVPo2WP3UR8UTl4BBox03oTUCO4LB8BAIdToRpfL
         DCAr8bOMbq0TtCkN68zOrz9tDwvWG6Q3f3D9ohI5H3xIQBfcQj6WwuIZNEMwCT+SSKAz
         ZmmxwLT2Iw2230aJAFA6UC0bRF42yGWVP2bNjZyaYO4Cx3iQyu+OSrvButr8XkfAQTI/
         Soy9IeMJwalVIbCSBV+ajOTcCaUDojCZS0OsYhKZVuwOIa8bCXinPeaXDyeAevkENm4F
         Pezi/DWtJJnw5RQ5wgtqvEtpjq2PYwUQPFV76rMBIZcEOVD2w0mlXrH63DkFDMPh/MlH
         MSWg==
X-Gm-Message-State: APjAAAVCuxvoC5sL2HNFKI6+z1fxIP8Ghk0IfSCZbK9BNJ1X+PIAwfLG
        yHdhHqg0BAEN7i2wAeMuFA==
X-Google-Smtp-Source: APXvYqzx+hvjUephMmngHDzZS47Ab3tENvyvPRGzV+BUSpVGCXYSkagCJCjNWjOyoeGFAwR964faBQ==
X-Received: by 2002:aca:382:: with SMTP id 124mr12947109oid.22.1553542207271;
        Mon, 25 Mar 2019 12:30:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k23sm7221427otr.6.2019.03.25.12.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 12:30:06 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:30:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     linus.walleij@linaro.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, sean.wang@kernel.org,
        srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        eddie.huang@mediatek.com, chuanjia.liu@mediatek.com,
        biao.huang@mediatek.com, hongzhou.yang@mediatek.com,
        erin.lo@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: mt8183: add pintcrl file
Message-ID: <20190325193005.GA18114@bogus>
References: <20190325122302.5483-1-zhiyong.tao@mediatek.com>
 <20190325122302.5483-3-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325122302.5483-3-zhiyong.tao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 08:23:00PM +0800, Zhiyong Tao wrote:
> This patch adds pinctrl file for mt8183.

Still has a typo in the subject.

> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h | 1120 +++++++++++++++++++++++++
>  1 file changed, 1120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h

Add acks/reviewed-bys when posting new versions. This should also be 
called v8 even though a different person sent it.

Rob

