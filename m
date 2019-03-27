Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2259C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC313206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713448;
	bh=LvLKoPMWKuLlrz0K3rjLUwBtbKSrMaa6v0Vn/KQONoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VovyxSPGSNfpM1XnOGlOk8YIasKK7rSrVvtSe8Jm52fCzlwxvi7jm8VEh+25BO+qa
	 aS9oCryf9JAStBsDworKI1qzGmOzWaRAAN5KmErAO8y5H0zfCfZicvxCVMSfPIGT7A
	 zffBjwvN8PekNy5aOPk3nyDuGW527oVPbySLUjU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbfC0SNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389351AbfC0SNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7FFE2147C;
        Wed, 27 Mar 2019 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710388;
        bh=LvLKoPMWKuLlrz0K3rjLUwBtbKSrMaa6v0Vn/KQONoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8TM+jLezv3jxRl+e8/GePi6PoN8LjHOw97J/i5osvvk/g4pqqOWjcSZDAQTGg0bU
         HJC6dVNT4C15eGkwlsHCUhEnjSAvc1OQFov5I5eAtdxxfE3i9o20PJwH7nWaKklFD2
         2d8x7AdQ4AMx34/4yIuw9spFEfk949dw0+dxNuPM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hong Liu <hong.liu@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 095/192] HID: intel-ish-hid: avoid binding wrong ishtp_cl_device
Date:   Wed, 27 Mar 2019 14:08:47 -0400
Message-Id: <20190327181025.13507-95-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hong Liu <hong.liu@intel.com>

[ Upstream commit 0d28f49412405d87d3aae83da255070a46e67627 ]

When performing a warm reset in ishtp bus driver, the ishtp_cl_device
will not be removed, its fw_client still points to the already freed
ishtp_device.fw_clients array.

Later after driver finishing ishtp client enumeration, this dangling
pointer may cause driver to bind the wrong ishtp_cl_device to the new
client, causing wrong callback to be called for messages intended for
the new client.

This helps in development of firmware where frequent switching of
firmwares is required without Linux reboot.

Signed-off-by: Hong Liu <hong.liu@intel.com>
Tested-by: Hongyan Song <hongyan.song@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 2623a567ffba..f546635e9ac9 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -623,7 +623,8 @@ int ishtp_cl_device_bind(struct ishtp_cl *cl)
 	spin_lock_irqsave(&cl->dev->device_list_lock, flags);
 	list_for_each_entry(cl_device, &cl->dev->device_list,
 			device_link) {
-		if (cl_device->fw_client->client_id == cl->fw_client_id) {
+		if (cl_device->fw_client &&
+		    cl_device->fw_client->client_id == cl->fw_client_id) {
 			cl->device = cl_device;
 			rv = 0;
 			break;
@@ -683,6 +684,7 @@ void ishtp_bus_remove_all_clients(struct ishtp_device *ishtp_dev,
 	spin_lock_irqsave(&ishtp_dev->device_list_lock, flags);
 	list_for_each_entry_safe(cl_device, n, &ishtp_dev->device_list,
 				 device_link) {
+		cl_device->fw_client = NULL;
 		if (warm_reset && cl_device->reference_count)
 			continue;
 
-- 
2.19.1

