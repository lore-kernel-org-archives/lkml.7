Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA4C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741AE214DA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Skz4hWsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfKIBg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:36:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36041 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfKIBg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:36:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id f7so7056076edq.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 17:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ihuncdiVh1w2nyHht0DAHccXGXWUHYDHepJ39RlLdk=;
        b=Skz4hWsKKuMx3wLuXfNJY24cjJ18AYpIo5ZHOlNqrz8J3nwwcDUlRtB+tv7D9x2NkQ
         zNixtCDqplp8PO2X/wAh8J/TpUopdAgeexbq4Lxdq4VK9tJuxWsfQp7kri2dwVsCdgxk
         xbiapGcqF1W/OgSXycwf7e6uZz0pHt720u5GMLI+Ebw6KlGwXfrjLmfQvaXsQtFhn1Ow
         mf6BoIEJplnSUhqv2fhUzpqX+0tEH7uY9WinBXfD3eq/6/eTncJGfLjseYrRTMlYpE6I
         ve4FT+vOtFI43aTVR02MQd7dZ28tLDofKefDIegDg38eElj8jtTsHGavqTwuCl/Fxj9F
         LtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ihuncdiVh1w2nyHht0DAHccXGXWUHYDHepJ39RlLdk=;
        b=B3oj7+bf+Z4ioj7Z2eQQgOfrB1QTye+PbPW8IGy7JQAhLvwh8PIvDstbJOhzlJ3nxb
         BT11eY4XGh1uJR6DLbKyrmMH6EKec9UR0XLU+xSYpmjS8rkqmcMq/DIDM7F7AHT6n1aB
         cn1u6+ynm6SDgeRDJ34vN0Xnnvt5eNLcdX2Fpjf+R8WM5L0VbBXScvBP4ZkGdE71Bmby
         SamvqCWNnfHDUh0ZVTliGWyTq3gC317RPoaXCgF463rqmlFw99CgFtzJGCT3yK9i2wp1
         hq0eJOTs8APrCm68P4wlGjJW9JEVNFxNLeybTvVAoAJuTHWDCwKHcWL9qOIaLF7h/ioX
         34Rg==
X-Gm-Message-State: APjAAAUQr3ojr5j5r01YWYaqOLUDFrQSvk5tfgzSxp43VT0F2Tny3D1t
        SnY9g2c7DRpHYoopABbFEIzdfzpx4DFLJunHvcdfskKp
X-Google-Smtp-Source: APXvYqy7XqIGIk9M5j3K1MmAPYs5/4NA3INBn2+8EF5Xsbvfv01MNL4os3Li5IUVMzKzXcW0J69aXJQz7KjQVLN/j28=
X-Received: by 2002:a05:6402:6cf:: with SMTP id n15mr13619391edy.269.1573263417389;
 Fri, 08 Nov 2019 17:36:57 -0800 (PST)
MIME-Version: 1.0
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com> <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
In-Reply-To: <20191108103917.GB683302@kroah.com>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Fri, 8 Nov 2019 17:36:46 -0800
Message-ID: <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
Subject: Re: [GIT PULL] interconnect changes for 5.5
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 2:39 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 07, 2019 at 05:42:13PM +0200, Georgi Djakov wrote:
> > Hi Greg,
> >
> > On 11/7/19 16:21, Greg Kroah-Hartman wrote:
> > > On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
> > >> Hi Greg,
> > >>
> > >> This is a pull request with interconnect patches for the 5.5 merge window.
> > >> All patches have been for a while in linux-next without reported issues. The
> > >> details are in the signed tag. Please consider pulling into char-misc-next.
> > >
> > > I don't know about
> > > 0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
> > > Shouldn't you just fix up the dependancies of subsystems that rely on
> > > this?  We are moving more and more to kernels that "just work" with
> > > everything as modules, even on arm64 systems.  So forbiding the
> > > interconnect code from being able to be built as a module does not feel
> > > good to me at all.
> >
> > Thank you for commenting on this! The initial idea was to keep everything as
> > modular as possible. The reasons behind this change is that other core
> > frameworks like cpufreq (and possibly others) want to call the interconnect
> > APIs. Some of these frameworks are built-in only and it would be easier to
> > handle dependencies if interconnect core built-in too. Now each user that
> > can be built-in has to specify in Kconfig that it depends on INTERCONNECT ||
> > !INTERCONNECT.
>
> That's fine, when those subsystems start to use those apis, that
> dependency needs to be added.  Nothing new here, and you forcing it to
> either be "on or off" isn't going to change that.  Let's do it correctly
> please.
>

Please no!

Making our frameworks tristate means that we can no longer rely on
include file stubs (as framework=m, client=y will fail), so every
single client must add the "depends on framework || framework=n" - in
contrast to nothing the framework itself is bool.

An example of this is that there's almost 500 files referencing the
regulator api and all Kconfig entries referencing these files must be
updated with a "depends on REGULATOR || REGULATOR=n" if we're going to
start tristating frameworks.

For individual drivers behind these frameworks, definitely tristate.
But the only thing you're going to get out of making the frameworks
tristate is more build failures.

Regards,
Bjorn
