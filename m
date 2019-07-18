Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF809C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921CF21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URRIl3Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfGRPRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:17:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37755 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:17:23 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so52018512iog.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNr21Xxvun76oFcTohttI+fEqj00Jvnn+E2aS3PEEUA=;
        b=URRIl3ZuHdXT55d5UnpugdudCrTxPjHu4Wu8xsigydt7FnxW2zWF592qetTV8Wa/Tk
         Vph/LKt2p8i8toal2eEjit/EcJ3SPYxw06c00xpt47/U0WqH1X66uL6b+lOXZL3HAOJI
         oSs+1irvQfwOCK09tCfhiZKoY9pTTNhOoQRUEK2hN6m9O5m37gRlXwkDgb7KpVcOK9tB
         4AB3JNuCDo8IeccCp87mDUaZ4gesARTE3bVA5VOUUuVvLEOhxlOeFNt/IrnI5ToyNLBL
         cXKkaTQfi5vqsI3dN7j75YlqdkgAZTttVtS90hmRLS7k8NauXvWmLpH3yLu5uBuBFhBl
         48Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNr21Xxvun76oFcTohttI+fEqj00Jvnn+E2aS3PEEUA=;
        b=njsvMPbiC5EprFQlu8LfdPKzhug8wb6u6dw8FUFIGmXkf/3rC0wub8z4Mm2bMa0iXZ
         NMQlwE4AqPbuTAAokeRkjsofO+ex7qjK/Y0fIl23nHGuQrG/ZdXL2mXF1rcr+XsKeQ+9
         4XHQXypckbNFRQ3AYYcG+oTdWE1KZ7ReYDZCEFPdcMWm8UgU3yeEz7ka3GXRxFG7rlB5
         f+5JO2mgsJJ9iP1Zy47Ge66RviIhhyRolFwoNzvaM684AvsBRjttDB/9KcxbSZ9/daN/
         xenepOn2MA4uRRjr3UBMJenmjn8v9P8AK1rB11Jj9RqSc2FI1t0kjm8tney/EADJ314e
         z06w==
X-Gm-Message-State: APjAAAWtcf1nzQfFiPTGgW9ktEFlneJkAecSsvrL2WbhbmIuw9JykK7t
        Mr+yvdDf0bvHggvX0TCHxTLH40nWgBZozE8Bwec=
X-Google-Smtp-Source: APXvYqxNmLrhjNA79cm/kVqf7d+Q5SHSJftO9uiWl0IW9ioT7MdB7s/V580kVwjs7CADY8ugWUpH2hOr8+QNwntOHVE=
X-Received: by 2002:a02:2245:: with SMTP id o66mr18526881jao.53.1563463042191;
 Thu, 18 Jul 2019 08:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
 <20190718134240.2265724-1-arnd@arndb.de> <ea59751e-7391-e3e9-bb46-00e86b25f1a8@samsung.com>
 <CAK8P3a0q5xmi+mCvb1ET4d1uQmbnw+J2VkjRCzjemCXGy+5OBg@mail.gmail.com>
 <7da08013-5ee0-1c39-e16b-8b6843a28381@samsung.com> <CAK8P3a2nYArwNQrifW2xgzN=GUkN2wAjmZVo21JNw6YjHzwh7Q@mail.gmail.com>
In-Reply-To: <CAK8P3a2nYArwNQrifW2xgzN=GUkN2wAjmZVo21JNw6YjHzwh7Q@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 18 Jul 2019 18:17:09 +0300
Message-ID: <CAKdAkRS0w3KM-F95-F1jUicq2srAzWu21_7Npnw28F5fF+UxtA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: fix RC_CORE dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 6:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 18, 2019 at 4:56 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > On 18.07.2019 16:21, Arnd Bergmann wrote:
> > > On Thu, Jul 18, 2019 at 4:16 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > >> Hi Arnd,
> > >>
> > >> On 18.07.2019 15:42, Arnd Bergmann wrote:
> > >>> Using 'imply' causes a new problem, as it allows the case of
> > >>> CONFIG_INPUT=m with RC_CORE=y, which fails to link:
> > >>>
> > >>> drivers/media/rc/rc-main.o: In function `ir_do_keyup':
> > >>> rc-main.c:(.text+0x2b4): undefined reference to `input_event'
> > >>> drivers/media/rc/rc-main.o: In function `rc_repeat':
> > >>> rc-main.c:(.text+0x350): undefined reference to `input_event'
> > >>> drivers/media/rc/rc-main.o: In function `rc_allocate_device':
> > >>> rc-main.c:(.text+0x90c): undefined reference to `input_allocate_device'
> > >>>
> > >>> Add a 'depends on' that allows building both with and without
> > >>> CONFIG_RC_CORE, but disallows combinations that don't link.
> > >>>
> > >>> Fixes: 5023cf32210d ("drm/bridge: make remote control optional")
> > >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >>
> > >> Proper solution has been already merged via input tree[1].
> > >>
> > >>
> > >> [1]:
> > >> https://lore.kernel.org/lkml/CAKdAkRTGXNbUsuKASNGLfwUwC7Asod9K5baYLPWPU7EX-42-yA@mail.gmail.com/
> > > At that link, I only see the patch that caused the regression, not
> > > the solution. Are you sure it's fixed?
> >
> >
> > Ups, you are right, I though you are fixing what this patch attempted to
> > fix :)
> >
> > Anyway, we want to avoid dependency on RC_CORE - this driver does not
> > require it, but with RC_CORE it has additional features.
>
> Right, that's what my patch does: if RC_CORE is disabled, you can
> still set DRM_SIL_SII8620=y, but if RC_CORE=m, DRM_SIL_SII8620
> can only be =m or =n.
>
> > Maybe "imply INPUT" would help?
>
> No, that would make it worse. Device drivers really have no business
> turning on other subsystems.
>

OK, in the meantime I will redo the branch by dropping the
sil-sii8620.c Kconfig changes and also drop all "imply" business from
applespi driver as they give us more trouble than they are worth. We
do not have "imply" for i801_smbus for Symaptics SMBUS mode and it
works fine. It it distro's task to configure the kernel properly.

Thanks.

-- 
Dmitry
