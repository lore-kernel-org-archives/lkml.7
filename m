Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AD0C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6B9218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SZYkkOWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfDWW04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:26:56 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37856 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWW04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:26:56 -0400
Received: by mail-ua1-f65.google.com with SMTP id l17so5362566uar.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3dRxb4+p4g2+xMx/df+eeyt/t3JS/j5BzYyaZ+/lz0=;
        b=SZYkkOWbZNPbyxO1aa7sn+5EvT5VUU340a/F0GOMe6bxbDUoAvl8HIw7TjQKYG6+Fq
         IF0JNIdHBzIbwop2/o3FkPxPcPzl+gleauddn+opfBC85inKDq8tMN0FVHTY8Dw0le+f
         yLBVwNWC0KzcWyhAqScfz8ykY0aCpqxYBRIio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3dRxb4+p4g2+xMx/df+eeyt/t3JS/j5BzYyaZ+/lz0=;
        b=pUEoE3dJ6SINuohja1ar2vHihGcow5z8Q7DC2VK+uZ11vwtqVXzq2ScsNvttX5WsfD
         d2q0UNbMoqAWxdnCe+MTkUhGtG7PcD+cGvDuw3Lhs5DVzhAsQfGm7LI2Z8L+0mzqPXC5
         mO/ChbamxT7ngfCrYXNk+57yxMVewPqfOkC6M6LIgthV9Wu1oY95Ru/1zOlEDGisEAgT
         cBZAeu2OonfbiX/vuXZzYs/PTb0xYd5I5ATajoVCIeyrelVN7q5QMYxrlFoVaOlWTo/p
         wrp7gxXpX331zdEDvtSNsX2FFumpCsQsJK0Irt1EEe4Tu6SVqyANhk7+WFVASfRaktbY
         MnaQ==
X-Gm-Message-State: APjAAAXhFKVrSas+RfLYGUop+/r2mcXxQ1H8QeAw/boSW9pJYrwpAjiq
        Pn3BCrenR3HOZNlR9bTW1QV1KcAsjfI=
X-Google-Smtp-Source: APXvYqyaiy05oxq5WwucDCAKtaPQlfAO0wSNyM87XpuSJfAzMPNVoJdKWD0JG5TObph5xZZ+84Uf/w==
X-Received: by 2002:a9f:2c09:: with SMTP id r9mr12959409uaj.56.1556058414987;
        Tue, 23 Apr 2019 15:26:54 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id g123sm4386560vsd.6.2019.04.23.15.26.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:26:54 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id 33so670746uay.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:26:54 -0700 (PDT)
X-Received: by 2002:ab0:2692:: with SMTP id t18mr14866033uao.106.1556058413653;
 Tue, 23 Apr 2019 15:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180910163932.13722-1-katsuhiro@katsuster.net>
In-Reply-To: <20180910163932.13722-1-katsuhiro@katsuster.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Apr 2019 15:26:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com>
Message-ID: <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM attribute
To:     stable@vger.kernel.org
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Urja Rannikko <urjaman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sep 10, 2018 at 4:39 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
>
> This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  sound/soc/rockchip/rockchip_pcm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I just tracked down that audio was broken on 4.19 and needs this
change to work.  Stable: can you please pick it?  Specifically I
believe you'd want to treat it as if it had:

Fixes: 75b31192fe6a ("ASoC: rockchip: add config for rockchip
dmaengine pcm register")


-Doug
