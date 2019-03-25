Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840F120828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IeOEeLff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfCYXCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:02:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43408 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfCYXCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:02:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so9373552lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdPpZB5vkBI+EFPOi1OAj3cIg/tTC1XEzFIU8acZ7FQ=;
        b=IeOEeLffXVGK7nzRBsTCOhpGUNJS0QPLgz9vm6nFElERJeNYOUNSwUHq6wvEU7cBzd
         uj7uaSCjbUClheOpmpoOZHyanb3t6Y5rbfLhNHV1WCCMqgDHmVLEvsjZk12fwYvRjzPw
         jwEwdiyitIwO/Ib3921S2XJOoZEGK9/cV3VRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdPpZB5vkBI+EFPOi1OAj3cIg/tTC1XEzFIU8acZ7FQ=;
        b=fTjnvSGefekCCOrQqjSDzHVoXRsG+pzuhu445hR2+JEF36FpBTYYd3fT6LS1gH1IK0
         p0YDJndCf2NBPhEs3Fp7Wty1wd2zV0RUFHPamM17O80SnzLJL9z/2bQKPe+CX6sd3C77
         GeIKvwyoBI8m5lGF6Q4OgGPmSVtWGU/WnwIRh2qb4fDzFvtksJg9E66hBmq4Hefb0lF+
         QX9X3bmUM8WewIVcfJxqTq8qXdYYTgcdUzdR98QHnw/gkJwQVerqezvo/5QxS/KC4n6C
         apTMVAZKOkns3t84QsAVzTLRIE+9KGM5Az7qZQzu2POB6d130FldYUoD0wInxcklFWIp
         8a3w==
X-Gm-Message-State: APjAAAXh2gzPZCbkN53RnKk9RAvvFOntwcEHvvYo5IXr4PYwYgas1rnu
        8lFvnUayYMKfvaMrm2f+hPLuzb70284=
X-Google-Smtp-Source: APXvYqwLaAGt/r/XR8v+pmzHn2xx/fPfZGbQEW/CXHlHQLtKq/xFjSWvUhGnFLthbhftX6Av8bJxdA==
X-Received: by 2002:a2e:7806:: with SMTP id t6mr14631901ljc.143.1553554963851;
        Mon, 25 Mar 2019 16:02:43 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id g24sm3607919lfb.49.2019.03.25.16.02.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 16:02:42 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id t13so9359272lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:02:42 -0700 (PDT)
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr13966540ljk.78.1553554962375;
 Mon, 25 Mar 2019 16:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214730.6545-1-valleau@chromium.org> <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org> <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org>
In-Reply-To: <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Mar 2019 16:02:30 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
Message-ID: <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
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

On Mon, Mar 25, 2019 at 3:07 PM shuah <shuah@kernel.org> wrote:
> On 3/25/19 11:56 AM, Brian Norris wrote:
> > On Mon, Mar 25, 2019 at 8:51 AM shuah <shuah@kernel.org> wrote:
> >> In general the ABI is stable.
> >
> > No, it really isn't. This commit was a breaking change:
...
> > But this one is definitely a break:
> >
> > commit 1c9de5bf428612458427943b724bea51abde520a
> > Author: Yuyang Du <yuyang.du@intel.com>
> > Date: Thu Jun 8 13:04:10 2017 +0800
> >
> >    usbip: vhci-hcd: Add USB3 SuperSpeed support
> >
> > You can't just arbitrarily add columns to the beginning of a file like
> > that and claim that you're not breaking ABI. And I shouldn't need to
> > remind you that Thou Shalt Not Break User Space.
>
> USB 3.0 driver and tool support went in, I would say it was oversight to
> not make sure the tool continues to work on older kernels.

While that's true, you're still not grokking my main point when asking
about ABI stability:

  *old* tools should still work on *new* kernels

The above commit broke that.

> So what's your ability to upgrade to 3.18 latest to get the security
> fix. You would want to pick this up anyway.

We'll take cherry-picks as needed. You don't need to worry about
exactly how we maintain our branches, as that's not really the main
concern of upstream (at least, not in terms of kernel development).
But for the purposes of this conversation, assume that we have that
bugfix.

> Now the second issue is "supporting the latest tool on older kernels".
> Guess I didn't think about the possibility of tools from 5.1 being run
> on 3.18 :)
>
> I am willing to guarantee that going forward the latest usbip tool
> will not break on the supported stable releases.
>
> I am going to take a look at fixing the tool to run on older kernels.

That would be appreciated, but frankly, even that is not really
required: if you want to maintain the tool such that it always assumes
the latest kernel features that's your prerogative -- we don't have to
upgrade every release. At some point, new software tends to require
some minimal dependencies beneath it. So again, it would be nice to
degrade gracefully on older kernels, but it's not an absolute
requirement.

The biggest issue, as noted above, is that I currently cannot run
older usbip (user space) on newer kernels. That's a flagrant violation
of kernel ABI guarantees.

If you did consistently maintain ABI as noted above (old user space;
new kernel), then your users can choose to upgrade user space only
when needed. (And so, for instance, I could solve my problem by simply
downgrading to usbip tools from 3.18.) Today, that's not possible.

Brian
