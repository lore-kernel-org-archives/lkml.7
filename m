Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6675AC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A78206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hV6Sv9HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLXLXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:23:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40209 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXLXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:23:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id b8so17710912edx.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 03:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c47JlWEDIhN2S2u1wxTqqESFzvVYGhPlp0cUwZlGkVY=;
        b=hV6Sv9HYva9wtb8hp6tNO6tvePcODpHmJZu/VUzADMIq7e1lydd4AIQm5QcNgB8QLH
         1h+gGHLMQV+DC93LLBNgu5GAcaNfeOYim8qnsSVtJUOBuN5Hcmf3dlduNlw31nhQTYxs
         osdHml8BruM08yn80dRcRPGWfGicWKVsHl0QUj5Iq7BUC/0x0x5AZg+Xs5N3AaEG5l0e
         1hgTzroXNUUC/XTQAcz+7jatKQAUGqM5BqvFRiXGZPRKK0M2gIvP27m5xjBtoCJLxJFT
         S0aFgzHrxoKwh8kAkkC1Q8gr7awSD4Q8qA2B0IdA43b9YkQFPkFIvnRPc7PXIo7w9TXJ
         bfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c47JlWEDIhN2S2u1wxTqqESFzvVYGhPlp0cUwZlGkVY=;
        b=LJYIcqFzE5upCqD9PJewSz4JdC3+IPYdAT/qdrl0B8TyTx1miFugiw8gRvL+8SARVf
         terLGciv0LAaVEy+ObOEfs/+t3sFa8RFmZsSsFyCJoJAFBxS2Nmla14/DOxKPxST9Io8
         yR/8Qv0reWCGBaq+M/LTWc5ZNJf0U4zcK8qrBlrAPWcUBQrDNxU8cJ7dN6DG2FChJkf9
         73Vxo+YpxFJZXVHXaMp/nKynDt3owd7EFACxk6ftJikTOC234X7v8eW9HT9g/bGdl9Pu
         RSOgBGdf9H7XMSViS3Z6/PWMl3hVC4ydfMGGa+4xIlZlZMG7ZuIAhi2RPEpudORHH9cd
         kkUw==
X-Gm-Message-State: APjAAAWWvsf8Rb0ZXo1ZBt+HSl6jXOy+u6HJ7boINfWWui0CboKv2mgr
        tp1rGsDfOiVSXRSeYPnQbZK5elH7iuW+mJqmbaY=
X-Google-Smtp-Source: APXvYqwD+JCN10hMA2DFib/zOkIvt8olsyADG5yMRQAnRIpVdhoobkX+Lq9zRK7zOH1PNOCsg/qoxPJQkum6XaM3KOE=
X-Received: by 2002:a17:906:339a:: with SMTP id v26mr37490223eja.2.1577186586030;
 Tue, 24 Dec 2019 03:23:06 -0800 (PST)
MIME-Version: 1.0
References: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com> <CAGb2v6528SUOyefhsnjEwG7vfud3+Ce+_=CM3cM4vKiRcmNXAA@mail.gmail.com>
In-Reply-To: <CAGb2v6528SUOyefhsnjEwG7vfud3+Ce+_=CM3cM4vKiRcmNXAA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Dec 2019 12:22:55 +0100
Message-ID: <CAFBinCBTL05FLiZfBGdGCdq2JZ-_W_zDYKP_nrrUs-YEwaHCfg@mail.gmail.com>
Subject: Re: [RFC v1 0/1] drm: lima: devfreq and cooling device support
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     yuq825@gmail.com, dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 4:03 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Dec 16, 2019 at 5:12 AM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > This is my attempt at adding devfreq (and cooling device) support to
> > the lima driver.
> > I didn't have much time to do in-depth testing. However, I'm sending
> > this out early because there are many SoCs with Mali-400/450 GPU so
> > I want to avoid duplicating the work with somebody else.
> >
> > The code is derived from panfrost_devfreq.c which is why I kept the
> > Collabora copyright in lima_devfreq.c. Please let me know if I should
> > drop this or how I can make it more clear that I "borrowed" the code
> > from panfrost.
>
> I think it's more common to have separate copyright notices. First you
> have yours, then a second paragraph stating the code is derived from
> foo, and then attach the copyright statements for foo.
thank you for the hint!
I found other examples that do it like this, so I'll update it.


Martin
