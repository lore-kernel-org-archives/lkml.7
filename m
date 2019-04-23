Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54660C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12029206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhklM1Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfDWCwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:52:34 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53765 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfDWCwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:52:33 -0400
Received: by mail-it1-f195.google.com with SMTP id y204so21087684itf.3;
        Mon, 22 Apr 2019 19:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXevF8x3FwcZfk49I9x/0X2h44nvZTi88w1UJaAibtI=;
        b=jhklM1Fxh8HgrfyKAfoS8ViZuS6df3FofCPmZc7sdCYeuOPzy7l7UZDxzu/eKC6+VU
         5FRmFm+9pBQjSELM1XLqnqcyXiXkgNrJzIEHb5ruRejpiUquWYPMG/+HGeBYBAennvel
         +PeXYuQ/GtHDJW3R5qcxvI2HxCJ7WU5zvQ7BWDpUlZxXHOKcOpkAXiPLODS3YsrHH6dE
         11taPsC+erjSk1UwUdoc9hMXx7hABk+X/uWeX8SwXc/VIaC6FvwlDW7pv+M9098qHaXa
         iKvIIGVMGdGlIGnirFrD5IRhS0RCvHzdmo5oaHMwNZMi3EanruS2YlHr07i5HI1JOrd6
         jKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXevF8x3FwcZfk49I9x/0X2h44nvZTi88w1UJaAibtI=;
        b=MEbRXRRzXlTIA0uZKc2IcL4cfmOt8He37F3103NAuJLs4rVebUA6QW0KXKjkHfambI
         wNTFLdvqUeV3dGX2pfjJ4YXavdtXwH5EsBt8eYtxrEScuQII0bs5o42f8+vV6Pyy8pex
         duxpxVUisXX2UdSqZM12yU7m64LAAg4NeARPOXTosUmo0D6wRvat8PlA+qhHc3fEPnoh
         QelkW3lEbxAG34ZxzvtasNw7Dc0OfKIU1exLWlAvQRxSpcWKfuUoOLNoWLT5htgDxDL0
         h4HthuESq/Wf65jIF4HeExniJPlqk1MC/vLXIgJCdTvFOB/UjqWomIy3eGIUK3PQT/9m
         aRtQ==
X-Gm-Message-State: APjAAAVKJ5rdZiL+Sv+BAOPXlBcfZFqmtvRuSRgOkHPmkqTaoZUSawHp
        oE5EavrvZ3DT0o/fWa11w9GufN9sjxP2sAyz+7I=
X-Google-Smtp-Source: APXvYqz+qkVBHiymSb+yvFn4EWeaPklDs/RB9Rp9rh19zK635EyEI5A25N5rVdiStQtwSdYiwfbmCoFLGPufV7yoxFY=
X-Received: by 2002:a02:896:: with SMTP id 144mr15310167jac.53.1555987952655;
 Mon, 22 Apr 2019 19:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190422050344.24513-1-crag0715@gmail.com> <20190422133947.0b6aaf82@cakuba.netronome.com>
In-Reply-To: <20190422133947.0b6aaf82@cakuba.netronome.com>
From:   Crag Wang <crag0715@gmail.com>
Date:   Tue, 23 Apr 2019 10:52:21 +0800
Message-ID: <CAP-8N0g4s2o7p1oL9swBUEjfiyxnU=4Xf2CXu2Fo-1+a2L2J8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] r8152: sync sa_family with the media type of
 network device
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        Mario Limonciello <mario_limonciello@dell.com>,
        "Crag.Wang" <crag.wang@dell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Glass <sjg@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Chen <david.chen7@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Charles Hyde <charles.hyde@dell.corp-partner.google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 4:39 AM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Mon, 22 Apr 2019 13:03:43 +0800, crag0715@gmail.com wrote:
> > From: "Crag.Wang" <crag.wang@dell.com>
> >
> > Without this patch the socket address family sporadically gets wrong
> > value ends up the dev_set_mac_address() fails to set the desired MAC
> > address.
> >
> > Signed-off-by: Crag.Wang <crag.wang@dell.com>
>
> Code looks reasonable.  This must have been caused by:
>
> Fixes: 25766271e42f ("r8152: Refresh MAC address during USBDEVFS_RESET")
>
> which is still in net-next.  In the future please make sure you read:
>
> https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html
>
> In particular:
>
> https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html#q-how-do-i-indicate-which-tree-net-vs-net-next-my-patch-should-be-in
>
> To assure smooth flow of your patches into the tree :)
>
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>
Yes, patch is intended to fix 25766271e42f which is still in net-next.

It appears that prefix is desired in the subject. Thanks for sharing the info.

Crag
