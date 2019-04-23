Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0962C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EA1218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXFw6Oe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfDWXun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:50:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39604 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWXun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:50:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so8285104pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6X9k61YHes/wtaMB15cVsCGzU6OmfVoywYkiyvdTfxA=;
        b=NXFw6Oe7bumR+PeGr0zt39jUWZH4g1zElXkhKPGoO/875NWbu3/ABH6ey+m6fD82Mp
         +uCyCDuDoMT9eI6fSbTftv9JeBBoe2lqNz3ZUpk9IH+ELj2SlM9QLwN4ZVEBXgmwdM63
         gBLJzMRl/OZ8Rovkjn76c3TmifGPRqTCq21XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6X9k61YHes/wtaMB15cVsCGzU6OmfVoywYkiyvdTfxA=;
        b=fe8b5yNll61cygPulqObeKaqaDdtx3Gl4GKxsm2KCPHQWK011VW10di8YjcblDXoaF
         dDfpKzoauwb5J6kzYNm0Jxgh6JULn4gMgDaOvLoUbcKwdkYFMUpdvCsP8BrV8svoGeo0
         qXfloEki1VImFuxpbA3kkS/4OjXEdW2mPrhy08XexuC6ThO5BDrOfOSRE6rI0chOZZ1I
         n7h1UChUwoQcBW66+9tIOY2dyiofY5XR5cAPYAQa/Hw1XDIYyJmHnfYHK+Thfg4aX3QJ
         9DEEJ4cjI6vDgeDx48NHVlOqUxaIcZwDDKS65gX8AgvMddX8Ve40qVWAnJuJUNXvk6yE
         tx4Q==
X-Gm-Message-State: APjAAAVbhVY+CUh6CzaNRCDAGSfjvJv5hK1+3Fko2GPs8dpH2TU/lsfZ
        InJssMcWiDkbogU45Q0scTdknA==
X-Google-Smtp-Source: APXvYqwCH7lRaekaEK7ax8qzBQrrFwefJGFGsMoFbCF8U1CkTnUCeo+DkPt8kHDLH5RszBomE+3dSQ==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr27066330pgc.158.1556063442475;
        Tue, 23 Apr 2019 16:50:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u20sm24748455pfh.112.2019.04.23.16.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 16:50:41 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:50:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: linux-next: build failure after merge of the qcom tree
Message-ID: <20190423235041.GF112750@google.com>
References: <20190424092531.3988850d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424092531.3988850d@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:25:31AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the qcom tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/qcom-apq8064.dtsi:1297.29-1309.5: ERROR (phandle_references): /soc/dsi-phy@4700200: Reference to non-existent node or label "xo_board"
> 
> Caused by commit
> 
>   3560af5a56b5 ("ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the DSI PHY")
> 
> I have used the version of the qcom tree from next-20190423 for today.

I thought I built-tested this, but probably only did arm64 builds :(

I'm working on a fix.

Matthias
