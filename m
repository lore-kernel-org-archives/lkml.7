Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB11C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9348521726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT59i1R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfIDRHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:07:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37656 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732610AbfIDRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:07:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id r195so4695691wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OmbrMDzjBpiOxmAtJ5tpbDIpWnFC6mZzSWfiYEEna1k=;
        b=DT59i1R1IVCqVqjH/Pzz6nG1z04AT2jwcDTq/Hjuv5d79AwcEZu8Bm9ozefrl/gopQ
         SCFql3VM6ygPT0Y8fJZ5na+4iFOeAal7ie6ABTtEjeoRbpfTEh1arj3246ow5U+lHc7b
         U9FudxoN5QN7fNtoIOLXlqUaGJo3FvuTZ7WEcvVvliP5sA15eGmWBOxL5JbmJtk4L3KA
         hcgbAB8GV9LSqUj+z5G8iL0gThz8xJutMlKEE1aQj89RsleDV35ljWat1/g30Syt9567
         FEoJDA5Kdg6L72aGtyGGagxhsnvP/eusL1TnlQd78QrMGhYVNH33Ad7GQvoiqrj2+MXk
         svig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OmbrMDzjBpiOxmAtJ5tpbDIpWnFC6mZzSWfiYEEna1k=;
        b=JppR47nCQGWsgDeVDgM5sHWFTT5z853zKrx8EweKRfuU9WzLtsFccimc/HWBaU+CCj
         yxwtHL/D63rjz69Jf4ztfKN/Sm8vANMrlXGsWSZa4qjs1xjHr9+PKWRM8ofH7heKpDfb
         PM9mvfKm+QxOa8qtqoVDUhC7NcEndeumteZgLYcnyMDxGbu4LTRSkBlZ5x5sagWFBVvA
         LrQ/DZhBY7yLiFbf+3JlxISs4zuCDYDYD9S/DTj6gn7M7eBE07VakaD0OFymtUwXtqQr
         3zQUZanBwiytl/lvsAN+X5jyPgkuvfUpWx6G5TpxjSE4EkxtNIMOzp2zv0ghUJFikXxP
         4lfg==
X-Gm-Message-State: APjAAAWHmbHJlXl1+G2lQcfkMdRcF6Gf2JWOtzeBrFL5P77JD7WIIKQI
        6kCoryZ12CdU9vHxVwbx5aQOiw==
X-Google-Smtp-Source: APXvYqw1tqP/h/YX6foxFEa/SPKEduE11Gj2PCn45FoInpy6jTOi7mrXrxeQ+Jh3ASfHe5VUL9HNFg==
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr5138400wml.144.1567616823581;
        Wed, 04 Sep 2019 10:07:03 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id j18sm17633627wrr.20.2019.09.04.10.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 10:07:02 -0700 (PDT)
Date:   Wed, 4 Sep 2019 18:07:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: Add Lenovo Yoga C630
Message-ID: <20190904170701.GR26880@dell>
References: <20190904121606.17474-1-lee.jones@linaro.org>
 <20190904141257.GB6144@bogus>
 <20190904161247.GP26880@dell>
 <20190904165246.GA25356@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904165246.GA25356@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Sudeep Holla wrote:

> On Wed, Sep 04, 2019 at 05:12:47PM +0100, Lee Jones wrote:
> > On Wed, 04 Sep 2019, Sudeep Holla wrote:
> >
> > > On Wed, Sep 04, 2019 at 01:16:06PM +0100, Lee Jones wrote:
> > > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > >
> > > > The Lenovo Yoga C630 is built on the SDM850 from Qualcomm, but this seem
> > > > to be similar enough to the SDM845 that we can reuse the sdm845.dtsi.
> > > >
> > > > Supported by this patch is: keyboard, battery monitoring, UFS storage,
> > > > USB host and Bluetooth.
> > > >
> > >
> > > Just curious to know if the idea of booting using ACPI is completely
> > > dropped as it's extremely difficult(because the firmware is so hacked
> > > up and may violate spec, just my opinion) for whatever reasons.
> >
> > Once [0] is applied, we can boot Mainline using ACPI.
> >
> 
> Good to know.
> 
> > > We just made ACPI table version checking more lenient for this platform
> > > and would be good to know if we continue to run ACPI on that or will
> > > abandon and just use DT.
> >
> > Which patch are you referring to?  If you mean the ACPI v5.0 vs v5.1
> > patch authored by Ard, then yes I know, I instigated it's existence
> > due to these devices.
> >
> 
> Yes exactly that one.
> 
> > DT will *always* be more enabled than ACPI, so it's advised that you
> > use DT for anything useful.  ACPI booting is ideal for things like
> > installing distros however, since they do not tend to provide DTBs in
> > their installers.
> 
> OK, as along as it gets tested/used in some form, that's fine. I do agree
> that DT will be more useful on that platform as it was derived from mobile
> based SoC SDM845 rather than solely designed for Laptops and with more
> alignment with ACPI spec. The way whole power/clock management is done
> with ACPI on this pulls me towards DT ;)

Exactly.  For Power Management on ACPI, we need to re-implement the
"Windows-compatible System Power Management Controller" (PEP), which
considering there isn't any documentation and/or source, would be a
mammoth challenge, if at all possible.

Feel free to provide your {Ack,Review)ed-by for this patch. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
