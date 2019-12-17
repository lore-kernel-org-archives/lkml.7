Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A2FC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB52321582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576625725;
	bh=HMstQrZKuwi74wJ4cMmuorxOn5AW/f4Mj1GadtC2JCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kcOidliolvRFJzv0qLPubPvSHSYss53r8p0DM9GY4uT7FtavbJMunDZTIdjrWKCLN
	 5Pj2mvzXUy815exJipMUsktRkHzxYthm3SvlKwTl/yeuf1AufyNcJIiC9MbTyIkLnG
	 clpV6Z8oeqEVDfbfDCjYQyKfTOpfDaSguctIpw5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfLQXfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:35:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35927 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLQXfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 18:35:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so107536oic.3;
        Tue, 17 Dec 2019 15:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BI73ZBRjjqR0+V9ow7XsG6Zpq8G1O7yVR3mkt4nqq1I=;
        b=GeQ97sb5pTHYufmxnSh1mGTrLIGA0VEm5cCQTzx6hOjm9HXI+q+bgcyxPcD7Zm+7oX
         i8v+mwYN/Psm01C3OjEXtIua0dX6OrAc7/PhY5PhNCToV8ztVLXfLu3QIa5H5Tz+X+pM
         TvGPBcrPDAKMSoCjVM/HJtoSI40ga2HXG0hWeQHwo4Rug4fC+bwv4A7Q3TxKi99WTjQK
         W+WckxTS6Mwe1/3lqDTBY4Zbjn8EkXYWh4QRQdf0X2/ctX0QSyQfQ8ffKbgycxQfX/ed
         JcCC8FZgNvo/Fql6YMGJuQNXW8Rp22GWwVcr6btWx/3b9nVDVMSuZpFewjCf6wlni1zp
         yN0w==
X-Gm-Message-State: APjAAAUXQRX0A5UF/79PRPLfoQflqM+l+AGD0RnG4oliFNMPe5sRe4GQ
        +I+tnuyuxTm5L9V2roZVFQ==
X-Google-Smtp-Source: APXvYqyRMza5p9FcM6gHlmpJkzd8vwIoG+HS9nMq49ZnmHNRYgI1aLev14QmXW//C7ZTMozv5ATcsw==
X-Received: by 2002:a05:6808:3ca:: with SMTP id o10mr3165499oie.14.1576625722498;
        Tue, 17 Dec 2019 15:35:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o16sm17262oic.7.2019.12.17.15.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 15:35:21 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:35:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pascal Paillet <p.paillet@st.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, p.paillet@st.com
Subject: Re: [PATCH v3] regulator: Convert stm32-pwr regulator to json-schema
Message-ID: <20191217233520.GA31425@bogus>
References: <20191205161359.20755-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205161359.20755-1-p.paillet@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 17:13:59 +0100, Pascal Paillet wrote:
> Convert the stm32-pwr regulator binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> Changes since v2:
> remove /schemas/types.yaml#/definitions/phandle-array for supply
> 
>  .../regulator/st,stm32mp1-pwr-reg.txt         | 43 -------------
>  .../regulator/st,stm32mp1-pwr-reg.yaml        | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
