Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A4FC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDB921D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NssoX+yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfJDVYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:24:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42220 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfJDVYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:24:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so7858831lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNGHFdo8S+XEl4ip8OV0waiNXwdBZOvLZWPEbaAFdNM=;
        b=NssoX+yI2Cgip/+Cwjg0GyMlo5A71XQr2ocWuZhlzYPkmzgbKvQlJyJYhcPoA+OKxa
         U5rtXE+xhKdQDS589JqhTYZ34Mhs6CHauo9DCh7MenK3ReWuDy0hYfxcjHlCj/tLQCnL
         rPAVfSSL1RzTwO294FsRpDk5Kux2n+yeTdDG+Or2bp0SnLCxChtgLJLeZt2HzKjx6yjp
         o8O/vg3l5OKp4QMi1X4kbkTUqa6v8sVukZTxHWhXF5btPpRICEzIw/cLSmY3+OW/0160
         v52tjq5PACVQprBMz2eUQilH1kiklfMsBO5732TVRSQ0ALApvD++8vEib3S4xsWmQJo4
         iAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNGHFdo8S+XEl4ip8OV0waiNXwdBZOvLZWPEbaAFdNM=;
        b=Rb8aHrAGLhU9s3hcRWz0gvvKGFRdATjpeod1klfwFqQUTggpHAGghEFBMFhJBePbL6
         kBfZi4BLghsQLW1mPNeXMPmYw7c5mTHdLu0FZXx5S63S6yVG1Z8iHpg154sKjVicimEY
         /IXcXyv5+vdWYY24pPFnh9tXFl70J5YxjMSjxjf2gSIIFQpkDZNFSkp34Ct0s22MWcRH
         3wUJfj2dH9oh69eHFA9fZZ4Jv4DjaqkPwNofHSlxXNz0a9aj9XWmqs2Y3l2wrK2ouf2A
         WPcVeXTuUNlYMoIRUmyONEuQNWRe+IoGike9q70USrhN756IwVNehfFRHdtaiYfQXRzg
         wc7Q==
X-Gm-Message-State: APjAAAW7F0cga7nwcJkdbcb1NbJBiDdBwez9Mulp6VROl+n7gpCtUhG2
        XRTapqf47qEQB155Hfbik8vQ65Hv8Nj0bAxgnaMKQw==
X-Google-Smtp-Source: APXvYqyMA9RzeuncA2ngYUaYy5cXaQEwJ+1dQ0bAT1/5pc3cn5SzEaJQSouN1M7jDax6q4MjNNAX0ngD/1TPXgjETbc=
X-Received: by 2002:a2e:80d3:: with SMTP id r19mr10510006ljg.41.1570224255943;
 Fri, 04 Oct 2019 14:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190910152855.111588-1-paul.kocialkowski@bootlin.com>
 <20190910152855.111588-3-paul.kocialkowski@bootlin.com> <CACRpkdY40PZc9R-yFwooR4-WMgn3LH7K+yTx00ZNxyq6OOnw6A@mail.gmail.com>
 <20190923133325.GA57525@aptenodytes>
In-Reply-To: <20190923133325.GA57525@aptenodytes>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:24:04 +0200
Message-ID: <CACRpkdbtFQWJK_RtdHrh8hr9HTq4Pmnd9VXC11H45w9XvGCU2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: syscon: Add support for the Xylon LogiCVC GPIOs
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 3:33 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> Maybe a first step would be to introduce Kconfig options for each device and
> ifdef around in the code, as to solve the "built unconditionally" aspect?

ifdefs is something we try to avoid using too much, better for things
to have their own files and use a library, usually, it's cleaner.

Yours,
Linus Walleij
