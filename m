Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1E3206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZMsaP0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfC2O7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:59:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39019 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfC2O7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:59:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so1162476plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/kqlenlK+JvnueFoIuTbjPBJgfLDPggKwVH9M46JcU=;
        b=oZMsaP0xJnByw7yZdvNu/ndTbJYPScvxNSrJ9DMe4IMR8Hs4xgUV1GssfZyU6eR2Ec
         QEnpaGyQJ9Wh98ARFFzBLH8SYzKcmbancd+pQi5GMV85ji7d9s1cXRYaK3nN+a/7pXeh
         xVp37jgIDo7J2eHP+p7+CsFvMczIly32f2yVvnqNv4FsO17faFA9dZtmh/1zPYgW1/MD
         /k9/GVKp5KiayYSrk+tAg6ONLSlfdFLJgJV9B6xsQgGcFaEoL4rlSTmYtCcRzEk45OFL
         MbQJs5Ra60FZsYrBsieEtPVLO/YDowjOjmEVSEWJR0z/7nJ5UVsasuLNIU4vojGgJCY3
         Iijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/kqlenlK+JvnueFoIuTbjPBJgfLDPggKwVH9M46JcU=;
        b=akoTxEFZsbgp2b0kmt7waewoknRIhmQt4xu8VWkyw0NN1XalzLvbO/hexfuXYgLoCh
         5ruFGNn6SZPx9/JhX0vbJHgBDbphWOYEQU6pDTG++yHLy6srGkq0XylxJ4p69bI9db6m
         /KdNKY4ZbNXn2zphQV1zcGVVrmWZ0caOxYEo87SBtO+cthjXrmKaysMjm3cO/6hty2ZV
         YLgYtJE26yOVMYh8uFc6w3ZuU8JtPotXz8iQUa62Tz7w8zU9knqi+9B6UXAqNyyJCE4d
         0f00wWytu0uTVmKBEZYvj7jS78AfJq8Vh81S2TbbcXShieGezcYs1vMU07WtyOAJWPWE
         u56g==
X-Gm-Message-State: APjAAAX9osyZdgYMQbcTywhjpSK5zl3x1zHOy7oLbNPakMzA+WsZW4Mt
        Y7knsNKUzirg4Tgt7qYCfvPa5P+NpRwndh+houS5dg==
X-Google-Smtp-Source: APXvYqzBn0TUg7zyJ5+rJrBQshvl4Hjm3joBLvGbSDOr4JrM+cZuZQXOfsdJgP69bBFLJg+EhyZ47PJmyRax5BskUhc=
X-Received: by 2002:a17:902:2aca:: with SMTP id j68mr2414356plb.233.1553871583485;
 Fri, 29 Mar 2019 07:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190327212155.80730-1-venture@google.com> <20190328165009.GA25705@bogus>
 <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com>
 <CAL_JsqJSvzOQbJSgz7z2wZj9-z=bfhzF_C+662Gnf68TgAPFaA@mail.gmail.com> <CAO=notx6K7xTW1VG6BGJFBM5k8EQsWXn3WoWSPSrZRsxkwueSA@mail.gmail.com>
In-Reply-To: <CAO=notx6K7xTW1VG6BGJFBM5k8EQsWXn3WoWSPSrZRsxkwueSA@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Fri, 29 Mar 2019 07:59:31 -0700
Message-ID: <CAO=notxD=5pa5sT15a+VrA7qVNPBoJoTo=5sLxibBxc+HWcG4g@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 7:56 AM Patrick Venture <venture@google.com> wrote:
>
> On Fri, Mar 29, 2019 at 6:38 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Mar 28, 2019 at 12:03 PM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Thu, Mar 28, 2019 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> > > > > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> > > > >
> > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > ---
> > > > > Changes for v8:
> > > > > - None
> > > > > Changes for v7:
> > > > > - Moved node under the syscon node it requires
> > > > > Changes for v6:
> > > > > - None
> > > > > Changes for v5:
> > > > > - None
> > > > > Changes for v4:
> > > > > - None
> > > > > Changes for v3:
> > > > > - None
> > > > > Changes for v2:
> > > > > - Added comment about syscon required parameter.
> > > > > ---
> > > > >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> > > > >  1 file changed, 48 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > > >
> > > >
> > > > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > > > there's no need to repost patches *only* to add the tags. The upstream
> > > > maintainer will do that for acks received on the version they apply.
> > > >
> > > > If a tag was not added on purpose, please state why and what changed.
> > >
> > > Adding tags in this case is adding a change version?  I was doing this
> > > to keep the two patches version-synced.  I thought that was required.
> > > There was a version change in the other patch in this set.
> >
> > Adding tags is not considered a change. I gave a Reviewed-by in v7.
> > Subsequent versions should carry that tag if there's no change (or
> > only minor changes) in this patch. What happens in the other patches
> > is not really important. Maintainers are not going to go searching
> > thru the versions to find all the ack/review tags. And if I've already
> > reviewed this, I don't want to look at it again.
>
> Thank you, I didn't realize that had happened.

I went back through my email and found the line of your email that
included it.  I apologize.

So, before I send the updated patch with your ack -- do I need to send
a v9? or is this just me sending v8 again?

>
> >
> > Rob
