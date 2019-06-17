Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD32C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752122084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFo756ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfFQQeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:34:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41430 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:34:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so5969806pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ebkO1wyJElJAHhkYmwNP4KJfNQGU6gGWQjT69uRMtpY=;
        b=hFo756otAjIObcVe8/HRn/qZUyB6hF98qOkrhqiNuAHJARyd2c/tEBuji44b5i3WLU
         ZOohDVCX9y4s+FjGAlSl/BqCiWlR6elBk3gRt4KfqwnXMIv6wKBtYkFP6pp8fj+OcDLN
         Z/qsrRJ/zJXBJ2Wbjbh7VXWHUMcYctewkEbku5xlfwbs6HOR9HM/gYRpHqEGANYW25nr
         501fAtA0ETXTXCz3ZOEVHhMh68b0pN6xv9cjtCwJPE+imnLh+FW1aRTI9ncCXK8LTp2j
         8g7JsFIZx+RPHIdSwZVku8lAR4Pt5JNAcvcyK6qUQc3jBUMsVso41Q/MEln/52XeEmDE
         D5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ebkO1wyJElJAHhkYmwNP4KJfNQGU6gGWQjT69uRMtpY=;
        b=YZ6E5HpMDNI5q2z5EhBPSqSsh1+k9ScBpQC5VETZ6NSos/C1XSwMpFz+YOCvi0YSI4
         krrGUgR4eqhXm5tXiQjqV5VRFTRL+K6q2hNYgoNoFdlwcq8E44c2tKx0j5y4l7zcfZit
         mJQMskhMQTuDwVov5d6Wpx9L/w42sn18CqHrQztOyYNdirkWAQMEAs0Ytqk+P7IYbdpk
         IcLPvht7hpxHJGgfUI2xhGWUnJFyw8dMp6GppGuzK8my1bJsabIcv8heWO6U/tE2W4Ea
         23SM7JTnfwR2ZePp29L+QHfmc05baAFOpAdq52MC0BgUuux9N1PfTpYrTitynEU7qKxR
         /EkA==
X-Gm-Message-State: APjAAAXK1g4Sh+diX/nSTLLN9vMatlEE629+RxUDwbIHsF+X7c/SL7rj
        ntzQ9fukgz3x2f+BDLtfTzP7
X-Google-Smtp-Source: APXvYqzEOK55wn6wxv3xLz9QGXsTulkPtopaTMHSWzG0osIiTAA5EDU7cMDDPQr6I7aKH7BBeZ6riA==
X-Received: by 2002:a63:b24:: with SMTP id 36mr50408245pgl.439.1560789260492;
        Mon, 17 Jun 2019 09:34:20 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:629b:c246:9431:2a24:7932:6dba])
        by smtp.gmail.com with ESMTPSA id t4sm10401632pjq.19.2019.06.17.09.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 09:34:19 -0700 (PDT)
Date:   Mon, 17 Jun 2019 22:04:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20190617163413.GA16152@Mani-XPS-13-9360>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
 <20190617163015.GD5316@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617163015.GD5316@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Jun 17, 2019 at 05:30:15PM +0100, Mark Brown wrote:
> On Mon, Jun 17, 2019 at 09:20:10PM +0530, Manivannan Sadhasivam wrote:
> 
> > +++ b/drivers/regulator/atc260x-regulator.c
> > @@ -0,0 +1,389 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Regulator driver for ATC260x PMICs
> 
> Please make the entire comment a C++ one so this looks more intentional.
> 

Okay.

> > + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> You definitely didn't assign copyright to your employer?

Yeah, that was intentional. This work is not part of Linaro working hours and
falls into my spare time works where I'm trying to complete the upstream support
for Actions Semi Owl series SoCs and target boards which I'm co-maintaining
(sort of)...

Thanks,
Mani


