Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A72C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F338E218DE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569937669;
	bh=4SYxozpggALUFoq+hix6bOttvPdIt89FA3o2AdzISek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QANOrX1TyUasipdPzvDMz9N2Rwl0+kaWF3DDO9yf/q4AqYU5CYE+Tbi5Cr2Q4+yIA
	 eC4c7GJRkykxHI3n7FbW2hLuKjwmyzI3B0XtpkArSjhfGwQyw5Mc24fabRv6HnLwSf
	 B0KKpc9nHQiIgh8SZRK/+D5alWWGhli7wku092Gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbfJANrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:47:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33463 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388557AbfJANrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:47:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id e18so14464524oii.0;
        Tue, 01 Oct 2019 06:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rEDnc9Jd/28M1ohLSPCRWsF0EEAGDKVCbMJuC0W7puU=;
        b=StHkJTYSOwHh5hm5Hu6ec6yqjkLusXPUTVDkMd8UMHq2m0r6w6E7awEcRXO9kHceCi
         7v5tSGlFikKJPiMqJfGhbkCIT6rrnEOPma0fRJI3+N7enJCvHjs0dB4ZTbRgE+elEyNU
         hlcCb+O/FuX5/WMVUpHbERv/nQsql/N8bwd4R6q+OqQ6R3iBn7k4mQVdscPU1txbwWfz
         rP/qf6h0ZWT35niWRp8I7memvyFp3/ENzrwVhtdd7AKdPSyf6BR7O31vbcPpTJFGuhmN
         Ezqp/BGS7bHlbLYwIfIRzSjDD2VvcaIeSeC9j5Eu0q8CMkeMHRntvw5+O2xO41sIqFNc
         W/3A==
X-Gm-Message-State: APjAAAXFnIyVyeG0CGmzNwmMJnhG5FbAmfi/JI11iYW/sisvbDrgDbyY
        q40r4JZ65bbBX0o/e2LxYXDa2ozsrw==
X-Google-Smtp-Source: APXvYqw+KmPmFzmwX23fwaUZyE2kdDvGO96W7ayIpwSq39QK5BvLEHskSHj/M4RX2RX1E5kPaWkipA==
X-Received: by 2002:aca:5ad7:: with SMTP id o206mr3927590oib.59.1569937665296;
        Tue, 01 Oct 2019 06:47:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o184sm5305824oia.28.2019.10.01.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:47:44 -0700 (PDT)
Date:   Tue, 1 Oct 2019 08:47:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xingyu Chen <xingyu.chen@amlogic.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: reset: add bindings for the Meson-A1
 SoC Reset Controller
Message-ID: <20191001134744.GA28989@bogus>
References: <1569738255-3941-1-git-send-email-xingyu.chen@amlogic.com>
 <1569738255-3941-3-git-send-email-xingyu.chen@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569738255-3941-3-git-send-email-xingyu.chen@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2019 14:24:14 +0800, Xingyu Chen wrote:
> Add DT bindings for the Meson-A1 SoC Reset Controller include file,
> and also slightly update documentation.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.yaml        |  1 +
>  include/dt-bindings/reset/amlogic,meson-a1-reset.h | 74 ++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
