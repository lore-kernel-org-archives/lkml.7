Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E927C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C03E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfENz/5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfEMSJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:09:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33768 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbfEMSJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:09:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so7972971wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZBxw3BQbaqpNiHsdkbnukeHq4nKrz3shSsyzzNHd4M=;
        b=cfENz/5UHqta8nz6XhqvxQcERP5bbinjZFJkloo4rlmvh+WnCitH0oRDl7eJD+6QYH
         nFHh2CcabhbSUAH/MMGL7dY5LlHsO2f8cdB/I8qZHb9B0e0AOn4GJz1lwjLJETBW15Al
         JTbbibvBOLCXHTGZn384Ulohsr5h2y8zEaXmJMUhOvDx+5MeYTygWYKYCXPSwUndPrhg
         CiU5LCZ2FHV9SrjYBGsNDTNiA+54Gx5nOR+X4rPWXeFI+HArG66hJz/A31W4yEwdtKQs
         0uPBqmM7a4/94wUNePKRHTckMn3O8h1fdks8slrLkcqTKHnzC5tPJfgCde+4+5jIOMzZ
         nRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZBxw3BQbaqpNiHsdkbnukeHq4nKrz3shSsyzzNHd4M=;
        b=JuXp2mot5spRVyGwyzuPkwUi5g4ko/HKuckY5N+h8wS6Ef962Oo96ne2SkRUuBgPej
         hzGvijQEWVBQLo1fGEFmTBPhxsrpm20Q+VL6UftrKoNpxWswIfsQOB/RQkmVrp7tDK6l
         69uxFBuv9jHMDWxUxE6hcEewk1dWIBhmZ0eTQy17uXnKqcv3Y+tFdXy/M6Chi7Zw3ovV
         BHTR+nP6fnEbsdL61FFzCnjbuksOpJSlERVnJynCxexr7z2yFKfrBlBh+KytM7H4lPQ1
         nAeiFo70tsTfR+VqddNSwjGMNqji3nZila3UJxUMPFj2I/fNxL//SzdyVYev3xN+nXnz
         Ah8w==
X-Gm-Message-State: APjAAAVZqKk/iqwvb+NnEHA3+lSh9lc5yAFPzoai7kju1yDXgYobaVDK
        rb7SERLOVLRJBn43j+p7titDSQjKR2ahPdf4+PoPFQi33eo=
X-Google-Smtp-Source: APXvYqzGMaGgYsxgysYiEyi7Oon8Zhg1rRup69UofSQu4xNqfLZshmMu0etOviRuzy8jC94vjH0ff8lakkLV+S9lpjY=
X-Received: by 2002:adf:ef83:: with SMTP id d3mr6001055wro.253.1557770975789;
 Mon, 13 May 2019 11:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com> <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
 <CALAqxLVUFfrPVVjR74V3PhhtcCytfp=cUYjo=BcJ14D1fkVXTw@mail.gmail.com> <7ec57c29-d1ab-dc4c-755d-a6009b9132b5@collabora.com>
In-Reply-To: <7ec57c29-d1ab-dc4c-755d-a6009b9132b5@collabora.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 13 May 2019 11:09:23 -0700
Message-ID: <CALAqxLUgnTB7aZ4edXCaG8SJsJzfY1_yNEPc6Losssw5Xy9-XA@mail.gmail.com>
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Felipe Balbi <balbi@kernel.org>, "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 7:08 AM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
> W dniu 09.05.2019 o 23:23, John Stultz pisze:
> > So yes, the kzalloc/memset patch is a clear improvement, as it avoids
> > the bootup crash on dwc2, and seems like it should go in.
> >
> > However, there is still the outstanding issue w/  functionfs sg
> > support stalling on larger transfers.
>
> Do you get "functionfs read size 512 > requested size 24, splitting
> request into multiple reads" message when problems happen?

Unfortunately no.

> Is there anything in the kernel log?

Nope. Just the transfers stall/hang and further attempts at adb
connections fail until the USB cable is unplugged and replugged.

> I'm unable to reproduce your problems. I thought I was able, but
> it was another problem, which is fixed with:
>
> 5acb4b970184d189d901192d075997c933b82260
> dwc2: gadget: Fix completed transfer size calculation in DDMA
>
> (or you can simply take upstream drivers/usb/dwc2).

Yea, I'm able to test against mainline. I can give this a whirl, but
since it affects multiple drivers, I suspect the trouble is in the
f_fs code, not just dwc2.

> Do your problems happen on dwc2 or dwc3?

The transfer hangs happen on *both* dwc2 and dwc3. And on both we can
use a similar workaround of disabling sg_supported to get by.

https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-mainline-WIP&id=21dfaac615f1f287377897804cbfe69450d489e3
https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=5b70ec4ae1c06ae700fcca7141130c71e205fa1c


> Is there a way to try your adb without building and running the
> whole Android?

Maybe? I have heard of folks doing it in the past, though I don't
really know a quick path to get there.

Is there anything else I can try for you?

thanks
-john
