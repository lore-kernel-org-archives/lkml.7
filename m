Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04057C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81BA22CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcrfGics"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfIDIqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:46:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51363 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfIDIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:45:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so2332581wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UjxPLpoRTJDahkA20/YcDxWDLvHQIg0O7GSl3PV0lsA=;
        b=WcrfGicsOynEl7OkjgRdiLsuOPydRuyRn+4n1s6rO21+LFfWOpl0FghRZJI1Ef98WI
         cWd+g0HUb99J67J8QlASd1rE76yYeW9uBqbfIqS/d3FU89IAUFCJFCgAYjnxLrzGsvsH
         f/Fsj9E7guyAxHJIwOr7DNZAjKYtYGUdNWefvJVfSLG2fhs799yW7lxXp9UV/xfuQRmR
         +rpqBrqUxrCI9YPJu0Hi1uVMU4Js15p7OB2AKSdxSZN368zykUol1jt3VtUiXOrXjBct
         JuMo+E1yCHy6g0vZ+b1nDxb0b5JO+BnFpwgeeisQJtIyuYm7GmY0AzHU5irTfagIpLmu
         +oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UjxPLpoRTJDahkA20/YcDxWDLvHQIg0O7GSl3PV0lsA=;
        b=ud7WWiqWigsk+NsW0kyjdVDAmMjr9kEytbiBa5t7rJOcPFv4zT6m7B5brBa/cHYCJD
         JWQ9IMwhs2SSK5DqLMLPSxjxSWMgVdBoyiNXZpYUkA1XrCPNanNxUZOVByXgDdS+mcLF
         lg3ifVPpKsHI4L5kDe/zVNUpXhnciRXxAdpJDgCyol7qx2XsK1+LiONKvVWUv4WfziLb
         mNARsSTfsvt01pi8rWiCwBDdbl/Ol/3+CT6k4zYMKS7s0mFTgEG5I9ndhjj17OEVgNOh
         Qgm1HdQJW040Bi3pUT2bG0t6dCHKbdUWT6KJSNeXj429caBiyLJPVlobZxUy22cCjOaY
         7F3g==
X-Gm-Message-State: APjAAAUIN5DdfQxOEmyhxQIB+7nC05hOKqB4w64RdbdxK2AJN7sbCI3x
        PKkOgNedpMNGviMhgknKivIKpg==
X-Google-Smtp-Source: APXvYqzgk+6NoC5ihZJP9WaAtvy/AF4VregIt4YQm3V0VC3hTz2SNpcE7xwKl4SyuMFlT5hJt8A/TA==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr3556661wma.120.1567586756696;
        Wed, 04 Sep 2019 01:45:56 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id c132sm3367486wme.27.2019.09.04.01.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 01:45:56 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:45:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] soc: qcom: geni: Provide parameter error checking
Message-ID: <20190904084554.GF26880@dell>
References: <20190903135052.13827-1-lee.jones@linaro.org>
 <20190904031922.GC574@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904031922.GC574@tuxbook-pro>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Sep 2019, Bjorn Andersson wrote:

> On Tue 03 Sep 06:50 PDT 2019, Lee Jones wrote:
> 
> > When booting with ACPI, the Geni Serial Engine is not set as the I2C/SPI
> > parent and thus, the wrapper (parent device) is unassigned.  This causes
> > the kernel to crash with a null dereference error.
> > 
> 
> Now I see what you did in 8bc529b25354; i.e. stubbed all the other calls
> between the SE and wrapper.
> 
> Do you think it would be possible to resolve the _DEP link to QGP[01]
> somehow?

I looked at QGP{0,1}, but did not see it represented in the current
Device Tree implementation and thus failed to identify it.  Do you
know what it is?  Does it have a driver in Linux already?

> For the clocks workarounds this could be resolved by us
> representing that relationship using device_link and just rely on
> pm_runtime to propagate the clock state.

That is not allowed when booting ACPI.  The Clock/Regulator frameworks
are not to be used in this use-case, hence why all of the calls to
these frameworks are "stubbed out".  If we wanted to properly
implement power management, we would have to create a driver/subsystem
similar to the "Windows-compatible System Power Management Controller"
(PEP).  Without documentation for the PEP, this would be an impossible
task.  A request for the aforementioned documentation has been put in
to Lenovo/Qualcomm.  Hopefully something appears soon.

> For the DMA operation, iiuc it's the wrapper that implements the DMA
> engine involved, but I'm guessing the main reason for mapping buffers on
> the wrapper is so that it ends up being associated with the iommu
> context of the wrapper.

Judging by the code alone, the wrapper doesn't sound like it does much
at all.  It seems to only have a single (version) register (at least
that is the only register that's used).  The only registers it
reads/writes are those of the calling device, whether that be I2C, SPI
or UART.

Device Tree represents the wrapper's relationship with the I2C (and
SPI/UART) Serial Engine (SE) devices as parent-child ones, with the
wrapper being the parent and SE the child.  Whether this is a true
representation of the hardware or just a tactic used for convenience
is not clear, but the same representation does not exist in ACPI.

In the current Linux implementation, the buffer belongs to the SE
(obtained by the child (e.g. I2C) SE by fetching the parent's
(wrapper's) device data using the standard platform helpers) but the
register-set used to control the DMA transactions belong to the SE
devices.

> Are the SMMU contexts at all represented in the ACPI world and if so do
> you know how the wrapper vs SEs are bound to contexts? Can we map on
> se->dev when wrapper is NULL (or perhaps always?)?

Yes, the SMMU devices are represented in ACPI (MMU0) and (MMU1).  They
share the same register addresses as the SMMU devices located in
arch/arm64/boot/dts/qcom/sdm845.dtsi.

With this simple parameter checking patch, the SE falls back to using
FIFO mode to transmit data and continues to work flawlessly.  IMHO
this should be applied in the first instance, as it fixes a real (null
dereference) bug which currently resides in the Mainline kernel.

Moving forward we can try to come up with a suitable plan to implement
DMA in the ACPI use-case - but again, this is feature adding work
which should be carried out against -next, where as this patch needs
to go in via the current -rcs ASAP.

> > Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > Since we are already at -rc7 this patch should be processed ASAP - thank you.
> > 
> > drivers/soc/qcom/qcom-geni-se.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> > index d5cf953b4337..7d622ea1274e 100644
> > --- a/drivers/soc/qcom/qcom-geni-se.c
> > +++ b/drivers/soc/qcom/qcom-geni-se.c
> > @@ -630,6 +630,9 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
> >  	struct geni_wrapper *wrapper = se->wrapper;
> >  	u32 val;
> >  
> > +	if (!wrapper)
> > +		return -EINVAL;
> > +
> >  	*iova = dma_map_single(wrapper->dev, buf, len, DMA_TO_DEVICE);
> >  	if (dma_mapping_error(wrapper->dev, *iova))
> >  		return -EIO;
> > @@ -663,6 +666,9 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
> >  	struct geni_wrapper *wrapper = se->wrapper;
> >  	u32 val;
> >  
> > +	if (!wrapper)
> > +		return -EINVAL;
> > +
> >  	*iova = dma_map_single(wrapper->dev, buf, len, DMA_FROM_DEVICE);
> >  	if (dma_mapping_error(wrapper->dev, *iova))
> >  		return -EIO;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
