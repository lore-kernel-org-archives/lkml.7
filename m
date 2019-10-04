Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6155DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3867C20867
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2lrbEYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfJDKTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:19:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43313 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388701AbfJDKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:19:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id f21so2913685plj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5K8ntS607db3gqcfLzLCwoL2HyIKgHaBgtSTehSfcLE=;
        b=w2lrbEYz8OleWs+kIGG25hIQ6Mkbb0TcEeJPyG0izgHlgFzSjbTo3lRBMvA5CofCHI
         q3AZpFPRgx1RtXYCZIFQqWYpct3HCY4TRX4xN8s4IlefdcswauhLGdt9V1SWdfPIX1LX
         81NdCN96N0+sDL2G9st4ULRPBer3iZDtNEUHnWfiDec5toAnOqKYN5VStoqphHCu9qZb
         o2vdNM8E022EoBFoGwXoP4gvDZY9YGoieia6uFAw/Vja/RF+EEyLsjSZxDoZpoZhiPWr
         b272NpRYnrmweDTAO6cUyb19wWIVsv+BZC9NlDtnOck0TBuqquo7X6Yw2YCNw7wuNOZK
         A/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5K8ntS607db3gqcfLzLCwoL2HyIKgHaBgtSTehSfcLE=;
        b=USuzc8QcEVixz9cqdfMYCmxk+PaiCImmwQdbXKMBk3qoL1Rsms8EQgME1GnUc7uOK5
         dHwYbW9u1EZfNSCZgfkaj4KzQnR7k/VyBg/GYchv+znXBYmYTRtiE2EfzNQeuPmIL9lG
         x/pxwghUfgf4ujcOsgRbBFLRFgWyXb53k1i6sWPVzG755Z1q/dHzRByfTjxZaSUdEPmX
         e5Xnr2J1KYrzs5cWsiTqN8mdKyfCt3lYvWJocpQ+2zeUViEJ5FNBngOR/HeAwpmWKjyH
         W6QxMA1C8QVMxasCWcAt1oJiCR72Ibz2SSP6uxksQ5LVMvzygSzMrrdnIVPObOasqyUB
         TlXA==
X-Gm-Message-State: APjAAAWZSPZx6GNru8TUGQtRyskoEFxWT5cjSm/NJ3ic14Wbz3/SBfMm
        QMWW01XRzAff+JTJakj6f3js
X-Google-Smtp-Source: APXvYqwiC5YkVbZSFQhsV0TuxkbaLtwXuDVpgwko2JyvMa5X+ttRFjVAIJSxRXn6S4lVePeuh42YFQ==
X-Received: by 2002:a17:902:74c4:: with SMTP id f4mr5339677plt.296.1570184350880;
        Fri, 04 Oct 2019 03:19:10 -0700 (PDT)
Received: from mani ([103.59.132.163])
        by smtp.gmail.com with ESMTPSA id o185sm9698225pfg.136.2019.10.04.03.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 03:19:09 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:49:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com
Subject: Re: [PATCH v4 2/2] media: i2c: Add IMX290 CMOS image sensor driver
Message-ID: <20191004101902.GA19685@mani>
References: <20191003095503.12614-1-manivannan.sadhasivam@linaro.org>
 <20191003095503.12614-3-manivannan.sadhasivam@linaro.org>
 <20191004092336.GL896@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004092336.GL896@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Fri, Oct 04, 2019 at 12:23:36PM +0300, Sakari Ailus wrote:
> Hi Manivannan,
> 
> On Thu, Oct 03, 2019 at 03:25:03PM +0530, Manivannan Sadhasivam wrote:
> > Add driver for Sony IMX290 CMOS image sensor driver. The driver only
> > supports I2C interface for programming and MIPI CSI-2 for sensor output.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Could you remove the unneeded ret variable from imx290_power_on() and
> unneeded goto in the same function?
>

yep, sure.
 
> The MAINTAINERS entry belongs to the first patch adding new files.
> 

You mean the bindings patch? If then, sorry no. Usually the devicetree bindings
belongs to a separate patch and that is what perferred by Rob. I prefer the
MAINTAINERS entry in a separate patch but I've seen subsystems maintainers
asking to squash it with the driver patch. But squashing it with bindings
patch seems weird to me.

Thanks,
Mani

> Then I think this is good.
> 
> -- 
> Regards,
> 
> Sakari Ailus
