Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583DDC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7C52072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578500855;
	bh=Qp+tEQvjJBXTymbKNXSpzRHKMqxJbBtdk5mkOGAUajM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wzRTSwccX9MrX1u2T1hTMYrDDp+nuhkZ+OiuD/zZoxbLQzeUl9xXHgHWdIj3sA7gn
	 sm1HtQE0mkdZAJfMHCOSk5KrL1Ol1qFbYdB8ullORfOO933escOeD6WXwQ0azTsYSW
	 pcfgSUoMHq+CufKEX9+7ArrprUR2mYG6Im9o0DlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgAHQ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:27:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36991 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgAHQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:27:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id z64so3147561oia.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hlPj6SA9VOkT0SEDoGb32WMgkDWrYAi1UZe0L9iyH6k=;
        b=O7kruooCwgM1i8CZ5gECwWlq/zFRMYTwytrpEIzfvAlsHbPnnR7pkNaAmaCe+uvej0
         icWwVJbFc9cdSA8Jeyg7vJCzQ4GrRNoqcliasbe/ukyIX5BkHSPtK2CSHuNlYmgC5CUT
         RT+8skW8SG8hb90ae2Wmq2xz8rnMBToNWCTbSlQAICWKIq9gNizbg0MR62yOiNRHph3L
         RLDZ5xGuPOhTI2dNTWmTFQECTFh+HFcIPbc75qH4x3nuaKOdydNUIseVrb23hKB+5lpD
         PMHfqGxUVYNjoz4HwybjIGnH8COSc2XkwJFzzpC3WtQUyxwb3ASL6SJayJH1rVoOA8lB
         YEzQ==
X-Gm-Message-State: APjAAAW0ie35Iy58/mkZ/YqqF7cMIgrO/SCNfmx2j/Zfw1SBecCDzPbI
        p+xqNbl1pC39YWe+zzoJCvmqobY=
X-Google-Smtp-Source: APXvYqwjaEFpo1QJ05oRIvwbv+qn5yj/g2Y85HsOiDHwbFjZACs6SVZSqPvJrHcn54n3ZUGwueH/zg==
X-Received: by 2002:aca:c7cb:: with SMTP id x194mr3738000oif.157.1578500851902;
        Wed, 08 Jan 2020 08:27:31 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h1sm1261734otn.6.2020.01.08.08.27.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:27:30 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220adc
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:27:29 -0600
Date:   Wed, 8 Jan 2020 10:27:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, od@zcrc.me,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: sound: Convert jz47*-codec doc to YAML
Message-ID: <20200108162729.GA26720@bogus>
References: <20191224002708.1207884-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224002708.1207884-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019 01:27:07 +0100, Paul Cercueil wrote:
> Convert ingenic,jz4740-codec.txt and ingenic,jz4725b-codec.txt to one
> single ingenic,codec.yaml file, since they share the same binding.
> 
> Add the ingenic,jz4770-codec compatible string in the process.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/sound/ingenic,codec.yaml         | 55 +++++++++++++++++++
>  .../bindings/sound/ingenic,jz4725b-codec.txt  | 20 -------
>  .../bindings/sound/ingenic,jz4740-codec.txt   | 20 -------
>  3 files changed, 55 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ingenic,codec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
>  delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
