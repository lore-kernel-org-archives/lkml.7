Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB18C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950A42053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTfKPX0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbfIDQMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:12:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38977 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732548AbfIDQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:12:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so21936361wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q8pUvpVjKp1g5Qr8w2IVnrREUirRn/vuVmUWXmSYL4Q=;
        b=LTfKPX0N8u61M2wJ5sy42uTQ+BoMX6ermJhYqKH/Q9DtGM30IwZRVjEk1iEvZtxsFg
         jQGWkdRoBDp2evmwXeNcR4Jf89nZto3VO5zeJr9dneojF1ouo9VkWbE2ima2ckTz/TcK
         HUhJSSX0ZdT69PvDgc9MqPoNpwJNAMOvdEDZ8rgfjX8b6w+KYSLYv6oexA5UhJ9bgwjk
         xdzh+p3SgAql537WzCRStiL10eKM0SWalzasmaxAMDujB9HZfdyPziW4Os3qGGG5zIEj
         0qayE9Hgo+ALfLW3FOs/S7GpC4nmNRQVGtWL0kMqrLWlSOjpmVJQLLFEeObL1ztJmEU4
         3jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q8pUvpVjKp1g5Qr8w2IVnrREUirRn/vuVmUWXmSYL4Q=;
        b=WzD02HIBxCz3wHixBPwvSucE4+MPbEcFbocbPR+v4821qHMwMmB62K7oQnQm3ahB48
         O7216I0ole7hLTJYHEDZPsBaH5sdWXaELGCvHIZn66+aLUnVmBv7Cmg95mAI0Lk5Eofc
         1F8Q8YMWp8LH0VwnErRkSZipOjhlmPZmewcixtiHs85fgxsxT6g1toO0u7/o6YTaIGGm
         D3BwBo94279Up+HUmvfIeBZS2t9PcdF9tCZwCtj1rkCEh4whQyhlwnAXHxy335FKtYEo
         DzoMiS8ancwX10cD6E6DZWfjiq4/YT3mMRI0D0EE4tVPilI2N8acIhzPfyZ8DsZRYHN5
         +4Ow==
X-Gm-Message-State: APjAAAUNAK4wQzZFIVDIiw0fKvgUzf5jRi0CseoCPxqJ3Tm7U3YueOxk
        cUGS5EaWi9hlBWjAScFe4yBFfQ==
X-Google-Smtp-Source: APXvYqwdxIz1SPASSWDxK72taN7umX8eaGJ50gyjNa1JHwg+UjQz1fdTJ6rPguOhSqf3vQ64uuDm7w==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr32359282wro.234.1567613569826;
        Wed, 04 Sep 2019 09:12:49 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id e6sm19269452wrr.14.2019.09.04.09.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 09:12:49 -0700 (PDT)
Date:   Wed, 4 Sep 2019 17:12:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: Add Lenovo Yoga C630
Message-ID: <20190904161247.GP26880@dell>
References: <20190904121606.17474-1-lee.jones@linaro.org>
 <20190904141257.GB6144@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904141257.GB6144@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Sudeep Holla wrote:

> On Wed, Sep 04, 2019 at 01:16:06PM +0100, Lee Jones wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > The Lenovo Yoga C630 is built on the SDM850 from Qualcomm, but this seem
> > to be similar enough to the SDM845 that we can reuse the sdm845.dtsi.
> >
> > Supported by this patch is: keyboard, battery monitoring, UFS storage,
> > USB host and Bluetooth.
> >
> 
> Just curious to know if the idea of booting using ACPI is completely
> dropped as it's extremely difficult(because the firmware is so hacked
> up and may violate spec, just my opinion) for whatever reasons.

Once [0] is applied, we can boot Mainline using ACPI.

> We just made ACPI table version checking more lenient for this platform
> and would be good to know if we continue to run ACPI on that or will
> abandon and just use DT.

Which patch are you referring to?  If you mean the ACPI v5.0 vs v5.1
patch authored by Ard, then yes I know, I instigated it's existence
due to these devices.

DT will *always* be more enabled than ACPI, so it's advised that you
use DT for anything useful.  ACPI booting is ideal for things like
installing distros however, since they do not tend to provide DTBs in
their installers.

[0] https://lkml.org/lkml/2019/9/3/580

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
