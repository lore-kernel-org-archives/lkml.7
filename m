Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71499C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF062184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAQFlvTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfCTLo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:44:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40567 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfCTLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:44:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id 3so866556oir.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pb9BBWRMDf0NMbm5WI5qoWMAvnwsvdVTg76HNYPXrdE=;
        b=zAQFlvTYOBHLpoCFXuN78FGCf2O/JqnuWJS6zP/rwWDolySAwreRWu6MhuCKZqo2gN
         a5eQWd42hyW1hCn1SEYG1FyJKvTKyIEGleRIWNSGFaFJfdXafI4RU3bqKsh5kIUHPGnW
         IhobsAfnCiPkwpJwZQk3+QyNXbX1OKPKW9YWiTZ9LCQZiWug1vBZN2reIZS/I0deZmUk
         JjzKGoQwJofSD8OAvOrHeQ3Q9Y657QqOBa66Zkru9rArlPZYCVGmX4ZJdFA+UNUkE+K+
         pbqiy/IsOJdQb+HnfB/Iu1GuAGanGaLVE043OZEMccDQRxqPZYVFi4M9tle4MnI18RCE
         JStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pb9BBWRMDf0NMbm5WI5qoWMAvnwsvdVTg76HNYPXrdE=;
        b=gXPpO99W22p42REoE9MvKpuO9LJGvd6uQDKfDtsHqWP1u/gSj0CrGG4U463D9ee4WW
         RUclU/1Xk3A47twf44Qw9vA6EFF5CEtDNQty0w1LpF2dXWl1FdgtCrNc++bSV/4MlMIU
         22QstOp9AE2AJOv0RdQFXyxOPd15zgV1bTKmIHeHuHQerPVhNBqFZVME5mcBkWA/mKRy
         k3E0rbBVGrqxCmWdp6HUaOCudeN3ah6X0MLFtheG180EIjd+a/DtimHN2OleU1nnKpuU
         UZKEeqAAVRHwm+Z9+rJSuMXiarW48NFBHaXVMqgOApJCgVJZHP02rWIDdiU/ZC2Oe2SQ
         sBLw==
X-Gm-Message-State: APjAAAWa3Maq4xwT6+9Qyp3ZZT38HSq+cA5cg94VVANtPRWwUKgXBNTZ
        X9q+bEnpaKBleZfZKjBz0zRfPA==
X-Google-Smtp-Source: APXvYqya7ruXXcic+5hzX3x7o1Ii1ZMZYPzwT/krtYdKjqHT1eQQ/rUj7AKfRDe7wbeIoI9M4ensIw==
X-Received: by 2002:aca:e84c:: with SMTP id f73mr4980047oih.163.1553082296914;
        Wed, 20 Mar 2019 04:44:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id a14sm706759otl.46.2019.03.20.04.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 04:44:55 -0700 (PDT)
Date:   Wed, 20 Mar 2019 19:44:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: juno: Enable smmu_pcie for Juno r1/r2
Message-ID: <20190320114450.GB17539@leoy-ThinkPad-X240s>
References: <20190320083105.8954-1-leo.yan@linaro.org>
 <2566ce76-a8b2-c8ac-9f3f-4b99101f7661@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2566ce76-a8b2-c8ac-9f3f-4b99101f7661@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Mar 20, 2019 at 11:24:18AM +0000, Robin Murphy wrote:
> Hi Leo,
> 
> On 20/03/2019 08:31, Leo Yan wrote:
> > Though PCIe controller has been enabled on Juno r1/r2, but it misses to
> > enable its connected SMMU.  From the testing, even without set this SMMU
> > status property to 'okay', the PCIe NIC device still works well.  Since
> > the SMMU is not enabled in DT binding and its iommu_groups is not
> > created properly, finally this prevents to enable vfio-pci for NIC
> > device with KVM.
> 
> FWIW, whilst it might appear to be fine, there are still potential issues
> once the DMA API sees this SMMU and starts using it, which is why this
> particular change remains as one of my oldest local hacks that I've never
> yet considered upstreamable.
> 
> The IOMMU DMA ops happen to work for light usage now as a side-effect of
> 122fac030e912 combined with the current top-down allocation behaviour, but
> as soon as IOVA usage/fragmentation leads to 32-bit DMA addresses below
> 0x8000000, or full 40-bit addresses, being allocated then data loss and
> other problems will happen (for the reasons explained on the other thread).
> Similarly, it's also going to be fragile to any internal changes in the IOVA
> allocator.
>
> Until we have a decent solution for handling such 'windowed' DMA
> restrictions (there do exist other systems with similar behaviour) I'd be
> very wary of enabling the PCIe SMMU for all users who may not be aware of
> the caveats. Given that the lack of stream IDs and SR-IOV support prevents
> Juno from being a realistic virtualisation platform anyway, I'm not
> convinced there's enough benefit to justify the risk.

Ah, I didn't connect the 'windowde' DMA restriction with the IOMMU
property setting in dt, which actually is deliberate.

Please drop this patch and will leave it to you.  Thanks a lot for
related info.

[...]

Thanks,
Leo Yan
