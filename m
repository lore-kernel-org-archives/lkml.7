Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC7AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F090D2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MayBXyTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKLSNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:13:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38603 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKLSNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:13:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so13917747pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ttsaT2g998/aiu+eFjBLupeUhT9Bgi8Aso3XAQDnnqs=;
        b=MayBXyTWp237uos2XCVb22/N31xIWJOfIa/FnJBfQrwJfdXqGIdPZUmY/IEmcGUGNU
         wuhE7ZQ0fR0yfGjEASCvLFTzCKliCHRekx1STjNQD3IQHjFcX6Oi95FxjMvH0nxjq6I4
         1sGRLriksGOT0lrQL2gUH6wXl63wts2pd5P/cAxaBU3qYmdl3ZqERVNXXgzeCN6uPhjg
         fmuml1rpJeYp6+tZMw7AFU7yIBFLBXpcKOsuRQjd4hnuubEOY17rgGns4sAPGi/F7IdC
         yKlQzyS6BdvX+qO8S7IcMw0bfIffgC7/h7Y+p7YptV/9fNhIc97F31QSlx5Gc7imWju1
         xWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttsaT2g998/aiu+eFjBLupeUhT9Bgi8Aso3XAQDnnqs=;
        b=kfWoHE7DE2rU2V/9sJfM9ZztDdh+JKsT4+e/5omdRE4cYzcLberzp07w/mGey/VD2u
         cW3KpMFxy6w3zxZHgyLw87wkimf/2N3Pv/GynE03E65g62Yux1bXLV7QI1A2sn5yLzDX
         A7ofjUb5QGNQDTjcbAuOgBEV1bwSa1vwcvNYrpkY+BbtCZITinpCF9uWmjpFtkBqmuVS
         XQx3TeXjlqSIy4aP/ZYPEyIqnDhg6phcO9v26z18/mDzI+DuZCdL5x/V6ZW9Faz2ejkL
         roIsA//9OjwTJ6ewM1Mm8eS7ET5mZ71soX+bZ+yKaRPxqn2+NhfJB0FjgLFHScCNwH8C
         kf1Q==
X-Gm-Message-State: APjAAAW+KfJpYnmEKnQ6hk0HsPL6WngsxkXWt02tqoR0dp+mRSMLV74t
        jf/tjLShzDqZ9etu4xJHTRPLsg==
X-Google-Smtp-Source: APXvYqw7xxpe4kAYYGCiaepPobw+ItaGudcOYKH5xbOuntKEn8xI9RZ77DRRW0fHYF3Om2prDFwiVw==
X-Received: by 2002:a17:90a:7bcc:: with SMTP id d12mr8273991pjl.63.1573582426298;
        Tue, 12 Nov 2019 10:13:46 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t1sm3945386pfq.156.2019.11.12.10.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:13:45 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:13:43 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com
Subject: Re: [PATCH 08/17] remoteproc/omap: Add support for DRA7xx remote
 processors
Message-ID: <20191112181343.GJ3797@yoga>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-9-t-kristo@ti.com>
 <20191111233707.GJ3108315@builder>
 <0d26759a-8a48-e573-cbf6-721c6e5367c1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d26759a-8a48-e573-cbf6-721c6e5367c1@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Nov 00:37 PST 2019, Tero Kristo wrote:

