Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42037C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1643E22353
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uz/uKTs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbfGWNZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:25:49 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:39979 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbfGWNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:25:49 -0400
Received: by mail-io1-f49.google.com with SMTP id h6so81721249iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Po41j8PRY5LtQpBYzCHkpShqYoyBrgFgJu9cuq/d5B0=;
        b=uz/uKTs2ERrgrSdCSbcq1vIdME1ilXv4sLV+RcUNFOUViFYVgHtIjXpBYHZ0/qlSdn
         U3S5keAlaT27s3v6EKwsB0RRPnqXoPv2b7M5uL0uYaNAT2bSoJF8j4U3qzZTwa8i0Q3Z
         Gkgsfk/BLHTEEF1nfzfAK551ND5mKfnrZ2cZXrv3hgSLTK1yTHxv3WEsqjfrJfHcTPkG
         kNW5OI3MaEX90MO861qrzd4tejRH5+t3k0QsU2azCzVfrX6wASxZh8ISVjNurgHcOW9K
         +nA946p8cYEDSz2Jnxxx4uSi88TGhLPH/KdXjcuhkq5zN4xV8ZK+80PktwEXEO4T2Dx5
         Kc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Po41j8PRY5LtQpBYzCHkpShqYoyBrgFgJu9cuq/d5B0=;
        b=J08pGgHIJKykgoK8hyn028C5ZIA4HGXJC2ozAjOvQTYqRcCwwgGLyBN3yPMy2iuX+1
         v1fwbReDQXAxzQZsr1wd35hsMK79nSD4uzkOeVscs3aUSKsvmvbbYFut3O1I9ODyFCDZ
         OHJtu3HFPqICN4Plg6rZSvYQxCCC+g11iiMEw6vBMRQDd/jo7LemRiAMW0G3T/ij58nV
         ahcRtO1CrxV3fXFFVjMebB6t/F+WKW5xSGe6EKu/Dkf9/ay1KtKxwXsIin9OfQh46GMi
         R4tCJKbiOMQmijgAdzakKdi9CPdWufbOv2cQKu9idZlDX1gATuki7eJtL5aCV4Gwh9ui
         1iCA==
X-Gm-Message-State: APjAAAU2qOe5HScTyLHE3wqUj30rJSgWs1vXUILXEpYKJFsxbX9txmRA
        Xn+z93m20hLvwUgfQC6XeJVKW+GFuVslZTexYMU=
X-Google-Smtp-Source: APXvYqxMgqlz6GvdHFLT/7t94Kp592lxEsH0vlXisuylQVBxY4i30FAvi+JHiXla/iKk7hhau03ycLNl4yS62MysUyo=
X-Received: by 2002:a6b:e30a:: with SMTP id u10mr50063707ioc.39.1563888348352;
 Tue, 23 Jul 2019 06:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <2c912379f96f502080bfcc79884cdc35@fau.de> <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
 <2835dfa18922905ffabafb11fca7e1d2@fau.de> <CAKXUXMwfd133rv0bMert-BBftaqxxr_93dUHpaUjEwE8RE_wwA@mail.gmail.com>
 <8016ee9b5ee38fae0c782420ca449f863270cca9.camel@perches.com>
In-Reply-To: <8016ee9b5ee38fae0c782420ca449f863270cca9.camel@perches.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 23 Jul 2019 15:25:37 +0200
Message-ID: <CAKXUXMym7Sd28gVxVXj60XS+aoqM4DAtEp2aA7BUUu06YQYufg@mail.gmail.com>
Subject: Re: get_maintainers.pl subsystem output
To:     Joe Perches <joe@perches.com>
Cc:     "Duda, Sebastian" <sebastian.duda@fau.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Jul 23, 2019 at 1:18 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2019-07-23 at 10:42 +0200, Lukas Bulwahn wrote:
[...]
> > Joe, would you support and would you accept if we extend
> > get_maintainer.pl to provide output of the status in such a way that
> > the status output can be clearly mapped to the subsystem?
>
> Not really, no.  I don't see much value in your
> request to others.  It seems you are doing some
> academic work rather than actually using it for
> sending patches.
>

Thank you for that indication. It is good to know that our use case is
too special to be covered in the existing tool and serves no one else
besides our research work.

> You are of course welcome to extexd the script
> in whatever manner you need for your own use,
> but even here, I don't believe you need to do
> anything to the script but change how you use it.
>

Okay, I now understood your suggestion how to use it. Sebastian and I
will investigate and discuss this further off-list.

Lukas
