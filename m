Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6737DC46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F7921473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557761192;
	bh=kjha8BKm8yBYsHEO2leNOEO2y7FhJqdeUCtT6WNzuS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ld9sPycoE78gzauGbXFOcjLudJrZbU6RwdP7HIvpLhNtvCziszcRiNo/s4QkhH7Tp
	 W8alLRj5e1xwWw0Zg0z70wvz3WIEOAQT7VR2i4N/AAAHQFSD/ibUbExtqIlH3Scp02
	 3BXbtbHiE5Z9FV4I8mjR69AqOcMv6ohtPXRxqJeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfEMP0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:26:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37182 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfEMP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:26:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id r10so11389222otd.4;
        Mon, 13 May 2019 08:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nIvktfd4Hu4J+EanMaRcVbjL4KHwX8r4JOA04Ck3E04=;
        b=Hkk8Nsb7hKIC2XFypkOJ+NTeBHPRV5M1j4o/SsS/Uld3iYc269r+WzYYPysGv3z/NK
         p5OBnYsklBHyhOrrQ1aJc7CKrESB+Tr0T62P5yDXhAte64UzEc/tbX5dGn8ovE11+ePX
         RQ4ZY8DbopY02xKZ2kztuCQg1MzpWRsADFB5wl4NJEQxDMdpfIDQy+eesS7G5blItYmC
         Q7J/U/DS1YA3thfXpuH40w5s3QE13+Zmc8lxJn35DrW5bKH14O+wJdHsEwi8QOeEWZXM
         VqXlIniAIzn33nyPPCjKvvo0Wki8/JFqbFMahLzaYj1rTHJy5PK0nqhEtdupuoE/LdxN
         Y+tg==
X-Gm-Message-State: APjAAAU0ir/UMiKCXlbfhtsI9Od87PrmbnMyuLdJc6l8FyO/WGaExV7j
        Xi0YdfJ1otR9srHAOYO8Nw==
X-Google-Smtp-Source: APXvYqzOz0IJhiSIHUggaPIhdUeY+8qUhUMxIUjErgTOEdtsFRFR0DWcAUAIS2pzGbes4imV56PH3w==
X-Received: by 2002:a9d:12d7:: with SMTP id g81mr11173627otg.46.1557761190168;
        Mon, 13 May 2019 08:26:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r15sm2003876oie.5.2019.05.13.08.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 08:26:29 -0700 (PDT)
Date:   Mon, 13 May 2019 10:26:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: watchdog: move i.MX system
 controller  watchdog binding to SCU
Message-ID: <20190513152628.GA28757@bogus>
References: <1557192198-19640-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557192198-19640-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 01:28:12 +0000, Anson Huang wrote:
> i.MX system controller watchdog depends on SCU driver to support
> interrupt function, so it needs to be subnode of SCU node in DT,
> binding doc should be moved to fsl,scu.txt as well.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 15 ++++++++++++++
>  .../bindings/watchdog/fsl-imx-sc-wdt.txt           | 24 ----------------------
>  2 files changed, 15 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
