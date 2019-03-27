Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F1CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC292075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRtlgK5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfC0BQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:16:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41361 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfC0BQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:16:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id 10so10096566lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RacjWB4hhZwRPGNOlaFIhXUvLU+ZIOgAttjMq5EfPlA=;
        b=iRtlgK5UtCATYWukXnI/uZ4PvWFYemcPKRdT/P8fReNLvSYa9kmfQ0Xso6kvU+838r
         1incnOsaYon/Cmg+ycTSWLEO9J4F/pjM2Gf7zKr7B9MAFOA4h3yuknA+cZaCfQGkH3qS
         dwJs+GsyWPpFnF0h5hWlk381CjSvqsZ58gL5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RacjWB4hhZwRPGNOlaFIhXUvLU+ZIOgAttjMq5EfPlA=;
        b=XnU10eRhMVEyvrvg2Klaebu/jU0uDLKkBexTahYi8LA8Ap4J2NINJx5RJ5gG8Oqlte
         8kt9H7mnJzYgfSnppn8w2jSxRE/F2i6pxu6gkNXNg1/nNuk/O3nOs+tdkO6FVxMBCjzh
         qQIl+mhEgwUGB7xFZXdQhM2LaM4eduQqPsvxJTvNHTLE35ZGIqTnNzYNUl9p6RGGg4Hs
         eJPC9jdZ+w+qJoYAz0rejJ1fJFfqKikWXvsYifFdRqrRBYnxGpJE9LxiBXrcqGkQIyBt
         4m0B0U17VeHxwdfeFrp1BF6DqIZHvJNQrGQke0D9k82rCYB25OFhg5OZNX00KSl7NX03
         XvHg==
X-Gm-Message-State: APjAAAW/EZ724vpLECYHXCZuui/9EmA0dP/koR8ElViE3NZTZdg74cZ3
        0XXKD7hPpJBbHYpGJDJazIDZWPSTfe8=
X-Google-Smtp-Source: APXvYqwgCDaK6t3kgrtVRHMeqMnH+yM8d/oJPfsEyYxwM7LJ7cfq1zC2DJtg14+GIYUl8SUZhtXarw==
X-Received: by 2002:ac2:4563:: with SMTP id k3mr16703517lfm.101.1553649390072;
        Tue, 26 Mar 2019 18:16:30 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y10sm4200692lfg.44.2019.03.26.18.16.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:16:27 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id m13so10099741lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 18:16:27 -0700 (PDT)
X-Received: by 2002:a19:f017:: with SMTP id p23mr16845675lfc.103.1553649386786;
 Tue, 26 Mar 2019 18:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214730.6545-1-valleau@chromium.org> <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org> <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org> <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
 <759fcefa-974b-7430-e7cf-64eabd219d61@kernel.org> <CA+ASDXMt97g-r3PniB4Z9+DeETdybtZ2sUneRgmetRKVZC-FBw@mail.gmail.com>
 <01ee061c-bbf5-12f2-8e0e-eda3f9132ad0@kernel.org>
In-Reply-To: <01ee061c-bbf5-12f2-8e0e-eda3f9132ad0@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Mar 2019 18:16:15 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNMBTwY1ianfXrS1mGOi7TzekOwTULxpCaCqM6vZYbZ6g@mail.gmail.com>
Message-ID: <CA+ASDXNMBTwY1ianfXrS1mGOi7TzekOwTULxpCaCqM6vZYbZ6g@mail.gmail.com>
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel versions
To:     shuah <shuah@kernel.org>
Cc:     David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 6:59 PM shuah <shuah@kernel.org> wrote:
> 1. I plan to fix the tool to make it run on older kernels (pre-USB 3.0).

Great, thanks! We will probably do something downstream anyway, based
off the work David has done. But it would be great if upstream
supported this too.

> 2. I don't plan to support old tool running on new kernels. It doesn't
> make sense considering the security fixes. You can use the latest on
> older kernels (pre-USB 3.0).

Agreed for sufficiently-old tools. (Say, for instance, before this
year, where it seems we now agree that the interface shouldn't change
unnecessarily.) But eventually, this is an essential part of any
mature interface: that today's tools don't break on tomorrow's kernel.
(And yes, Greg noted that old things must die eventually, esp. for
such low-level stuff, so that might not be true for sufficiently long
values of "tomorrow." But it shouldn't be taken lightly.)

I think we already more or less agreed on that, but in case we didn't,
I want to make the disagreement clear.

> 3. I am going to assume you are *using* the latest stable kernels that
> have the security fixes.

That's a reasonable assumption. It's not necessarily a true one (prior
to 4.4, where we started taking that seriously), but where it's not
true, it's our problem not yours.

Thanks,
Brian
