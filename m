Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3DDC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E11120859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TCX5m6h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfE0SMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:12:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37231 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfE0SMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:12:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id f4so12434712oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdEdzKwrwwR+hZrRuekbTm4BMx8O7NzP4YL8a4f6Xyw=;
        b=TCX5m6h3kSNswGNfH9xVf7MNEte1kWLAUZV2H9MaftkLrqoChQpWF9viqrvYi6oyn6
         tMkNsoSpUVfYD/CCZosnrlppsI84qiMpucB5XKAzOQplFzM2KPYLEDMwfKyXFaG5RbO1
         LjeZRTQ8cjEpmhm1Sy8uCqpD+io3/Cm0qwA84eSxw6osWF7EkPE/L2BoZPLI2SGA7aO3
         NDcaBI3XhU0VFHOXVHwWcRXnr6l1uoOT6AIbk/0g1XMUq30s8F24O3na6AC+dtrGROBE
         vqmZzoO6VI9MfrcgmrmHYS6/pPyFeezktzDMd7Bt7FZa2WF/szO/NCiryKq/lKy0KOeV
         ErkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdEdzKwrwwR+hZrRuekbTm4BMx8O7NzP4YL8a4f6Xyw=;
        b=lJ7NQ9FXlVT5K+l4vptkMXwWbN56pNcj/KEXdbOPxQQ+mqfSiHD+c0If/NiCRBtgBm
         so+DJr4efZo35cfN+reJx9rqrIaI+EjyzOZqttijEeG++hu0+4aJYE1v3KqYRepa0FuX
         CC1W95W4KKOKKl9X7KkCcZpaFOQzX0DgEnqO39U7r4ppkq08eibPS6SiR24I9dItk6i6
         23YqekguiOrpznv1Q5LTnC35l964B4mICbc1AXFdPxSOOGAq0k9oz/qpaJT4S1dabTNC
         tQkmFotUdoLEcEFcn542bSi0J/moOHQDO3mZXBGfZdF12sQ9YI+o1IadRpXGdi43mADY
         d/JA==
X-Gm-Message-State: APjAAAVieZx/riXiAzYEuc8OZiPp5Vz6DS9jSviBFEnECQtM642PyMc+
        UuCCN4z5KHvTT4HgzV9KIbPblOpI2ym6U6ZeqxvozKGavok=
X-Google-Smtp-Source: APXvYqwmz7MYBR3RPfckjQ+bn80jPUguVMJFtd+LUXLXHyBI+ktAg+X8jo5YLRokDHP1QncBkXrVu3K0ewCBCk+mFp0=
X-Received: by 2002:aca:4341:: with SMTP id q62mr175063oia.140.1558980764213;
 Mon, 27 May 2019 11:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190527140206.30392-1-narmstrong@baylibre.com> <20190527140206.30392-4-narmstrong@baylibre.com>
In-Reply-To: <20190527140206.30392-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:12:33 +0200
Message-ID: <CAFBinCC+QrMhEErnt28ACe7x_VM65_envvOw7kFWAir53B=_nQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: meson: Add minimal support for Odroid-N2
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 4:03 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch adds basic support for :
> - Amlogic G12B, which is very similar to G12A
> - The HardKernel Odroid-N2 based on the S922X SoC
>
> The Amlogic G12B SoC is very similar with the G12A SoC, sharing
> most of the features and architecture, but with these differences :
> - The first CPU cluster only has 2xCortex-A53 instead of 4
> - G12B has a second cluster of 4xCortex-A73
> - Both cluster can achieve 2GHz instead of 1,8GHz for G12A
> - CPU Clock architecture is difference, thus needing a different
>   compatible to handle this slight difference
> - Supports a MIPI CSI input
> - Embeds a Mali-G52 instead of a Mali-G31, but integration is the same
>
> Actual support is done in the same way as for the GXM support, including
> the G12A dtsi and redefining the CPU clusters.
> Unlike GXM, the first cluster is different, thus needing to remove
> the last 2 cpu nodes of the first cluster.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