> On 12/11/2019 01:37, Bjorn Andersson wrote:
> > On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
[..]
> > > +	for (; data && data->device_name; data++) {
> > > +		if (!strcmp(dev_name(&pdev->dev), data->device_name))
> > 
> > I don't fancy the reliance on node names in devicetree, is this well
> > defined in the binding?
> 
> I don't think it is.... So, would it be better to just replace the
> compatible strings for dra7 remoteprocs to be like ti,dra7-dsp1 /
> ti,dra7-dsp2 etc.? I think that would clean up the code also quite a bit.
> 

While it would solve "my" problem I'm not entirely sure about it being
a proper way to flag that they should have different default firmware.

One way would be to simply rely on a "firmware-name" property read from
DeviceTree (this was previously objected to, but we have that for
several bindings now).

Regards,
Bjorn

> > 
> > > +			return data->fw_name;
> > > +	}
> > > +
> > > +	return ERR_PTR(-ENOENT);
> > >   }
> > >   static int omap_rproc_get_boot_data(struct platform_device *pdev,
> > > @@ -334,7 +384,8 @@ static int omap_rproc_get_boot_data(struct platform_device *pdev,
> > >   	int ret;
> > >   	if (!of_device_is_compatible(np, "ti,omap4-dsp") &&
> > > -	    !of_device_is_compatible(np, "ti,omap5-dsp"))
> > > +	    !of_device_is_compatible(np, "ti,omap5-dsp") &&
> > > +	    !of_device_is_compatible(np, "ti,dra7-dsp"))
> > >   		return 0;
> > >   	oproc->boot_data = devm_kzalloc(&pdev->dev, sizeof(*oproc->boot_data),
> > > @@ -360,18 +411,27 @@ static int omap_rproc_get_boot_data(struct platform_device *pdev,
> > >   		return -EINVAL;
> > >   	}
> > > +	if (of_device_is_compatible(np, "ti,dra7-dsp"))
> > > +		oproc->boot_data->boot_reg_shift = 10;
> > 
> > Put this in omap_rproc_dev_data.
> 
> Yeah.
> 
> > 
> > > +
> > >   	return 0;
> > >   }
> > >   static int omap_rproc_of_get_internal_memories(struct platform_device *pdev,
> > >   					       struct rproc *rproc)
> > >   {
> > > -	static const char * const mem_names[] = {"l2ram"};
> > > +	static const char * const ipu_mem_names[] = {"l2ram"};
> > > +	static const char * const dra7_dsp_mem_names[] = {"l2ram", "l1pram",
> > > +								"l1dram"};
> > >   	struct device_node *np = pdev->dev.of_node;
> > >   	struct omap_rproc *oproc = rproc->priv;
> > >   	struct device *dev = &pdev->dev;
> > > +	const char * const *mem_names;
> > >   	struct resource *res;
> > >   	int num_mems;
> > > +	const __be32 *addrp;
> > > +	u32 l4_offset = 0;
> > > +	u64 size;
> > >   	int i;
> > >   	/* OMAP4 and OMAP5 DSPs do not have support for flat SRAM */
> > > @@ -379,7 +439,15 @@ static int omap_rproc_of_get_internal_memories(struct platform_device *pdev,
> > >   	    of_device_is_compatible(np, "ti,omap5-dsp"))
> > >   		return 0;
> > > -	num_mems = ARRAY_SIZE(mem_names);
> > > +	/* DRA7 DSPs have two additional SRAMs at L1 level */
> > > +	if (of_device_is_compatible(np, "ti,dra7-dsp")) {
> > > +		mem_names = dra7_dsp_mem_names;
> > > +		num_mems = ARRAY_SIZE(dra7_dsp_mem_names);
> > > +	} else {
> > > +		mem_names = ipu_mem_names;
> > > +		num_mems = ARRAY_SIZE(ipu_mem_names);
> > > +	}
> > > +
> > >   	oproc->mem = devm_kcalloc(dev, num_mems, sizeof(*oproc->mem),
> > >   				  GFP_KERNEL);
> > >   	if (!oproc->mem)
> > > @@ -395,7 +463,26 @@ static int omap_rproc_of_get_internal_memories(struct platform_device *pdev,
> > >   			return PTR_ERR(oproc->mem[i].cpu_addr);
> > >   		}
> > >   		oproc->mem[i].bus_addr = res->start;
> > > -		oproc->mem[i].dev_addr = OMAP_RPROC_IPU_L2RAM_DEV_ADDR;
> > > +
> > > +		/*
> > > +		 * The DSPs have the internal memories starting at a fixed
> > > +		 * offset of 0x800000 from address 0, and this corresponds to
> > > +		 * L2RAM. The L3 address view has the L2RAM bus address as the
> > > +		 * starting address for the IP, so the L2RAM memory region needs
> > > +		 * to be processed first, and the device addresses for each
> > > +		 * memory region can be computed using the relative offset
> > > +		 * from this base address.
> > > +		 */
> > > +		if (of_device_is_compatible(np, "ti,dra7-dsp") &&
> > 
> > Please don't use a ternary operator repeatedly, it makes the code hard
> > to follow.
> 
> Yeah this parts looks somewhat messy, let me try to fix that.
> 
> -Tero
> 
> > 
> > Regards,
> > Bjorn
> > 
> > > +		    !strcmp(mem_names[i], "l2ram")) {
> > > +			addrp = of_get_address(dev->of_node, i, &size, NULL);
> > > +			l4_offset = of_translate_address(dev->of_node, addrp);
> > > +		}
> > > +		oproc->mem[i].dev_addr =
> > > +			of_device_is_compatible(np, "ti,dra7-dsp") ?
> > > +				res->start - l4_offset +
> > > +				OMAP_RPROC_DSP_LOCAL_MEM_OFFSET :
> > > +				OMAP_RPROC_IPU_L2RAM_DEV_ADDR;
> > >   		oproc->mem[i].size = resource_size(res);
> > >   		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%x va %p da 0x%x\n",
> > > -- 
> > > 2.17.1
> > > 
> > > --
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
