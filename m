Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E7C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007DC2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSHsBcXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfG1WJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:09:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37306 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfG1WJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:09:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so2360806ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX1hpidhvVd2B1jpZNjhTE/QLOo8ZOGtRfMqnoho3GM=;
        b=WSHsBcXZ7JERbbGCMkWI5YCfQg8C14MBHZJm3Hue5oF7J5DyqJl6tQpVbngQ8q52c8
         2ScdHTPvRGepFlQLYPWxw2+AXctL99KLBkHSFQ8O4PukhjvxlRN35e1Mbo2a9eAsRy1L
         kJeMT5pviW3zV/uCvwdcsc4DwJCul8jcDjVvLZOXt+LUuxErTKp4EjWHWw8RditvsrEk
         Ql1emScyRfzwoGqoycMYh2gQ9ULJv2iQuCMF5g1ImxA1dcbqvRfi1uanPOPq3N2SLAHn
         ak5s40rLE1mfZYkTU+iKfp8r8S/5/BMctQsqsZ8htKP912yknb+5p451H5XxfSf1/42x
         1cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX1hpidhvVd2B1jpZNjhTE/QLOo8ZOGtRfMqnoho3GM=;
        b=EmnrTTVNDV8fAJ1nq2W6QxLRZw2ND1k2WDY2Lp5IIBZIJY5843JJUqtXRajdebH8/z
         7jCpDE7ZoAuYkJQCRfR0fufOURd35sOQuA3nMpNkj8JZ8d0XJpYL81WKTh/Fb7f7QEGA
         b4oo9tmbRBGg/5vXldXku3E/vAOxw25WSZtkPemkB1dk/QrEMh0rbg2NE0ZjYQ8KlRWu
         IXh0Ug7ky+rPzJUcfAnPqtl87Dl7R35m4FwdoIuFntFaqJM2b+eNdQ5/yeVi2lNKZvJX
         CkdWHoXv6WF+HnGTbSQMSB1SmyJ/ygge790mOMy8AfkCI5SkGC/ArXHeNGC2lX96EPEm
         DnpA==
X-Gm-Message-State: APjAAAXxEt+z4QdA3ibqUD6MmBlQ5hLYHJYkgA/kXQQBZE7luMmeCu6C
        xIrj2UzHuHEX2h8v+9Se8xVXw2xifO9HepsjmHcVVg==
X-Google-Smtp-Source: APXvYqywJuBj32EcmV1j+DhpREz2WRlJ8AJL77FsJDcPL2Uh+1cobshd9SxF1ulQUi38gPjw1BTeSgp8v1gBCV2YbpE=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr8043666ljs.54.1564351771778;
 Sun, 28 Jul 2019 15:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190606010249.3538-1-bjorn.andersson@linaro.org> <20190606010249.3538-3-bjorn.andersson@linaro.org>
In-Reply-To: <20190606010249.3538-3-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:09:20 +0200
Message-ID: <CACRpkdbSrGq7ma2ywyQ89N8PKQWLVUiz8NqE4iGyctyENcBKSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scsi: ufs: Allow resetting the UFS device
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andy Gross <agross@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 3:02 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Acquire the device-reset GPIO and toggle this to reset the UFS device
> during initialization and host reset.
>
> Based on downstream support implemented by Subhash Jadavani
> <subhashj@codeaurora.org>.
>
> Tested-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I agree with Rob that just "reset-gpios" looks better.
Otherwise:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
