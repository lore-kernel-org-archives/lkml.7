Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBFAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6512120656
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hrQo4lV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfHTUWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:22:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36840 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbfHTUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:22:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so6285935otr.3;
        Tue, 20 Aug 2019 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6O3nF6OsIezS3m94/FyyV74f4w1BQyF9b2ftz/OG11g=;
        b=hrQo4lV2skKSXv8CtS6ag3XtN8M9PayYvljEnc7WxrhkY09nskwWr52OHiPXLlac/p
         JYYske9tLSwYCj7fKXR9ASj1nickrFwjy7/UUffeXRcRuv7kHgWy+zyk5Uk8wYhVKL3B
         OU+CqtU0ePFWo5Agui14q6YGolD28BEvzq5mnoEqVm5bv/BiF8gJS7cJH8hwEzjVrs+Z
         et7XHucKD362BCEzf202AbmP5JCpJHc4d6pgE97JaAyjQaQDnDxCcex0s3ONoftF3sCe
         Hghp7DgWk0/YUFJVeTs4VxTehrVte52Odt5PhDrNfRSntGPSXa3q30t67CZRzVR0oCoo
         JVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6O3nF6OsIezS3m94/FyyV74f4w1BQyF9b2ftz/OG11g=;
        b=QNDvEjM/DOZKq5ae+qo3wTPesj5/T9by8nkLSSfkuT30HUk+JkwZlhuyF6GQ49nEzE
         Ix80EsUKqCqPDfNzopH/e8X6Ix4eHt3yjAfTYWxXoOVZoKPn5VIWJbLMDg2/DiutNrnN
         I243b2oFNbmxpRnLcQWLXDNhunstiKKrT2PfoiABH0FY0M20KyAn2RIfYWDogxAxd4u1
         wIUhzUZHG17INc6slCjN++vaVQUe3qhisXHs5lwRbZGfJE7e4kqVVxXaOXszWKqVsbAN
         JaoOdmKWzit+oiJ3nDSvjEzX68STPu/ns+GCm1XKfxNG5/nGxeIWNtJ1ztQJfgDgLVYm
         HQtA==
X-Gm-Message-State: APjAAAWnH1WekNuNfv+Zp9V0bBqTef5d60EopnFcR7x5G022ytGBvViu
        dR9G2/Uh3KPVPAQoR6Q0J/rMxljhrCJxjRIrFyU=
X-Google-Smtp-Source: APXvYqx0K7h6tbDRl+C7T3XrBX8gwsSfp6tP2WE6DpcngUbYzTfI6pPfbkaRk0FBWUCRTaMk0XJuqy8HU08MhXtXY88=
X-Received: by 2002:a9d:6303:: with SMTP id q3mr18030706otk.81.1566332544240;
 Tue, 20 Aug 2019 13:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-6-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:22:13 +0200
Message-ID: <CAFBinCB1fRP8-JaUN4sgwFpinUkQiXvo6COdP54-H9CYkmRKzQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] arm64: dts: meson-gx: fix watchdog compatible
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
> meson-gxbb-nanopi-k2.dt.yaml: watchdog@98d0: compatible:0: 'amlogic,meson-gx-wdt' is not one of ['amlogic,meson-gxbb-wdt']
> meson-gxl-s805x-libretech-ac.dt.yaml: watchdog@98d0: compatible:0: 'amlogic,meson-gx-wdt' is not one of ['amlogic,meson-gxbb-wdt']
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
