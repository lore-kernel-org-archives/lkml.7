Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C42C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F6D22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NFpxjJ+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfHTUfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:35:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36584 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfHTUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:35:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id n1so2779611oic.3;
        Tue, 20 Aug 2019 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shZI82Zl0a1vHkFKOP8kqC8vGCDr5oXp88gXw96LLYA=;
        b=NFpxjJ+Fr7xKPu3L0zKJ8v8AUa/bW/d1wEprP+UsRX34exWwlqD7IpKtKOqqKpQD9+
         CfCw2hunvnMRDynay6NI5pDYSfExI7YCTLtUdE1Kn9DcBZHZDAcRYq/5jySavs1ez1eC
         v38+8pNMorc+ONtthB95+DHcpErr/pfWwNbC8OV42t1NeCRxEIH2O73XEmTzXvGknZYf
         r1GcrhNJi4G1wfFgRPaL0GzTQDm8j9c6fFXIerxDaqhuMzlcJB51WTHVFXQIMX2/f98B
         25E3zfJwxlMkAE7WtjR/w2bVwPNcbDvC6rzZm04oEqhg6LF9METLL4MhipTAUBt9HM5d
         oxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shZI82Zl0a1vHkFKOP8kqC8vGCDr5oXp88gXw96LLYA=;
        b=mOVVRo53c3THRPqq577/XLlEPLgXZiwnBnEub0RMnnZcuPVfzzWhmOZexqrux8Z8V3
         qx4zgbc0Oqp2g04iur4HEPvUd4NKEYlgYVIoiOp1EpkZLhQIgog1B0hUxtVBBnj0gzan
         /lIpTEu/cvG6YHXH0b7tA7L6nxR9BiWLJYCBakiNQJ44owm0uzskYkOWvvHxa1kNpIjF
         w37gkG7LeMzpPrROSFsdvXM8D6Or7TnEO7fT9hM8CyfgaTMA2DyIBiu3rP8ltMZnDLui
         LA42F5U4ixoluW0uejBSAqkBZDMchJZlPBz0US8vFyb6fNYz0ZxGJJJFexPK8x73teA5
         L4ZQ==
X-Gm-Message-State: APjAAAUscdMKOzs7GYCEqgon/cc8sYHhoqrKk73WbT8OoI1qQ/Plw6rC
        D6V0F2KB9YT6tLeBttVri8ipXkUnBBc9Nosb6Dg=
X-Google-Smtp-Source: APXvYqwF+wqaQaOhsdA099YOhLAMF4+0X9jZXZ57p3A1tskhIG+Cq5/F0EEgHWGCTE9OmycZu1wV62qbVj5Bs+q55M0=
X-Received: by 2002:a05:6808:8e2:: with SMTP id d2mr1400869oic.47.1566333323830;
 Tue, 20 Aug 2019 13:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-15-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-15-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:35:12 +0200
Message-ID: <CAFBinCApsk7VhfUBB9Gs5_k1p3-q5RQgfFO_6yjij=kALh9AJg@mail.gmail.com>
Subject: Re: [PATCH 14/14] arm64: dts: meson: fix boards regulators states format
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:34 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxbb-odroidc2.dt.yaml: gpio-regulator-tf_io: states:0: Additional items are not allowed (1800000, 1 were unexpected)
> meson-gxbb-odroidc2.dt.yaml: gpio-regulator-tf_io: states:0: [3300000, 0, 1800000, 1] is too long
> meson-gxbb-nexbox-a95x.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
> meson-gxbb-nexbox-a95x.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
> meson-gxbb-p200.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
> meson-gxbb-p200.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
> meson-gxl-s905x-hwacom-amazetv.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
> meson-gxl-s905x-hwacom-amazetv.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
> meson-gxbb-p201.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
> meson-gxbb-p201.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
> meson-g12b-odroid-n2.dt.yaml: gpio-regulator-tf_io: states:0: Additional items are not allowed (1800000, 1 were unexpected)
> meson-g12b-odroid-n2.dt.yaml: gpio-regulator-tf_io: states:0: [3300000, 0, 1800000, 1] is too long
> meson-gxl-s905x-nexbox-a95x.dt.yaml: gpio-regulator: states:0: Additional items are not allowed (3300000, 1 were unexpected)
> meson-gxl-s905x-nexbox-a95x.dt.yaml: gpio-regulator: states:0: [1800000, 0, 3300000, 1] is too long
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

note to self: NanoPi K2 and the Le Potato board .dts are already doing
it "right"
