Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B848FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889BB20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688035;
	bh=yBb+yU9nAHS5c6QPyj9qpA/vi2Dnyz/ty7K7nIsh43Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1aqcvZbv9ywEncRW3UBa+f6LknWY3H55OXNR448kgROv9z56X00kpkWuBFA4ubD9n
	 2QuegGUQxrm4E4jbm4iuB801JgmAYuFnxpwW8LNJ+OjvCU3cbBgyd1+luzir5d0lFV
	 zc/jJYMd7Y1rqFMXo21biCmtFNzlXUnZGBuu29M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCDI1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfCDI1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:27:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C5820823;
        Mon,  4 Mar 2019 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688029;
        bh=yBb+yU9nAHS5c6QPyj9qpA/vi2Dnyz/ty7K7nIsh43Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYtrq0e2FykIRf8DMxgaq028iLuE7T9+9NI/3hNy5Xcl6T8dg7qNN1qQYZffVd4J4
         zMKg2ritZoWAKS+7mSMt/yMl94FFXnMFjJCCKUlvY0CrzFvIgqMe78dGkgLm5G8Vx+
         6iil/900UMkc+gwZXfFUu5HjYRvgLcAwukHW8MxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/52] thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
Date:   Mon,  4 Mar 2019 09:22:10 +0100
Message-Id: <20190304081617.827486185@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index f02341f7134d4..c6ab7db8c8e23 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -416,7 +416,7 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 		proc_priv->soc_dts = intel_soc_dts_iosf_init(
 					INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
 
-		if (proc_priv->soc_dts && pdev->irq) {
+		if (!IS_ERR(proc_priv->soc_dts) && pdev->irq) {
 			ret = pci_enable_msi(pdev);
 			if (!ret) {
 				ret = request_threaded_irq(pdev->irq, NULL,
-- 
2.19.1



