Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8063FC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B95A206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2AK1NVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfDDJpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:45:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37204 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbfDDJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:45:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so903348ply.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+QDB5r2PCwS3HHnN9lYT7YJKQcsthlU9yatvibLI/HM=;
        b=D2AK1NVhSm05ZnmKhIHK/cs5L40sLB1+gc0PQ1nMNX2YNmPvvF+gPDdZUS6Iii32RV
         8OW0Z30StT79fZxXcthqr0z3XfP+y6F90dMlRWSU55tEUYBYSWZmRrdi/P56tkALnxH8
         RJbT9wE15pntGZXZXQJt10whcyQU/E8iQOoO7/XynC6RPddpKKM8WMMie7/LFMn/nB+u
         GsuWocM6PPThEdrB7WNKxEnQ0Z973yUbPx5+Ia9q+wTOMcCsI/iK/kDfBdunph3ZyDhb
         Jzn6zycXwRdJ4MoS/84pDz81A6t4tSR79oMVmdDE4tKZAE+GN3gkof/17QoJ1kdreOuy
         JZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+QDB5r2PCwS3HHnN9lYT7YJKQcsthlU9yatvibLI/HM=;
        b=N6b/y7FDY8Y1IbmY+DayjVmd17q7PwacQxTwE2Ifv+QPFqjSXCOOXUu6nqaD65h47u
         7KRc7QKNV2zRJFoa8KQJoqsk4fv1XvYqVZ9wpnMmjJSSgR5+z46TC1NWKh4dNAaCwQfU
         OI1kd0/44dYEIvWqqEDuuRrvItuLTWpDBxJfT3w6yxcPqGg+pxeZesOA0rYcR8i5pJ+W
         PDdoQmSJTY7CTgkzd/yeC0IMlMtrQt5lgc1v8HlsMh8oNLR6TPESgm41tLBuHBqGu2mY
         1ahBBtxFcZeGjVri36o60ljCyaRoafmiM26nXFzjZuKW++fQmt8DpsdCnoSik89zYJ1N
         zN4g==
X-Gm-Message-State: APjAAAUl1RiQ9SvMGREvoiMzgO0p/0BrznvWrKW3Cf3rXEJEku0IAT54
        mcGqNkkHocoRkZUCqPFOUcPIDNmPFuOYbg==
X-Google-Smtp-Source: APXvYqxQYcODO4fWAnz4ujnu92iMmKd/C1lnGN/PAXU4IxY7x45oiEzgjqLUWNbsOsAhIu9BGUj6Ww==
X-Received: by 2002:a17:902:e393:: with SMTP id ch19mr5131409plb.117.1554371104861;
        Thu, 04 Apr 2019 02:45:04 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id i79sm39587477pfj.28.2019.04.04.02.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:45:03 -0700 (PDT)
Date:   Thu, 4 Apr 2019 10:44:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190404094459.GV6830@dell>
References: <20190318095316.69278-1-andriy.shevchenko@linux.intel.com>
 <20190402051211.GR4187@dell>
 <20190402122001.GM9224@smile.fi.intel.com>
 <20190404070004.GE6830@dell>
 <20190404070357.GF6830@dell>
 <20190404082138.GF9224@smile.fi.intel.com>
 <20190404090314.GT6830@dell>
 <20190404092617.GO9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404092617.GO9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019, Andy Shevchenko wrote:

> On Thu, Apr 04, 2019 at 10:03:14AM +0100, Lee Jones wrote:
> > On Thu, 04 Apr 2019, Andy Shevchenko wrote:
> > > On Thu, Apr 04, 2019 at 08:03:57AM +0100, Lee Jones wrote:
> > > > On Thu, 04 Apr 2019, Lee Jones wrote:
> > > > > On Tue, 02 Apr 2019, Andy Shevchenko wrote:
> > > > > > On Tue, Apr 02, 2019 at 06:12:11AM +0100, Lee Jones wrote:
> > > > > > > On Mon, 18 Mar 2019, Andy Shevchenko wrote:
> 
> > > > > > > Although succinct, dragging values from one platform device into
> > > > > > > another doesn't sound that neat.
> > > > > > 
> > > > > > So, how to split resources given in one _physical_ multi-functional device to
> > > > > > several of them?  Isn't it what MFD framework for?
> > > > > > 
> > > > > > Any other approach here? I'm all ears!
> > > > > 
> > > > > From the child:
> > > > > 
> > > > >   platform_get_irq(dev->parent, CLIENT_ID);
> > > 
> > > So, instead of keeping a fragile approach in one driver, we will spread this
> > > to all of them.
> > 
> > No, the fragileness goes away with implicit definitions of IDs.
> 
> Did you mean "explicit"?

Yes.  Thank you for correcting my English. :)

> Something like we need to have a shared map of those indices?

Defining the IDs of the devices would lead to a more robust
implementation, yes.

> > > > > > > Also, since the ordering of the
> > > > > > > devices is critical in this implementation, it also comes across as
> > > > > > > fragile.
> > > > > > 
> > > > > > How fragile? In ACPI we don't have IRQ labeling scheme. Index is used for that.
> > > > > > 
> > > > > > > Any reason why ACPI can't register all of the child devices, or for
> > > > > > > the child devices to obtain their IRQ directly from the tables?
> > > > > > 
> > > > > > And how are we supposed to enumerated them taking into consideration single
> > > > > > ACPI ID given?
> > > > > 
> > > > > This question was a little whimsical, since I have no idea how the
> > > > > ACPI tables you're working with are laid out.
> > > 
> > > There is one device node with several IRQ and other resources.
> > > In pseudo code:
> > > 
> > > 	device node {
> > > 		device ID,
> > > 		IRQ 0,
> > > 		IRQ 1,
> > > 		...
> > > 		MMIO 0,
> > > 		...
> > > 	}
> > 
> > Sure.  Thanks for the explanation.
> > 
> > Very well.  I guess it's not too bad as it is.
> 
> It represent real hardware 1:1.
> Just out of curiosity how this case can be described in DT?

In DT you can have a sub-node for each child which can contain the
IRQ.  Without a sub-node you would define the IRQs in this file.  If
these IRQs do not change, that option is still available to you.

I can't think of an example where all of the children's IRQs have been
listed in the parent's DT node in this way.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
