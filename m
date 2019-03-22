Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC216C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8FC21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254116;
	bh=wOjABEPksF5yie8rQCNkI61MgcHhXSlOZHhaVkkKV0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jXwrB4Krvvd3KlFWR7PyWMVyQQPMqRWEigEUvHUtOoWO8FOam23c74KaVEw8WuTF5
	 bY8PetFGGq1ZB+xMrOZ30H/4RUJpYh43tbX/ARyhOqzhQqtlGG+B59lqqMyjMuf3bO
	 vfQO+p1M8bJeRX+v63lk79WnQxe0YGaJn7cK/AnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfCVL2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbfCVL2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:28:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F164821929;
        Fri, 22 Mar 2019 11:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254110;
        bh=wOjABEPksF5yie8rQCNkI61MgcHhXSlOZHhaVkkKV0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3dXfs51TLzAjGHEpTrH2Bt05J4lZMMl8FBWgZJ5ofdWbhmQ+kR0lCBxXC/58zFAN
         ZnvpWZjk+JY87N3ftq96c096dMHw/Ur7ZF6C3RnRpQon7177s/Xtfl2AH/i5QfZ/Ys
         5tc+1BN8T9OxawfS9B0MiVddZjqXgItHk4qV5L9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 035/230] thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
Date:   Fri, 22 Mar 2019 12:12:53 +0100
Message-Id: <20190322111239.161075639@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index ccc0ad02d0669..7f374ab5b1760 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -363,7 +363,7 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 		proc_priv->soc_dts = intel_soc_dts_iosf_init(
 					INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
 
-		if (proc_priv->soc_dts && pdev->irq) {
+		if (!IS_ERR(proc_priv->soc_dts) && pdev->irq) {
 			ret = pci_enable_msi(pdev);
 			if (!ret) {
 				ret = request_threaded_irq(pdev->irq, NULL,
-- 
2.19.1



