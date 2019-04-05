Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD2C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238362186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UskltlgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfDERwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:52:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44087 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731597AbfDERwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:52:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id v71so4963566lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FSpSosZdFZRPfx7A8yR39RXqE1Cn94GDH5CixHI+5eY=;
        b=UskltlgPf+BwYotFvqC2/ydUItpjQpa9y4u9m9TblPK8dZIhVlyO+s52wNOUCGM3La
         4YAkhP95kbBc7k/dp21l3Z6lvxJXEEnTs5O/N58kVFR+1rSYQzXEwKpihyIP0zWF6XJL
         wus9F6ve3lBUVedtoH5pRra+oJ0jymNw86kL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FSpSosZdFZRPfx7A8yR39RXqE1Cn94GDH5CixHI+5eY=;
        b=TH4VmFf6Qru6eZQt+etgQCN5oRoYJ1lRXJAmEr+SFKjivAHeoOr/fqMu8X7PZ5Slhg
         yfqXS10YvO/NeG5nU+CB/STzCaZoVJr1OfHBG+HiXl+W47FPH4eFmkNHaqSQtbOUfw35
         Dq9eJrgkvOKerEFs280tlyDGR4cmAJUttFOB/w5f6bEd4jOM6QScfFnQxAQa4LstWRAX
         CH7i4W3e+YiaWPDgtBdCmwOSDN20LboUX4gK1nHwE5xDLGcw2TOb2ZL7x9xONZ4oEn8W
         62EymbRPnxky4W6OJ/+cNPwrYLr/i2wC2ujnwCQMiRfkTDJfgty5rjvgIkAxz0h3sd+r
         nR5w==
X-Gm-Message-State: APjAAAXYUST8xekHtmL8nv9vPHxdZqJYRRpmlYir5e+4aAPG+hvRjO4+
        2+Nv4wwTEPMN8eFfuh/pFRtMpgDUhZU=
X-Google-Smtp-Source: APXvYqyz2SsUKLieXN4DGQ/p1dztjnOGCRAepSJBnQdBIfBj/wTQLVw9jV9EfnH/SJ0WDJ7JINp6Uw==
X-Received: by 2002:ac2:5285:: with SMTP id q5mr7303854lfm.37.1554486762267;
        Fri, 05 Apr 2019 10:52:42 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id d3sm4829729ljc.15.2019.04.05.10.52.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 10:52:41 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id j89so6035225ljb.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:52:41 -0700 (PDT)
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr8195155ljj.84.1554486760470;
 Fri, 05 Apr 2019 10:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190401180505.6621-1-evgreen@chromium.org> <20190405071455.GA30194@raj-desk2.iind.intel.com>
In-Reply-To: <20190405071455.GA30194@raj-desk2.iind.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 5 Apr 2019 10:52:04 -0700
X-Gmail-Original-Message-ID: <CAE=gft7r+0s6M2KZLdcp33xvnxjX2Kqyg-vVk5dVVoC5PUOGqw@mail.gmail.com>
Message-ID: <CAE=gft7r+0s6M2KZLdcp33xvnxjX2Kqyg-vVk5dVVoC5PUOGqw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Report slp_s0 residency range
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 12:28 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
>
> On Mon, Apr 01, 2019 at 11:05:04AM -0700, Evan Green wrote:
> > The PMC driver performs a 32-bit read on the sleep s0 residency counter,
> > followed by a hard-coded multiplication to convert into microseconds.
> > The maximum value this counter could have would be 0xffffffff*0x64
> > microseconds, which by my calculations is about 4.9 days. This is well
> > within a reasonable time period to observe an overflow.
> >
> > Usermode consumers watching slp_s0_residency_usec need to be aware of
> > overflows, but have no idea what the maximum value of this counter is,
> > given the hardcoded multiply of a 32-bit value by
> > SPT_PMC_SLP_S0_RES_COUNTER_STEP.
>
> This register is a 32 bit register untill ICL generation and a recent patch
> from Rajat fixed the overflow https://patchwork.kernel.org/patch/10816103/
> already so i am not sure how this will help userspace. I think the userspace
> can still take care of any overflow concerns based on the information
> available about this register in EDS so i feel exposing a new debugfs entry
> just for the sake of knowing range is probably not needed.

So you don't anticipate reusing this driver for other models where the
factor of 100 might change, or the counter might be a different width?
We can hardcode the multiply in usermode in order to detect when we've
exceeded the 4.9 day rollover range, but it seemed brittle, and would
break if this hardware implementation detail ever changed.
-Evan
