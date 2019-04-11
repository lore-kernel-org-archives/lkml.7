Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0A42184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWrTZ9Tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDKMqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:46:05 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35934 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:46:05 -0400
Received: by mail-yw1-f68.google.com with SMTP id u197so1998984ywf.3;
        Thu, 11 Apr 2019 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SRH3hwlIqDwS4sqOoUzpqCkc6msvHxF8eJTXUFgjC74=;
        b=AWrTZ9TuOgRRycR9kOM0YvsgeqyF8RhUvqzq06cm1cxA+dTsGBo6576aq6jywCVOrN
         Uv+nKicEyI/tCzUP6YEvzE1TTrYN25Y5lc5tVtU3i9pqVYG39/NlM4PgDx1geZCYyV1R
         Qguyqz5vT+AvTlEFK5ui52DKWnAL3Q0cAyttpO0dlvSXielfA1R4TWmjQ1mBWo2jWw8W
         o7Yanh3MPH7DGQHBf2MEKk6kOPTzBOI+BYAVQ5YPXm7sWKDSINOM5VDDWaKvx6o1k6KE
         ORIYw7aVsZPx1GX25X+qrCN6MEa2HlT+bq3Ojdh8odn2+EzMFRxvY7Vqg6ROskdul6BX
         QW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SRH3hwlIqDwS4sqOoUzpqCkc6msvHxF8eJTXUFgjC74=;
        b=VNh+uaPV9zQhUWJ2LOIsUaccqFnHA+DWe2K793gX1CAkj/7YBrDSWsirlvsTeuf/jN
         wRfkK5ldVBkhx+jw/IFOA4upPcJ5np/u7Y4OEbLVBb7q5SHlzsfn8339zQMOw/zCey6L
         DzruHw3RLkGkcMqBG0SnxmqVz74CwcCenmyRd3Tb1JtiAkTcqXtSJS1TMoqqkZVHSNZt
         GVCUfV0wZVxxSdZuXd4GqWtc0/Rp90tqQC/TUeJZswc+4Hxgs8wlRMEkA/+yKTdOI9C8
         gVbRSn60ctaEuxA+DnuJZ6xf8LXVs/n56Lx0/1YagNHRIOIr/5hbq3zJMrt7dKRccfYz
         bVfg==
X-Gm-Message-State: APjAAAVtZhQWi7RR7DzzmTJdseUDqp10+8Oa6DIbG+AlR+8uIbgwsRA5
        nvP204oJ1D9neoT5fy/Ff54l339J1B0GLA/E7AM=
X-Google-Smtp-Source: APXvYqzrsvdwVNXYIPC/rIZdGpkTMj2VmKmxK+6IMiDqVmqKxxYSz8nSnDcoLQq49R1I6HcaOZzfRbjiZIHSn8+U+u0=
X-Received: by 2002:a0d:d645:: with SMTP id y66mr39835675ywd.459.1554986764268;
 Thu, 11 Apr 2019 05:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190411105720.32357-1-peron.clem@gmail.com> <20190411105720.32357-3-peron.clem@gmail.com>
 <20190411123055.bpriih42puliuzoy@flea>
In-Reply-To: <20190411123055.bpriih42puliuzoy@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 11 Apr 2019 14:45:00 +0200
Message-ID: <CAJiuCce5zAWKSxxWA0HPBB+-+ik0A13mt2mrUcEOT4ZymmmDCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: gpu: add bus clock for Mali Midgard GPUs
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Apr 2019 at 14:30, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Thu, Apr 11, 2019 at 12:57:14PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Some SoCs adds a bus clock gate to the Mali Midgard GPU.
> >
> > Add the binding for the bus clock.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> I'm not quite sure what you did there. If Icenowy is the author and
> you're sending that commit on her behalf, then she should have the
> authorship of that commit.

Indeed bad cherry pick, I will change the author sorry for that.

Cl=C3=A9ment

>
> If you're the author of that commit, then we Icenowy's SoB is there?
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
