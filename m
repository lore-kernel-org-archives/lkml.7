Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4CD2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OKxZIXgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfCAAEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:04:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34115 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfCAAEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:04:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id u21so16677241lfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 16:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6vEDFatUlLOOK2igagXUb55zWkg+bRViRuJMbK51Uo=;
        b=OKxZIXgKJNV8snaAaJcSo7zXKFCFJcEeCBoGHPZI/GeOevt8QjWJRFpZ8HBf2J3gai
         g1weTQd5urPtNkr9eQikm9UWRwg8TiM55ISxtIxRkecsQhmsirVjcJ6uhllXbzwl+ahs
         etcvG/LOEaNVOxu3UwjDk9t4ReIuaJjy7Hb2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6vEDFatUlLOOK2igagXUb55zWkg+bRViRuJMbK51Uo=;
        b=ccqoAuq/MYNioKPRnFSY8mPjmTThrz/BLVek+PiOVBVe+Ki+7rWIItuXk680C4jb3a
         wSbVnIvJVJtIYs9fopS41RPpI5EQcjYtuqxI0rdiDgd8D3r+VdpWfoBiR9v6kjiZU5fY
         jThTKsNKVAAllBEGRvaMCYgx5+lQGqaxkz5n6grrk3nEaPpl35fbBCjdFkdCp+cH9AEx
         8Kw+j468Ft2kEb/JElgv+TPeBnScbg5s9AKcu4YEHTXZbBKNMGiG43w5IHtFcczFlXYT
         VbSdmTt3i7a3/RhEFiLNlBfZqxA34vOtbORe1KMlK2Fim28v5k0EQ/TjsiZvCijNhI0o
         lDvQ==
X-Gm-Message-State: APjAAAWcxiDugnlUQLzle5OUIbxrp6NbVko2CEf0WpfQHGzUkd4mN6Wp
        vVZLfjRxmXgutMsdupzv8b4T7KR1gEk=
X-Google-Smtp-Source: APXvYqzr156NNWUIbsSSR6u7x+qyzJGzpl1Bb4YD2zPQOaNevOD3HOE7kBa/tzoqtuDJllRjYVNnjQ==
X-Received: by 2002:a19:f017:: with SMTP id p23mr1185218lfc.103.1551398649941;
        Thu, 28 Feb 2019 16:04:09 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x2sm4255486ljd.30.2019.02.28.16.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 16:04:08 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id h10so16627328lfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 16:04:07 -0800 (PST)
X-Received: by 2002:a19:4948:: with SMTP id l8mr1300132lfj.156.1551398647297;
 Thu, 28 Feb 2019 16:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20190228115256.5446-1-louis@kragniz.eu> <20190228122417.9318-1-louis@kragniz.eu>
 <15c6689389503a82394bccb9204650bf20a7a6d3.camel@perches.com>
 <CACJJ=pzfSMgJbt5zKzgN-AcugkYRuGhbB88tsTX7k+-qPnS0jA@mail.gmail.com> <1450785b937f4a2b5f98c8548986b162684a719b.camel@perches.com>
In-Reply-To: <1450785b937f4a2b5f98c8548986b162684a719b.camel@perches.com>
From:   Jon Flatley <jflat@chromium.org>
Date:   Thu, 28 Feb 2019 16:03:55 -0800
X-Gmail-Original-Message-ID: <CACJJ=pz50c3oovHbKkjDDF=pabAj_9RtKGWvtpwx4nO+E_EtJg@mail.gmail.com>
Message-ID: <CACJJ=pz50c3oovHbKkjDDF=pabAj_9RtKGWvtpwx4nO+E_EtJg@mail.gmail.com>
Subject: Re: [PATCH v2] wusb: use correct format characters
To:     Joe Perches <joe@perches.com>
Cc:     Jon Flatley <jflat@chromium.org>, Louis Taylor <louis@kragniz.eu>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 3:05 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-02-28 at 14:23 -0800, Jon Flatley wrote:
> > Thanks for the patch and comments.
> >
> > On Thu, Feb 28, 2019 at 1:53 PM Joe Perches <joe@perches.com> wrote:
> > > On Thu, 2019-02-28 at 12:24 +0000, Louis Taylor wrote:
> > > > When compiling with -Wformat, clang warns:
> > > > ./include/linux/usb/wusb.h:245:5: warning: format specifies type
> > > > 'unsigned short' but the argument has type 'u8' (aka 'unsigned char')
> > > > [-Wformat]
> > > >   ckhdid->data[0],  ckhdid->data[1],
> > > >   ^~~~~~~~~~~~~~~
> > >
> > > I think the message is somewhat misguided as all the
> > > vararg arguments have implicit integer promotions.
> >
> > That's a fair point, but Clang checks the arguments against their
> > format specifier before they're promoted when using -Wformat.
>
> Perhaps clang could be a bit more verbose if
> checking signed types emitted as unsigned or
> unsigned types emitted as signed instead.

It is a little strange that clang warns when the length specifier
doesn't match but not when an unsigned specifier is used for a signed
value and vice versa.
>
> > When
> > considering integer promotions it's difficult to say if this is
> > "wrong",
>
> I didn't write "wrong", I wrote misguided.

Apologies for my poor wording. I meant "wrong" in the sense that it's
unclear if an improper length specifier is deserving of a warning.
After all GCC doesn't warn for incorrect length specifiers, and as you
pointed out Clang doesn't pay attention to if the specifier expects a
signed or unsigned value.

Cheers,
Jon
