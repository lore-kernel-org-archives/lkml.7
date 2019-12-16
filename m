Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B58C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB9A2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519165;
	bh=iiGxtiCksUKZs3N0Uvz48pMrybG/3CoWbd+PwipCuu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a6Up0nyvXbe+Xkj9jMZUZkEcihQ0K9rkqLFkKa+I9WooDmNktf/DDxKnGIbPwpvJs
	 dL38DEmAzxNev/+UzFkJBqKCnlRCOj+aTO7g3iVvlqhUUUob3qdNV5iPXWzr+Z6nrD
	 ruXxHYTGTcbX+/8c8QyD2T1noilLoXvj3yEU4T4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfLPR7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbfLPR7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:59:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76FD9205ED;
        Mon, 16 Dec 2019 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519160;
        bh=iiGxtiCksUKZs3N0Uvz48pMrybG/3CoWbd+PwipCuu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PybzV/zvIvt7JF/Axnwd8ONhmJQiav0I7GvOCuVmB4ND79ku54WfRppFGMEhhXaqm
         YzpnWmYppe++JxAzG8lIkDqzxVMl3pArHiWw1e9lEcqcn5Evwn8pqAa8BDT1T0tZ6u
         vVa16hHQP8zuLaV2NndDElnxLkexPu7gPcookQ8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 219/267] ACPI: PM: Avoid attaching ACPI PM domain to certain devices
Date:   Mon, 16 Dec 2019 18:49:05 +0100
Message-Id: <20191216174914.554256331@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit b9ea0bae260f6aae546db224daa6ac1bd9d94b91 upstream.

Certain ACPI-enumerated devices represented as platform devices in
Linux, like fans, require special low-level power management handling
implemented by their drivers that is not in agreement with the ACPI
PM domain behavior.  That leads to problems with managing ACPI fans
during system-wide suspend and resume.

For this reason, make acpi_dev_pm_attach() skip the affected devices
by adding a list of device IDs to avoid to it and putting the IDs of
the affected devices into that list.

Fixes: e5cc8ef31267 (ACPI / PM: Provide ACPI PM callback routines for subsystems)
Reported-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/device_pm.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1154,9 +1154,19 @@ static void acpi_dev_pm_detach(struct de
  */
 int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
+	/*
+	 * Skip devices whose ACPI companions match the device IDs below,
+	 * because they require special power management handling incompatible
+	 * with the generic ACPI PM domain.
+	 */
+	static const struct acpi_device_id special_pm_ids[] = {
+		{"PNP0C0B", }, /* Generic ACPI fan */
+		{"INT3404", }, /* Fan */
+		{}
+	};
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 
-	if (!adev)
+	if (!adev || !acpi_match_device_ids(adev, special_pm_ids))
 		return -ENODEV;
 
 	if (dev->pm_domain)


