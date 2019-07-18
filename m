Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C0BC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471EC217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390591AbfGROV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:21:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41554 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390350AbfGROV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:21:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so27293134qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 07:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJSn3w0n1j2YNOpQyI6dRVDfYepa6cxkjB5g4haixAc=;
        b=eZwT6b2RrUdS0CxzfQ/6RHCKYADIChLwEPneob9Eun2nYxkMFHuhGsO2XgbqwTrE53
         FhnHOnQbUHKoHPB6lmdF/yWp/rYEH8msnDT3T0Ea9pXWWjgGs2fOdn4uS8xR7C17mf1+
         +9wV8Zj0/nUJGwwgyQhli+d79W+HY1i2z6KEYOnhYmPBdA43AHRLYCMfMslDLUNvWuH+
         ++x2SjiWSJTAKyOZTCDYQcMFXqP0y0kDqOhmZ3DnX+dnr6ePiwTzBVooR3OKbvA24Y6V
         qQIERa2euY4K7Wdwi5regi8mErNBPKBz4dmVCpjGG0NEvm0rfnInkLdHs2r2ddzwJUMH
         clmQ==
X-Gm-Message-State: APjAAAVlyXa4IESWIU+vfkydDNniRTdLsu218M+otP1mThF+TVOGg4Cl
        9VLrlWLlt6vteLh9HqcMhVXrfjAUZvhaDlfsd7k=
X-Google-Smtp-Source: APXvYqyOL96qqaAzWb0sRHrwIHNEekEP/dvPqHMZCRaBijvjyR4X1MbBzgSpIkydH6XLPLJr/VEzj62aMg5/VwD3cus=
X-Received: by 2002:a0c:b88e:: with SMTP id y14mr31941430qvf.93.1563459688451;
 Thu, 18 Jul 2019 07:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
 <20190718134240.2265724-1-arnd@arndb.de> <ea59751e-7391-e3e9-bb46-00e86b25f1a8@samsung.com>
In-Reply-To: <ea59751e-7391-e3e9-bb46-00e86b25f1a8@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jul 2019 16:21:11 +0200
Message-ID: <CAK8P3a0q5xmi+mCvb1ET4d1uQmbnw+J2VkjRCzjemCXGy+5OBg@mail.gmail.com>
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

On Thu, Jul 18, 2019 at 4:16 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> Hi Arnd,
>
> On 18.07.2019 15:42, Arnd Bergmann wrote:
> > Using 'imply' causes a new problem, as it allows the case of
> > CONFIG_INPUT=m with RC_CORE=y, which fails to link:
> >
> > drivers/media/rc/rc-main.o: In function `ir_do_keyup':
> > rc-main.c:(.text+0x2b4): undefined reference to `input_event'
> > drivers/media/rc/rc-main.o: In function `rc_repeat':
> > rc-main.c:(.text+0x350): undefined reference to `input_event'
> > drivers/media/rc/rc-main.o: In function `rc_allocate_device':
> > rc-main.c:(.text+0x90c): undefined reference to `input_allocate_device'
> >
> > Add a 'depends on' that allows building both with and without
> > CONFIG_RC_CORE, but disallows combinations that don't link.
> >
> > Fixes: 5023cf32210d ("drm/bridge: make remote control optional")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>
> Proper solution has been already merged via input tree[1].
>
>
> [1]:
> https://lore.kernel.org/lkml/CAKdAkRTGXNbUsuKASNGLfwUwC7Asod9K5baYLPWPU7EX-42-yA@mail.gmail.com/

At that link, I only see the patch that caused the regression, not
the solution. Are you sure it's fixed?

      Arnd
