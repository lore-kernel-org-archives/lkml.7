Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D76C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19EE2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzkUIuyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfCTO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:29:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34793 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCTO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:29:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so19173224wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aIi4ddq5S6Ln3Ix0EW6HiRXfhoBMl6atbJ4RXLkwiyw=;
        b=IzkUIuySj0uETdNAaEObKaquT0LojTU7HFpG4Af3Lo0iAeMmAZVD1eDbn0N0T34Y9r
         frtlanmOzAcQku9rUSRmsAmQdniEeXStZE+2l9e+csA8XyqRvfSST1q3s9oysHHyMYcs
         CM1AliW8vayRXhcGDpLJ5huEZ1/AKvDfyrE5tfNUqF6/j5mN9Fxa0J43YOjGJiVcAV+t
         uJZqw5nvWofzAsvjJiJUcR8nxgwKlb7+FJehAk66yC63MBn87zvq1pWWCKgfIRJO2bvo
         mfYqN3EHcYzuNNcM+LQLRu/J30ZDZ1HxXXDqSw/V0V1TkSVbFb99OxgakuJXt7lAYlWC
         7XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aIi4ddq5S6Ln3Ix0EW6HiRXfhoBMl6atbJ4RXLkwiyw=;
        b=Qsg2E4Hm4Aqd7pKI6imCuugnHP3yQC/Q3ka5W7U+k9Ny465oN2zkrPtS8rFRZfK/a6
         sH2y/X0SyCStkRp3L6GFkBhD+MVgGpCpzRa9sEQWo0UagZM27RHcLW0E+xV1hIJEwVAe
         4J7mrlk9kLLY7KYYoji9UnuhLTURXNlmjeL6FaGksq75fd/oBqFNTCjlteZScamOghhN
         jqVDBEQuRLP+ismXDYvbAmDil8VRWs3vmTQlakBlMEZVENABWK4FgshCBZhurES//X0t
         1vfsOA2JsF/wPn2KWwY9/3nkkg5lx8sy+Jbw1mGbCDumvvlCKFqmecd7ZIxbx9io9m2f
         GbuQ==
X-Gm-Message-State: APjAAAVhsScjZsvujEX7XrHYtkVxhv68js8Mri0CnjqjPrLwh5bXWyDl
        hq72JSrcqC3b7reAyXGta6ebPQ==
X-Google-Smtp-Source: APXvYqzG1Wl3DF0o03muvOV5GFbzORFvSSATiKgqMR2RQZ8TcMYomHq8uosDuMZ1rPv6sBkUUK1SQQ==
X-Received: by 2002:a1c:d04a:: with SMTP id h71mr8407188wmg.120.1553092143257;
        Wed, 20 Mar 2019 07:29:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g2sm4814210wrh.7.2019.03.20.07.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 07:29:02 -0700 (PDT)
Date:   Wed, 20 Mar 2019 14:29:00 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux@armlinux.org.uk, xuwei5@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, peter.griffin@linaro.org,
        guodong.xu@linaro.org, haojian.zhuang@linaro.org,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH 1/2] amba: Take device out of reset before reading pid
 and cid values
Message-ID: <20190320142900.iblx4za3ivb5xpxd@holly.lan>
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
 <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
 <20190312122711.b2ibipico2dgavl7@holly.lan>
 <20190320065658.GA22381@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320065658.GA22381@Mani-XPS-13-9360>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:26:58PM +0530, Manivannan Sadhasivam wrote:
> Hi Daniel,
> 
> On Tue, Mar 12, 2019 at 12:27:11PM +0000, Daniel Thompson wrote:
> > On Sat, Mar 09, 2019 at 07:26:34AM +0530, Manivannan Sadhasivam wrote:
> > > For the AMBA Primecell devices having the reset lines wired, it is
> > > necessary to take them out of reset before reading the pid and cid values.
> > > Earlier we were dependent on the bootloader to do this but a more cleaner
> > > approach would be to do it in the kernel itself. Hence, this commit
> > > deasserts the reset line just before reading the pid and cid values.
> > > 
> > > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/amba/bus.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > > index 41b706403ef7..da8f1aac5315 100644
> > > --- a/drivers/amba/bus.c
> > > +++ b/drivers/amba/bus.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/limits.h>
> > >  #include <linux/clk/clk-conf.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/reset.h>
> > >  
> > >  #include <asm/irq.h>
> > >  
> > > @@ -352,6 +353,7 @@ static void amba_device_release(struct device *dev)
> > >  
> > >  static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> > >  {
> > > +	struct reset_control *rst;
> > >  	u32 size;
> > >  	void __iomem *tmp;
> > >  	int i, ret;
> > > @@ -388,6 +390,13 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> > >  	if (ret == 0) {
> > >  		u32 pid, cid;
> > >  
> > > +		/* De-assert the reset line to take the device out of reset */
> > > +		rst = reset_control_get_optional_exclusive(&dev->dev, NULL);
> > > +		if (IS_ERR(rst))
> > > +			return PTR_ERR(rst);
> > 
> > It is really correct to propagate an error if we cannot get exclusive
> > ownership of the reset line.
> > 
> > With drivers for vendor specific cells it is ok to "just know" that the
> > reset line is never shared but we cannot know this for generic cells and
> > we certainly can't know this for the bus.
> > 
> > I think it *might* be OK to propagate an error if you used
> > reset_control_get_optional_shared() instead because if that reports an
> > error than arguably we have either a mistake in the DT or a bug in the
> > driver we are sharing a reset with.
> > 
> 
> Hmm. I'm not sure whether we can assume shared reset lines here or not! Maybe
> Russell can share his opinion here.

I didn't *assume* anything. I read about the difference between what a
shared reset line does and an exclusive reset line. Providing the
get/put is properly balanced it is both safe and correct to request
shared access to the reset line.

The question is whether it is OK to propagate an error code if another
device has already requested exclusive access to the reset line (which
would cause our request for shared access to fail) since this causes us
to give up on adding the device. Here I concluded that it OK because a
failure does indicates a bug in DT or other driver but added the "I
think" because just-WARN_ON()-and-carry-on" is also a defensible
recovery approach (and *much* less likely to provoke boot sequence
regressions for existing systems).


> > > +
> > > +		reset_control_deassert(rst);
> > 
> > Perhaps we might also need to explain why we can ignore -ENOTSUPP
> > here. Perhaps something like the following based on the comment
> > found in in reset_control_deassert():
> > 
> > 		/*
> > 		 * -ENOTSUPP means occurs when the reset controller
> > 		 * does not implement .deassert(), in which case the
> > 		 * the reset lines should be self-deasserting (and
> > 		 * deasserted by default).
> > 		 */
> > 		WARN_ON(deassert did not return 0 or -ENOTSUPP);
> 
> Ack.
> 
> > > +
> > >  		/*
> > >  		 * Read pid and cid based on size of resource
> > >  		 * they are located at end of region
> > 
> > This looks like it will leak the control reference... shouldn't there
> > be a put after you have read the pid/cid?
> > 
> 
> Yes, but it can come before this as well. Right after deassert.

No it can't.

If the reset line really really is shared then another driver could
but the cell back into the reset state before you have read the pid/cid.


Daniel.
