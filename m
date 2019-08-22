Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A156DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B2522CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIpf24nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfHVNxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:53:01 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37745 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfHVNxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:53:01 -0400
Received: by mail-vs1-f65.google.com with SMTP id q188so3888281vsa.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuGMouOtFOL6qd6oBESyF32JYfPiKh5leEjrSnKcwpo=;
        b=RIpf24nRH3NUjh7tR/MywKsXGcriypUW3Nw3anrRX3qatgw7KCnHTkXo3cU/OFH3X2
         NQeZCbxcPKcmtt7MbN/GPbEOg9oYcgPV2XCjK02rdsa0QPEezNRFzYcsNkaBHcH5Pe6y
         UqMYqZIINSZ39LZeTGVvj7L/jZXZFHzYNFSUmk7gxCW974AGFMP85ICYFbaLD2jmircr
         bHH603dKDy9u//yt275AVzVyqZ+GIXaLMYfSmSyxAUt/ZZqlHex64BJXlaG9J0iUkY1B
         SY++cLbJvsB6MHyhQotX+Y+tXTaF1SCJAFRyK71QAX/he5OHCp3ajltLGSNtA833uZNO
         esaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuGMouOtFOL6qd6oBESyF32JYfPiKh5leEjrSnKcwpo=;
        b=cCmx7oNsJBvQH7gY2N7QlS7F2VKOVA7mJsjde5cbsfdjAyXSlDTgg36GPj2jYzIYKc
         21PHneTFBEpmjp4DLYYhAsiCDWt/nYpePxKG8FURw7Gv1J/SkjWIvCDIgbcGNK5e4G4s
         S47P5JeDjW3ioya3m7PdpIRQe4k3JXNpLZcpSE7jzb09/HT3GpILh/0HMVrrYvtVW8By
         vDt2XCy7qD/XPhn9mVKHyGQ8MOdq4+j8HFEhyFga2IXZn48bwpif1lKvkuAw8csphQd8
         vqIKsgLYmIEcplsVKoCD1PPI8Eeb9DG0slX3q+NhhYZEeAeyi9dhGuQMqXt0lBmbz9Yj
         +hTA==
X-Gm-Message-State: APjAAAWcDIAihYCYCeMrN5GJ2lLHhetOol+fNv45klj099ap1dGWB9yF
        KbnALmPr5gCUN/qJ3h2QehlybxtvFeS2BnRkaBzs7A==
X-Google-Smtp-Source: APXvYqwLUBPKQGwaCHNT/xqZtRG5kBo+RsrpLvjiu+PO1wXYnj3Lf88aoVFjhAhrpB2zEipWIW/7o+VlnllMarHDCvA=
X-Received: by 2002:a67:61c7:: with SMTP id v190mr24937528vsb.165.1566481980346;
 Thu, 22 Aug 2019 06:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190708173330.13217-1-martin.blumenstingl@googlemail.com> <20190708173330.13217-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190708173330.13217-3-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 15:52:24 +0200
Message-ID: <CAPDyKFoFQ_QvHD-+Mg_VAR5rqs3CM_h7dw25p81JTzE1Yz7d1A@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jianxin.pan@amlogic.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 at 19:33, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> WiP - only partially working - see performance numbers.
>
> Odroid-C1 eMMC (HS-200):
> Amlogic's vendor driver @ Linux 3.10:
>   7781351936 bytes (7.8 GB) copied, 134.714 s, 57.8 MB/s
> This driver:
>   7781351936 bytes (7.8 GB, 7.2 GiB) copied, 189.02 s, 41.2 MB/s
>
> EC-100 eMMC (HS MMC):
> Amlogic's vendor driver @ Linux 3.10:
>   15762194432 bytes (16 GB) copied, 422.967 s, 37.3 MB/s
> This driver:
>   15762194432 bytes (16 GB, 15 GiB) copied, 9232.65 s, 1.7 MB/s
>
> 1) Amlogic's vendor driver does some magic with the divider:
>       clk_div = input_rate / clk_ios - !(input_rate%clk_ios);
>       if (!(clk_div & 0x01)) // if even number, turn it to an odd one
>          clk_div++;
>    It's not clear to me whether what the reason behind this is, what is
>    supposed to be achieved with this?
>
> 2) The hardcoded RX clock phases are taken from the vendor driver. It
>    seems that these are only valid when fclk_div3 is used as input
>    clock (however, there are four more inputs). It's not clear to me how
>    to calculate the RX clock phases in set_ios based on the input clock
>    and the ios rate.
>
> 3) The hardware supports a timeout IRQ but the max_busy_timeout is not
>    documented anywhere.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Martin, overall this looks good to me. Once you moved from RFC to a
formal patch I will check again, of course.

There are a couple of calls to readl_poll_timeout(), for different
reasons, that I have some questions about, but we can discuss those in
the next step.

[...]

Kind regards
Uffe
