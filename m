Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E3220693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370006;
	bh=zibQUQln7n4H2CDIVdOfJm9lbvI0haqw//u/yLBrrpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGtxCO/umA25B3oqJbAISax/trtOMLXl8ZocpJNwaoqpln3K9maGIBs3PcrS9Q/mR
	 XWVAu4MY/irYmNshN05wP8tbTSWzbLb1IOOIH4i5xOiy+QlyMLjTA3e3lwjyyystgk
	 bGIMT5zUEkpK+xDv3vsp9Omqluru7kppNEk3vX64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbfDDJM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732968AbfDDJMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD1520820;
        Thu,  4 Apr 2019 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369173;
        bh=zibQUQln7n4H2CDIVdOfJm9lbvI0haqw//u/yLBrrpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7iSmbuPA17QvB/veosU3y4UHaacWq2lXB0axtiL9sQYICvRAUH1bixIYAvLQLX44
         5dWDpx9bu8bF1hX01wTf/zXsl9EVmUOTL8iXIadT17FiwZ8sHfJJ0uNQwp7/hQLMKa
         Ct1HHB62MZyoBZcwdbH9AGUTzc9ha6DSTpoP/AWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hong Liu <hong.liu@intel.com>,
        Hongyan Song <hongyan.song@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 124/246] HID: intel-ish-hid: avoid binding wrong ishtp_cl_device
Date:   Thu,  4 Apr 2019 10:47:04 +0200
Message-Id: <20190404084623.499194842@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 728dc6d4561a..a271d6d169b1 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -675,7 +675,8 @@ int ishtp_cl_device_bind(struct ishtp_cl *cl)
 	spin_lock_irqsave(&cl->dev->device_list_lock, flags);
 	list_for_each_entry(cl_device, &cl->dev->device_list,
 			device_link) {
-		if (cl_device->fw_client->client_id == cl->fw_client_id) {
+		if (cl_device->fw_client &&
+		    cl_device->fw_client->client_id == cl->fw_client_id) {
 			cl->device = cl_device;
 			rv = 0;
 			break;
@@ -735,6 +736,7 @@ void ishtp_bus_remove_all_clients(struct ishtp_device *ishtp_dev,
 	spin_lock_irqsave(&ishtp_dev->device_list_lock, flags);
 	list_for_each_entry_safe(cl_device, n, &ishtp_dev->device_list,
 				 device_link) {
+		cl_device->fw_client = NULL;
 		if (warm_reset && cl_device->reference_count)
 			continue;
 
-- 
2.19.1



