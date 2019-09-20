Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067C0C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A3E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568983388;
	bh=GNYWxCKXwHi0/DCkc7hTDssZIm4gCFKm+/GJFQfAzrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VFlGerOUIsAWo9z0w2c//qW/FJJ3p+6910vfFYfpn0YwbIFTVD7teSOVYl7TofJfN
	 TrgoB88JswoHkptlcMsNYuUbA3vY95JTLk5Fmg3p3DtVBTl6gI2OkRYXkT8o93FM6M
	 Ot3ttuqyeZlpFpn36MisGHW8cabrWoYUAZ6/SdJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfITMnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:43:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35897 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfITMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:43:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so2154869wmc.1;
        Fri, 20 Sep 2019 05:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IUIz0TFnK+oC5M96ipiDUxKW+O/HTgXIaIGHBEPFmZk=;
        b=qXu9doL71keYnAxF1aIrdpDggr3vLdYOZfEh9WB/S2BZlHC2FZ2EeKKhL8oWVju+Yn
         qV5ua8EJDKk+R5HTrqxZ5PwV68P8lqSFZh7JJqhNplirxG4asX5TkgJnX7zFHzlOQabS
         3rhXSJkeLPD+qAOg0PjftT0R9iwqY2KZ55j6/UlYJqgrpe5ujSoG4WUOoY5Gvs6XIZf+
         r9N3pSXH1DaPgzGuZyY2sConouS0vWC2pI2d8IFcsOhXWsDsQsZGp95VDaGoQdGYtdTo
         VRAnngVw9baGdaf/pDjzlg+wuR+Evs7o2P/8agxpI/lMt2dXsib2yKnFMN/lSRx90gM1
         /cCA==
X-Gm-Message-State: APjAAAWTpiOLnm/mVDnBgHMb5ZxRxbVDr20nJRJdMKgxJynin8P54YQk
        qi6Zd97gICmjYDfGv708KZk=
X-Google-Smtp-Source: APXvYqzbaPx3iXSpFSvDy/ZXK9L8E7TXMCemVZw3zZNJjaJFe/Zom9X+pjc+WhUMLjEMWMRXD5G5Eg==
X-Received: by 2002:a1c:96cd:: with SMTP id y196mr3276669wmd.67.1568983384086;
        Fri, 20 Sep 2019 05:43:04 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id l9sm1678293wme.45.2019.09.20.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 05:43:02 -0700 (PDT)
Date:   Fri, 20 Sep 2019 14:43:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v3] dt-bindings: sound: Convert Samsung I2S controller to
 dt-schema
Message-ID: <20190920124300.GA26917@pi3>
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
 <CGME20190920115200eucas1p2253a3eb13373061ef8aa39131c98a319@eucas1p2.samsung.com>
 <20190920113540.30687-1-m.szyprowski@samsung.com>
 <20190920122616.GA26862@pi3>
 <68ec938a-29b5-0c07-3a5e-771d6ce587b4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68ec938a-29b5-0c07-3a5e-771d6ce587b4@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:33:13PM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
 >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/clock/exynos-audss-clk.h>
> > Does it really work? When I tried, it was failing... If you look up at
> > resulting DTS example it is wrong.
> 
> In which way it was wrong? We checked and it was correctly propagated to 
> the example dts. It also compiled fine without errors. The only minor 
> issue was that the include was generated inside the root node, but for 
> the clock definitions this doesn't matter, but it makes the example 
> easier to understand.

Hmmm.... indeed this works. The output DTS is weird as include goes to
example node (not even root) but it compiles. Somehow my previous tries
with it were failing, I need to check why. In general I am all in for
this include.

Best regards,
Krzysztof

