Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51CDC48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F3D21530
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053860;
	bh=WSu3/ceb3J+TQuBlB//pSgrMKId2nK1ya7PgVpH5mWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AoTSMJYhM2gcDP3j1gljpDirIWDJW2FqeulILYmkAasapcCK4F9bcWZhtEsqEVa0e
	 yqc2hVrYeQBVamlo4LOY8WawR49IyeuQtsksbdmCXvzKi60ZSgm6ZWuuDTlpxVDjXL
	 rIvxmz/6zOC9afyTe1klDTEkWl82fBRrrj79YxZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfFTSET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfFTSEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:04:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D7E0204FD;
        Thu, 20 Jun 2019 18:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053855;
        bh=WSu3/ceb3J+TQuBlB//pSgrMKId2nK1ya7PgVpH5mWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipdUTSynjhPnPoaOrF8/ltXOyMIbJxZIlK6RwCBmGaNw6UfqFGfu0I8+Phb89Y5Ho
         S5oufcODXjwgcbLuwqv12XjrjdCWYa3SHYd3mXevRM90TnaW6EO3AxUFK65YqvE9ee
         9qrY6RXN0aJZNIUcgnsv2x8hWiB8WRppQM5L6LOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junxiao Chang <junxiao.chang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 043/117] platform/x86: intel_pmc_ipc: adding error handling
Date:   Thu, 20 Jun 2019 19:56:17 +0200
Message-Id: <20190620174354.562843497@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e61985d0550df8c2078310202aaad9b41049c36c ]

If punit or telemetry device initialization fails, pmc driver should
unregister and return failure.

This change is to fix a kernel panic when removing kernel module
intel_pmc_ipc.

Fixes: 48c1917088ba ("platform:x86: Add Intel telemetry platform device")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_pmc_ipc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 0bf51d574fa9..f2b9dd82128f 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -620,13 +620,17 @@ static int ipc_create_pmc_devices(void)
 	if (ret) {
 		dev_err(ipcdev.dev, "Failed to add punit platform device\n");
 		platform_device_unregister(ipcdev.tco_dev);
+		return ret;
 	}
 
 	if (!ipcdev.telem_res_inval) {
 		ret = ipc_create_telemetry_device();
-		if (ret)
+		if (ret) {
 			dev_warn(ipcdev.dev,
 				"Failed to add telemetry platform device\n");
+			platform_device_unregister(ipcdev.punit_dev);
+			platform_device_unregister(ipcdev.tco_dev);
+		}
 	}
 
 	return ret;
-- 
2.20.1



