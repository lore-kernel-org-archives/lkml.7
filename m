Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0019BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA88218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610384;
	bh=AcHtwJZLIP5ZxBGvwr0IP7u79ECIX+JnBeYDJZZPisI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b4sdqwT3ahI3RHi404VPDFOmeprr/L6TH5sU/+7iOkpDNp7VI3qSqq07LnkQZTzzW
	 jSqsK8F03iMV/HOdg0svlCgoSN53djotg3jHBP8uSoBFOpPr15gB4Xvj0ilfSE3Yn4
	 B9TOAvJbO0YJJpIyeIadC1VT0/OQbn0gBEip9mN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbfDRR7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390187AbfDRR7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:59:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B814C217FA;
        Thu, 18 Apr 2019 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610379;
        bh=AcHtwJZLIP5ZxBGvwr0IP7u79ECIX+JnBeYDJZZPisI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+/oBdWdSrWx0+xndhLtsLvW4VezFYc95j/JpHbJNb9ON5Fwd53NYZBOflKAoIaGa
         4NBgEih/CvGAIHRaNpDFaGqQkShJD42mGfTVKKhcbZH+wbCv1qYIujTDaSnozjZOvu
         7bQnoRJAdWPlOEaQhRwB+gSWQExwDdFaLqk8Ed0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/110] ACPI / utils: Drop reference in test for device presence
Date:   Thu, 18 Apr 2019 19:56:27 +0200
Message-Id: <20190418160442.289954925@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



