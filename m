Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2936C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7A9208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8HMkD1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfFURcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:32:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38240 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFURcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:32:03 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so2549991ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=x0w0cICqmKMHbqMi3TqTJo/d6Opn22c9DRuCkjr5CKM=;
        b=l8HMkD1dRulhfDkq5w4c4pNGnTo2f0drZAn2TA7/ulWSn4SEEVCjvhfjE9a7s0Q8mG
         XVoeWrkG8EwD94uhco+flGFOYkoAU+M8dU8wSqv4+EuwT9LfetuuhKL1dAoGUecN+3fL
         jUwadaN55cnpbP8X8g9D/RSzSMel66BWTgc9DfQHImMzMiE6hnm2x3G+PBwU2vN4kS8V
         COSml29XhDuV5Qqh/PAC9T+Eup5CnbND93l3iOjASRwlaW9Pfgm42Cb8TKd32l3bkAXO
         QZaOTeFXicL4Ml4zygN8ndvJToZAGXvAzIYvTKB7La/y/JmVwov9ySUMFcPOwjIvEVcN
         XTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=x0w0cICqmKMHbqMi3TqTJo/d6Opn22c9DRuCkjr5CKM=;
        b=WIwF7BUZ/duoXfIPeOr1ELV0PAWA/rFmOhSngZPG/RUVhlUHvxx5JtfAVI1/S42z59
         oAa67OVmtznO2qDyC9syNGsS4pJGVFqpoV18M9/+AzAlSN2mbHx9C4X9WprV0MD5Yr0I
         o5/Arh+LYvkG93xy1w05UIkTL3SlrD9notEOJ6RTQo2SWn7vTbOFLxkxadbrauRkz6TQ
         voTdJD64OqB0WHtM59c+IAGQlipOSlmXGVFMh0gbL9HRJ5vLtTAadWgRscoCpmfVEvTI
         EhDIgBjuLVG/GfNYWfVQnfjmchsYXrgq+dYnbQwdzqGbIevZwcXLTQsVr0yKxj57GtTw
         5R4w==
X-Gm-Message-State: APjAAAWY0HxF/CloGJCbaLEEBi742aZRSb5flrZfdHu4Wy30SAcHN6aX
        UvIyzioG3OBXv4l6il/seLuStop5BzVl5vs3PTI=
X-Received: by 2002:a02:b10b:: with SMTP id r11mt884598jah.140.1561138323173;
 Fri, 21 Jun 2019 10:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190614185547.34518-1-jeffrey.l.hugo@gmail.com>
In-Reply-To: <20190614185547.34518-1-jeffrey.l.hugo@gmail.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Fri, 21 Jun 2019 11:31:50 -0600
Message-ID: <CAOCk7NoaP=DkNLgdiUw5M0JYRGEGGCFQkn1sCO9dqtexMPC9dQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] MSM8998 MTP Display
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, thierry.reding@gmail.com,
        sam@ravnborg.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:55 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> Since we are trying to get the GPU and display hardware in the SoC
> supported, it would be nice to be able to put the output on the
> integrated panel for the reference platform.  To do so, we need support
> in the Truly driver to support the specific panel variant for the
> MSM8998 MTP.  This series adds taht support.
>
> Jeffrey Hugo (2):
>   dt-bindings: display: truly: Add MSM8998 MTP panel
>   drm/panel: truly: Add MSM8998 MTP support

Lets actually hold off on this series.  I thought I could solve an
issue in the DSI driver, but thats not working out like how I'd hoped.
I may need to rework this.
