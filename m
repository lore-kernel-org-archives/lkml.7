Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F55C04AAE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901722173B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DW4j3UDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfEHVje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:39:34 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38749 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEHVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:39:34 -0400
Received: by mail-wm1-f48.google.com with SMTP id f2so431126wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlLtOGrHBLSmzj2HqHiA/JMzVq4aWeUV3lKlGygc0zk=;
        b=DW4j3UDdFuNljmD2YMSDHu+D0hVUBXSVotWQ7LJLXbvj1AU8dRFeFnEMDP4IMiAK0F
         7mycbPzWTNakeGiphcFr6lUQ2ikJ1TtkNg4tDF4bXxkcFpU9XdbwpL1i8lr4f5gMa0IH
         ecxuS+SefEHIiRQsm6J4lvEFTqqTU/Wirl2z6mfBgqhcT/U4DZlMQewL9SjlrLJBjz/2
         ILprFeLQUdJV8TZsTQVWVcbyvtNJ+Jr02KL8R63iZKt9t3R+kXMVXzITEbcxGytuU1Y7
         p5aN+WBRmXHSEBILPARlVUueB9+bfD7M8jb2fAzniKdT28d8O/fZF7taZzXZDko/UQLe
         4i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlLtOGrHBLSmzj2HqHiA/JMzVq4aWeUV3lKlGygc0zk=;
        b=nuRfEIUF2nkRj/Y4he4fw37DZfoom9EqYSIFYrU2Iak7fNYgixG0qNHV7UcAuEd6Px
         cXp0qF7AtPMo4eQRldsM11uWAf8qEdCJwq7eyH4piGKjVwmz3Uq8Wz3Fmi2DbD5rE14P
         UWBzftrQ1L/lW2nRKm1N1DTLVDcZPSULvO+H3S9cQbf9AwyRbAxw0yURjqH4SC8mscRx
         Noj/eu18TH2akKXSfZk9wDz+EJTaRRrM1wDMOPfz0wXC1ToDBIyJB9VvB9kSLvgHwYEf
         M33LUuPJAbyQUTtkx9UACk/4gLvU7E9J2BfI9yGy30VnY+aDvY4GMSDLVXg6VkOkDdDR
         gDLQ==
X-Gm-Message-State: APjAAAXHprRaDeMkcPMPqBWRZNojsLDjH7/cQuoewEXi7bVaBsQi6+Ra
        X82go4Un2mOI3TzqlLWvZQ33TaMcGXhyoWNnX4i/Eg==
X-Google-Smtp-Source: APXvYqwGwyJxbJ3cVDoz2Tw64zQzpRH/9D0bxmHtS5xfCMMwkaWskinNvn3j+3wwRGooFo9keBzxQBz2Z1TdUQvgUIE=
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr251594wmj.55.1557351571900;
 Wed, 08 May 2019 14:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <5d58059c-1b10-665f-983b-a1d018a30d1f@gmail.com>
In-Reply-To: <5d58059c-1b10-665f-983b-a1d018a30d1f@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 8 May 2019 14:39:20 -0700
Message-ID: <CALAqxLXJE0POEYRJ1qwZurD2RMYmJsP7g5PnPNZ1Kab1ZRW1_w@mail.gmail.com>
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 12:01 AM Andrzej Pietrasiewicz
<andrzejtp2010@gmail.com> wrote:
> W dniu 08.05.2019 o 04:18, John Stultz pisze:
> > Andrzej: Do you have any ideas or suggestions on this? I'm happy to
> > test or run any debug patches, if it would help narrow the issue down.
> >
>
> There is a patch:
>
> https://www.spinics.net/lists/linux-usb/msg178536.html
> https://www.spinics.net/lists/linux-usb/msg179653.html
>
> which fixes a subtle bug, but hasn't been applied yet.
>
> Can you please try it?

I'll give those a whirl, but those both look to be dwc2 specific. I'm
also seeing trouble w/ dwc3 based devices.

thanks
-john
