Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2E3C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69707216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQLC2I7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfHUTNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:13:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42595 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfHUTNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:13:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so3062250wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApyQLdi+gYbeJe3vyoHHnQmW9ptBIH59qh3KB/xbWCc=;
        b=PQLC2I7tYSvd4myZXf2Ilp9iNr53YY66Eo0iCvmXj/DpSK/4QRW0AIe9OlDJg+p5lU
         pXgANzFjfHh8P1vmSlcTVCJgGwCxSLWSG/40iztlI1oZsD14H4iaAJQfesp+FWmdWxBE
         s9cBrKYbWVvwLek8XP9nQRkWpX1WR7/i2pCXkYBbwC2LWoPk6QQ3qXZrPxgFcycjOEQP
         NnhcLm1iy08SrqFZpWr/1fdUqKq0j8RFZXFmDXhWBWzUlOyr0tRDeKWEKvGVWzyDKKPQ
         Y4VExIwrShcvpJOETR+6wCS3Of1RGpsEPELd0UnHR22+bOAEr6WRcff0QhgUxGs7WzxC
         2QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApyQLdi+gYbeJe3vyoHHnQmW9ptBIH59qh3KB/xbWCc=;
        b=XRjzYYlrh1tqJujb59dEA7gAsahnB8Bhx6mjHj0iDnseQ7XY05vBbQhp5/Wegy9w5h
         Z61Xv8SlnwJpCA7LgRsyiGvZbp9YFcZuv49djr09G2XaqLxJjisfD6iZALLuTe5VYDeS
         8gxmRBceRf1nuieLFp5jjZnn28aZsUli/gkdFZWcs5JOZGJ90Z/bnKpb5pcdPeuihrdY
         lrxIhRV4bnpX6jB++eGif3w2BPmQ9agctIg6g7C/9Fp80w9RYn92hPpmlMiEzIePPR2X
         9DKXxSsZsJ+coGG0t0lha8vPEC/1PZ2mllpjO7nC9RLAjTtO58wgyFK32vrtXiM5KfbA
         cuWw==
X-Gm-Message-State: APjAAAWktlX9Nlc2SMpu+g5TqL8vUVpCbN2BKAT1noAMd1p5RpByYxJ6
        8pKTLUabGhUdjUmJdqkvMg1rzW1k/Ry860O6G3b56w==
X-Google-Smtp-Source: APXvYqwbY47BbnoK+28egtUMifMeXnSKEc9P9m8WLL3GflsH7HXxSqf4yPhOSzZmqRrE3NihPA6fLemHAEo5wBrLZEg=
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr3463137wrq.208.1566414801961;
 Wed, 21 Aug 2019 12:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190820230626.23253-1-john.stultz@linaro.org> <20190821180412.GA8385@ravnborg.org>
In-Reply-To: <20190821180412.GA8385@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 21 Aug 2019 12:13:11 -0700
Message-ID: <CALAqxLVq0rV8DheoF9qy9O0XSQik1L3CeEEAGNh7adBJirNZJA@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] drm: Kirin driver cleanups to prep for Kirin960 support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:04 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi John.
>
> On Tue, Aug 20, 2019 at 11:06:01PM +0000, John Stultz wrote:
> > Sending this out again (apologies!), to address a few issues Sam
> > found.
> >
> > This patchset contains one fix (in the front, so its easier to
> > eventually backport), and a series of changes from YiPing to
> > refactor the kirin drm driver so that it can be used on both
> > kirin620 based devices (like the original HiKey board) as well
> > as kirin960 based devices (like the HiKey960 board).
> >
> > The full kirin960 drm support is still being refactored, but as
> > this base kirin rework was getting to be substantial, I wanted
> > to send out the first chunk, so that the review burden wasn't
> > overwhelming.
> >
> > The full HiKey960 patch stack can be found here:
> >   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey960-mainline-WIP
>
> Applied from the mails - as this is what my tooling expect.

Oh yes, that URL was just for reference if anyone wanted to see what
all the churn here was for.

> Pushed to drm-misc-next.

Great! Thanks so much for all the review and fedback! I really
appreciate your time helping!
-john
