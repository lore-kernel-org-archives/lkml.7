Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A40C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F21420717
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpMyBXef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFFF1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:27:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40692 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFFF1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:27:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so941917wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 22:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vet3rWA51CMnPKU0OwZ/zSGewScYG6Ll5Y6AZ+aj4o8=;
        b=NpMyBXefRfQh6ZTPZQ1aIMSBBwQ5y+gMO11DDvjr9nTqAJnnJXEUsKgmSS0T0NSu2C
         ldlNxdQS/9ViW8gN+qwbD8IpcpBuVkOy7uArneX5FTmcjiPVMfmbc33VgZjsDzH0YRTZ
         beBl+xI1NyVdDHf1AEi5wPyOXCZ5DfHqHuNufvUhwl4+Zv/pYmKTHbWZ24SJpZynDPXY
         f2ETsur4YdsOIXRyIo24elHPQq9LYRJ34UmUl/0wIKFG5DA6Ni7//4LQkVeHn9dTwlu4
         fE1xhyXSNtyJRDfo3zsrMKFVYkpHewi+LatCwwGklpXTa8vzIn9wbGEask8oV/+xzao6
         VGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vet3rWA51CMnPKU0OwZ/zSGewScYG6Ll5Y6AZ+aj4o8=;
        b=ZplKa0hxjnuz6LKuXbNcNVCQ+/vU58NrisjS/+sb8wnpE1ZyyM+L16Xqa45QqTFCVz
         d6sq7szlnaABVYb6G8vjV7WQExdxNbVWDqzs4jY+skzB06up+XvmHClNr5/D4tB8oSEF
         QBeb9AWpoT7DUDw2ulHlLpKBttWrPqCnVFOMinJItx0LEoISvc8zkoZld14TPltQDGFl
         rUES23kDo6o6FHPzSpZaeaqKiU7WxgALInDKbMq4BmRKFBdf72l2megIJtGpxiaoz70D
         gW27TpuHCruMGymRsUf2HhJhMhMf/HM+wA4oE2//hpfOz2TC82UQKBXTzUCjy8mo0w6X
         E28A==
X-Gm-Message-State: APjAAAXlgJFnkazLA36IYs9xj/LLWnluJmqTNrEPG7uMNCmp7s8tThoY
        RmLm/dOJOosuUp7QNzcBOMVz1yEpQS4=
X-Google-Smtp-Source: APXvYqy9mBVLJ5TiWqZIU8VG8+SPJ5H1xs1/kl9e+MOb32LRJj6LRwL9v1w1L4hQdai36oIaY7ZTgg==
X-Received: by 2002:adf:f050:: with SMTP id t16mr13031877wro.99.1559798822395;
        Wed, 05 Jun 2019 22:27:02 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id f2sm778088wru.31.2019.06.05.22.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 22:27:01 -0700 (PDT)
Date:   Thu, 6 Jun 2019 06:27:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Hancock <hancock@sedsystems.ca>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: core: Support multiple OF child devices of the
 same type
Message-ID: <20190606052700.GZ4797@dell>
References: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
 <1559687743-31879-2-git-send-email-hancock@sedsystems.ca>
 <20190605063108.GF4797@dell>
 <7561b2af-52b4-af78-f854-00ba0b86c822@sedsystems.ca>
 <20190605184505.GT4797@dell>
 <3a961f58-05d0-95ab-95e1-6d336336193c@sedsystems.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a961f58-05d0-95ab-95e1-6d336336193c@sedsystems.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019, Robert Hancock wrote:

> On 2019-06-05 12:45 p.m., Lee Jones wrote:
> >>>> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> >>>> index 99c0395..470f6cb 100644
> >>>> --- a/include/linux/mfd/core.h
> >>>> +++ b/include/linux/mfd/core.h
> >>>> @@ -55,6 +55,9 @@ struct mfd_cell {
> >>>>  	 */
> >>>>  	const char		*of_compatible;
> >>>>  
> >>>> +	/* Optionally match against a specific device of a given type */
> >>>> +	const char		*of_full_name;
> >>>> +
> >>>
> >>> Can you give me an example for when this might be useful?
> >>
> >> This is an example of some device tree entries for our MFD device:
> >>
> >>             axi_iic_0: i2c@c0000 {
> >>                 compatible = "xlnx,xps-iic-2.00.a";
> >>                 clocks = <&axi_clk>;
> >>                 clock-frequency = <100000>;
> >>                 interrupts = <7>;
> >>                 #size-cells = <0>;
> >>                 #address-cells = <1>;
> >>             };
> >>
> >>             axi_iic_1: i2c@d0000 {
> >>                 compatible = "xlnx,xps-iic-2.00.a";
> >>                 clocks = <&axi_clk>;
> >>                 clock-frequency = <100000>;
> >>                 interrupts = <8>;
> >>                 #size-cells = <0>;
> >>                 #address-cells = <1>;
> >>             };
> >>
> >> and the corresponding MFD cells:
> >>
> >> {
> >> 	.name		= "axi_iic_0",
> >> 	.of_compatible	= "xlnx,xps-iic-2.00.a",
> >> 	.of_full_name	= "i2c@c0000",
> >> 	.num_resources	= ARRAY_SIZE(dbe_i2c1_resources),
> >> 	.resources	= dbe_i2c1_resources
> >> },
> >> {
> >> 	.name		= "axi_iic_1",
> >> 	.of_compatible	= "xlnx,xps-iic-2.00.a",
> >> 	.of_full_name	= "i2c@d0000",
> >> 	.num_resources	= ARRAY_SIZE(dbe_i2c2_resources),
> >> 	.resources	= dbe_i2c2_resources
> >> },
> >>
> >> Without having the .of_full_name support, both MFD cells ended up
> >> wrongly matching against the i2c@c0000 device tree node since we just
> >> picked the first one where of_compatible matched.
> > 
> > What is contained in each of their resources?
> 
> These are the resource entries for those two devices:
> 
> static const struct resource dbe_i2c1_resources[] = {
> {
> 	.start		= 0xc0000,
> 	.end		= 0xcffff,
> 	.name		= "xi2c1_regs",
> 	.flags		= IORESOURCE_MEM,
> 	.desc		= IORES_DESC_NONE
> },
> };
> 
> static const struct resource dbe_i2c2_resources[] = {
> {
> 	.start		= 0xd0000,
> 	.end		= 0xdffff,
> 	.name		= "xi2c2_regs",
> 	.flags		= IORESOURCE_MEM,
> 	.desc		= IORES_DESC_NONE
> },
> };

This is your problem.  You are providing the memory resources through
*both* DT and MFD.  I don't believe I've seen your MFD driver, but it
looks like it's probably not required at all.  Just allow DT to probe
each of your child devices.  You can obtain the IO memory from there
directly using the usual platform_get_resource() calls.

> Ideally the IO memory resource entries would be picked up and mapped
> through the device tree as well, as they are with the interrupts, but I
> haven't yet found the device tree magic that would allow that to happen
> yet, if it's possible. The setup we have has a number of peripherals on
> an AXI bus which are behind a PCIe to AXI bridge, and we're using mfd to
> instantiate each of those AXI devices under the PCIe device.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
