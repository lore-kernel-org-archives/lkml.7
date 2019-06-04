Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3F9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA8924C4F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfFDHkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:40:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38234 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfFDHkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:40:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id g13so30610871edu.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPZoKEpxMdZA3Cy+DOvZz+UKiVos8Da/MXX9dJMPwts=;
        b=ar1aop51lklQTJMXPRqeTmOrbTHhBn5d+MXn3wr2/lUPl8HzSWGTQmbDy4CYHrBpfW
         Z773yNnc5wWQCeULUVWZpRccg6sXp/P6DD6eG//1odHiGMEsEXapmJ++I3gY85yz7ZS8
         Vax2iXfBuKh8GtrEfofEJRHPKZEm6TA36yJAsntZxjY2rAMDHOfFzcJR6niEKSt8wHkY
         YPllgTgb8maSJ+/ygo1Z77L6ZVCVN4zK3JwFX1NK5I8mhgdKNi/OCOGbvLiwnqLHSK05
         ojbzQYuAdpvzpFC29VFr+/kO6f1357RaYxI/k/XYyzDp5HEEWGHjGcZXHYPpQc41/BS2
         j3zQ==
X-Gm-Message-State: APjAAAUod0gyHUc4jpjQBNfivbhB6rprtEHU/LyAnk5dFn1gRtsy3hSl
        rlVei7VhjmSyA+799rsP5KMD4LQlh+I=
X-Google-Smtp-Source: APXvYqzMRgtseuYn92ekhWx33fOIS+thpuEgbN4LcPNubaxExICaA2vRQn7TZ8aO+b58pVuZvIBBWw==
X-Received: by 2002:a50:f599:: with SMTP id u25mr152890edm.195.1559633998207;
        Tue, 04 Jun 2019 00:39:58 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id u5sm3008717ejm.85.2019.06.04.00.39.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:39:57 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id b18so14631654wrq.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:39:56 -0700 (PDT)
X-Received: by 2002:a5d:4311:: with SMTP id h17mr19701241wrq.9.1559633996367;
 Tue, 04 Jun 2019 00:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-3-codekipper@gmail.com>
 <20190604073651.gst57ki7ohzxcrqz@flea>
In-Reply-To: <20190604073651.gst57ki7ohzxcrqz@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Jun 2019 15:39:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ch3F23q-SSxU01Mvkt-x8LL5HfwnZb4NdJcMMkN2H+w@mail.gmail.com>
Message-ID: <CAGb2v67ch3F23q-SSxU01Mvkt-x8LL5HfwnZb4NdJcMMkN2H+w@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v4 2/9] ASoC: sun4i-i2s: Add offset to
 RX channel select
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Code Kipper <codekipper@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 3:37 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Jun 03, 2019 at 07:47:28PM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Whilst testing the capture functionality of the i2s on the newer
> > SoCs it was noticed that the recording was somewhat distorted.
> > This was due to the offset not being set correctly on the receiver
> > side.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Would be nice to have

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")

But otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
