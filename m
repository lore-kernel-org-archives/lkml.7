Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18C1C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963B8218B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/1NfqRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbfGWOuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:50:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38422 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732532AbfGWOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:50:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so19272166pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=qFGyu2e0qPfrwHi7OXbbKa0ySxd874e1ZB3q+1beBgk=;
        b=B/1NfqRknQzOA9lNUKMjw8bei1USgk+jf8C7LimjmeeuY/nXbOwY9qKGdqr1xB0Ep1
         fF+uGyD6SZT5kkwDHqgcI+JJucEKJ2eELk1VJumWUxl26Nnj5D2cJF8WjuYyVe4s8NF3
         VlozWZllNLHU0k5+JPfpJ+vslVBC70FPXvsr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=qFGyu2e0qPfrwHi7OXbbKa0ySxd874e1ZB3q+1beBgk=;
        b=r2MfK8TK0nIkNt1qfVtLZABvmvtTesBGRd+hxwwha5syxBP2s6+yrLSeEka2+k4WT5
         zb5nSrQ8jRDHxEIEIJQ5W5HhGT7oDfl9nLhPlfOYSqT2mgs2NWPwWSmlk0+qeZiOTWbf
         SRd0CQrhCSWSHfy/25XqWJ+nvb4mJ3X8qsmhOn0p0p9OAFl5ogw8u/O78tai3qqWAk8t
         +gsQoU6Z7zfZhY6aCwILDKXhTI02rDAuYXkaydgXyLCdq0In1DanQZ2nv4XTrpN8B7N/
         y/LH5UEqiMrmCoelrL42QqndaUp6SD5nAzg64wixwXX99DV1yv32Q9LjvwQHqun4PgQ4
         9bvg==
X-Gm-Message-State: APjAAAUj21xD5fixHUpCqTW/mrMxhaYXs+esrrjicibpSMeEieuGLMMC
        4LuTnRbZhwzm/P3uvK0kbOoqgA==
X-Google-Smtp-Source: APXvYqzh3JlVXvMXshU7/BGzt6pys4NOV2ew9Hhpy6X+ywpiQ45vC0nwZXvmBT2O3iv2LcxoEYem+A==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr77607662pgk.355.1563893406340;
        Tue, 23 Jul 2019 07:50:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w2sm36341678pgc.32.2019.07.23.07.50.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:50:05 -0700 (PDT)
Message-ID: <5d371e9d.1c69fb81.8d9f4.1ac0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190722123422.4571-2-vkoul@kernel.org>
References: <20190722123422.4571-1-vkoul@kernel.org> <20190722123422.4571-2-vkoul@kernel.org>
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sdm845: Add unit name to soc node
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 07:50:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-07-22 05:34:18)
> We get a warning about missing unit name for soc node, so add it.
>=20
> arch/arm64/boot/dts/qcom/sdm845.dtsi:623.11-2814.4: Warning (unit_address=
_vs_reg): /soc: node has a reg or ranges property, but no unit name
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index 601cfb078bd5..e81f4a6d08ce 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -620,7 +620,7 @@
>                 method =3D "smc";
>         };
> =20
> -       soc: soc {
> +       soc: soc@0 {

This is kinda sad, but ok. Maybe you can apply this fix to at least all
the qcom boards then.

>                 #address-cells =3D <2>;
>                 #size-cells =3D <2>;
>                 ranges =3D <0 0 0 0 0x10 0>;
