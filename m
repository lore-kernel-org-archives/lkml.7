Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014BDC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC7D2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jAcfv0YI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfG3Krz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:47:55 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56794 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfG3Krz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xd8aJIuQ1HAMcxnsxnnuGT/Zwd/6CK6dCjhjivBsWNs=; b=jAcfv0YI5u+CH+N2xxZBD077X
        WgPpgKKibt8++BpMBtcf9BAXQ8oFUcuoDC70jjU39pPG3tid3H8ga+UqhyTX39kFQot/+W5SGRhtZ
        U7sgVOW0uVo/V0OOkQv7kWAwNOVvLl33RGXZd+JCPvhlBidCwWCnr/w+Ah9SsPNtPJfD7wSraJnyH
        uLrMbjSgdsAR23fZAMkWTULEojIblZ4vIuBsOCCD/w8jwAvSZ0X1UzMIbKoLvaw6mCE5qwveg7Suv
        LcB73+GkpPPNpiWRyUyeWmoa6OthCKPb75BAvAyurJrXBULiJdEdaphLttxaPnNZuEiRri6aKNmLw
        3EEIbVnxQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46346)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hsPfY-0004j6-DF; Tue, 30 Jul 2019 11:47:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hsPfW-00029f-Ts; Tue, 30 Jul 2019 11:47:46 +0100
Date:   Tue, 30 Jul 2019 11:47:46 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Luis Araneda <luaraneda@gmail.com>
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: zynq: Use memcpy_toio instead of memcpy on smp
 bring-up
Message-ID: <20190730104746.GA1330@shell.armlinux.org.uk>
References: <20190730044326.1805-1-luaraneda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730044326.1805-1-luaraneda@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:43:26AM -0400, Luis Araneda wrote:
> This fixes a kernel panic (read overflow) on memcpy when
> FORTIFY_SOURCE is enabled.
> 
> The computed size of memcpy args are:
> - p_size (dst): 4294967295 = (size_t) -1
> - q_size (src): 1
> - size (len): 8
> 
> Additionally, the memory is marked as __iomem, so one of
> the memcpy_* functions should be used for read/write
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
> 
> For anyone trying to reproduce / debug this, it panics
> before the console has any output.
> I used JTAG to find the panic, but I had to comment-out
> the call to "zynq_slcr_cpu_stop" as it stops the JTAG
> interface and the connection is dropped, at least with OpenOCD.
> 
> I run-tested this on a Digilent Zybo Z7 board
> ---
>  arch/arm/mach-zynq/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> index a7cfe07156f4..407abade7336 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -57,7 +57,7 @@ int zynq_cpun_start(u32 address, int cpu)
>  			* 0x4: Jump by mov instruction
>  			* 0x8: Jumping address
>  			*/
> -			memcpy((__force void *)zero, &zynq_secondary_trampoline,
> +			memcpy_toio(zero, &zynq_secondary_trampoline,
>  							trampoline_size);
>  			writel(address, zero + trampoline_size);

I'm not convinced that this is correct.  It looks like
zynq_secondary_trampoline could be either ARM or Thumb code - there is
no .arm directive before it.  If it's ARM code, then this is fine.  If
Thumb code, then zynq_secondary_trampoline will be offset by one, and
we will miss copying the first byte of code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
