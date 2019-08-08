Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3044C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9503F21881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565251721;
	bh=LEJBdGF3+zKiZ/gDRK/GSLC+1nib/flq+adxh2DDplc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K5mi7GaypCbKNGJ8g8f2Hl+2nf4ko5d+t0RcPGcsmMAFc5AQdWiWmAy9UtjNpb5UP
	 mLiObqTeYTF54iV3DbRox9gcW3GrudJh1XPgzMII/MrY3/uU9JY1WsRYZZioq24L5o
	 4X7UKlHpRAKMjLfKNfaElBB/GIe4QLSeDZXC5UYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfHHIIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731658AbfHHIIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:08:40 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987222187F;
        Thu,  8 Aug 2019 08:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565251719;
        bh=LEJBdGF3+zKiZ/gDRK/GSLC+1nib/flq+adxh2DDplc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOa6iG5SmZfPC3g1w7HTtZx+ntqjy7vtMoKRrOB40Y1IAJadxT/a1qUH7M1hcWNN7
         W8qiRDWZYvufdHdGDu+qM1d8a1ZVlDor3TTEdzdRnqhOaZb7tBU7wRwv+eqaHSlT7g
         lxSTZpDBXTzZEgo0HCx0IGQcI53ACbHG1ptXyEHE=
Date:   Thu, 8 Aug 2019 09:08:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Message-ID: <20190808080832.nleult5bknmzr3ze@willie-the-truck>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> Introduce support for LINFlex driver, based on:
> - the version of Freescale LPUART driver after commit b3e3bf2ef2c7 ("Merge
>   4.0-rc7 into tty-next");
> - commit abf1e0a98083 ("tty: serial: fsl_lpuart: lock port on console
>   write").
> In this basic version, the driver can be tested using initramfs and relies
> on the clocks and pin muxing set up by U-Boot.
> 
> Remarks concerning the earlycon support:
> 
> - LinFlexD does not allow character transmissions in the INIT mode (see
>   section 47.4.2.1 in the reference manual[1]). Therefore, a mutual
>   exclusion between the first linflex_setup_watermark/linflex_set_termios
>   executions and linflex_earlycon_putchar was employed and the characters
>   normally sent to earlycon during initialization are kept in a buffer and
>   sent afterwards.
> 
> - Empirically, character transmission is also forbidden within the last 1-2
>   ms before entering the INIT mode, so we use an explicit timeout
>   (PREINIT_DELAY) between linflex_earlycon_putchar and the first call to
>   linflex_setup_watermark.
> 
> - U-Boot currently uses the UART FIFO mode, while this driver makes the
>   transition to the buffer mode. Therefore, the earlycon putchar function
>   matches the U-Boot behavior before initializations and the Linux behavior
>   after.
> 
> [1] https://www.nxp.com/webapp/Download?colCode=S32V234RM
> 
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Adrian.Nitu <adrian.nitu@freescale.com>
> Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Signed-off-by: Ana Nedelcu <B56683@freescale.com>
> Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> [stefan-gabriel.mirea@nxp.com: Reduced for upstreaming and implemented
>                                earlycon support]
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  drivers/tty/serial/Kconfig                    |  15 +
>  drivers/tty/serial/Makefile                   |   1 +
>  drivers/tty/serial/fsl_linflexuart.c          | 956 ++++++++++++++++++
>  include/uapi/linux/serial_core.h              |   3 +
>  5 files changed, 981 insertions(+)
>  create mode 100644 drivers/tty/serial/fsl_linflexuart.c
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 46b826fcb5ad..4d545732aadc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1090,6 +1090,12 @@
>  			the framebuffer, pass the 'ram' option so that it is
>  			mapped with the correct attributes.
>  
> +		linflex,<addr>
> +			Use early console provided by Freescale LinFlex UART
> +			serial driver for NXP S32V234 SoCs. A valid base
> +			address must be provided, and the serial port must
> +			already be setup and configured.

Why isn't earlycon= sufficient for this?

Will
