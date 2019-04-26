Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A230C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD7D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556318985;
	bh=KuP4KMaOpM+mWz7Mq9nfuvBq0n6yXYhuBA79LChbKsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Om+rOFv8RUbxwoWAyXevhVW+Pjc5t6VJoUCt8Ela8+9RIl2T1k7x7/6MrmWtUfUsE
	 uZm85vbc6zxOpinLXt0HwVpV0U/F9I8XgvdZoK7gD+waHfC3e41YwqwUZySWP1INvI
	 YPj5nn+H8h9d/RpURB0VIABD6jPRg0Gels8fcnZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDZWto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:49:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37439 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZWtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:49:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id k6so4215493oic.4;
        Fri, 26 Apr 2019 15:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kN+VciKgZd6jcxQb4UY3f5HrIMHWadQkiOAB3ugqPf8=;
        b=fyaQMhEEE1Fy6cHO8pUGAZyZJ1b+jrJcdejUNOBKOjGNEOuhGvTgws6Qs6xLorkfNa
         cGx6jyapB8IZeIJnL8oH+BlJ7HIWr7USm8G7ubrrgW8OmdIh4erF6bMBXiTWxIcQvdgY
         Bedlx2FyVD5vMzcsSxJgVqLgjlco8I9wFrHW0yydSH8lDG63pZ39IsG5sDx3ZjX6XvPS
         0pextWC3rHOg4MirN2ygzyTp2E0YWXglP9BdmersjWclUBuv+jhPSjbNyejpqKsi/c4L
         cRQFA1sH5xO7fV0Vd3DScaRvbclIL8uPraMxJqpcNFa92F2EOOGe02lhfVknhfB9iCHX
         R40w==
X-Gm-Message-State: APjAAAUrl4kmvh5sexYsVHoSAhzWpc6KNQcQdSbA4COEh3Iyurd42Xam
        nwkuGDhhgd6j5G3NxEgpSw==
X-Google-Smtp-Source: APXvYqyR2gdrPPCjZwkgEy9aa4OtfVlOhM2lFz/CC8cStAQgMxfgUEUjKHviBX9jgk5i+31p758EUw==
X-Received: by 2002:aca:3e05:: with SMTP id l5mr8018709oia.22.1556318982975;
        Fri, 26 Apr 2019 15:49:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i136sm4599760oib.42.2019.04.26.15.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 15:49:42 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:49:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [v3 1/3] dt-bindings: display: mediatek: update dpi  supported
 chips
Message-ID: <20190426224941.GA12234@bogus>
References: <20190416055242.75764-1-jitao.shi@mediatek.com>
 <20190416055242.75764-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416055242.75764-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 13:52:40 +0800, Jitao Shi wrote:
> Add decriptions about supported chips, including MT2701 & MT8173 &
> mt8183
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt        | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
