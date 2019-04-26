Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F57C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AABA2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556311167;
	bh=Xs/52Qt7X24+K4Kgu2+wbsP9hbdLw1ME2Zf3vLSZCaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O6DU1vCCGBjNaaBhjmKAu1lz75lY+d3/wttFTeJ9eplTTsiIPPmR6Q52qF+6w1Rd8
	 wkXkjKpMSEtiN8cICK6iR29p51I8iAK6tTPj0+Ka3Pgp0sFkqqLYcHculBiKKxvqr8
	 icpHuGbbsEG84qYfgSJgJkqT54xBAu+RLJj0PK0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfDZUj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:39:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41735 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZUjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:39:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id g8so2763873otl.8;
        Fri, 26 Apr 2019 13:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9hvmLAEdxHGOEN44vIYoChsiy8LN6ra/6LYCmnGb93I=;
        b=HeX9DhnzzU+GGaM7RSadULF26JSX0UaalDApzJ2RFizvrVjR/u0e7It0vNNUeQbBTK
         w+3aEmBS2QE2/Xe2FYbp+2BTv3+Y+ZEdL4yL9YvUbgkp/9ygkArdxMAOL6yCtg+Uv9XI
         CjSDaBCHtqo5gr9mpzM6UpjMMrBnNzGHpSsqNyo+6lmHn82YRwlGcF2epLEdsxPLV1GG
         Tvf97BSSUkP62X8kHmQnlgv5dTv1isPxAZFPtNEx+a2RxbQUPi8J31ZiFO38AoT4OeOE
         SAEp2uZ5Dt63B3eEe7DCJnLbmC5wHzBx1+KL2ai9NJBgRqajAdpA5FvEJH8T/JR/YeJH
         gnxQ==
X-Gm-Message-State: APjAAAWWn2mwCW3XOfAb2taLg09HOWzpFv/raLI36sKeFpWHGXbG1kFm
        Bg5oCtEmcmKL7z+VJR3kvw==
X-Google-Smtp-Source: APXvYqw0vboSJQN2kK8Pf65R1nAsHkP4niUucEsd1jYxzSUjyPq4Q3fVLOVc3Y25a5e97VHmddZR5A==
X-Received: by 2002:a9d:73d2:: with SMTP id m18mr12084972otk.204.1556311164581;
        Fri, 26 Apr 2019 13:39:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h26sm10491595oih.22.2019.04.26.13.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:39:23 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:39:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add doc for the Ingenic JZ47xx LCD
 controller driver
Message-ID: <20190426203922.GA14919@bogus>
References: <20190426005308.27039-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426005308.27039-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 02:53:07 +0200, Paul Cercueil wrote:
> Add documentation for the devicetree bindings of the LCD controller present in
> the JZ47xx family of SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Notes:
>     v2: Remove ingenic,panel property.
>     
>     v3: - Rename compatible strings from ingenic,jz47XX-drm to ingenic,jz47XX-lcd
>         - The ingenic,lcd-mode property is now read from the panel node instead
>     	  of from the driver node
>     
>     v4: Remove ingenic,lcd-mode property completely.
> 
>  .../bindings/display/ingenic,lcd.txt          | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,lcd.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
