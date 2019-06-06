Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8999C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C63206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JfdsVdvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfFFTyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:54:44 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38970 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfFFTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:54:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id m202so2480491oig.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSoI84zbFfjJh+yucOPwxT6kilJj6MAJP+rtvhtzHSI=;
        b=JfdsVdvsUGgY9HlTxARM693KrJ3d3LOhodM05kVM/jqD2yctg/yUCsdNDvltCR/9o2
         bOn0L2jTGRvvPmte2dhpruXCv1vsV6NcePYUNiSH+8NbGnjxW8H+HpNz73Jss8GI7Qen
         cbhhmflFI0OToHaa1Pvq86yQY167iVJTH5audBJA9tVchznxATtih6JS7zzjNbXUffu+
         hkxsrmKCKotcHvUpUJIIUwQqn8kkfCGzpe71UDYrkFq79XBSXjZVyacCoYWvgvlxqekz
         y3TF8Nk0nTFY+cJKspYmD2v0wVA7gpGzQ6h5SgPF0ztjl4i45nc/qPvJrN13fEmGOuJK
         Ae1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSoI84zbFfjJh+yucOPwxT6kilJj6MAJP+rtvhtzHSI=;
        b=Pkha8T9VQtMFcQ94btr42tOys4N7SoaIYFVA78fUH8gyxPatHpowMO35oXrnH4hso+
         ToHn9ZK+g+WHA8cvGaiwuutSyv9OUHUePy9YnQzgtg/OYQe55wkLlKf6xAwiOO7KD8vw
         9ad0YEHgfxT9zdInjyrl3kr6QTZoeOW2GE9IT6mnY16k6HyC5WWTWa+Qyt/UvdJkjIjX
         pN8UlNCyaE6SyiX1hZ85tfMtoS8nrMXWsrCoGv/IxI0Nm4qtaBth9yXBQj0MuuK1pNXX
         0grs8e/1WVS+gv3HP27/itY/4eWq6+EYBf5Vfvbzv+C0mQ79Jpw1Gr9FS2MXaokMD8PW
         4S3Q==
X-Gm-Message-State: APjAAAUhKg8KYKmxL+y50oEa7Fy9eE2/mpFpp1hp9t5fhn7LjLvyUNqO
        iRegmXBkHbr6W5tqHGqen9ZlMScUW1DWqGgL8pI=
X-Google-Smtp-Source: APXvYqyw70dr2fyJDIqlurnAqWsemlv1vzvsRBlsbzDIcPAIal/g3gva1/cOrXlnngTXqo0jEtGlY7jBnw/bVGVCAps=
X-Received: by 2002:aca:4403:: with SMTP id r3mr1320040oia.39.1559850883385;
 Thu, 06 Jun 2019 12:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190603094740.12255-1-narmstrong@baylibre.com> <20190603094740.12255-4-narmstrong@baylibre.com>
In-Reply-To: <20190603094740.12255-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:54:32 +0200
Message-ID: <CAFBinCA0vy2eB+LCVDokeoEkkeu0A1VQQsTFwdBJoh3a6EAyOg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: meson-g12a-sei510: bump bluetooth bus
 speed to 2Mbaud/s
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 11:48 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Setting to 2Mbaud/s is the nominal bus speed for common usages.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I tested with this speed when I updated the meson_uart driver back
then to allow higher baud rates [0]
so I don't see a reason why this shouldn't work


[0] https://patchwork.kernel.org/patch/9517907/
