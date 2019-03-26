Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6360C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8979C206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ohkc212Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfCZSqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:46:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41783 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731755AbfCZSqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:46:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so12084586lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/3OBAKAOSO/1AIbYk5hXO8vRD4tZbOgI5tqSvL0l7U=;
        b=ohkc212Z0MDOWMPvd2KYwtXD7YLmxpPPxtlSRClo8I8cN3Dca36DbP7x2tVo2J6ZfX
         diU5jBi5juJXNVvFqyL19nSjySh7zbIKt/QhOi0tgstxsHmbMfSaaGQwTWmBTPlk6+FL
         S93E58jVWyHh2p+2MbofNoE5lgtzx6WuSmu2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/3OBAKAOSO/1AIbYk5hXO8vRD4tZbOgI5tqSvL0l7U=;
        b=Q9pWa5lIvQ9O081ee+DL7BvSzdXa+GPP4Fla8vu5QajsqeH73vfMcNAL7BBCeX7nKt
         tlGnZN7m3GXy1uho7WKQHO5BEk5o4ThO8kezS729P2m2bVzn7VPxSs4jVgi/Ng4ogSSS
         xg5Gkt67rqkCT4i1dKr/NcNDWmwv71+noQP/x6j/QjhyaHh/V5wn6bpIVtCDjy6EKMZU
         5+a4HCcNct4ZwIL7xs5aW7XzS9b9UAMKwy3xIlGtYvAnCF8fETRNOvjk7sdieBRldCI6
         vVPAKhBC5v4ANIkLCAcau4HoPEbJ6x3hbdanjfHcKKguqoZxkCOBajqtHHSY08IN+cje
         psGw==
X-Gm-Message-State: APjAAAWbyvCvSWmOyYqJw2/n3YlW3SvROgic4A75+QopbNO00iMUSopJ
        DjpSGSojet0WjNtLoJglwzGTHXyZUyw=
X-Google-Smtp-Source: APXvYqzqxzWjnwkpQj7T8lYHScL0DwVDQCqM0RawWqGhRg4nQwjHDF46ncUA/GfWUUIpcPYS8JA08w==
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr17273618ljr.101.1553625974238;
        Tue, 26 Mar 2019 11:46:14 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a7sm2631190lfo.8.2019.03.26.11.46.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:46:11 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d18so9481082lfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:46:10 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr17028560lfn.139.1553625970009;
 Tue, 26 Mar 2019 11:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190222225345.69084-1-briannorris@chromium.org>
 <C908FF06-43F1-4A5C-B80F-0982315DDB6A@holtmann.org> <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
In-Reply-To: <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Mar 2019 11:45:57 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com>
Message-ID: <CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible properties
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 1:34 PM Brian Norris <briannorris@chromium.org> wrote:
> On Tue, Feb 26, 2019 at 11:53 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > all 3 patches have been applied to bluetooth-next tree.
>
> Thanks! I failed to repeat my comment from v1:
>
> """
> This patch is also required to make this stable, but since it's not
> really tied to the device tree, and it's an existing bug, I sent it
> separately:
>
>   https://lore.kernel.org/patchwork/patch/1044896/
>   Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
> """
>
> Can you take this one too? Otherwise Scarlet will be less stable
> (possible interrupt storm at boot).

Ping? RK3399/Scarlet is currently in bad shape on v5.1-rc2, since it
doesn't have the interrupt storm fix.

I'll ping on that patch directly too.

Brian
