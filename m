Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34972C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027C8214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lneRNQyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfLLWAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:00:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35459 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbfLLWAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:00:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so112700pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 14:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:to:subject:user-agent:date;
        bh=m5RN7Ruq6b2oNIbW1OTVbblEFx0jLwFpTd4HTw5wVkQ=;
        b=lneRNQyxzco6VraFwiZvfvv0ix1xxj0F27IGpoVPrKlMBCxe/LgOg3peL5pluU74Qj
         S0F34wXbAn9QLYC/itEq43IXWcwWGqQNAYo6Tkjpm+Va8IZnD1aSHUgTAVaSl48PjFRc
         XvyPyCdILOnFtRcu7hpg1zu/YWYv0QI7oE1VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:to:subject
         :user-agent:date;
        bh=m5RN7Ruq6b2oNIbW1OTVbblEFx0jLwFpTd4HTw5wVkQ=;
        b=HxbZ0ZqO9EKakPGfC8jnSlKA+wvAoIYuIQvVp8ZLkpGuEbM1gvMWHCgwmo1VQHC22n
         vKS0LWcRwo1FqNtX9Ozhq210p1yR7Xc1Yl3Ozu0bVPqg3U3kcDWfKmI4GFALrZsNMaRG
         9Lv/4+SMYRxc2RjufrIhTDbVhboMAGNgNcHiMLl4yUcFwApZXv4TkgVdtmGDAedSh0SL
         lUmlyFLd8dWBu7NEDSI2Mb+lBO6MOHM+enkRHtzMHuCDecoIwJVYII9n1mw31A4PtDZh
         /AiRA/PxV/hpBY3Q5D/FVqBgB7KN1bAceny92ZS3M+WeebLYy/NK9Dk3z8KadxyBSJ1Z
         +z2A==
X-Gm-Message-State: APjAAAUXMUUwdl+MX2u8Gc6m8mMC5+dXUMQIh9G/Qd2Rll455rvNr90i
        ChpduWB+DaAO0+DgbJSxNfzUyw==
X-Google-Smtp-Source: APXvYqxKdxvqy0acTBm4XIVBtjHKPFwJWztj4zqFxxtbPgd4PxaZjT4MbgmTjW0W6DUqKyuKf4jamQ==
X-Received: by 2002:a63:1a22:: with SMTP id a34mr12401788pga.403.1576188022050;
        Thu, 12 Dec 2019 14:00:22 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 199sm8862298pfv.81.2019.12.12.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 14:00:21 -0800 (PST)
Message-ID: <5df2b875.1c69fb81.41383.651a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191212113540.5.I4e41d4d872368e2e056db2ec8442ec18d3f7ef08@changeid>
References: <20191212193544.80640-1-dianders@chromium.org> <20191212113540.5.I4e41d4d872368e2e056db2ec8442ec18d3f7ef08@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sc7180: Avoid "memory" for cmd-db reserved-memory node
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 14:00:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-12-12 11:35:41)
> By using "memory" we trigger we trigger the "schemas/memory.yaml"
> rules when we run "dtbs_check" which then complains that we don't have
> a "device_type" of "memory".
>=20
> Looking at the "reserved-memory.txt" bindings, subnodes shouldn't just
> be the word "memory".  Presumably using just "cmd-db" should be OK for
> a node name.
>=20
> Fixes: e0abc5eb526e ("arm64: dts: qcom: sc7180: Add cmd_db reserved area")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

