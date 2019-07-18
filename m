Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF017C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AD020873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfGRPNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:13:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35861 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:13:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so20732210qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qiq6mo8SuSLVGWvAOj/8rf0rOGcRje0ptMJyRuIppek=;
        b=rZQTMMEaDhGoUueudl1hJ8elehgzQONkp4K3eiEhSi0TiEsqQLMz3Y31VmzVw05yjl
         VdYx8+exd7yTdokFJjRLmnd+ELvt2qP1VxZyuqMB9IxFtUIKfpcuCEX8yghXu8blXpFQ
         +c1FkP73QAxROsaRLZ/Lq4+pXMh9kwtSWwgQCQ9pxxGyJ/4uC9F3TAjx+tnJKaPEyYdg
         y93IinOcwzd/cTAwuj655b+KnU4NADKVg9JBhSDNhQ+shDiW1hah5yeHBa49jK5yMv6q
         kYKoQDcyqDPPIcWIG2wKQwLhVtunuZAhydW2/paE/ZvLnEJ3ZFRewoRujW2W7bwSo6qr
         P6aA==
X-Gm-Message-State: APjAAAUyj4+kN8nw5wKicUWEAXlUNbKK8JPtEFdNsB7oJaT36eff+Q9C
        9dWhpC/Ohu94oWyI+2Bef6Uz/WCo+vIgKjLzdJE=
X-Google-Smtp-Source: APXvYqxnY0lfOEAOH/XvQdETK6Rku54hS6REry80H0mNybtT8Lr8Z0ZnkiBDE6H3VUatFtjpsNi5YxyqB7y4VRJ3Xjk=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr31499950qki.352.1563462784849;
 Thu, 18 Jul 2019 08:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
 <20190718134240.2265724-1-arnd@arndb.de> <ea59751e-7391-e3e9-bb46-00e86b25f1a8@samsung.com>
 <CAK8P3a0q5xmi+mCvb1ET4d1uQmbnw+J2VkjRCzjemCXGy+5OBg@mail.gmail.com> <7da08013-5ee0-1c39-e16b-8b6843a28381@samsung.com>
In-Reply-To: <7da08013-5ee0-1c39-e16b-8b6843a28381@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jul 2019 17:12:48 +0200
Message-ID: <CAK8P3a2nYArwNQrifW2xgzN=GUkN2wAjmZVo21JNw6YjHzwh7Q@mail.gmail.com>
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

On Thu, Jul 18, 2019 at 4:56 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
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

Right, that's what my patch does: if RC_CORE is disabled, you can
still set DRM_SIL_SII8620=y, but if RC_CORE=m, DRM_SIL_SII8620
can only be =m or =n.

> Maybe "imply INPUT" would help?

No, that would make it worse. Device drivers really have no business
turning on other subsystems.

       Arnd
