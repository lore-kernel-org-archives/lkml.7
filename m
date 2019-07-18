Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6318C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966C020873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd1twbsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390653AbfGRPNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:13:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37796 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:13:23 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so51995840iog.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxhFlZti0naM2sDVdiDzJc8/ssIuZA4T/1kRQ8AEdP4=;
        b=Fd1twbsRFkV2uARiboN365L46fCumZdWwggXza4I9g+14jQ/0ZBU41IunO1gxAhnWh
         AJZKfFjseNbttdxS58l+XFoCi/V6+cjbOQyavTaAF8iO+GNZ4txNmYtFQG0pSl/NYngW
         uqJpqlDXRXluzItAEgpuqPVTDhJDbe8MdjBLmSrTTFhw8+FesAoGRxe/ekypVMsI1SHl
         MB7fMS2gNVIkHA7BLfob3iDPXQF30JC90BqeDLbK9FzAFj7rr2cSH9Xq0XaTRNeURyt9
         5p0NvduYZLObluTF/yq1Pprx3hS3M9IpM7TxlsFlgAitcruT57tSgHKqYql5f+72OGds
         VIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxhFlZti0naM2sDVdiDzJc8/ssIuZA4T/1kRQ8AEdP4=;
        b=RSlJSugn6GEcxWniTrRfsHeHggy1b+PoZFCcAF8mXTHzbeqDRmNqJtMDEHX9PPoLPL
         S7C1btwIGvdPyu8jMt0iyAWZ8XBEzCcdmy15v90ZUwy8d16t5lf9SJUV+Kbi8dP7ZwvZ
         1zmWphBNSvU9RnTgLgb1e2V8dmBnCa/QxZNbCQLsBUVNuqwyZXHga4fpujYzrxhg9KYs
         Sb6NsZWiZQ6nfMkzsFlFyfugMBuS2ItI5lcLr4Ue+inibzbCci+E54unm/o3I9xCskEy
         Hvb5AVkTiw4fmDUF33OZIW4B8LW6200Bv8hSnTLZzotI8WOgj9uAS4Inaq5dsz9wBc19
         6IaQ==
X-Gm-Message-State: APjAAAWS/vcukRLjXNHlud7DbrUaXTVSJd3E7D9TqFksPu/iKCSVSsHX
        sc2TOz6r9DhHj0XvIjZt63MpcR0VIyfz5jnrzfQTXm+o8uvdtQ==
X-Google-Smtp-Source: APXvYqyy6OG/tR1lqn+BDem6HrdtnNMA/3X8yiuoyfk09UEpbo1gGBW+QIlyr9RnAWtrI/EnjoS/vbf3L1Ls5JIE9U8=
X-Received: by 2002:a6b:7208:: with SMTP id n8mr33238445ioc.151.1563462801849;
 Thu, 18 Jul 2019 08:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
 <20190718134240.2265724-1-arnd@arndb.de> <ea59751e-7391-e3e9-bb46-00e86b25f1a8@samsung.com>
 <CAK8P3a0q5xmi+mCvb1ET4d1uQmbnw+J2VkjRCzjemCXGy+5OBg@mail.gmail.com> <7da08013-5ee0-1c39-e16b-8b6843a28381@samsung.com>
In-Reply-To: <7da08013-5ee0-1c39-e16b-8b6843a28381@samsung.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 18 Jul 2019 18:13:08 +0300
Message-ID: <CAKdAkRQQn40nUm6KjK80Zj95b_dhkTmETp7rMe+1s61gR4Xv5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: fix RC_CORE dependency
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
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

On Thu, Jul 18, 2019 at 5:55 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 18.07.2019 16:21, Arnd Bergmann wrote:
> > On Thu, Jul 18, 2019 at 4:16 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> Hi Arnd,
> >>
> >> On 18.07.2019 15:42, Arnd Bergmann wrote:
> >>> Using 'imply' causes a new problem, as it allows the case of
> >>> CONFIG_INPUT=m with RC_CORE=y, which fails to link:
> >>>
> >>> drivers/media/rc/rc-main.o: In function `ir_do_keyup':
> >>> rc-main.c:(.text+0x2b4): undefined reference to `input_event'
> >>> drivers/media/rc/rc-main.o: In function `rc_repeat':
> >>> rc-main.c:(.text+0x350): undefined reference to `input_event'
> >>> drivers/media/rc/rc-main.o: In function `rc_allocate_device':
> >>> rc-main.c:(.text+0x90c): undefined reference to `input_allocate_device'
> >>>
> >>> Add a 'depends on' that allows building both with and without
> >>> CONFIG_RC_CORE, but disallows combinations that don't link.
> >>>
> >>> Fixes: 5023cf32210d ("drm/bridge: make remote control optional")
> >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Proper solution has been already merged via input tree[1].
> >>
> >>
> >> [1]:
> >> https://lore.kernel.org/lkml/CAKdAkRTGXNbUsuKASNGLfwUwC7Asod9K5baYLPWPU7EX-42-yA@mail.gmail.com/
> > At that link, I only see the patch that caused the regression, not
> > the solution. Are you sure it's fixed?
>
>
> Ups, you are right, I though you are fixing what this patch attempted to
> fix :)
>
> Anyway, we want to avoid dependency on RC_CORE - this driver does not
> require it, but with RC_CORE it has additional features.
>
> Maybe "imply INPUT" would help?

No, it won't. I am sorry, I should have looked closer, but as written,
drivers/gpu/drm/bridge/sil-sii8620.c has a hard dependency on the RC
core and "imply" was the wrong solution for this, we need "depends on
RC_CORE". If we want to make RC support optional than we should stub
out paths that use RC_CORE (such as sii8620_init_rcp_input_dev()) and
guard them by "#ifdef CONFIG_RC_CORE". Then we could keep "imply" on
RC_CORE.

I am surprised though that imply allows violating the constraint on
implied symbols, as RC_CORE has straight "depends on" for INPUT.

Thanks.

-- 
Dmitry
