Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDE5C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6999C2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="faHrnHBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfHQECX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:02:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43086 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 00:02:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so4100309pfn.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 21:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=LsFrOXJq15XZL37B55TOHg13GB/6UlZAx1tf1mF0vgE=;
        b=faHrnHBHHFMpMEb6WPW1+nTnesDz1k1vxDrVmWiZDh6DGc+ePIs/A4rC5ua7wCnjsN
         6oJlKKHuYI0LyHzNdxLwNjrgA8REbzNM5PfkbmB1cgHZwWF8ZD1Nu1f+nY5S0GttejAJ
         F6Ut5MOszAOmYBeuhxLGBHBPzgNE1VC1CWxWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=LsFrOXJq15XZL37B55TOHg13GB/6UlZAx1tf1mF0vgE=;
        b=blrFVh/R+pmqLogw1tzz1oLOXidOc5tDCHyAi6JDeWBccJDkaTiijpeNfxZyeBxZ7p
         r8omh1ujCvvN0N9fUJ9Z+Qh0KdZRQIHPjGOcNgP3DZUnoQ6Vg73AYb3mh4Pqai3QUWY4
         a4AjRmxYdbZKYADPhK4sVQuzFl7i66nVx5pX+Q1ELh7HSgeQBA8EcUKKYtXUbQ/NZ8c6
         sfzwih4NVIIctDn32LyaKqzhtpjhzVJoa+p1wP3WA4heE9pYfJTH6hnRLUD5ghhAXmW0
         dHIdCebBFiFVW+nLvS4a+EkNB+QuLGwQ91r2b3+XmG6WamyAG6TH+5kACwbBMHLaKIaQ
         PBWA==
X-Gm-Message-State: APjAAAUPzJC7B1rKZGOQn+7Lcdhnp3v7NTKhKY/dC3Ej8L+64KCf1N3N
        /X3slLkYaXyXk7/FmiBM0Rwo4Q==
X-Google-Smtp-Source: APXvYqyt70onMslYirDbCwRV7IAna5jtVCadGp0gGG2Gai76w7DcAc07t05l1S14n2LJd0icOnoofQ==
X-Received: by 2002:a17:90a:d34f:: with SMTP id i15mr10530619pjx.42.1566014542750;
        Fri, 16 Aug 2019 21:02:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b24sm7420547pfd.91.2019.08.16.21.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:02:22 -0700 (PDT)
Message-ID: <5d577c4e.1c69fb81.f3557.6783@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <355cd15c91e02716140d7114fd403559487b66b6.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <355cd15c91e02716140d7114fd403559487b66b6.1564091601.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH 02/15] drivers: thermal: tsens: Simplify code flow in tsens_probe
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 21:02:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-07-25 15:18:37)
> Move platform_set_drvdata up to avoid an extra 'if (ret)' check after
> the call to tsens_register.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

