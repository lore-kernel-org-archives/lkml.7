Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2103C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A420643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOJgdGI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfCKQuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:50:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38078 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:50:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so4997345wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9dBJ4NwNB62s3bZo7u0/QJA77GvfBIPB9kdw3KAMaY=;
        b=xOJgdGI0fsyw6kLv9GBWRaB+HufmWpOcmyV33pdqLNbEkxrY/WUdYrMs5x0/St2EV1
         i3fC0eLtOWPeqeemZlfMtD3sc9xOZBgh48DK30MG8Q6QZ3uE+5EZEDu5YOMFdqYcgL1r
         mrx+n4usHC4+UXD6/D5ZFzRh0qUtmsiluZeIWLalMLvPt1D3r2QStGQBoBq5PrydN5hO
         8twuQOuswhmCsewo+922TsLyIPueiCLxYEKCfL+4RmCLc9yjkgA+iPci/IPPKhiOkg13
         gvmNyu+Suc6tU4Q6kKPDZbAzxXunGdsMrBb6ymn8UjF0rDdab8qwUm2F93h1SWGqnxeE
         3mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9dBJ4NwNB62s3bZo7u0/QJA77GvfBIPB9kdw3KAMaY=;
        b=nlh3flw1ObiqpjG9wD2ZbDH0msVH6htxbjp6/FBjOwF8c+AIWUk76MOoWUtEpxJmjg
         hqS74FdqHzwDMFbN/3nqealVUjCDAfiz+iJSfVzAq4p2FOMSwcItGTBAKaOKXKFVJYnT
         sed7j5WPTKrrjHhjVzt+cKUrQ72zHrtmUnaBgxP2GXwCco1qvUc7svnO4/ZksQYEzOjw
         IvDiZZ0eg3Tk8jECocDJBD63gYQIvIkjXkpRNGz8UPAuIQPeowE2m8fqygCk7RkGiuFH
         Qvqi4MIh1Ga1kOfr387AJZJARYaP/bvZ1woUjubhK2exqcCCcR9NYZ6kDYquCnFpVbUM
         o7uQ==
X-Gm-Message-State: APjAAAWWi6xclHodBVU7yj/BnHvcH9DmnL+lF4s2hKygcy0YNkMgA9LZ
        SyjFekWU9YFa14oStr/2i7fkSfDiiUEtOFUdxM3dSg==
X-Google-Smtp-Source: APXvYqwQNBr5SGSUcDSVTSB60H/nsAkuIoexn1eoA8bjZ4GKIyDxLHSxeYGjZlT56F89uMidBVoFWU0upV9G+tl6cKE=
X-Received: by 2002:a1c:80c4:: with SMTP id b187mr395918wmd.23.1552323020672;
 Mon, 11 Mar 2019 09:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190308205332epcas1p181370b12f611fd746d333a557a1ddb48@epcas1p1.samsung.com>
 <CALAqxLUZKinhCasO4rXBJuip3bOo+JCovWLrHYPBPTopf6d7Vw@mail.gmail.com> <fe3b207e-1200-4a76-8c10-28655029f16d@samsung.com>
In-Reply-To: <fe3b207e-1200-4a76-8c10-28655029f16d@samsung.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 11 Mar 2019 09:50:08 -0700
Message-ID: <CALAqxLV2tWWNuo5UWq8UqDsUDbT4CQX5GVXiBRkHRb+322ys_w@mail.gmail.com>
Subject: Re: REGRESSION: dwc2: gadget: Add scatter-gather mode
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Gall <tom.gall@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:15 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi John
>
>
> On 2019-03-08 21:53, John Stultz wrote:
> > Hey Andrzej,
> >   I just wanted to let you know, trying to boot linus/master on the
> > hikey board today, I've been seeing lots of errors on boot (which
> > sometimes crash the board, and sometimes doesn't). See the example
> > below.
> >
> > I've bisected the issue down to 10209abe87f5 ("usb: dwc2: gadget: Add
> > scatter-gather mode"), and if I revert that change the issue goes
> > away.
> >
> > Looking at the patch, I can't see anything obviously sticking out, but
> > let me know if you have anything suggestions you'd like me to test.
>
> I've CCed new Andrzej's email.
>
> Could you tell a bit more how to reproduce this issue? Which USB
> function are you running on the target system? I've noticed that you are
> using functionfs. Is is possible to get access to the usb function
> daemon to reproduce the problem here? Which version of HiKey board are
> you using?

So this is on a LeMaker HiKey (2gb ram 8gb storage), running AOSP (so
its adbd that is the ffs daemon)

I have a mainline tracking tree which follows mainline here to provide
MALI gpu and other android requirements:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey-mainline-WIP

I'm traveling this week, but if you really want to reproduce this
yourself you can grab the system/vendor/boot images here:
https://snapshots.linaro.org/96boards/hikey/linaro/aosp-master/latest/

Then build the kernel w/ the hikey_defconfig and replace the kernel
image in boot.img w/ the abootimg tool.

Let me know if you have any trouble and I can try to help walk you through it.

thanks
-john
