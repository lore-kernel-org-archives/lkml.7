Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CD3C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787E62464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575569932;
	bh=XfyVu1p8a5TrrVmz7rJkW2JFHYqk3kxOgBs7bIJRUCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X5cl+8uKvMSll0ugFMxDPnAm7m+/XrXNEgdlNljfVNKlOGI7bYUOvWGJ/wEkwaoGJ
	 7787+84O74NRiKA+Pyvjl08pm0RX/iOUMlqongRolgiqEKhVB6kh4c7VqlPklY8qlk
	 qXQBzr/OpfkPahF6sdJ9EINIZRGt6Hv+IZDlGQ6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfLESSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:18:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44199 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:18:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so3602766oia.11;
        Thu, 05 Dec 2019 10:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g1S0bB1B3s1eiBmGGOq4Zd2xB9ghrSQ0W48kBREdYO8=;
        b=RigG6yHU54pQFmyZQUdTQJZpPKuMeXnw/d/Qx3cMC8ti6DCup2403nzbAK/aOwgwK5
         VmvXXvW9DI8pefTssBXEjUY5e0c0haMgNuv/7dTJZlKDll9FGMnR/Gdkg19/ACyiOnmV
         UleZjE/Vdez7GxUtKvQA+Rh0hBWYe1bf0eoEWGkmiBLd3+vg+PCQg02uaR8KNi2uk2la
         kDdiYlIOLgbkVEiMUndm4z5ov2sgQmdjy+HeptM3SMDYXGLAvDyqKycgQ41DkNYb11Xz
         Mjs2q9v3mM4sJMi5DkjXT+B344nL17hhncrWAM6vwjnud6so6ytz13Fb9oaSwwvpRD/5
         TcNA==
X-Gm-Message-State: APjAAAWTxLGNvzjiX1PJNpL0V1dDN71VcKMuK19stiUAg/l+UEtDzlyD
        Cdrqbf9DidX0x5U2J9iRuw==
X-Google-Smtp-Source: APXvYqzCu+5P6svNk0Z7nvquQqpKEJ1EkYhRWPedOycu5KVB8CbYQCvP6n9kDHJ9yA3cvmpJvOwJrA==
X-Received: by 2002:aca:aacf:: with SMTP id t198mr8671653oie.135.1575569930363;
        Thu, 05 Dec 2019 10:18:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w123sm3752138oiw.47.2019.12.05.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 10:18:49 -0800 (PST)
Date:   Thu, 5 Dec 2019 12:18:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mxsfb: Add compatible for iMX8MQ
Message-ID: <20191205181849.GA6827@bogus>
References: <cover.1574693313.git.agx@sigxcpu.org>
 <1e452d74454d550ec4134428994ad8559aaa587e.1574693313.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e452d74454d550ec4134428994ad8559aaa587e.1574693313.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 15:50:06 +0100, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> NXP's iMX8MQ has an LCDIF as well.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
