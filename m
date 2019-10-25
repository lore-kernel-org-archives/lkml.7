Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF1FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBC521D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572012193;
	bh=pMRvbdDCb4dImnhTz2eaL8s9Wnfeqq0pbrx6tQqzFUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M27YnEsAD+SKdK60aU9aimGt7aZbW3kIU1GZ3xruLEK1c5iQtrymUqgu0z4SB6jeY
	 G7He6m9YBzooLvEiqt9U22PZJ8rGIMsuUp79kJqB03I34ZFZjWDPEQnFb1hY88RIl8
	 jeNJP5UaBfse3T2hJXax5KUavKRB0Fz115YTE5+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395108AbfJYODM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505299AbfJYN5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:57:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D683B222C2;
        Fri, 25 Oct 2019 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011840;
        bh=pMRvbdDCb4dImnhTz2eaL8s9Wnfeqq0pbrx6tQqzFUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYxq7FbYJzgNwykN05TYZbuR6U6qLWn4FWGYyJuSWxzeHgzeNgXY7mxGKN4zsltTf
         lIFZbpFJu1k7w4za9P7TETw7QwT+v8VeeyHsxVxYFcpOMRdC26w9rKTQD0/S19asp/
         vcS1luzUlbWZuASp06+alZ6xGPmWvZbO2J0NrLxE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/25] ACPI: video: Use vendor backlight on Sony VPCEH3U1E
Date:   Fri, 25 Oct 2019 09:56:51 -0400
Message-Id: <20191025135715.25468-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025135715.25468-1-sashal@kernel.org>
References: <20191025135715.25468-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit aefa763b18a220f5fc1d5ab02af09158b6cc36ea ]

On Sony Vaio VPCEH3U1E, ACPI backlight control does not work, and native
backlight works. Thus force use vendor backlight control on this system.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202401
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 43587ac680e47..0e0a3929e34e2 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -141,6 +141,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
 		},
 	},
+	{
+	.callback = video_detect_force_vendor,
+	.ident = "Sony VPCEH3U1E",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEH3U1E"),
+		},
+	},
 
 	/*
 	 * These models have a working acpi_video backlight control, and using
-- 
2.20.1

