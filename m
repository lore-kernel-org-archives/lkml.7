Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61D6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76A5217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368221;
	bh=/Bd8Gc07YYv2Y58iJVCprt7QPBnrQ7ivEY0oUxMbngw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0aGkgB7n42W1DA3D1Of9hQA1P7X/N2yyuhao/eDNG9W118/Zsh+QfzURxGVny+s6I
	 vF6EqNEFm0sq0zi/Qn+8cLMBjeIHEGaUWp94W6B4GZdLi+uaTOcH7h3ehRDnbvPn9i
	 WTk9FSDY2XLZxUJKo05K0Vn1EK6mbI4mPBusE2Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfDDI5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbfDDI45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:56:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B872177E;
        Thu,  4 Apr 2019 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368217;
        bh=/Bd8Gc07YYv2Y58iJVCprt7QPBnrQ7ivEY0oUxMbngw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTwPekT73neEx+EueqgXdDPv1rltvUDG5ZN0iBS0SJzZJfeya0zo5Nlos5t8zZ/hy
         PAsQ37Swdy559SxAxpBve7pVE8UhE6WGLbV6qZ2849uR5xF+8LNCytfLQD5R4WxBKu
         U1sQD3XwLrLym+a9l7NdlZuhnd2TdJV+sazxLBCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hong Liu <hong.liu@intel.com>,
        Hongyan Song <hongyan.song@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/121] HID: intel-ish-hid: avoid binding wrong ishtp_cl_device
Date:   Thu,  4 Apr 2019 10:47:33 +0200
Message-Id: <20190404084548.770065645@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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



