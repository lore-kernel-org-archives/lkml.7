Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D02C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8F522D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iB5LViSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfHTUVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:21:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38579 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfHTUVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:21:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id p124so5153206oig.5;
        Tue, 20 Aug 2019 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFhIFMNnaJwO0FsKXVLZvfaKji7ksglDhoULj5vQdP0=;
        b=iB5LViSb7jTNNAhbtywPQFBv6ZPrntg54tPB6pWu+y3tEHXrW7lYgsKIlNvuqpdIDY
         A6B+eG4uTHPV20yAS9qAJ00Bx+uswKRvzE/CX1VGFZz+DB9sW3fNz7Ya7HLIETaNWdUB
         1c38CQ/KAap3kDkN4BwGg/H+8YsAodptASj+i+clz3oW9we85GjL9/Pgoq71mBWzShwD
         rZTYaRflJoWKbU2harz4XQ6VMnF1r2flEb0YXRX9xxs3UPwlWHghLYqpaapbe1WqUYXO
         Qiqba40Nrkj5ijVPIt9Tro8fZm19OsNHcAPkXuoLXx8jzeGlCvI2PUHDu1eLhzz6Xjvb
         6J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFhIFMNnaJwO0FsKXVLZvfaKji7ksglDhoULj5vQdP0=;
        b=bohJD8BAji/1GxEnijJMCcqDSt/QrmZXikdteEx/+sICSym4RjSIvxhqLKyO+9pgxY
         2QWUVfZrGbfca8c1B6QhL1jqlAFgOjbs5kAlvqBbjLSBZuaQ5mOJZq5rXWg3P140GGwd
         8ODFyD+kcv7Ji3dcR5eufPmFTMO12NShiHIscZLsGPeL8d+/j+O1OSOc1xU8Sjet+TXe
         bBYrLFIFKaDowQU7TEG1/MWEgiQuX2bzVQdaRZ5LNptJM9MxdLCL2Bllq0PJ0XeSAoCZ
         GJeKo4wpG1zzRTK9rJzjoTuGqHMRNjslcl/8IYTw1OKm28F5M7B06eylQK8TzrDToqRH
         HhSg==
X-Gm-Message-State: APjAAAUQHngA/r3CmTPTBlt3ktaBWgOePUxgCMyswiHOWJHTSM1hrZ5s
        MoKa6QzqPXtDaNacS/8KPx7QW0UDBlzs4c4jPP8=
X-Google-Smtp-Source: APXvYqzkLHh9E1pIvB0Iyz/FjsJ1I1eYHA9pMWw8yy94lIIDALmtN9giwzYeTUuWmVtTnhzpd0zUMimezCzBcmqBq20=
X-Received: by 2002:a05:6808:8e2:: with SMTP id d2mr1367608oic.47.1566332512616;
 Tue, 20 Aug 2019 13:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-2-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:21:41 +0200
Message-ID: <CAFBinCA5dPztTZ6kUBWK1XgjQPDY6FVsLHytMdncThHnf4Z+8g@mail.gmail.com>
Subject: Re: [PATCH 01/14] arm64: dts: meson: fix ethernet mac reg format
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:30 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-axg-s400.dt.yaml: soc: ethernet@ff3f0000:reg:0: [0, 4282318848, 0, 65536, 0, 4284695872, 0, 8] is too long
> meson-axg-s400.dt.yaml: ethernet@ff3f0000: reg: [[0, 4282318848, 0, 65536, 0, 4284695872, 0, 8]] is too short
> meson-g12a-u200.dt.yaml: soc: ethernet@ff3f0000:reg:0: [0, 4282318848, 0, 65536, 0, 4284695872, 0, 8] is too long
> meson-g12a-u200.dt.yaml: ethernet@ff3f0000: reg: [[0, 4282318848, 0, 65536, 0, 4284695872, 0, 8]] is too short
> meson-gxbb-nanopi-k2.dt.yaml: soc: ethernet@c9410000:reg:0: [0, 3376480256, 0, 65536, 0, 3364046144, 0, 4] is too long
> meson-gxl-s805x-libretech-ac.dt.yaml: soc: ethernet@c9410000:reg:0: [0, 3376480256, 0, 65536, 0, 3364046144, 0, 4] is too lon
if you have to re-send it for whatever reason I would appreciate if
you could add:
"while here, also drop the redundant reg property from meson-gxl.dtsi
because it had the same value as meson-gx.dtsi from which it inherits"

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
