Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E09C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5D208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF442hqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfFUNiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:38:25 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35143 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:38:24 -0400
Received: by mail-vs1-f66.google.com with SMTP id u124so3846747vsu.2;
        Fri, 21 Jun 2019 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3RLgKLOFIxvZMzXOwU7F5Yurn0c+NOUw+jUTBkhCgo=;
        b=mF442hqXyWC8aR9fMe4LMrIymhJ7j/2eWnIxti4QdqJLT13eFvyCmkjK/JQY0DiqUe
         Rq+PluQKYySpM44e6mT8Fm8qEge3slgpf2R8P8egW9Hyx/L0JR2nPtmBa7matk//sNQW
         diWPsvfkFSQHfIHvRtYfVlPMNPrI7TOvuYKlGLalZP/wLcqU5gIoyZkN6gaJJeAwupkC
         8ancpd/cKIYDueEMn3+rvFNdtVbyXc3MqtnyGv0wiwK6rvwrOlACLt9uxgIetlB2wdsF
         kYVkSBrSp7gkRX0eAVJhu5jnxXWNG+cdqzM9jEDNm/UCzUyCTUvT7BlY0XV2fvJJTLY3
         J2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3RLgKLOFIxvZMzXOwU7F5Yurn0c+NOUw+jUTBkhCgo=;
        b=sHgOQznNqWDy5VzJfpZkiIc34P26Z7vlgx6G5B3CfVdFupaBJ6KKoT3knEAhpwycMy
         RCQnXpwjSyAqp/xfye0zEfpi1jv5IH7HXSI2SGguf5sE1zPz79DskOpjRmmAhsYZNn33
         ODFY0h4DjngHgX/1GqQfETYJjcqrxwK9wsc/ay56Y89gAXltN8AiIZpUccx+bui9pgD5
         8NI5DLWEo7Z+CLN1UYS4FksgNJnFZznlTjiS0Txs+1bI8CXgqOATN8I+d7vJjQru0HCy
         HYEnaY4ZSdXepuC/AzrbFMf3hwuE9Kf/++rXLxEpuhjSL35/UXdNUiiGO3kWnNMZdwTr
         nv8w==
X-Gm-Message-State: APjAAAWnFMVgKhwboa+EqhexjtaR7XjYc5G/ap+NqRmIIRfSRg0i21SF
        mCco8960SpkwMniulC9MiEMRlWIkLVGvLbVfsWU=
X-Google-Smtp-Source: APXvYqwXhGSaeU4cIvOV+lL4GHqdL9eNUIi3gdmDB80kH/6pe8U/CrLJNfH7mhCD+EiR1b9dDIWgOj4eTxHfMp3XkCI=
X-Received: by 2002:a67:f8d4:: with SMTP id c20mr11787135vsp.239.1561124302979;
 Fri, 21 Jun 2019 06:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
 <1561064991-16874-4-git-send-email-alcooperx@gmail.com> <1561095579.32589.3.camel@mhfsdcap03>
In-Reply-To: <1561095579.32589.3.camel@mhfsdcap03>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Fri, 21 Jun 2019 09:39:08 -0400
Message-ID: <CAOGqxeWUHbo51k-BpBJ0NT=s1hhJW5TOQ_js2QyqHV=mGbYUEw@mail.gmail.com>
Subject: Re: [PATCH 3/6] usb: bdc: driver may fail to get USB PHY
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been very useful to have the DEFER debug message so I'd like to
leave in the check for DEFER. I should not be skipping the clock
disable, so I'll "goto clk_cleanup" for both cases.

Thanks
Al

On Fri, Jun 21, 2019 at 1:39 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Thu, 2019-06-20 at 17:09 -0400, Al Cooper wrote:
> > Initialization order is important for the USB PHY and the PHY clients.
> > The init order is based on the build order of the drivers in the
> > makefiles and the PHY drivers are built early to help with
> > dependencies, but the new SCMI based clock subsystem has the side
> > effect of making some additional drivers DEFER until the clock
> > is ready. This is causing the USB PHY driver to defer which is causing
> > some PHY clients to fail when they try to get the PHY. The fix is to have
> > the client driver return DEFER when it's "get phy" routine returns DEFER.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/bdc/bdc_core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > index 11a43de6c1c6..c794890d785b 100644
> > --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> > +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > @@ -543,9 +543,13 @@ static int bdc_probe(struct platform_device *pdev)
> >                       dev, dev->of_node, phy_num);
> >               if (IS_ERR(bdc->phys[phy_num])) {
> >                       ret = PTR_ERR(bdc->phys[phy_num]);
> > +                     if (ret == -EPROBE_DEFER) {
> > +                             dev_dbg(bdc->dev, "DEFER, waiting for PHY\n");
> why not disable clock here? when re-probe, will enable clock again.
> to me, no need check -EPROBE_DEFFER.
> > +                             return ret;
> > +                     }
>
> >                       dev_err(bdc->dev,
> >                               "BDC phy specified but not found:%d\n", ret);
> > -                     return ret;
> > +                     goto clk_cleanup;
> >               }
> >       }
> >
>
>
