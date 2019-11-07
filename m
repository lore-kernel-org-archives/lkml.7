Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F02C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CA320869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKZTnhE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbfKGRre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:47:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36400 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbfKGRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:47:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so101560pls.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=5GkGrpSVmrc9ViRHH2ReZO4gd77aOs3+re0Xo6aImAI=;
        b=RKZTnhE1z3GMZ6EfTwhYdjOGcMis203JqjKGp2LhVORZZ3SI7tkpSUk4FkeyjAwS+R
         u9RKQBoxIyHqXOthmB4GIHXFnvgqved15RLaxMfve/hnPE3RiUi/nYB0sJfqCKudz9Ez
         gIYV1R3CikDKdE3aCdOAA1wDAXM4jFt36M3Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=5GkGrpSVmrc9ViRHH2ReZO4gd77aOs3+re0Xo6aImAI=;
        b=Th28QqQRLYjFI2mEparC19IfsS+AHW0MoGT/O9UOYcow1gxvZqu2rBYiYLdtXj++XU
         L+vK2TPo2Ke70qfuZ9j2CaLDzScERFt8vMeKOZImXImoCd5BSFg46wjXXEXEQO3va/fD
         kx2p7ff0H6UolKcIyvA+h5fE3bcZhLLGu+a/+M0tXrswY+w0qQBhe35jkM13jzwonUBC
         5kq3mjGfPp8cCfPf4cMcXbX9vM8Ax6uwr+eKM82aDKJKkL74pz1uc+A0dLssdjU8sSlH
         B0ltDSUg6Tvfd62FPiT/XwUB5GKm3XRhrNm/gLYe1DLMYolj97+XF6Zd7ZG3DPBsvH2K
         udNA==
X-Gm-Message-State: APjAAAWktWe4tf1vTpsHNGyT+ojRgVw3SIfSHTwdt7RiysK7hROsISsE
        PCJBChIhlS2GS+INLE+u+T7hzIXhGqnCEg==
X-Google-Smtp-Source: APXvYqwmNlBHag+5rFJWuA4Jm6Eufmf4x2cr1CIXPm9ihVU7YrZRXfgn8dvl8MetvcC+PCM7/qHx8g==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr328362plk.226.1573148852495;
        Thu, 07 Nov 2019 09:47:32 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m4sm2732758pjs.8.2019.11.07.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:47:31 -0800 (PST)
Message-ID: <5dc458b3.1c69fb81.b9f5a.6eb0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-5-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-5-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 04/14] arm64: dts: sc7180: Add device node for apps_smmu
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 09:47:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:07)
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
>=20
> Adding device node for APPS SMMU that is connected to
> devices such as display, video, usb, mmc, etc. on SC7180
> chipset.
>=20
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

