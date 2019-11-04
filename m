Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F329CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E479D21D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572832672;
	bh=mtTHSbd7Hygdqlh64EyjBn0IsDGy91z2yQc/KOzX5WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ho55KfsRQgG7/6mKlDbyAQlohznsfp3hznsvufNxIzwFlkCi07mqeBez7/3wmiTHM
	 JR1aqQl+jAf4hur5K01scokE6uzNbYkZx8ZqkRSq24Hw69Prmhqfiv6i9k45+ALKgO
	 E7TYDeRiz3xMweLFlO2K2y5Osgrh8N0SUsgP2T0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfKDB5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:57:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728432AbfKDB5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:57:49 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FBEA217F5;
        Mon,  4 Nov 2019 01:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572832668;
        bh=mtTHSbd7Hygdqlh64EyjBn0IsDGy91z2yQc/KOzX5WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFGqMMQUSdY8FeF1cxANXcYO0epjGC61gmKn4S+OW0/Fx4k3PD3xtBqv9JPI9642X
         2xPvSnF+uXUEXdrhuT8Rc/n6L6aPR3hypcKwH97mHpRtARM1mtV+sByJLA/hhyV9ja
         rum3NU0wfmTs9wtJTTYMYKB9FtlsaQmB+oo7kX38=
Date:   Mon, 4 Nov 2019 09:57:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: dts: imx7ulp-evk: Use APLL_PFD1 as usdhc's clock
 source
Message-ID: <20191104015722.GM24620@dragon>
References: <1572482622-22070-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572482622-22070-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 08:43:42AM +0800, Anson Huang wrote:
> i.MX7ULP does NOT support runtime switching clock source for PCC,
> APLL_PFD1 by default is usdhc's clock source, so just use it
> in kernel to avoid below kernel dump during kernel boot up and
> make sure kernel can boot up with SD root file-system.
> 
> [    3.035892] Loading compiled-in X.509 certificates
> [    3.136301] sdhci-esdhc-imx 40370000.mmc: Got CD GPIO
> [    3.242886] mmc0: Reset 0x1 never completed.
> [    3.247190] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    3.253751] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    3.260218] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> [    3.266775] mmc0: sdhci: Argument:  0x00009a64 | Trn mode: 0x00000000
> [    3.273333] mmc0: sdhci: Present:   0x00088088 | Host ctl: 0x00000002
> [    3.279794] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000080
> [    3.286350] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000007f
> [    3.292901] mmc0: sdhci: Timeout:   0x0000008c | Int stat: 0x00000000
> [    3.299364] mmc0: sdhci: Int enab:  0x007f010b | Sig enab: 0x00000000
> [    3.305918] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
> [    3.312471] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b400
> [    3.318934] mmc0: sdhci: Cmd:       0x0000113a | Max curr: 0x00ffffff
> [    3.325488] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x0039b37f
> [    3.332040] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
> [    3.338501] mmc0: sdhci: Host ctl2: 0x00000000
> [    3.343051] mmc0: sdhci: ============================================
> 
> Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Tested-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
