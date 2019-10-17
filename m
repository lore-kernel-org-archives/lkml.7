Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0D7FA372D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6E520820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omGGAu8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408194AbfJQIWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:22:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40716 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389530AbfJQIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:22:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so1506754wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fYGdEVezenwEmKunM4P/w4H+KqhyuJh3iRzTJQLbaO4=;
        b=omGGAu8sfqDYj4mpAcGhJE/NCG4FiPlRoW4+kTIyASObEqQF/FuuzRsToebiwryRA9
         Vpg0CXJu0w1phdCJf0A/qLSnKGEUWER8ig/ml6ByVyt3Zz23S3B/d8MqvuE3GOnhOrev
         YbVOfDri0E/FERxwKZvXl38FQxuRXGfyojhSMitDshOtW4H6fmjL4W1VODZ4XEWI/AR0
         WYZMcEZx8U+5FngOZAJg1Xcd68aRZHD5C9ZrX/1PzGVp7aE5Sw7pT+KzUiLWbLHAl5nl
         X/ZrSh4/ql8atI2dArd7qp2bDIbZFaLl5Zv95FyRbJa5S4dLqNx7SizjxYO7ple1BiFT
         WMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fYGdEVezenwEmKunM4P/w4H+KqhyuJh3iRzTJQLbaO4=;
        b=SFYLzKl8LDBWliewG5vhJ8QmPvPftSuDVGE1X+JWuy6VtAT0ahQYyQ1n4qV+R8xyou
         7jSBOQdalokk0mM2AqbiE8qF197WD5wzayIXVB37nNtEA4/UGzSuNiH0jQd6FV6oMpF9
         Wcx7AKY4gc2tY/fpxelcR25NgoE4tFOtbydAfiytcqdpufI3RjjXVi7VRhEi3jEhQrsa
         RaZ9tzV1P5o+bUfrlFGyrHnT/ryrvcjyQCZP+xFS1dz867k2hBEu99oF6ax9XLm6sEst
         NGO8PvqFqNvaHqsaXBhlVhkE70h8dVfZOB2OQC2R2sW527/In1/Tji/YUZuzfOcZuFsm
         10uA==
X-Gm-Message-State: APjAAAUyf8u+qcFQgdf3pf5j36MQbpg7tuyuEsG6f14ymhr2CtATDvKM
        wu6h2aPLo7fG47Gpg5/aFyx7xw==
X-Google-Smtp-Source: APXvYqzMTGBl2RWAGCyV+z5jlnAko1HRTJcNJIpDvOCIZ7Oe9w89HcHBG6/902aZTae1LyXc86NXuA==
X-Received: by 2002:a1c:99cd:: with SMTP id b196mr1750399wme.105.1571300524077;
        Thu, 17 Oct 2019 01:22:04 -0700 (PDT)
Received: from dell ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id j1sm2042232wrg.24.2019.10.17.01.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 01:22:03 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:22:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tuowen Zhao <ztuowen@gmail.com>, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        mcgrof@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v5 0/4] Fix MTRR bug for intel-lpss-pci
Message-ID: <20191017082201.GN4365@dell>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
 <20191017071409.GC32742@smile.fi.intel.com>
 <20191017073116.GM4365@dell>
 <20191017080400.GE32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017080400.GE32742@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Andy Shevchenko wrote:

> On Thu, Oct 17, 2019 at 08:31:16AM +0100, Lee Jones wrote:
> > On Thu, 17 Oct 2019, Andy Shevchenko wrote:
> > > On Wed, Oct 16, 2019 at 03:06:25PM -0600, Tuowen Zhao wrote:
> > > > Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> > > > in MTRR. This will cause the system to hang during boot. If possible,
> > > > this bug could be corrected with a firmware update.
> > > > 
> > > > Previous version: https://lkml.org/lkml/2019/10/14/575
> > > > 
> > > > Changes from previous version:
> > > > 
> > > >  * implement ioremap_uc for sparc64
> > > >  * split docs changes to not CC stable (doc location moved since 5.3)
> > > > 
> > > 
> > > It forgot to explicitly mention through which tree is supposed to go.
> > > I think it's MFD one, correct?
> > 
> > To be fair, that's not really up to the submitter to decide.
> 
> Submitter still can share their view, no?

Preferences can be voiced, if held, and will always be taken into
consideration.  The final decision will always be made by the people
managing the trees.

The comment above implies a requirement to specify which tree is
preferred, which is not the case.  In almost all cases, it's best not
to specify.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
