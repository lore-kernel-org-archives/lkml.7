Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2155EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E8F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTpW9Gwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDKPkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:40:18 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46044 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:40:18 -0400
Received: by mail-yb1-f195.google.com with SMTP id b18so2359989yba.12;
        Thu, 11 Apr 2019 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cF1jjFvP25+o5tN84Fs2llTlGkKHSHXqcfY4yh3biAA=;
        b=pTpW9GwnPk960M1BzjNq2Ar36izlcXug95LcA/eCSZUoRSCxe9NtG2v1JDdTMmOVBs
         QIThHbUV1wZhhAPfG1uuokjEnHVBMDbtKYd6kovWKmd0GnlQDZ9smkMXNelC9A07Zn+1
         XkHh/uYRl/iac5YaWG57v6gLlYlbxWVJI1SwIzXV1l2Qxsm+/gUfUzwxH94dCMu1Ex5e
         AGKE6m6aVsR+CEmJPf/s+RoYcQTwX3LV9vJY1HBDlPejManYkp2B0RBKX20DBgyzfuOz
         50vJeuegSOBjjNrLgm/pgvrp8d2yUwfWc21PQTGAizxh276MkqkAK1dQUP7ysVTi5fG0
         aKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cF1jjFvP25+o5tN84Fs2llTlGkKHSHXqcfY4yh3biAA=;
        b=A6S0BZjdZQ6F6dqLWXZMgEAdX2bRLEn7DbbgikQad0VQoIBzw1pc5BZtxgFA19+jLN
         C6fiTKtW+AaTJaocCYaNQ8dCkLcx/gXOohcQhQv4rBkTTIqrl06PYQEeFX+YozWwRUtH
         ge6wOPkxe0og+cifZA0fJderoDR9QlEYujbzADXirv0n+JAcYsDwCmoL4BOz+IAHtCOF
         ijXuA4T+L18HdS0OJchtMzJlcQslBFZNHFubIYRlTbjJHCVq194tA1cgq07Xk7RQQVT7
         z3XXQCAIAYEik6W0a/a0wX2LiZfGwxAzJC8j0eRBPHZUCcN3+Hr9YcnO0z6WufBObZ2m
         KqOg==
X-Gm-Message-State: APjAAAX7NW1zg7ucIxVxauN0Rj4hqMFh+F5kbEoP351dKpq8+nT907uJ
        IRrEmN6l+P6IxaT/nWRZkMgdAYFb7VxqBa3flmA=
X-Google-Smtp-Source: APXvYqwbcLfvws37IGUDXbotLsIcw+0zoQ8hfyZ+5qH8r0DqOyEZdIjmYJJTVLj0qlxyxcAGStx4iRA6nBWgEQQx4hs=
X-Received: by 2002:a25:ba87:: with SMTP id s7mr41146604ybg.49.1554997217306;
 Thu, 11 Apr 2019 08:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190411154534.25563-1-peron.clem@gmail.com>
In-Reply-To: <20190411154534.25563-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 11 Apr 2019 17:39:53 +0200
Message-ID: <CAJiuCcevrDNcPiwjG7nciig64OHp0P2e-k+CTXo+7gGEfMm8oA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add Watchdog for H6
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@googlegroups.com,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 17:34, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi,
>
> Allwinner H6 SoC has two watchdogs. The documented watchdog is identicaly
> the same reading the user manual as the one used in the A64.
>
> After investigation it seems that on some SoC the first watchdog doesn't
> make the board reboot.
> Some tests has been performed and it seems that first H6 version aren't
> affected only the latest one.
>
> Chen-Yu Tsai's boards:
> Pine H64 - H6 V200-AWIN H6448BA 7782 =3D> OK
> OrangePi Lite 2 - H6 V200-AWIN H8068BA 61C2 =3D> KO
>
> Cl=C3=A9ment P=C3=A9ron's board:
> Beelink GS1 - H6 V200-AWIN H7309BA 6842 =3D> KO
>
> I think it could good to add it with a comment anyway.
> In case a user want to activate it and isn't aware of this issue.
>
> The r_watchdog is still available and usable on all the H6 boards.

Changes since v1:
 - Use A64 compatible instead of H6
 - Remove dt-bindings patch
 - Change watchdog status to disabled
 - Add r_watchdog node patch
 - Add enable sunxi watchdog patch

>
> Thanks,
> Cl=C3=A9ment
>
> Cl=C3=A9ment P=C3=A9ron (3):
>   arm64: dts: allwinner: h6: add watchdog node
>   arm64: dts: allwinner: h6: add r_watchog node
>   arm64: defconfig: Enable Sunxi watchdog
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 16 ++++++++++++++++
>  arch/arm64/configs/defconfig                 |  1 +
>  2 files changed, 17 insertions(+)
>
> --
> 2.17.1
>
