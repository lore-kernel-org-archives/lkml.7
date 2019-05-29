Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5111C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F1C23B88
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfE2PJe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:09:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40752 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2PJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:09:34 -0400
Received: by mail-io1-f66.google.com with SMTP id n5so2116316ioc.7;
        Wed, 29 May 2019 08:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZnaDev0tj+heu2iB5lB6hq5yDeKgLXO4KFHMV/Qt+5k=;
        b=HhRQ4iY1Dg2OjS5vw1kfJlHWgsoEd8OliHnrcv6gwwgwKycHafISYKNP+czvWjASQd
         RS2+gomWhKrOE7PX0lMS1p8oy/AJfuJ2JUNTlJC0l1X2kelNzaG9/Ip49JJh7aWd7C5E
         thlrf4XXxDrpfJ47KME9bFjXiyIgVjTYrrgQevkRfh7IdPQyXpnTOaWGpB3K23GVQtK9
         SxXmBQWSII/w5Q9JubTdBinOw3c/u+r13XOJwWygU4DMgk4lpGzUSkTW9fXy0Ly7b7e9
         dsFeDvEtW3Lvg/2AXtWhez9j/3DKXPbYSjasp4z2gMHz1nNqFZABjD6naDQ/rvHjedCa
         enTQ==
X-Gm-Message-State: APjAAAUsavQI4ewtFB745rk7/u2vUG8r7tfI5NdksInV6+VYFVkvcD2f
        RHuS3rZnNvpsfLHKSbnOsqo8fefVtWn50dd7KRA=
X-Google-Smtp-Source: APXvYqySOnocW0FtjyGqwuP2FQxhmxY7P/texfW33GuY5PwHsuap8yTRqkoaWNnTkj3NpjtfrGddYcbbqyuWzUYQqNA=
X-Received: by 2002:a6b:7:: with SMTP id 7mr828192ioa.253.1559142573556; Wed,
 29 May 2019 08:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com>
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Wed, 29 May 2019 17:09:22 +0200
Message-ID: <CAAObsKD8bij1ANLqX6y11Y6mDEXiymNjrDkmHmvGWiFLKWu_FA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 at 18:11, Clément Péron <peron.clem@gmail.com> wrote:
>
[snip]
> [  345.204813] panfrost 1800000.gpu: mmu irq status=1
> [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000002400400

From what I can see here, 0x0000000002400400 points to the first byte
of the first submitted job descriptor.

So mapping buffers for the GPU doesn't seem to be working at all on
64-bit T-760.

Steven, Robin, do you have any idea of why this could be?

Thanks,

Tomeu
