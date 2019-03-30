Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9330EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAEE2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908144;
	bh=BRU6nGgdquvegwE9j9bghspsqA8Zse4qqoTXwFZzOXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KHwtrOgi3RRd+CKQp4JStnU25E5PSdK/wdZNWl7PQLCiqH3DNyTF+ioSM09rcMAtX
	 AppTY2SJIfDtUPhT8c9czQRZjhVl6iktI2bMj0TuHumbNQjxAYqFkmBXKW7yGa+5uh
	 UN86m9vWmXDBJ0rTP3tlLYnF5V37UR+x9Ll57IfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfC3Awf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfC3Awa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA04B21901;
        Sat, 30 Mar 2019 00:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907150;
        bh=BRU6nGgdquvegwE9j9bghspsqA8Zse4qqoTXwFZzOXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xz2e59C7AqG7XR5yzORCwGICmRm2WlqF8//qQ0aRIRSiDCUXtmQf6O8ISNcucCdab
         WAFvtCwXGXfm6JCW4T+y1ziDV8LI7Cque0FpaAd8WlhzeVU2Pqh2inr1e2npVv6Ik5
         4DuH6zw5flvYEXi3b3skLMYiHjuTkVaZkztu5j3M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 49/67] ACPI / utils: Drop reference in test for device presence
Date:   Fri, 29 Mar 2019 20:50:29 -0400
Message-Id: <20190330005047.25998-49-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 54e3aca84e571559915998aa6cc05e5ac37c043b ]

When commit 8661423eea1a ("ACPI / utils: Add new acpi_dev_present
helper") introduced acpi_dev_present(), it missed the fact that
bus_find_device() took a reference on the device found by it and
the callers of acpi_dev_present() don't drop that reference.

Drop the reference on the device in acpi_dev_present().

Fixes: 8661423eea1a ("ACPI / utils: Add new acpi_dev_present helper")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 78db97687f26..c4b06cc075f9 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -800,6 +800,7 @@ bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 	match.hrv = hrv;
 
 	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
+	put_device(dev);
 	return !!dev;
 }
 EXPORT_SYMBOL(acpi_dev_present);
-- 
2.19.1

