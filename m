Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D876AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4EE215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UrI0SMga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbfJCQKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:10:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45219 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbfJCQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:10:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so1728456pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=/uux4QaLIxBgIS+S90+1Po/wEnZf/E4w+wy45KhyTSY=;
        b=UrI0SMgaaYbIISJ6/D8xRZ4Lk/gZoGdz0emX9xVpLMpkthMjLeCbmaU65NX8oYdJvd
         np8cgUQj2oR4WuMDHF9iJzr5P5yiG+GzNApMl/DPqi6kdXqj34g/c9KTEnb8EmdO5wc5
         22dxnYWmPxhzWdfW5bWKUKI2yJBgdCBKc1jU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=/uux4QaLIxBgIS+S90+1Po/wEnZf/E4w+wy45KhyTSY=;
        b=Gt93pYaGQRPqoK/jOX37RbM2+SMvGme65FIU3ieiCezGsBMspTbSpT2IPS/cUn19zw
         DHk0P4n3oMG+0c1kSB4gu1GsYkuqLfBC49/4APPQ2W+j32ezU2S59frebnFZR+t4KkDR
         Pm+t21ubuyj0nrYC1o2NVr1ED8jJ+uFpJ95MsxdPXQp4+wu0wgA3A4luiSo/P9K3E2ZK
         oOf9CqcBao/fl7GExeiXdAexK5lIJnBUj5Vn3N4APiiVHGfr6HZe1LR/hyLbRgERk41Y
         jGGKZcGVjhwCsrdEWBRzqWLX4DVqpiLI+eeL0LEKozBUR5mxLmTksbL0LW2iE6DDoKO7
         xqrg==
X-Gm-Message-State: APjAAAXxjptmvSZw4iSHimPqCn8ax6BGr15TVHacUXHbDOrkIED6NwF2
        kNpNPzyE72hAi02UL2S1I4O0fQ==
X-Google-Smtp-Source: APXvYqwZH1M6/LhbGuuzz592WQ9OjilbEDeLMqV+Nwj//lGPPbOMeQP4nSTTUjncGz1/gK/4ggJ8eQ==
X-Received: by 2002:a17:902:ff18:: with SMTP id f24mr10300646plj.173.1570119047382;
        Thu, 03 Oct 2019 09:10:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z13sm3540938pfg.172.2019.10.03.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 09:10:45 -0700 (PDT)
Message-ID: <5d961d85.1c69fb81.b9642.b721@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191001181109.1355-1-geert+renesas@glider.be>
References: <20191001181109.1355-1-geert+renesas@glider.be>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] phy: renesas: rcar-gen3-usb2: Use platform_get_irq_optional() for optional irq
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 09:10:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-10-01 11:11:09)
> As platform_get_irq() now prints an error when the interrupt does not
> exist, a scary warning may be printed for an optional interrupt:
>=20
>     phy_rcar_gen3_usb2 ee0a0200.usb-phy: IRQ index 0 not found
>=20
> Fix this by calling platform_get_irq_optional() instead.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

