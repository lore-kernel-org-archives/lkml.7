Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA940C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712FD20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688677;
	bh=5FbApxX4/3o5X4n0kspqAH8hDMTsh4Zhiu6ofvm9xUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oh63LzXTgCtWSyyaaLJw03NxYCjNHeY5R7YdcVmXW701dGRcduYsjEpD7YCD8ORmr
	 d4zlWwTRFragdlcAOgwG55CrMac7OjmYn5vYnm9Q7/Riiefzm36CtAb9WrQBXmiVk7
	 7r/BCPW5fmR08NiId6TCycziHfJHzXNuBIGE9k88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfCDIff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfCDIfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8254B20823;
        Mon,  4 Mar 2019 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688533;
        bh=5FbApxX4/3o5X4n0kspqAH8hDMTsh4Zhiu6ofvm9xUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceveyhPP6yiuWDWMaJhO4INNoJdCCAH2KeoIwGPGLYUe7dfDGRhImRy6+/RaIH1Mq
         uoEBj5HkKLJbZl8BCgxmnJwODi3+CFUH9FAfnfxL8OqzTYneiqPiAoCwhuFc4M/AiH
         /xoGYFZqS/PmMvbvZurmUIP+pz3wjLiJIIfZvx5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 74/88] mmc: sdhci-esdhc-imx: correct the fix of ERR004536
Date:   Mon,  4 Mar 2019 09:22:57 +0100
Message-Id: <20190304081633.563038513@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: BOUGH CHEN <haibo.chen@nxp.com>

commit e30be063d6dbcc0f18b1eb25fa709fdef89201fb upstream.

Commit 18094430d6b5 ("mmc: sdhci-esdhc-imx: add ADMA Length
Mismatch errata fix") involve the fix of ERR004536, but the
fix is incorrect. Double confirm with IC, need to clear the
bit 7 of register 0x6c rather than set this bit 7.
Here is the definition of bit 7 of 0x6c:
    0: enable the new IC fix for ERR004536
    1: do not use the IC fix, keep the same as before

Find this issue on i.MX845s-evk board when enable CMDQ, and
let system in heavy loading.

root@imx8mmevk:~# dd if=/dev/mmcblk2 of=/dev/null bs=1M &
root@imx8mmevk:~# memtester 1000M > /dev/zero &
root@imx8mmevk:~# [  139.897220] mmc2: cqhci: timeout for tag 16
[  139.901417] mmc2: cqhci: ============ CQHCI REGISTER DUMP ===========
[  139.907862] mmc2: cqhci: Caps:      0x0000310a | Version:  0x00000510
[  139.914311] mmc2: cqhci: Config:    0x00001001 | Control:  0x00000000
[  139.920753] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
[  139.927193] mmc2: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
[  139.933634] mmc2: cqhci: TDL base:  0x7809c000 | TDL up32: 0x00000000
[  139.940073] mmc2: cqhci: Doorbell:  0x00030000 | TCN:      0x00000000
[  139.946518] mmc2: cqhci: Dev queue: 0x00010000 | Dev Pend: 0x00010000
[  139.952967] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
[  139.959411] mmc2: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000000
[  139.965857] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
[  139.972308] mmc2: cqhci: Resp idx:  0x0000002e | Resp arg: 0x00000900
[  139.978761] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
[  139.985214] mmc2: sdhci: Sys addr:  0xb2c19000 | Version:  0x00000002
[  139.991669] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
[  139.998127] mmc2: sdhci: Argument:  0x40110400 | Trn mode: 0x00000033
[  140.004618] mmc2: sdhci: Present:   0x01088a8f | Host ctl: 0x00000030
[  140.011113] mmc2: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[  140.017583] mmc2: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
[  140.024039] mmc2: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
[  140.030497] mmc2: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f4000
[  140.036972] mmc2: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
[  140.043426] mmc2: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
[  140.049867] mmc2: sdhci: Cmd:       0x00002c1a | Max curr: 0x00ffffff
[  140.056314] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[  140.062755] mmc2: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d00f00
[  140.069195] mmc2: sdhci: Host ctl2: 0x00000008
[  140.073640] mmc2: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x7809c108
[  140.080079] mmc2: sdhci: ============================================
[  140.086662] mmc2: running CQE recovery

Fixes: 18094430d6b5 ("mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-esdhc-imx.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1097,11 +1097,12 @@ static void sdhci_esdhc_imx_hwinit(struc
 		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
 			| ESDHC_BURST_LEN_EN_INCR,
 			host->ioaddr + SDHCI_HOST_CONTROL);
+
 		/*
-		* erratum ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
-		* TO1.1, it's harmless for MX6SL
-		*/
-		writel(readl(host->ioaddr + 0x6c) | BIT(7),
+		 * erratum ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
+		 * TO1.1, it's harmless for MX6SL
+		 */
+		writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
 			host->ioaddr + 0x6c);
 
 		/* disable DLL_CTRL delay line settings */


