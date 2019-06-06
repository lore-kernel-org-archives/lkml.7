Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B564DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8124F206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cDwW5mVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfFFTqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:46:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33428 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFFTqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:46:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id p4so3154486oti.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apUohLJFv/6Ma/Odfu3BrkIEtoUfH61u2PuyTYCjZvg=;
        b=cDwW5mVxP7Q24RCc61BUOR351XLtcuEjXUZ7l9Ld7d3UHg41U+1qXkEQo+teFO44dz
         yZzd1PdPcO9KwpNAb/sS6ffMLzFXONJlcmsefoynlVfYz4hUj5vJ5+cV44K1qSbYGNon
         6h1s4WbmNEbGRDArcdHt90ob0/uiy9PyvfeWa+BDgQaETs4Nl7ELIoIrPCETOqHKzAuE
         KK55l2jvoxIsFGCJf15SEF0og2a1Lx0nRYgbMd40AbR9BDbt3U3wnYipVG1vZ8JoghQJ
         Wz4Gs6D9OyYlKfWLETUIS6lXzqAxp7MaJvctWLXmERLXDjk/U7wru/46ez1NrafI/ghJ
         /QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apUohLJFv/6Ma/Odfu3BrkIEtoUfH61u2PuyTYCjZvg=;
        b=CEFYs40z+OJKUYonHYTyuwIdY0zzd5NfRitDSlNMMZaEJdlRoETmoMxpQPV2/nfLXS
         2yJ+jnsky3zkq5m8BNLrJ9VBSaq1FLvusaLP6sOcWtlUxhgPrsFsLByLauDom6tF+w41
         8F8YsKctrzCfGmFX39ce1N1yzkO3j9NaCK+kIvqzDWi08UvDRXPvZU3WsGG8Fa8xIf3k
         QWzGfLkScqETebUICvmH4sbrgWlUc+N48EiOLJX+HF72FqR+N4wf93o1tCTZnsTTHGtW
         68ZnrTxEbRbrzi7ReY8PIB+MLl+F9wy1n1Znqzp+v+ucrjOySvffvVH4AeBskSwNdKhl
         S+5w==
X-Gm-Message-State: APjAAAWusmNMlKkKCBaUpzALhi4Kq8kZSeNfl1RuaGhBQWoaCfXvXmuX
        i66HbePcb6InIB8VHOpRUoB2wNjw7mzskt/cSCo=
X-Google-Smtp-Source: APXvYqyEecKKROAJgJ0f1bUKxcE/zJpLbenKfwbAR5m1rOjlR1UHNjL8uTKGU/flEXz51JoivrypOyNQGFv7rtlwHLI=
X-Received: by 2002:a9d:6d8d:: with SMTP id x13mr15661176otp.6.1559850397104;
 Thu, 06 Jun 2019 12:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190603100357.16799-1-narmstrong@baylibre.com> <20190603100357.16799-5-narmstrong@baylibre.com>
In-Reply-To: <20190603100357.16799-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:46:26 +0200
Message-ID: <CAFBinCAJUjwnLgqAxykpvZkeENENaJP4KT0hEje2yV=4Yutu2Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: meson-g12a-sei510: Enable Wifi SDIO module
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jun 3, 2019 at 12:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The SEI510 embeds an AP6398S SDIO module, let's add the
> corresponding SDIO, PWM clock and mmc-pwrseq nodes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the comment below addressed:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +&pwm_ef {
> +       status = "okay";
> +       pinctrl-0 = <&pwm_e_pins>;
> +       pinctrl-names = "default";
> +};
on the other boards we list the input clock explicitly here (I assume
to avoid jitter due to a less precise parent which may be the chip
default or set by the bootloader)
