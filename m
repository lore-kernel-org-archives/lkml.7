Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B6CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B9020644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY48gQrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfF1MpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:45:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36514 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1MpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:45:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so5870398ljj.3;
        Fri, 28 Jun 2019 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GEqhSw7XoHXqMZnEsUEUEWbSTHqXhJJe8Wyf3XsI9mU=;
        b=dY48gQrBtGafKX3VvVgG7RpEAGIy+5X/y+FG0d3UCbDJ4d9iyBGO6HbW1R+UOX4pHu
         j69y2wbXVY8t6JNPD1xqtGbZ7dWJqomIwfmjZmOB0/QKW501dSrMWcT7ZlW2Gf0J9Ss9
         k7xx98PMtJAnIcHts8YOmW0Mqi5qQknsZo7TA9SaLMkIAkgUrYHFAT4IiNIooPhfmyC3
         0JIfgkBJEMp8Qjr9AMdUBsuK4okety0MJyqZeeHsg0zM8hHMvEI/3DRZQ/BpGleU+MOF
         nA3YQ3nrHw9wGDCmEfDNYffOTPtIXgOQulHJw6bx30DYt0vIWSJ7eII1DxhDiUyW2KZb
         o6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GEqhSw7XoHXqMZnEsUEUEWbSTHqXhJJe8Wyf3XsI9mU=;
        b=s49Sj7u+rbZChMczS1deQmzGWZUcMEMcOHGSZraplJA9GtH3o51htDn7Wptp2SH/n2
         XvX8DReNHU+2INy5Ht1kezahH+eCyEVlp9/VWotUEyOg5oYPW/4xtUUCgwygJ1CxSXLR
         H9JnlkyJMqwMgZXBj3MmYMJP0TOnJbOLvhVjDII/yvXHH66VhSzz+O4x7KTT8FSd6vx8
         BL22yKU7TNRcA8EdJqKP5pyjYammq8yOOkzS4Z5eg1IrkkWLS/5pxqZtAMHUmG/AiHR7
         Oomt+hCSWy4FgSdWClAgT4vpLBkSpQ1ty+N8oEUvNH5YBLTU9vZc5UYXvHAKKpsIT9Tt
         0Png==
X-Gm-Message-State: APjAAAXWtCr8RZKKh/rcD6r86dtUV8NrOoTwscnGcLUdxjNjwFOqStYx
        Z0Ch2MGRm8VLntkjGSa5VMM=
X-Google-Smtp-Source: APXvYqxbkmX0DrMhEJRm5Y9OKIyBKj8ZNBWPG12rr9g1LqN7g2am6xv6zFO8SX7pBLbrCVvykSDmQg==
X-Received: by 2002:a2e:858b:: with SMTP id b11mr6010343lji.159.1561725921854;
        Fri, 28 Jun 2019 05:45:21 -0700 (PDT)
Received: from pablo-laptop ([2a02:a315:5445:5300:8da:9ea2:4aa2:e04a])
        by smtp.googlemail.com with ESMTPSA id e12sm544262lfb.66.2019.06.28.05.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 05:45:21 -0700 (PDT)
Message-ID: <3193437b89fdb22ccc69d654153e5b2b692d207b.camel@gmail.com>
Subject: Re: [PATCH v2 0/2] extcon: Add fsa9480 extcon driver
From:   =?UTF-8?Q?Pawe=C5=82?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Donggeun Kim <dg77.kim@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Fri, 28 Jun 2019 14:45:19 +0200
In-Reply-To: <20190628123738.GA25339@kroah.com>
References: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
         <CACRpkdYD7Z7XX9wXFtBehJG_4NCt=m_MNsR5cESPRnO3tomKmQ@mail.gmail.com>
         <20190628123738.GA25339@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 14:37 +0200, Greg KH wrote:
> On Fri, Jun 28, 2019 at 11:28:11AM +0100, Linus Walleij wrote:
> > On Fri, Jun 21, 2019 at 12:14 PM Paweł Chmiel
> > <pawel.mikolaj.chmiel@gmail.com> wrote:
> > 
> > > This small patchset adds support for Fairchild Semiconductor
> > > FSA9480
> > > microUSB switch.
> > > 
> > > It has been tested on Samsung Galaxy S and Samsung Fascinate 4G,
> > > but it can be found also on other Samsung Aries (s5pv210) based
> > > devices.
> > > 
> > > Tomasz Figa (2):
> > >   dt-bindings: extcon: Add support for fsa9480 switch
> > >   extcon: Add fsa9480 extcon driver
> > 
> > This is surely an important driver since almost all elder Samsung
> > mobiles use this kind of switch. So
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > This driver I see is already sent to Greg for inclusion in the next
> > kernel.
> > I just wonder if you guys are even aware of this driver for the
> > same
> > hardware added by Donggeun Kim in 2011:
> > drivers/misc/fsa9480.c
Yes, new one is based on this driver (plus device tree and regmap).
Originally this new driver was written for 3.18 kernel.
> > 
> > That said I am all for pulling in this new driver because it is
> > surely
> > better and supports device tree.
> > 
> > But can we please also send Greg a patch to delete the old driver
> > so we don't have two of them now?
> > 
> > The old driver have no in-tree users so it can be deleted without
> > side effects. Out-of-tree users can certainly adapt to the new
> > extcon driver.
> > 
> > If you want I can send a deletion patch for the misc driver?
If You could do this (and maybe it'll get merged faster) i'll be great.

Thanks
> 
> Please, I'll gladly take a patch that deletes code :)If You ca
>
> thanks,
> 
> greg k-h

