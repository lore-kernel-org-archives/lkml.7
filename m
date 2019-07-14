Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D1CC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC32063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYJafSEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfGNOap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 10:30:45 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46418 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfGNOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:30:44 -0400
Received: by mail-yw1-f68.google.com with SMTP id z197so6547120ywd.13;
        Sun, 14 Jul 2019 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d5mqB63T7VQxnr0JfX26P6/C4LWvV7mWWntLD2fXgbE=;
        b=AYJafSEPhM/ocLLBM9px4DWNUxcCKOpaKC6BzkrYXlj9j8PVXdRPucbgCmSh3KkwJO
         baM6OrxXg6UPAowsdXF0bYHuFtafb0U1bFOwRVnh+rsnIsxfbc2nj3Um2wA+OmFdDmXe
         jOaUpSyvJkSDs34sVnCmqBMDdG1C2LTADouY/W8lbrkC7jvUHvZGkZMcvno0lNXEGAzu
         G89WVJ99b8Gf8ByHByyw0jyYg7AxLlynETbERhDAwbAuMR4mM9R+knx/SaAYfsXZpXtw
         a+7z4F5ukfh1gsVAeLeHwR2C1gt2ZzACBBKOOnIJTvvMehPd+AheJv5Qhv3oveXzF5Ti
         cviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d5mqB63T7VQxnr0JfX26P6/C4LWvV7mWWntLD2fXgbE=;
        b=QZwJgvtuMdWo70ZIpqR+wpTDhmLtYppWy6Ms/3eR6dTq/MnfB/mcU+PrpT33Hj2Kai
         ol5BhsNdkYPWniGHb5cxKH1387yQlkzXOC5Tz2E8bvoAfAW5BuwvihSV3jyrMwqM4N5Y
         0twvPYZ+fKjPmBJ0U1ffFOG3FU0/77aO4lDEjZJK6ZWTn6S6zRXtA/g/qXfLuaXXix6F
         PtTJzqAFhuQNtkZ191Sh0RvZWtkDdtvV5+/3jLwfUpuThDM/LR/X6p6dWb4+FAKqvSlJ
         LsGycVXvvplQpC4cu6D949EGpxpZADVxeDH+fqh6k/Asau3/mLmt6mBios1v7TRaqWHr
         hpiQ==
X-Gm-Message-State: APjAAAWSRtKmwNm5hi4yhZYMlfjwlEq5+vsDmGIMblGHhQTeMcbqg9BL
        xXS4sR/vw6Hg0HH5lfOxAq65waPXnxuVvdZBHcQ=
X-Google-Smtp-Source: APXvYqyAEODGBECOlWYTv7vWNRPdwzvdVek9wXMbMZt1+F4UmDCEa/VIJ5KPJSkG6Kxsg5Yi0ej8vU9LwZ2zY8NvmhU=
X-Received: by 2002:a81:494f:: with SMTP id w76mr12006714ywa.21.1563114643583;
 Sun, 14 Jul 2019 07:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190607231100.5894-1-peron.clem@gmail.com> <20190607231100.5894-5-peron.clem@gmail.com>
 <20190610095243.7xwp4xhauds22qzw@flea>
In-Reply-To: <20190610095243.7xwp4xhauds22qzw@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 14 Jul 2019 16:32:22 +0200
Message-ID: <CAJiuCcfyjGTBbsjZQYj2p3KD6O-WaXhFe5NZrnKQwJYACmatUw@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] media: rc: sunxi: Add RXSTA bits definition
To:     Sean Young <sean@mess.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

You acked the whole v3 series but this patch has been introduced in v5
could you ack this one too?

Thanks,
Cl=C3=A9ment




On Mon, 10 Jun 2019 at 11:52, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Sat, Jun 08, 2019 at 01:10:51AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > We are using RXINT bits definition when looking at RXSTA register.
> >
> > These bits are equal but it's not really proper.
> >
> > Introduce the RXSTA bits and use them to have coherency.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
