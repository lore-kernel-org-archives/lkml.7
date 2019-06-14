Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEF4C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0198B217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560530733;
	bh=EE3HCBg8JunYZyszUxlEn4hZc09acKcjlL2zs+aHbSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B3WWcq0pfUVgJb/XJYxgnA8u7Jl1EcLteUEKWfWRvxIH6seneUMFlpjkmtU3KGFj9
	 71ABJkT38+XNy5LQRfOlJ+usg1srejvlkPyLXr5CpDrUm4ckUw16R1JdSwjasy0IKa
	 dm7oVbAyVQug4hUjrOFXCTHBleSsdL17fNThY62o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFNQpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:45:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33825 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:45:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so2101825qkt.1;
        Fri, 14 Jun 2019 09:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VifAE9FDVkI31pZVAA2VI7QJ/Wx0IcW9fionB1xyoh0=;
        b=f5gDBIMYOpL3op8T2idCcsZjhuqRrFx0P/ZgeCSQqH3xC/h09NVjjt6zG2TngeILQy
         Dj5+HL9kmlMzL6+8P61jyDssRBrihL65Ja2j3j3caz7Ue7u2cIuByGSnF5UZ6OfLQxQy
         xfjXPG7Onjkaolxa5ERrKWUUARMR0NUr/um+Is8sqN2Tjjgfp8QHY4sWZuYVziOWx2Bz
         YU+indD86Tw5/OvMT6PkIM9vmwRjRoeEbtYNNS65yD99P+REatLzHNnPi//EA7tu9RH6
         imXF+eU5Y+JIkjqyyzY5xXWn1UDd8RWGWSVOCAMLGxH+NbsCV0drSvKo9b9iO2RClEci
         DOOg==
X-Gm-Message-State: APjAAAXVSAYTIrNiflPFAG/v1z2k8mfJ5PlW5xhjzVAbXUT+dQz3lc9E
        xpdSejiSbZ6BExrbzlprSQ==
X-Google-Smtp-Source: APXvYqzFqW995e8sjoYb7nKrXgjhLY1KUnK5k7TGtKpruk3FzVi+niP+7rswSAogRaw59lDQ0hknHg==
X-Received: by 2002:a37:9d1:: with SMTP id 200mr28663998qkj.306.1560530729677;
        Fri, 14 Jun 2019 09:45:29 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id g54sm2554846qtc.61.2019.06.14.09.45.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:45:28 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:45:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: ti: Add bindings for J721E SoC
Message-ID: <20190614164526.GA14925@bogus>
References: <20190522161921.20750-1-nm@ti.com>
 <20190522161921.20750-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522161921.20750-2-nm@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:19:16AM -0500, Nishanth Menon wrote:
> The J721E SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration to enable lower system costs
> of automotive applications such as infotainment, cluster, premium
> Audio, Gateway, industrial and a range of broad market applications.
> This SoC is designed around reducing the system cost by eliminating
> the need of an external system MCU and is targeted towards ASIL-B/C
> certification/requirements in addition to allowing complex software
> and system use-cases.
> 
> Some highlights of this SoC are:
> * Dual Cortex-A72s in a single cluster, three clusters of lockstep
>   capable dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA),
>   C7x floating point Vector DSP, Two C66x floating point DSPs.
> * 3D GPU PowerVR Rogue 8XE GE8430
> * Vision Processing Accelerator (VPAC) with image signal processor and Depth
>   and Motion Processing Accelerator (DMPAC)
> * Two Gigabit Industrial Communication Subsystems (ICSSG), each with dual
>   PRUs and dual RTUs
> * Two CSI2.0 4L RX plus one CSI2.0 4L TX, one eDP/DP, One DSI Tx, and
>   up to two DPI interfaces.
> * Integrated Ethernet switch supporting up to a total of 8 external ports in
>   addition to legacy Ethernet switch of up to 2 ports.
> * System MMU (SMMU) Version 3.0 and advanced virtualisation
>   capabilities.
> * Upto 4 PCIe-GEN3 controllers, 2 USB3.0 Dual-role device subsystems,
>   16 MCANs, 12 McASP, eMMC and SD, UFS, OSPI/HyperBus memory controller, QSPI,
>   I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
> * Two hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>   management.
> * Configurable L3 Cache and IO-coherent architecture with high data throughput
>   capable distributed DMA architecture under NAVSS
> * Centralized System Controller for Security, Power, and Resource
>   Management (DMSC)
> 
> See J721E Technical Reference Manual (SPRUIL1, May 2019)
> for further details: http://www.ti.com/lit/pdf/spruil1
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.txt | 3 +++
>  1 file changed, 3 insertions(+)

Okay for now, but please convert K3 and other TI SoCs to schema soon.

Reviewed-by: Rob Herring <robh@kernel.org>
