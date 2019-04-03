Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC165C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF1620830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2WmTkDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDCH5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:57:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41953 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCH5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:57:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so7739799pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IwPDCcHtBbtFNI5oM6cINn5nEmj9C1ceQx82ZK3MxZY=;
        b=g2WmTkDmAf9QsHTruBaKnuZC0rwX6AcGeQMW2dzyN/CTckgewW14oqAUOaYUobrRDr
         EUoTcAE2W8v1Ds9pAFMBKXXBbDi/WCc/p0y0eLERCecqYGrbs7Sw78hlk283klMq2hkP
         f32+pHCF6KPApk49Qv48YEFMVQ45hQwPI+xQV7XJHmTrAJWFnfEJAfp6rBawWqpKWNQF
         d9YaCvUqjA/SJmHtGLqXW6NfGjDSygXTp3n7mqrd9Ak1+KpBJhOEBN3HVl9l9cP+eWtV
         ZC+S8KQU+yikAOxHWdaui/qhuH9WjYQvtp4qMG9WX7BDIuVLQY0VeEsYOdWF2ktAZrCu
         VYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IwPDCcHtBbtFNI5oM6cINn5nEmj9C1ceQx82ZK3MxZY=;
        b=GNi9tefdavrwYV/xK0PHHqGmdLpheBpim+dYGzbJ21REpjQcTKvML9jFHUdi+W+4wa
         G4DaHq/4CYX/Ow3GC9zcBH7bQwLzjkGK4sTAkJwbIB1Xt3xeSjqe6aj5abOyoAJOnKAH
         ZyyfpUUGgQm/+UcvPL+JD1gsVOGQJ5+mKd6+4+ekP4hPOHMWfbpOffGn6UQ8hcHJdUTI
         PU3peBkyP/lpEpNKR71cFgmk13qebJ2gB4FudV90n8Ho+K+816gM7BdWlcoX8eR9KUpe
         ifpPMaOXlZNKPrFqWEBaTXeSaaaKi2Hv6ikVkybkaKvjCSfM8COaXDmYpbWiGVEJNdYu
         FohA==
X-Gm-Message-State: APjAAAVR5c7xZCksVr8MZI6MlDIOS3QGmGl5hVQv2tc0V+l1evrRaw/9
        +jNc3eau2UnqxkTGwxEf/fFJDQ==
X-Google-Smtp-Source: APXvYqzm6P8ZtgWBW9J+YKNvWWlq5V3VPQqJo3RzyVbL27b/rDrISPZHTA29J5l7xck9q50qJC4+8A==
X-Received: by 2002:a63:4718:: with SMTP id u24mr72256115pga.381.1554278235390;
        Wed, 03 Apr 2019 00:57:15 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id k65sm13741934pfb.68.2019.04.03.00.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:57:14 -0700 (PDT)
Date:   Wed, 3 Apr 2019 08:57:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: ti-lmu: Remove LM3532 backlight driver
 references
Message-ID: <20190403075709.GD11301@dell>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-3-dmurphy@ti.com>
 <8769a95d-179f-6219-0a63-9dd623cdd297@gmail.com>
 <20190325075317.GW4731@dell>
 <c950b7d3-eeb1-2dc2-b732-3a40d5b3a8b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c950b7d3-eeb1-2dc2-b732-3a40d5b3a8b7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Jacek Anaszewski wrote:

> On 3/25/19 8:53 AM, Lee Jones wrote:
> > On Sat, 23 Mar 2019, Jacek Anaszewski wrote:
> > 
> > > Hi Lee,
> > > 
> > > Can we have your ack for this going via LED tree, please?
> > 
> > Patch looks okay.
> > 
> > You can take it through the LED, but if you do I will need you to send
> > me a pull-request to a minimised immutable branch please.
> > 
> > If you cannot do this, I can apply the set and provide the same to
> > you.
> > 
> > If you choose the former:
> > 
> >    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Please let me know what you decide
> > 
> 
> I've been exposing integration branches in the past, but after Linus'
> message [0] I have my doubts now. I wonder if it wouldn't make more
> sense if I just took the patches, and you'd cherry-pick them only in
> case such a need occurs. This way we would avoid this whole merge
> noise, which in an optimistic and very plausible case will not be needed
> at all.
> 
> [0] https://lkml.org/lkml/2017/4/19/1104

That email is 2 years old, and does not seem relevant to what we're
trying to achieve.  I've only ever had issues when *not* creating
immutable branches for these, cross subsystem scenarios.  The
shared branches I create are always minimalist and never change.

I'm happy to take the patches and create a suitable pull-request for
you if you are uncomfortable with the process.  I just need your Ack
to do so.  Up to you.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
