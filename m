Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C5C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A35D21872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571747158;
	bh=oXX6Ruh04x8qHjPZHb6cjHnTqz33Xt0fFodUI+uKHKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PEL9aC6WWMDxYH7ubWjRSrox1JA6k2T19wLGiHM6f9b/SAqrMju5eJNkJP2yEXact
	 WdfwYyVVul3qmdhFzOos+beLRhOCVn3Nvuz+1UEak81gnxHHL/ATAHbwNzOiHrprC4
	 2VQkl0NBJDm3fsdQOHRTgPipcsYUd1PrU+TdOvK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbfJVMZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388383AbfJVMZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:25:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91502184C;
        Tue, 22 Oct 2019 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571747156;
        bh=oXX6Ruh04x8qHjPZHb6cjHnTqz33Xt0fFodUI+uKHKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duVArzChHrutOcwxJlN96kTY7+qq2YILVx276cvY9b18m4OL8KF9BueLggsB8kb06
         Rz3EMvp3f5M9uTprMOgWvWee/MI/Xwa5r35mm0pCDildOFgnDalN1OTvyTtg8RyRjN
         HubV3AweoLeSmsFWva17wmGRYjpUVGSS0xkToypQ=
Date:   Tue, 22 Oct 2019 13:25:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Candle Sun <candlesea@gmail.com>
Cc:     mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Subject: Re: [RESEND PATCH] ARM/hw_breakpoint: add ARMv8.1/ARMv8.2 debug
 architecutre versions support in enable_monitor_mode()
Message-ID: <20191022122550.GA17232@willie-the-truck>
References: <1569483508-18768-1-git-send-email-candlesea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569483508-18768-1-git-send-email-candlesea@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:38:28PM +0800, Candle Sun wrote:
> From: Candle Sun <candle.sun@unisoc.com>
> 
> When ARMv8.1/ARMv8.2 cores are used in AArch32 mode,
> arch_hw_breakpoint_init() in arch/arm/kernel/hw_breakpoint.c will be used.
> 
> From ARMv8 specification, different debug architecture versions defined:
> * 0110 ARMv8, v8 Debug architecture.
> * 0111 ARMv8.1, v8 Debug architecture, with Virtualization Host Extensions.
> * 1000 ARMv8.2, v8.2 Debug architecture.
> 
> So missing ARMv8.1/ARMv8.2 cases will cause enable_monitor_mode() function
> returns -ENODEV, and arch_hw_breakpoint_init() will fail.
> 
> Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> ---
>  arch/arm/include/asm/hw_breakpoint.h | 2 ++
>  arch/arm/kernel/hw_breakpoint.c      | 2 ++
>  2 files changed, 4 insertions(+)

[...]

> diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
> index ac54c06..9137ef6 100644
> --- a/arch/arm/include/asm/hw_breakpoint.h
> +++ b/arch/arm/include/asm/hw_breakpoint.h
> @@ -53,6 +53,8 @@ static inline void decode_ctrl_reg(u32 reg,
>  #define ARM_DEBUG_ARCH_V7_MM	4
>  #define ARM_DEBUG_ARCH_V7_1	5
>  #define ARM_DEBUG_ARCH_V8	6
> +#define ARM_DEBUG_ARCH_V8_1	7
> +#define ARM_DEBUG_ARCH_V8_2	8

Looks like you can also add:

#define ARM_DEBUG_ARCH_V8_4	9

and treat that the same way. With that, and a fix to $SUBJECT:

Acked-by: Will Deacon <will@kernel.org>

Please put this into the patch system [1].

Will

[1] https://www.arm.linux.org.uk/developer/patches/
