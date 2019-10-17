Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576E1ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEFC20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MvI8fZNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503051AbfJQQu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:50:56 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38019 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503041AbfJQQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:50:55 -0400
Received: by mail-il1-f196.google.com with SMTP id y5so2715569ilb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBLNQqGbXkMMNFqwqmoHYpYR0omjyH2DGrqLk8lOHRU=;
        b=MvI8fZNQWqbbSWHSvnZ/YilFT8r4cXVjXFQLbWKFHwMU8rmnUzL7K0U7z5JH/0eobW
         tbUj8KjJpd9z05VN5jN3ZzXxr8yawzv+YjV/j/bJdAAWZMxY4CF+Mn4J3g8EbucRK0HU
         ocyC0XJjnK9HgOO3KDcSz/Q2uRNI1vIBMro+XbyDI5y7q72LPb93CBqPwRsp5244gISA
         mCRHf/ofo4mbZL+TotrdbLWcutWnrPd3oEYetBwlcx97bIfKJdbH5dYcoimf1YyvuaJ2
         j+a1Ymg/cLrIUhAfHFlH7TCAjLWLLrq+PSotmrhtIsIaitOcf84U8EHheu9nDsOTE2qw
         MKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBLNQqGbXkMMNFqwqmoHYpYR0omjyH2DGrqLk8lOHRU=;
        b=ln5wL/H/DKaDQRvnWdApnlZCUtEdp4La/laATk7+rXuhAxBOE0YG9guMeG+MW6zLnO
         0U9xtcbuha4VsHTHdQzao/Si7ZF3oR6pHM5Q4z8VDKNwRJFRdE5N7Nr2n+l/lGoxVMQm
         a1Z7dpLbGZ5b65iwZEXkON9fgPtzFz88nfY13HxrNw/MkbuZSp/Bd2jHhz2nAU3Imncd
         AUsbHqwlmq3m2b81fNxxUQGmxXsqvSPMxF7nt/qxvATTSihwikC8Ae5I0vJ/qQYUNLcA
         FFoFSg2m9S6C6ABVO3jfL2Td8RpSxbUA9gKgxoTfX0LabynO3TC4MF4MRWRbZ/lHcMl+
         vvFQ==
X-Gm-Message-State: APjAAAVGlMvVaXWaO2wJEzHHOmIz/Fvf295rW5I4vtGJBifddimm6ZMO
        WOc4Ii/MWtzjl+buorMPgFsSdxlyxet4FHj/3gI0K+++
X-Google-Smtp-Source: APXvYqzaJqnOh8u1ffkHjbOR8474PuKjMUFOrqsL8xsQWJAm4wh9nEWyJeiQKud1Q6f+SzNL5TC5NIZfvS6/nl1YvvE=
X-Received: by 2002:a92:40c4:: with SMTP id d65mr4939938ill.50.1571331054413;
 Thu, 17 Oct 2019 09:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191015065937.23169-1-mathieu.poirier@linaro.org> <20191016183121.GD801860@kroah.com>
In-Reply-To: <20191016183121.GD801860@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 17 Oct 2019 10:50:43 -0600
Message-ID: <CANLsYkzg2kwxTG=+RZr4CNqQxNSttcyp_bbmO2u=Vq=HJ5_xtA@mail.gmail.com>
Subject: Re: [stable 4.19][PATCH 1/4] ARM: dts: am4372: Set memory bandwidth
 limit for DISPC
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 4 . 7" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 at 12:31, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 15, 2019 at 12:59:34AM -0600, Mathieu Poirier wrote:
> > From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >
> > commit f90ec6cdf674248dcad85bf9af6e064bf472b841 upstream
> >
> > Set memory bandwidth limit to filter out resolutions above 720p@60Hz to
> > avoid underflow errors due to the bandwidth needs of higher resolutions.
> >
> > am43xx can not provide enough bandwidth to DISPC to correctly handle
> > 'high' resolutions.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Cc: stable <stable@vger.kernel.org> # 4.19
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  arch/arm/boot/dts/am4372.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
>
> What about 5.3?  Is this ok there?
>

Yes - all the patches in this series are also applicable (and apply) to 5.3.y

Thanks,
Mathieu

> thanks,
>
> greg k-h
