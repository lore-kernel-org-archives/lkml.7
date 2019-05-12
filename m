Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21C3C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1E4217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0bMqPOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfELQVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 12:21:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40680 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfELQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 12:21:53 -0400
Received: by mail-yw1-f65.google.com with SMTP id 18so8983836ywe.7;
        Sun, 12 May 2019 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TOPJGf99fx0pIuOa+mJLeJHDiEC2gaE8jhCKyZCcUYU=;
        b=D0bMqPOl4KMcE9yx9c0zLUrHutpFINUmjGtVdQwOhcFMKLh1eDITT83+DZ25CEChIx
         cIpD0dEmtcmrdmMP7+LJUsz2vnPcnFDxJy7PBddd0PloInxmr726ei01S8Zdhe6XfYnF
         lUl5GGnR001qDO0aj28ohQF0xpGFNioODJXmbpwJC/FNx+5dzMcopw+pc08esWoFURTo
         Ep3XnGSXfyYhBm6gdDhrtm15nBQ/P4d1+scTJd5ob+uQHF/5VK+RZCCY1WbbFDfouSug
         +VQFps53+03j7moT7D60lkq62vF6DdyZ1FkWnaZjQdQjhQSPYirAdgenuHBKT+6zYDkC
         H29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TOPJGf99fx0pIuOa+mJLeJHDiEC2gaE8jhCKyZCcUYU=;
        b=ZwMqniyRhVTbOJHwzQnyPDRUcghYORVxIiV3cJT4Dv5bvNfUtydERhXrkfTIp56F5+
         MRHDX3h7sAWsFyZVhotYa8vv6TTJZM6hBoDw82WmZc3vDJ0/6Bz1ceZBTa9W1KaqN3cu
         RBwXEblF8uwmOcC7otRwommb4Avg7sLv85ELbvpwThn87RP2MsXR6KZ4OlbmtWIZF5ig
         QFOx6l7D3gF+4NgC5471eOfO6lbnYWHRtumg9Tj51OJ3uspEgyfo/fSoUbqMzqQBihu9
         XthmedUKDfqRtKYoodMSKEHEz78Xtfzpta+j+dinKeazQU+iDNYgoaQOPAzyBh/EvX6X
         scIw==
X-Gm-Message-State: APjAAAXw+XwhK44ju9GnxJzkx9/PVR7W2yC1/FdiPDhJiWZfYpBRjL8p
        jeyXU7wjW0n+wbyaCygfTacYvFODGFc0bpKYmTQ=
X-Google-Smtp-Source: APXvYqwtIuH+K3gJStYpXRvCVBSpG8W4+socFkjdKI35G3vVDr7miYiNKjYklCbALO9LrhbwRk7Vf60kj7nVrDXDyTg=
X-Received: by 2002:a25:e89:: with SMTP id 131mr10899859ybo.416.1557678112340;
 Sun, 12 May 2019 09:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190417173031.9920-1-peron.clem@gmail.com> <CAJiuCccu_wfgio9wUcOCP0o4XPRgQOvTOZS8St7mV88TAdwaRg@mail.gmail.com>
 <20190512134509.vcduqbkmnvpkbmkb@flea>
In-Reply-To: <20190512134509.vcduqbkmnvpkbmkb@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 12 May 2019 18:21:41 +0200
Message-ID: <CAJiuCcdE5rvOicAKSGBKPgJ7Q1LVV2aKZobhZXtTJ8Jufr=C8A@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Allwinner H6 Mali GPU support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 May 2019 at 15:45, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Sat, May 11, 2019 at 06:39:39PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Maxime,
> >
> > Is this series ok for you ?
>
> I'm not the maintainer of that binding, so I'd need a ack from whoever
> that is.

Indeed, I will collect Rob H. reviewed and resent with the correct maintain=
er.

Regards,
Clement

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
