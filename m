Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46668C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EB02184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909459;
	bh=WCfCXrQQ2e9scIAqUXj4AtNrE87eEeJaP0MtVF3EAEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qe22plgtTlptjIIDJqcAUrhgKuGGPmqDFHvd7PT9JsYoZCr/5E/xZgEdY/B1K56Ta
	 UtgP56w7Gvz5qxBLErZY2GZXUDhOdVXnTH11AQQW4dAiT5RSYXh7A+OMyL2AlhnFhT
	 Ux0nYtNwHYNu9uPb3TwOQox2AuvaKpzFpeunsntE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfC3Ba5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731766AbfC3Bay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69BD2218D3;
        Sat, 30 Mar 2019 01:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909453;
        bh=WCfCXrQQ2e9scIAqUXj4AtNrE87eEeJaP0MtVF3EAEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0zzlRneXzDFWiLJj2h/CqsvRTByg0/jxuBfMh8vW/6LBpZRQ5zAa+Gh6VnSlPj9PK
         6WjESb/bM+DW3dcFulDM2lTLvwztLxw6OZWz9obfOtqt0pWNXWgY9knYsS1pcFlHzG
         4kRWGjLgcliSLhNnz3ZROH3KQDtVx7bEGtiN/AuI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 13/37] ACPI / SBS: Fix GPE storm on recent MacBookPro's
Date:   Fri, 29 Mar 2019 21:29:56 -0400
Message-Id: <20190330013020.379-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronald Tschalär <ronald@innovation.ch>

[ Upstream commit ca1721c5bee77105829cbd7baab8ee0eab85b06d ]

On Apple machines, plugging-in or unplugging the power triggers a GPE
for the EC. Since these machines expose an SBS device, this GPE ends
up triggering the acpi_sbs_callback(). This in turn tries to get the
status of the SBS charger. However, on MBP13,* and MBP14,* machines,
performing the smbus-read operation to get the charger's status triggers
the EC's GPE again. The result is an endless re-triggering and handling
of that GPE, consuming significant CPU resources (> 50% in irq).

In the end this is quite similar to commit 3031cddea633 (ACPI / SBS:
Don't assume the existence of an SBS charger), except that on the above
machines a status of all 1's is returned. And like there, we just want
ignore the charger here.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198169
Signed-off-by: Ronald TschalÃ¤r <ronald@innovation.ch>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/sbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index a2428e9462dd..3c092f07d7e3 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -441,9 +441,13 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 
 	/*
 	 * The spec requires that bit 4 always be 1. If it's not set, assume
-	 * that the implementation doesn't support an SBS charger
+	 * that the implementation doesn't support an SBS charger.
+	 *
+	 * And on some MacBooks a status of 0xffff is always returned, no
+	 * matter whether the charger is plugged in or not, which is also
+	 * wrong, so ignore the SBS charger for those too.
 	 */
-	if (!((status >> 4) & 0x1))
+	if (!((status >> 4) & 0x1) || status == 0xffff)
 		return -ENODEV;
 
 	sbs->charger_present = (status >> 15) & 0x1;
-- 
2.19.1

