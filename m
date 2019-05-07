Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E908520675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 04:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SRUggtVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfEGEvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 00:51:36 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42244 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfEGEvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 00:51:36 -0400
Received: by mail-vk1-f196.google.com with SMTP id u131so3726025vke.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 21:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6LuiDNx04tqP5yfdc2qbmlwjeob10O4SM7rIq3ikqs=;
        b=SRUggtVmJcYwtmhLPmHly4X8QR3bVq2tyyxSAMdeVDE8KlSjalza9otjVaeOabJfCz
         WlHbVUTq2EDvuC+7v55hM1jB6lHvB2hnuUg2vGh3+JpGUxpAluBtwY8WG4kqmJIeSmqW
         D1/PltZ7N+0URekiaUlcAd4pAEZOOnHQOHxjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6LuiDNx04tqP5yfdc2qbmlwjeob10O4SM7rIq3ikqs=;
        b=A+PLpBIgq5KdOL8FxhXF/moBbL1XKCq1JzUqezvc3VlQ4bGzI54X2/Y2L2zcnO7dOs
         GQYNutcNQ/iVjAoeyor3YfTz/Upe5ImsNfWVdLok8aHdqIbC1e0ualiZQhmATEZSAkIm
         bCQY/aVBtYAmDmYw+D8wW8bxhqE0rRSdrWcU+kvdFpRVilk/FoW67XoLvTsMYlIMFd7O
         jW3zfpMw9mEquaUSqe7HmuSgvjVE/yguBJ2ZSL2Wzv/Q+QNOiyq+r7i1ctZB+XHS/vMr
         RYialJjYYlUJy/uIPZq6XyV19kxlLKOm/lIsZ/PaBJIwRIA1kWvbtn5XFnCOBodfEegM
         5wmA==
X-Gm-Message-State: APjAAAW0IdeAFtnSvR6iyMnu/AEM1CQYt2h1Qs+OxSWiHTo0tlBIuUUU
        mxo3i5QvxZQUB27QL+W+dDLeKsutAKU=
X-Google-Smtp-Source: APXvYqwlnZlPbMegRvgwPbAaqCQxIiV447YmN7aUGnCNs3Z4KP5RZF1GcfPpsegMVs2yLcsVg1AiXQ==
X-Received: by 2002:a1f:9ad6:: with SMTP id c205mr15428905vke.1.1557204694744;
        Mon, 06 May 2019 21:51:34 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id v17sm3156756vsc.18.2019.05.06.21.51.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 21:51:33 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id o33so5512848uae.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 21:51:33 -0700 (PDT)
X-Received: by 2002:ab0:2709:: with SMTP id s9mr13716726uao.21.1557204692851;
 Mon, 06 May 2019 21:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org>
 <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com> <CAD=FV=WcjfUwH62bHVELOmzViv7d329r6+HfPqAyXMjKCO7LeQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WcjfUwH62bHVELOmzViv7d329r6+HfPqAyXMjKCO7LeQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 May 2019 21:51:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vxp-U7mZUNmAAOja5pt-8rZqPryEvwTg_Dv3ChuH_TrA@mail.gmail.com>
Message-ID: <CAD=FV=Vxp-U7mZUNmAAOja5pt-8rZqPryEvwTg_Dv3ChuH_TrA@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Kees Cook <keescook@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 6, 2019 at 4:58 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, May 6, 2019 at 2:10 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > From: Douglas Anderson <dianders@chromium.org>
> > Date: Fri, May 3, 2019 at 10:48 AM
> > To: Kees Cook, Anton Vorontsov
> > Cc: <linux-rockchip@lists.infradead.org>, <jwerner@chromium.org>,
> > <groeck@chromium.org>, <mka@chromium.org>, <briannorris@chromium.org>,
> > Douglas Anderson, Colin Cross, Tony Luck,
> > <linux-kernel@vger.kernel.org>
> >
> > > When you try to run an upstream kernel on an old ARM-based Chromebook
> > > you'll find that console-ramoops doesn't work.
> > >
> > > Old ARM-based Chromebooks, before <https://crrev.com/c/439792>
> > > ("ramoops: support upstream {console,pmsg,ftrace}-size properties")
> > > used to create a "ramoops" node at the top level that looked like:
> > >
> > > / {
> > >   ramoops {
> > >     compatible = "ramoops";
> > >     reg = <...>;
> > >     record-size = <...>;
> > >     dump-oops;
> > >   };
> > > };
> > >
> > > ...and these Chromebooks assumed that the downstream kernel would make
> > > console_size / pmsg_size match the record size.  The above ramoops
> > > node was added by the firmware so it's not easy to make any changes.
> > >
> > > Let's match the expected behavior, but only for those using the old
> > > backward-compatible way of working where ramoops is right under the
> > > root node.
> > >
> > > NOTE: if there are some out-of-tree devices that had ramoops at the
> > > top level, left everything but the record size as 0, and somehow
> > > doesn't want this behavior, we can try to add more conditions here.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > I like this; thanks! Rob is this okay by you? I just want to
> > double-check since it's part of the DT parsing logic.
> >
> > I'll pick it up and add a Cc: stable.
>
> Hold off a second--I may need to send out a v2 but out of time for the
> day.  I think I need a #include file to fix errors on x86:
>
> > implicit declaration of function 'of_node_is_root' [-Werror,-Wimplicit-function-declaration
>
> I'm unfortunately out of time for now, but I'll post a v2 within the next day.

OK, it needs this to land first:

https://lore.kernel.org/lkml/20190507044801.250396-1-dianders@chromium.org/T/#u

I thought it'd be OK to just send a separate patch.

-Doug
