Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12CDC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A343218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lmvTjVwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGCAsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:48:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44052 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfGCAsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:48:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id e189so557776oib.11;
        Tue, 02 Jul 2019 17:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shrSfUwHshC6sDZVTcq5ngfnPqY1USStRpRTR6d5/f4=;
        b=lmvTjVwxjRh4Poos3bVw/z29gyQ1LGWYW0KqBZyVQvzT1PBsRnK0gmc9Zw/FBp3J/z
         gG598+ah1lKIeOfGbKJRPIBTXmnJQ3wIxESOvWVHkDzesEaRCYDWTbQ6lzUbTE9j1IJk
         gqn4Y0DmySt7CS16WjFn4VmuamxVoDZhZ1PacqijL6nhTRujhRYeVWgyKNkrGobDiW6N
         +cCTPD4P34GuKqScCOsy6Ogm9IwWX+KgPxPuKfLXjZUmfJ36lDupDavpFSHgz+LAAYre
         zgN8hVD9NU38Q071uVi4UmGwyz2urWqeFiunyhsfh9OiicQBezQxKjuioROMMbXuydE8
         BSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shrSfUwHshC6sDZVTcq5ngfnPqY1USStRpRTR6d5/f4=;
        b=R2IUyNjTeGfwAUjV1hSdoO45muEtCkYW5PAT7lSdBedsWbRlkzRXA6GS2w4HjuV5cn
         tXoB9Zul/C711SqnTmaqQlsLKoxjAgMQ790RmY7WRyq1aZzuyQL5VflTBlaCcX1RuWlT
         lA+uGSuvC5cradPNOadIpoGZU+78tvP32XrFftds+lR7KMrER/DCBlZHqfupAaHi1SOB
         V1nkGiF+jml/t0ICTjxI2pXMvj/DNKvTFUXUd/rUU+qwFm+rEWQIN3H+htanC/4+aQj6
         +D90x4LeY2geKrYIf9LGSOLOhcvmMU/jlrhNOu70PkL8qglAhc9SZSkPTku4zGoYkNVz
         JBTA==
X-Gm-Message-State: APjAAAUHgnn4u+AuPGZ3wceTwfENm/b5pEuCBIzFclx1s3PGcNDz0hpn
        iIhPQgcMLZsGOVu5nlUUZ2PpHTaGXLZTGRDO84+Atg==
X-Google-Smtp-Source: APXvYqxgfcCHQv29gahaHjuPAS935zYySIUIEmD84h/Qr8o2D6W2Oc0WdHuOFDE2zlTwLAMbXKovNv8vmOyrgdfawlI=
X-Received: by 2002:a05:6808:3d6:: with SMTP id o22mr4652939oie.140.1562111682243;
 Tue, 02 Jul 2019 16:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-10-narmstrong@baylibre.com>
In-Reply-To: <20190701091258.3870-10-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 01:54:31 +0200
Message-ID: <CAFBinCA537EV9kzz+5syaF1Q-stTJ4no+NBdcYD3QL-FJSoWfQ@mail.gmail.com>
Subject: Re: [RFC/RFT v3 09/14] arm64: dts: move common G12A & G12B modes to meson-g12-common.dtsi
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jul 1, 2019 at 11:13 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> To simplify the representation of differences betweem the G12A and G12B
> SoCs, move the common nodes into a meson-g12-common.dtsi file and
> express the CPU nodes and differences in meson-g12a.dtsi and meson-g12b.dtsi.
>
> This separation will help for DVFS and future Amlogic SM1 Family support.
>
> The sd_emmc_a quirk is added in the g12a/g12b since since it's already
> known the sd_emmc_a controller is fixed in the next SM1 SoC family.
too bad they named the upcoming SoC family SM1

does it make sense to name this file "meson-g12a-g12b-sm1-common.dtsi" instead?
do you know whether there will be a successor to G12B and what it's
code-name will be?


Martin
