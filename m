Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913ADC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673FB20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571160139;
	bh=r5ZSxf7K5G98Rq1JgK5WtkXKJA0GZ5WrgN84/i9AQIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ldFwfIBOsulFf+2VL7CV9Mp0ODTdynFEqX8+dKcJcDG6668BtTOjy/OIzeLHrRbLw
	 ksPd7QaAjyWJXCNGOIERwOD0N+Vy47y75Hfc7o201pHtTxF/f948e9vqofjXrk2JIE
	 s96+pFNAFmDPbto30wjP6nEZpEWOBqQGFNSdwxyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfJORWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:22:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46211 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfJORWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:22:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id 89so17607704oth.13;
        Tue, 15 Oct 2019 10:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbHpx7XPETlJ9vzemeHjD6QE7tFzcrH2Jm0Y5GaVUsE=;
        b=qoB2FnlPc+uz+CzSCGN5hVHWu2cjETHgEn82JDhl9Iqp293PbAM1RAwxnLPA4TCqFV
         IYygTFNl6jk7LAMRU33fzk4Tv8bGaZJEV3Ept0c7Yf6y07yDrwCTH51R9kWDy4+S/k9l
         nzNIUq13Z/AIaUg3GgUJFblIv44bZE5tNOSgx/udVwvu9S7cgSrnWG7xi+1x2ZueC+Mt
         wJVs8UFKyhoPASUtyaJ8hUk9s9cuiK5dJWK7LCTsV9ufFIMH5LvSE69LEkEjJBRAaLL+
         Ct/JI0Q5gvEZZE93s6R6+yWi+YmDN9mdpsQvMGGmIwkLn7ZmHNJGdskhNRVbhmHiW5Zv
         22DA==
X-Gm-Message-State: APjAAAW70rYkGFY0DiYsTrBQokvjdGO8FnV+7w4UxzO/0hkdv6U4ygju
        AAAc3AFT/Eqw/6BnAi2bUQ==
X-Google-Smtp-Source: APXvYqwPKZrxBjDVG/uILAEhdydbS48WivhzBHRDzrcYQxF0oufQKLAlBVKJ72NlODmOQyjYCQPneg==
X-Received: by 2002:a05:6830:1188:: with SMTP id u8mr26388246otq.190.1571160136331;
        Tue, 15 Oct 2019 10:22:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s1sm6446834otd.49.2019.10.15.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:22:15 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:22:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: stm32: Fix 'st,syscfg'
 description field
Message-ID: <20191015172215.GA30472@bogus>
References: <20191007134410.10337-1-alexandre.torgue@st.com>
 <20191007134410.10337-3-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007134410.10337-3-alexandre.torgue@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 15:44:09 +0200, Alexandre Torgue wrote:
> As there is only one item "st,syscfg" this commit moves phandle description
> fields under "description" tag. It'll fix a validation issue seen  during
> stm32 DT check.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 

Applied, thanks.

Rob
