Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34864C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064F204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208303;
	bh=sz3G/G7S59Ufj57jzQemIJTIAXrIRuQ6U/WPK+vEEH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hEudq5xbBqfwSS3EpZVcf9OaaRF4E32mh34FJwb+/eKGvgs6SDEpGh4tNgB8DT0EV
	 DdKA/oCr8I9hxG3KF1mQUJOrQ5qesSamFGUwRozjqnvBwBf8HS4kAvfa843kGsyt7B
	 X0VuP09v5oNUvqoQjDBU0s0JdZV11pLk1FUQllYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfEGFvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbfEGFjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:39:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2908420675;
        Tue,  7 May 2019 05:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207589;
        bh=sz3G/G7S59Ufj57jzQemIJTIAXrIRuQ6U/WPK+vEEH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Satpoahixke2p4Zp9JZVVKOWs1CcyW3t1DJSB83E+AzV9BpY82ddC0SbXxJsNH21G
         LbRoRAhgwY/SEtYNk74AdND7XsGRzdRSsFsP/GyGtKbaRSZw/ISkTQHIosKCp0+zCQ
         YpZNaL8fZ/Ybg5gI0j2k1eplXFWNBAz+fiSv5iZo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [PATCH AUTOSEL 4.14 39/95] ACPICA: AML interpreter: add region addresses in global list during initialization
Date:   Tue,  7 May 2019 01:37:28 -0400
Message-Id: <20190507053826.31622-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erik Schmauss <erik.schmauss@intel.com>

[ Upstream commit 4abb951b73ff0a8a979113ef185651aa3c8da19b ]

The table load process omitted adding the operation region address
range to the global list. This omission is problematic because the OS
queries the global list to check for address range conflicts before
deciding which drivers to load. This commit may result in warning
messages that look like the following:

[    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
[    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver

However, these messages do not signify regressions. It is a result of
properly adding address ranges within the global address list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpica/dsopcode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 0336df7ac47d..e8070f6ca835 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -451,6 +451,10 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
 			  ACPI_FORMAT_UINT64(obj_desc->region.address),
 			  obj_desc->region.length));
 
+	status = acpi_ut_add_address_range(obj_desc->region.space_id,
+					   obj_desc->region.address,
+					   obj_desc->region.length, node);
+
 	/* Now the address and length are valid for this opregion */
 
 	obj_desc->region.flags |= AOPOBJ_DATA_VALID;
-- 
2.20.1

