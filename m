Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A33C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8435A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552416260;
	bh=IiIgLoKSOWmhD5xEHS9Zg9+ZxLKlqe2LfRfIvC2fByU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJx/yCszqiNplnZkPuRuLm482xFZUIj26on2dw2nUmUWF4nkqYhj1VLZ3MvtWEBmE
	 jOeWIPzwJV2a7lJB1OUBtve3dvOUZLOcCkowELcQa8Tmi62LKtdf7PWzQ/fGwL/mCe
	 cPvFBQEehCmFLYK1SmFzK0fsaarJOsSEJc8MxON0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCLSoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:44:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39212 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCLSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:44:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id e15so3459996otk.6;
        Tue, 12 Mar 2019 11:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ByQBUWEUPbsU3JaJKsKeod9CjS46G8BMLQfd27THgLc=;
        b=davlmrTYZfCNeQ0gqnWkWHXsR34h0K6wDY34N06vE4/3Ko4rzWHCET++FNzkJAjmfz
         lI/XrPUlVlFXdonl18sUf69nvoWM82ct3lhYE4AUPh4AvVWTceG4o2DIh9eFWXfUpZde
         TJvn7xh/fpwPPvlsYiqfU8aC8G83OsC/Mf7J9gqMV8DF/ad1w7AZSBTslS2YOJlmMS3/
         l3Aa3ZFrTwkPZrK6bZ0Z2NzYKWJPcuDH9yrMTYcv6nj1THDZ2hgNiM6yZvAX/zu9uo68
         pBFTTH9ARmiYR+CT3wjyEPUSDS9d1dGKu9Izm4t4joyFbGDiZvqne4hZtaRMuoX2T7TE
         4jjQ==
X-Gm-Message-State: APjAAAXjR+645jHhx5458LlQTuGQAmXLf/FU/aM6+iAyicJcjomGv4ZJ
        aHUrxcsdYPYoXmpbJRKYow==
X-Google-Smtp-Source: APXvYqwJlQVmNwfOy8pZ4dd5OQ3+raAlcVqaRRzdvX63cciywXe01/6EPDnk/F3uknDa+zExxPr4Xg==
X-Received: by 2002:a9d:5e07:: with SMTP id d7mr22330427oti.315.1552416257587;
        Tue, 12 Mar 2019 11:44:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h30sm4046958oth.19.2019.03.12.11.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:44:16 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:44:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 3/7] dt-bindings: mfd: add bindings for SAM9X60 HLCD
  controller
Message-ID: <20190312184415.GA15124@bogus>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
 <1551780434-4580-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551780434-4580-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 10:07:47 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add new compatible string for the HLCD controller on SAM9X60 SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
