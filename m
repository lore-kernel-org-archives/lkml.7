Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79069C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391672184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbcMNwbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCTG5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:57:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33018 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:57:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so1091186pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVNCJ1oojDym+rOOCLnijlSHrKrc/EZsBAi349G+qrU=;
        b=qbcMNwbg1hBWZYz2UN//8KxicSOwLTBuNqXMQJXaXkGsqgNgMZr8dAnVbriGkZs/Pe
         qTTn7ePYLwEVnsLyeZ9RJO2I9GUK/xjC+VZUyfqLh4UwYsLOEyJvXNHx5jaHTxmzT1tm
         CiTzVoD+FYFXwMpgzH36RRN2oK1xjFSyk6JYT+kLAx+Y5OrhMCsVIvZAsmkg9Cw+4EwS
         Cxj8mhOFPLqicrWdNp+IzIC8yXiO3wUuoL9o1VTh3FqJyqrVQktO+q9e+KZ/o5tMmYhJ
         uBPk9D8ycq2kVEuWc9Evs/nLLDWX7a78IykapMzO6mOWYsevhuBmj8iZNKDgZwC5G3Lb
         Il0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVNCJ1oojDym+rOOCLnijlSHrKrc/EZsBAi349G+qrU=;
        b=l4IoobgVhkKv1trA02PisRoq7OUDm+KVbEBXva2lPZnJKjjFBEv6Wa/XW6aVlbP6Ux
         tONHDQKobkIyNH3u9lG6CgyrBnaHi60Pf7QDKPuGYIn+d3dpajf+cRkKpDrWPfBmAz9W
         hhlsY19p4QzlfWgNLUODaAxkkKbpsIe7Wo3DBMVq550oZ6ZA9lg/QrNsf1x2zd/XxgBV
         mIsObsTKhYi5pNyFYSjxywjXscdILqJ2eufnfu2btDaShNRSaPJPXj8mU8hlX9sI2QYV
         pHY0ZhsJcWtXJS1YO3Oz/BBCZSTDaHbKZ/MA1qxYw9YquKCGociCqVWZb9MkvTxlcGme
         Kkmg==
X-Gm-Message-State: APjAAAXEC0ZzcJ9YBB5zlqOuJuy6Ib/JozI6Qq9Tttfb++Ort4Gzq79g
        4StbyqN60wC7u7g0foL+kScG
X-Google-Smtp-Source: APXvYqy5CjUzB98H1MM/K2zkWRZNxyp8QfBaFDJkEYZR+S/Orf6/ZT4MSBjBkFESlzzo+4o89NAApw==
X-Received: by 2002:a17:902:ba98:: with SMTP id k24mr21559221pls.185.1553065026477;
        Tue, 19 Mar 2019 23:57:06 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:608d:553:e11a:9b5b:79f9:9f93])
        by smtp.gmail.com with ESMTPSA id f2sm3068118pgn.43.2019.03.19.23.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 23:57:05 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:26:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux@armlinux.org.uk, xuwei5@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, peter.griffin@linaro.org,
        guodong.xu@linaro.org, haojian.zhuang@linaro.org,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH 1/2] amba: Take device out of reset before reading pid
 and cid values
Message-ID: <20190320065658.GA22381@Mani-XPS-13-9360>
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
 <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
 <20190312122711.b2ibipico2dgavl7@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312122711.b2ibipico2dgavl7@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Mar 12, 2019 at 12:27:11PM +0000, Daniel Thompson wrote:
> On Sat, Mar 09, 2019 at 07:26:34AM +0530, Manivannan Sadhasivam wrote:
> > For the AMBA Primecell devices having the reset lines wired, it is
> > necessary to take them out of reset before reading the pid and cid values.
> > Earlier we were dependent on the bootloader to do this but a more cleaner
> > approach would be to do it in the kernel itself. Hence, this commit
> > deasserts the reset line just before reading the pid and cid values.
> > 
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/amba/bus.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 41b706403ef7..da8f1aac5315 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/limits.h>
> >  #include <linux/clk/clk-conf.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/reset.h>
> >  
> >  #include <asm/irq.h>
> >  
> > @@ -352,6 +353,7 @@ static void amba_device_release(struct device *dev)
> >  
> >  static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> >  {
> > +	struct reset_control *rst;
> >  	u32 size;
> >  	void __iomem *tmp;
> >  	int i, ret;
> > @@ -388,6 +390,13 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> >  	if (ret == 0) {
> >  		u32 pid, cid;
> >  
> > +		/* De-assert the reset line to take the device out of reset */
> > +		rst = reset_control_get_optional_exclusive(&dev->dev, NULL);
> > +		if (IS_ERR(rst))
> > +			return PTR_ERR(rst);
> 
> It is really correct to propagate an error if we cannot get exclusive
> ownership of the reset line.
> 
> With drivers for vendor specific cells it is ok to "just know" that the
> reset line is never shared but we cannot know this for generic cells and
> we certainly can't know this for the bus.
> 
> I think it *might* be OK to propagate an error if you used
> reset_control_get_optional_shared() instead because if that reports an
> error than arguably we have either a mistake in the DT or a bug in the
> driver we are sharing a reset with.
> 

Hmm. I'm not sure whether we can assume shared reset lines here or not! Maybe
Russell can share his opinion here.

> 
> > +
> > +		reset_control_deassert(rst);
> 
> Perhaps we might also need to explain why we can ignore -ENOTSUPP
> here. Perhaps something like the following based on the comment
> found in in reset_control_deassert():
> 
> 		/*
> 		 * -ENOTSUPP means occurs when the reset controller
> 		 * does not implement .deassert(), in which case the
> 		 * the reset lines should be self-deasserting (and
> 		 * deasserted by default).
> 		 */
> 		WARN_ON(deassert did not return 0 or -ENOTSUPP);

Ack.

> > +
> >  		/*
> >  		 * Read pid and cid based on size of resource
> >  		 * they are located at end of region
> 
> This looks like it will leak the control reference... shouldn't there
> be a put after you have read the pid/cid?
> 

Yes, but it can come before this as well. Right after deassert.

Thanks,
Mani

> 
> Daniel.
