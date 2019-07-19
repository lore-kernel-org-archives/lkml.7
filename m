Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D09C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C192173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfGSIeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:34:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40244 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGSIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:34:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id s145so22675367qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 01:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t40DO/X7sJQ9uYQ+vcbmJFxeNmL+Zvgj4hLPmtUltGU=;
        b=op0CG5iybY/fpMCUhWemQmapw6BuruCiCswT56cyTJkYJrJWdAx6pav6oi3jJXCSBg
         uWDrB53ViHVuxNIX8lWtOtutQ2cu5uSz4YbCXtibITcNk+MtnfOZMpsvTXoBtp+dsE5u
         oI6RP/S5V4DolrhB6rC6gbB2QyEXoSZ681iQzraQM6AEkfCtIKFdNt9cmkztxDCioXyv
         SZ8gsSaQuvD6HxE6LDbKPCyHhJD4Ie1BJO6HOrXmhxS0xSB+uNdr9HPL2dlID4v0mouE
         qPmyp4JG/fugX6pvYpbopt6UGEEvq0i5u/c7yAtZ4s1QSTOscB/N64ZSo9CO+c1D0SQv
         /r0g==
X-Gm-Message-State: APjAAAWG9xNmA9r1cbJhDQaYcRQUB/IRBWImJinu8VmeK0qA0IOP4jdY
        kep+D6+EPRRz89n7N0wekTFTqJGPw1NrTIatIdY=
X-Google-Smtp-Source: APXvYqzLBYBJfvV/xjeS7wyaBBemab3RFfVOUtSyHzF7pehxyxR0cNpK6EPy9RAOht/iLf/RIFx1Owo2gClrrMbcQ4A=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr32994894qka.138.1563525256510;
 Fri, 19 Jul 2019 01:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
 <20190718134240.2265724-1-arnd@arndb.de> <763005f0-fc66-51bc-fcfe-3ae4942a9c07@samsung.com>
In-Reply-To: <763005f0-fc66-51bc-fcfe-3ae4942a9c07@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jul 2019 10:33:59 +0200
Message-ID: <CAK8P3a2rJ1WqWZ8VtOZZ5YwFrg5bpVve_kS4utL0MjeBUzrLew@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: fix RC_CORE dependency
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 9:01 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 18.07.2019 15:42, Arnd Bergmann wrote:
> > Using 'imply' causes a new problem, as it allows the case of
> > CONFIG_INPUT=m with RC_CORE=y, which fails to link:
>
>
> I have reviewed dependencies and I wonder how such configuration is
> possible at all.
>
> RC_CORE depends on INPUT (at least on today's next branch) so if INPUT=m
> then RC_CORE should be either n either m, am I right?

Right.

> Arnd, are there unknown to me changes in RC/INPUT dependencies?

I think this is 'imply' behaving oddly when we have conflicting requirements:

- INPUT=m forces RC_CORE to be =m or =n
- DRM_SIL_SII8620=y asks RC_CORE to be =y unless it cannot be enabled

Kconfig decided to make this RC_CORE=y, which caused the link
failure. Making it RC_CORE=m however would not work either because
then we'd get a link failure from the sii8620 driver to rc_core.

so a pure 'imply' cannot work here, and we need a dependency, one of:

a)
   depends on INPUT || !INPUT
   select RC_CORE if INPUT

b) depends on RC_CORE || !RC_CORE

b) is what othe drivers use, e.g. SMS_SDIO_DRV

       Arnd
