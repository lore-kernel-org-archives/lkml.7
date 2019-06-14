Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DE1C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F355F21848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560530740;
	bh=Qq3BQOkxt7IRt7h3bX425/JkzmUDec5JmUjUWWyOA9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Mvxx5pyKdEBOKcvTk2Ucq28efz01Yc7pldbUTYgq6KKJCyWx2fPqjNW3PW8u43Gx
	 Gj6Xkf8hxY0v7lIB0Em5xZGVRi1nIBdo3nMaLKDxiSWI95iKQ1MkThPKpgH87CylFY
	 W/6Dqt08KCA4kp40+H/qi/OumyQkHx5Ec5/d13II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFNQpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:45:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45453 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:45:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so3174685qtr.12;
        Fri, 14 Jun 2019 09:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HlBKCnO0xMTag9WfokrT/rGmwb/ORvUR1BpXNNiMUQM=;
        b=U5h617LkH8BZgcPr+LhsW5GfeevPCUlXh0JERV0gJckALYEVxCorv59d58xNzE5TAT
         419oceW1rB/bEosG1clFZrOrrQqFhdV1X+lq5hU/MtSjI8rklOp6PZP3XKGe2VANis+S
         +MiipGlWZmfoq+Wq5EOP4okwdnnIF6x3wozZQD8HHUXJJVj/CIAXNGtFtLj1HaaBZeH6
         HM9b3sKmhyrgtgtvE/BrM/SSDhHOj0Ffq5bJ6CrWunQDSKV5yNocCFZTBVKUA5mhvEse
         TqGmApqC5j44JWsDT/tF1JIDeAkM/s2hraeWk/vW+9A26GWI07sHuu0vCcOqo5gQkIYC
         gHww==
X-Gm-Message-State: APjAAAVO1jeyTgF1EwmKslI8PSyKdzKXF90ptIwULyQlLBnlrfPr+1Jj
        xCQWwaJSAZOu/286yHrxcA==
X-Google-Smtp-Source: APXvYqyd6wUFLy/S8KXkP9eDUvnYHmUJhimauNDZWvGK3zxBUlgJUXMl3RMwWqaPxUusvLz6Y82JMQ==
X-Received: by 2002:ac8:2b51:: with SMTP id 17mr25937893qtv.206.1560530737809;
        Fri, 14 Jun 2019 09:45:37 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id g2sm1831222qkb.80.2019.06.14.09.45.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:45:37 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:45:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: ti: Add bindings for J721E SoC
Message-ID: <20190614164536.GA18039@bogus>
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

On Wed, 22 May 2019 11:19:16 -0500, Nishanth Menon wrote:
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
> 

Reviewed-by: Rob Herring <robh@kernel.org>
