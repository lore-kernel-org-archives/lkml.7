Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21518C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D29A2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3bYmxTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfDYTZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:25:16 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52459 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbfDYTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:24:58 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so2003630itf.2;
        Thu, 25 Apr 2019 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlxvnPPRAeB6QKDQcuJCsKMtXSMLWsbJIXPOVAwtVVo=;
        b=Q3bYmxTJ1QnevyIWZD1OHcmDMFAUEh/YHqhTN5q9JJe1zidGKauuA4/sUWzEdcaJWL
         9VB5/l3c8Al0KTWLbwJ7jfP+ihGWoxgkDiv2HsxCHBJKRfjVY/ZVR9wh75exP28XUBqN
         MDAvYEJiXda3D+UCve8t+eXRZXLPjVd7LOdzQ8rtLFAdTF7GI8OVSH/zYzLJTSMA9L1n
         PnzlBOp+pojYjTeqC9IDDQ99U09WHtkMP/DoEAH+9RCEb8YwBkR7yCffzbndL0NNS/xH
         GhNf1/L46C4R6GMhcfU84mQJU+KRmlh4QuzQ8lQ9Cu8aD0FMEzZ6ztDi+SAQKLNXqiHK
         gvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlxvnPPRAeB6QKDQcuJCsKMtXSMLWsbJIXPOVAwtVVo=;
        b=q7+FZzxsWjuZCvESaruA0Pwt9/mR1fgptIqnePig3DK1Ly8gjyKNB+ublFpsXXWS1z
         r7twW8GkNm4wfXThUrHWA5F42t63gkxq8mVhvvCWkr7XN+Nrr3d+5+hBhqgn9x/m3CRC
         NDjBbkQJP8zcrJBRmmcmAj7dxShqiTbXIn+T7d3L0A+WvZ1cymhS4Bei68taPrtmMFqv
         bwzU/rDPd3a9GtzXcc6e7mISQlLf5oAFXUuY2Rih0koavTAIMx05GHxblaUHJZcffNks
         e3Kk9Y+d/+5ABTeRo33pBwCakmAZ6Lzsl77FIjFkkZ7FwSGZI90gBq5K48aJEkTkGzvf
         rL2g==
X-Gm-Message-State: APjAAAXm6HeCcmAv6eD9uBfo9V2NrMC7kbxRoSrRM3WEZYzcAQYKZJWf
        Owm+ZpwUv0DZyGzyzEMydJsNqIpgocmyQjn2Jxw=
X-Google-Smtp-Source: APXvYqxw2M3WYg+lvnxTRr0zI7MoMrNp/xiYFsJhQIQ0w9TtO5oZU3I8lHbSiOFMpdLvBR3WGIxqUcWRldpUxvzaTt8=
X-Received: by 2002:a24:e97:: with SMTP id 145mr5131387ite.141.1556220297415;
 Thu, 25 Apr 2019 12:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101913.1534-1-benjamin.gaignard@st.com> <CAL_JsqJp9f3Sv08igSyR38Z5eXnAYWMNY29U5qEGLp=r2YReRw@mail.gmail.com>
In-Reply-To: <CAL_JsqJp9f3Sv08igSyR38Z5eXnAYWMNY29U5qEGLp=r2YReRw@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 25 Apr 2019 12:24:46 -0700
Message-ID: <CAKdAkRTUsJ4TU7BrSNXCKiQGZnArao9o_qk7i0xSzYJ1SGU14A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add of_ functions for device_link_add()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Input <linux-input@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:08 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Apr 24, 2019 at 5:19 AM Benjamin Gaignard
> <benjamin.gaignard@st.com> wrote:
> >
> > It could happen that we need to control suspend/resume ordering between
> > devices without obvious consumer/supplier link. For example when touchscreens
> > and DSI panels share the same reset line, in this case we need to be sure
> > of pm_runtime operations ordering between those two devices to correctly
> > perform reset.
> > DSI panel and touchscreen aren't sharing any heriachical relationship (unlike
> > I2C client and I2C bus or regulator client and regulator provider) so we need
> > to describe this in device-tree.
>
> Needing to know which touchscreen is attached to a panel could be
> important to describe if you have multiple displays.
>
> Doesn't the reset subsystem already have some support for shared
> resets? Seems like it could provide clients with struct device or
> device_node ptrs to other devices sharing a reset.
>
> >
> > This series introduce of_device_links_{add,remove} and devm_of_device_links_add()
> > helpers to find and parse 'links-add' property in a device-tree node.
>
> Going to document that property somewhere? :)
>
> I think this is too generic and coupled to Linux. It doesn't have any
> information as to what is the dependency or connection nor what the
> direction of the dependency is.
>
> I'm not convinced we need to solve this generically vs. defining
> something for this specific example.

I am pretty sure there will be more drivers needing complex
dependencies. Doesn't ACPI allow defining relationship between devices
that goes beyond the tree structure?

Thanks.

-- 
Dmitry
