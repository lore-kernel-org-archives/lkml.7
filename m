Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC5EC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4BF20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578501777;
	bh=ynpqtPeDiLkS3B1XbB+7iA1SxwfKdgld1oNMaDvbztA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Al2qytAVPBaK4FAWTpxNF0Klk6ctZmNMZDsth6WWK6TdLWYZq63jRMVsgwryABrr9
	 VvDflHxClSboLnQEfs6fdjJq66wN4soM9e+cOLU/E0QfY0QJfAmYDPGQWF4rM8xQu5
	 AIV1sdi7HBpyTPHgU61lB7lpKCqcLappwGiGW2f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgAHQm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:42:56 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35630 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgAHQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:42:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so3211936oik.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKDNwGykO2dbNkNckCxJfHqBIvtnDZYUjcmwNmsSzE8=;
        b=B9wyXp8B6Kj0wM/Pxuc6+GerkGuTaVy+pPKwlbs75Fxfk3Rbp4l3Y9s3PIErFz9tJo
         vliU/DJ5Vtx4WILMlsvOZEI3GB+mz/qi+YStxgo4Gq1JuKNqM7uvr6iVYQlIg/JdOS7n
         E4Qdjuwtsfqt7YHxiA+/0MsaqDuq7mVeuQTQFMnPzwmpTO7wSW2UySlxa3popdZB964r
         pE3CzC84AhsXHQ6MYiNCsGHwnVO/1k0Dp/5TkbOIbI19cn9/edyb0kR9P2hE6Cwz6F0f
         n6u2w6oNwnW7GhiCzKPl5iK9T0pCSNNUsdnq9Wo3yqQdZwNAbc05ZXT3zhtDZ7kBAiuh
         oPyQ==
X-Gm-Message-State: APjAAAUk0gjtIdaVuYPUdUoqKmo+lB/FJY2N0m3cVhrCIVbZ26DatFAh
        RzKBuAlRvkjSTqpktS07NLhS9zA=
X-Google-Smtp-Source: APXvYqxE11QLzVyrtPegRwI8ZXTaRdM2SBk/p6R35E2OjRgGtUsquMcVae0SZkCPAIbxXoU7gT/N/w==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr3655602oiz.120.1578501773618;
        Wed, 08 Jan 2020 08:42:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm1217453oic.22.2020.01.08.08.42.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:42:51 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2208fa
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:42:50 -0600
Date:   Wed, 8 Jan 2020 10:42:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        aisheng.dong@nxp.com, l.stach@pengutronix.de, angus@akkea.ca,
        cosmin.stoica@nxp.com, gary.bisson@boundarydevices.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 3/3] dt-bindings: arm: imx: Add the i.MX8MP EVK board
Message-ID: <20200108164250.GA17075@bogus>
References: <1577426385-31273-1-git-send-email-Anson.Huang@nxp.com>
 <1577426385-31273-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577426385-31273-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019 13:59:45 +0800, Anson Huang wrote:
> Add board binding for i.MX8MP EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
