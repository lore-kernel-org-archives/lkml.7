Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB88C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D441214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fPAXHDWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392331AbfIFFPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:15:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40201 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbfIFFPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:15:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so3545135pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=Rs6lYDg7rzHFfE3fqBqCgcoh261QPFbPy/MlhwtPv/U=;
        b=fPAXHDWJg386CI0xnSxIs7N4XyMud3Qu1upV8CwvN0t006GE8zZl1VTWKnkG3pjSut
         Rp8P0hmrX4NZmEdBnSbNQQl1HFNKKaBEXDAhpUCCzImWycsUm1CoKqsZb8z4sT9oz4Jd
         4Zbdn4yUOwedFUpjglAdI2RkGsgid8eRl2+i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=Rs6lYDg7rzHFfE3fqBqCgcoh261QPFbPy/MlhwtPv/U=;
        b=HHa/ODQnhKGFvulP8DbSjMeoxPM4F9jR7quRAdqZOz1iSLDJ2Ya9p9WCXa+53o1YIx
         L5SZvI8Ii4OlflbSmEWk5xuH8Yza7pdO2sTmLb9KkVR2a8IEtWDAHTXPl6LyMCjYKAmr
         UbLiy/3SFoYNhN7nqnPmUEcBX8XhZYgCrW2lzLCa9RFA6I3fUsHrinT1FCbC/mliZXDQ
         EhyI875mZkMTpEfbq69MiwsBTxL/EiGF8WPBo5z6l0v4T73proLxrEEVJBM6Dd3Q3ExN
         eWoeS/AHCUpqTITqCrHA5f64ZOC5YJJLdtgdo4hCTmZj5WvT/oGBcsyFnoIuj7eyi2y2
         gS0Q==
X-Gm-Message-State: APjAAAVmNQlRf5op+ew95as/XAgJfJ663ABT5Si/5zpIPyn3M5swmczm
        ucZSGcgqGCMiIcjtRHEuu8Swzw==
X-Google-Smtp-Source: APXvYqzKV0mW9EELTg/94+NbXxWwYL0t9q7G5Qaisah+2L76fd6xkGvV+lbfx9rsLHkj3RyagSU2cQ==
X-Received: by 2002:a65:6284:: with SMTP id f4mr6618359pgv.416.1567746940523;
        Thu, 05 Sep 2019 22:15:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m19sm7637011pff.108.2019.09.05.22.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 22:15:40 -0700 (PDT)
Message-ID: <5d71eb7c.1c69fb81.7bdfb.3205@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190906051017.26846-4-vkoul@kernel.org>
References: <20190906051017.26846-1-vkoul@kernel.org> <20190906051017.26846-4-vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: qcom-qmp: Add SM8150 QMP UFS PHY support
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 22:15:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-09-05 22:10:17)
> SM8150 UFS PHY is v4 of QMP phy. Add support for V4 QMP phy register
> defines and support for SM8150 QMP UFS PHY.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

