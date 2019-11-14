Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC63DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F49206E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573696346;
	bh=pSlPHDCRNkgrHftVLeaBUR+UOd1Ega7DA1FW93ySRhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tq9DV24i1ZPGW8ckLT0X6UIm1zwD+9R/BbVMwhzaF6YZHFy9xa59f/XdcibUkDgWn
	 JJu2RBJAmch0J8ypwK6YW962LJ675/sSwHUt+/cRucXUAwsfnSMcinOFW7uuiz54uL
	 QmNj5zj21r6b55UIqQpVte6zaVw/siaAAHjJTAVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKNBwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 20:52:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44461 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNBwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:52:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id s71so3753658oih.11;
        Wed, 13 Nov 2019 17:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzR6nG67pn8IlqJFDhdjYxot9QbuFGZP+Pet1HLMx08=;
        b=idsT+EhLW8oG+MyMYmfYDGPkRRl8z2UxhzyjW3oE74cfiiv0zt1l11qm9+hRzUom8e
         tpq89GYBCyW7tJiByUBlol0oXDaXCwFzF7kUK4pXlc0CmPxYWR+kvts7svgrm6EBRPCI
         4HibmGhWFk37Y5SXrvm3LVOykHO9N+bMpyIQFruhN87vw+IwaBobCom9fZJ+Qe+9BN2F
         JBJkeDGlHjge0hySrjKz32+5IWiSNzGNI7S+d8GKY69uURwpC3bWEPZz5C39rzOja9Y1
         Eh1XXOKEAf61M1vyVkqhhoOg8ntxQ2/kkE0DoA32qv+Da7ouEdvB7IqZxjsqiqfEEnBm
         aQKg==
X-Gm-Message-State: APjAAAXDOqXUkNKLK9uP71s184MFZcn8mUzYYDOMBtj4GDnRJ/ofcWdY
        cqP3ImQecHsInfx2qVdEXQ==
X-Google-Smtp-Source: APXvYqy1LyXkt7WGiuHxADhPr836dQgZX6Iact41M6WrKpL8aIdlSK3MOwv9B1/LdhtB661imE7fmQ==
X-Received: by 2002:a05:6808:103:: with SMTP id b3mr1326000oie.38.1573696343304;
        Wed, 13 Nov 2019 17:52:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e93sm1380668otb.60.2019.11.13.17.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 17:52:22 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:52:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Cc:     dri-devel@lists.freedesktop.org, a.hajda@samsung.com,
        hjc@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, philippe.cornu@st.com,
        yannick.fertre@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: display: rockchip-dsi: add px30
 compatible
Message-ID: <20191114015222.GA22800@bogus>
References: <20191108000253.8560-1-heiko.stuebner@theobroma-systems.com>
 <20191108000253.8560-5-heiko.stuebner@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108000253.8560-5-heiko.stuebner@theobroma-systems.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 01:02:52 +0100, Heiko Stuebner wrote:
> The px30 SoC also uses a dw-mipi-dsi controller, so add the
> compatible value for it.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  .../bindings/display/rockchip/dw_mipi_dsi_rockchip.txt      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
