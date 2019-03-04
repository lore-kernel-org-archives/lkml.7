Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C6C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B9F21019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688094;
	bh=2bDs6sPQr1dB6E60N2/Db2h0nOwYk114zZcW3xlkd0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wa9/7woiYH0sk8gYkca/Ne/4F6aYDIlOdSHw5NvcJUAFywbSZ26raM2P0DYRUuDdz
	 XeWhRohixz7aJnZAyNCXyDtFtECLlBoIAeGPPlSX8CpwBVM7rPGQcjyyr+1T40NH9m
	 uzv10CIkEffnuBTljn/KSSdAjbKfzygrNUBfgPk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCDI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfCDI2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:28:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F1120823;
        Mon,  4 Mar 2019 08:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688086;
        bh=2bDs6sPQr1dB6E60N2/Db2h0nOwYk114zZcW3xlkd0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUAoVa7UvlcbyfxdCg0GS1zYr2bqLBf7RXJLpTYB/7ZMNDdRsahHxjOSCh7gG1au+
         Nixx+H0Cdi5pW8ITZP5kRISm0MY12JdbGd/vYsAoEHA+ciOvJ6knTUvwZhWRkb2bgd
         Yf8wH/yhqcITSGMbGqg2kTOpHLMX0H6+sCi04/tM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/78] thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
Date:   Mon,  4 Mar 2019 09:21:56 +0100
Message-Id: <20190304081626.098003701@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3fe931b31a4078395c1967f0495dcc9e5ec6b5e3 ]

The intel_soc_dts_iosf_init() function doesn't return NULL, it returns
error pointers.

Fixes: 4d0dd6c1576b ("Thermal/int340x/processor_thermal: Enable auxiliary DTS for Braswell")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/int340x_thermal/processor_thermal_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 284cf2c5a8fd9..8e0f665cf06f8 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -423,7 +423,7 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 		proc_priv->soc_dts = intel_soc_dts_iosf_init(
 					INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
 
-		if (proc_priv->soc_dts && pdev->irq) {
+		if (!IS_ERR(proc_priv->soc_dts) && pdev->irq) {
 			ret = pci_enable_msi(pdev);
 			if (!ret) {
 				ret = request_threaded_irq(pdev->irq, NULL,
-- 
2.19.1



