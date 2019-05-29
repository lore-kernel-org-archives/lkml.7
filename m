Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FF7C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC97E242F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBLUDOMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfE2XFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:05:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33379 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2XFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:05:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so1706910plq.0;
        Wed, 29 May 2019 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sn7SzLVePT74hYMrzOggoTTgR0I4/4qPqO4K8HBko7Q=;
        b=LBLUDOMQ6xSIKd5t0CVXmKnt1n9IcYRe4f2iENYgZQTG82Zhf4MtWusceLH4KdlVCU
         siTOUmbaiAUi8F5kfspioZsp/hePgBrFqNX9d8KYRaIGnXbewet8GyZtEdkxPcanuwKH
         /0HJG6Q1gu97wPgB2Be8xBr4st7zRMNkP7NYVeYbgpGoVcXPDDTEHtyC7cDP1dqugmYe
         XZqoviY0Sjj6yf9KcbvE0Vi8JRZOn3jFURIpel56Y6TPgry08kMQyWD4oGtAP9KidjP2
         e3D/ug4SyEtf9hoNn9MrY7JQV650Nl983cftcQb36SHpNKiPDpFEV37aVTEVs365rXpN
         3Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sn7SzLVePT74hYMrzOggoTTgR0I4/4qPqO4K8HBko7Q=;
        b=bh2pyS6TXhrQBs3g+rO7vzz9WMwsr5d1Z9qH0HVEWt4KMtbzUxJ6z1lpEYFicGx24r
         HWzEH+h+H7kWX1R0gorF4ZXwo6+4AqClZav6sJ8eAJiu+osZCQiVZJ+w6eV6JzobtN0X
         hj3Tcc9ZvGDDiWBNIDugOUNSZ4cbKGTiDrngPwT45Qh52dJ2AgAF2xc9mTmlxXvxn6/U
         l552r6dlp0ZuneRbvD+wJu1jVZGA+jTrjBp80UiCvQSqxFDZIIpO2hFysUC1mXMcUQTi
         QeQid3bVWaQ1Qr8vQL+ONprA3QRZ6YX78NtmY0YOx4c2iIGfdxpU4HmooIdTemIquxOL
         dkbQ==
X-Gm-Message-State: APjAAAV6dA0VrlOZiP2n5XxOZMnjgaOVw8V6rAN223fZVyAEeHmMBKDg
        iObnmy90qAIz7SxaX80vyoQ=
X-Google-Smtp-Source: APXvYqycvHn89zXHAwNBj7eZzs5T844h1v9oUP4/ximCLwqfgyxhCd66AUf4/IEmieDgzjtiZALRcg==
X-Received: by 2002:a17:902:2907:: with SMTP id g7mr513993plb.114.1559171107812;
        Wed, 29 May 2019 16:05:07 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id t24sm813254pfq.63.2019.05.29.16.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 16:05:07 -0700 (PDT)
Date:   Wed, 29 May 2019 16:03:57 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 0/3] Add mclk0 clock source for SAI
Message-ID: <20190529230357.GB17556@Asurada-Nvidia.nvidia.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528132034.3908-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 01:20:46PM +0000, Daniel Baluta wrote:

> 1) SAI clock source select MUX is really part of the hardware
> 2) flexibility! We let DT tell us which is the option for MUX
> option 0.

I think the "MUX" is plausible comparing to your previous version.
As long as DT maintainers ack the DT binding doc, I would be okay
to ack too. Just one comments at the dts/dtsi changes, I know the
driver would just warn old DTs, but it does change the behavior at
the mclk_clk[0] from previously bus_clk to NULL after this series.
