Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F90CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6230820989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0v+w5FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfEHLqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:46:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfEHLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:46:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so7529893wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lK+3d8MZJN2On8NKOvom0NUSbRl8X6Lpwh3/QgozcSY=;
        b=y0v+w5FIAHTdurnw1cu21WfiHPivffquh0+KrSW6le6nkERrm9NKmrnahP31aohamW
         neHYaTTGIIkmExwmWa+gD3umpWWkchdDSiQy6jOovdx05tUeolkyyQeTVkoR0FNkZ0hH
         PmsZenZyFUPQmT+DXEK/Flf9HkeSOUOKEoGkbmzVU0dlDgCUJ8w8dO9ZzwOeAHJV3lXM
         g8siYiM9erVdB3N0YSEWiyQRV2g0kCgOyLkCkVY12E9Eh+1YfGJQuKUDI7J+isUY7rwW
         PXapOmShKa6kW6agO8zYODBXVUpVAz+pOjy6T5HNDQ7oY9UitqRg6lVidYZULsged7R3
         YQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lK+3d8MZJN2On8NKOvom0NUSbRl8X6Lpwh3/QgozcSY=;
        b=LLDR6g87gaI2tOOa7uFtUmEwT1O8YNvz4Rz/KOsJbNrPKf5OBA5qPy03Y2CuaaO5rK
         Wp3DFXuzDZIL9uum4fJSm1roaGukbaEEuCFPCvWaVouen1vEoP1rLDoPUxWfIIP8d389
         OO8fPjhFC2zenmxWXDHJukqAuS6hKBV7Sn65nD+fwEOn/afJDgmmzQOcjj0q3CNc33m8
         FiuSICT+8/Sh7z3W3Iyd5aM0ycMebqNC4t480geip5R5MRH9JMiWzmTPl+ft6sYiqh59
         SkyLVYJjkfQ0UIvoLZjzVeNuwe5VBUzVMiBTb3q6cp22kuypNj/BIzp003i1e5IyJ2k8
         SnHw==
X-Gm-Message-State: APjAAAX/fJixwSLjCNt75NXaKTBpkrpKSjwfkt6VwpBeQw1XAeyMjmLv
        mZYq51Y/F8aMYUBdwz+RcGYXkQ==
X-Google-Smtp-Source: APXvYqxKVFGte1Ew/V9TgW7FVFiVCw5/xNDNFvhTQ0pVkzuMo+L/aM3TAKIf67yeB5PnQmk8Wjjc0w==
X-Received: by 2002:adf:fa03:: with SMTP id m3mr4846442wrr.323.1557315995272;
        Wed, 08 May 2019 04:46:35 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id a125sm3450734wmc.47.2019.05.08.04.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:46:34 -0700 (PDT)
Date:   Wed, 8 May 2019 12:46:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: mfd: max77620: Add
 system-power-controller property
Message-ID: <20190508114633.GI31645@dell>
References: <20190505154325.30026-1-digetx@gmail.com>
 <20190505154325.30026-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505154325.30026-3-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2019, Dmitry Osipenko wrote:

> Document new generic property that designates the PMIC as the system's
> power controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
