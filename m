Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BD7206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519878;
	bh=x/c0dywphSDx6W1FtBK+6NpMrfdCQI/RLiuODgV6fn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5+QhloP+qOOwC4bEtAEJJk/NVhn06I1g3ivzQ07MHINboUeGDGQZm6TMEkcYzvwt
	 JLz0CvjYgUgB2ITM/4fChnKAM8JULopGmff+GVyczogkdRsVsUz6pk63oxB9nt8P6P
	 2y1v4F56E7qmdpqtnyQJcgqsrXDemaLdLGm4jYa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfLPSLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfLPSLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:11:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B67C1206B7;
        Mon, 16 Dec 2019 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519874;
        bh=x/c0dywphSDx6W1FtBK+6NpMrfdCQI/RLiuODgV6fn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=in3YfYA67LMu7UGKTgRvi+tRP+2R/aRDtvz/dVeh9u0aK0qjrQy6at0nNlPc0xKsD
         DMfA+UlAkRe90U7TBNqGGBV1YXMWd7lHqeeQPlNhFnZ68Cp5nWaw09MgjXg2PA3uUE
         Tk4Eg4iZ1grlRoMW7zjV7Im9invZPQ71xhERSJiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.3 103/180] ACPI / utils: Move acpi_dev_get_first_match_dev() under CONFIG_ACPI
Date:   Mon, 16 Dec 2019 18:49:03 +0100
Message-Id: <20191216174836.968785364@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit a814dcc269830c9dbb8a83731cfc6fc5dd787f8d upstream.

We have a stub defined for the acpi_dev_get_first_match_dev() in acpi.h
for the case when CONFIG_ACPI=n.

Moreover, acpi_dev_put(), counterpart function, is already placed under
CONFIG_ACPI.

Thus, move acpi_dev_get_first_match_dev() under CONFIG_ACPI as well.

Fixes: 817b4d64da03 ("ACPI / utils: Introduce acpi_dev_get_first_match_dev() helper")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: 5.2+ <stable@vger.kernel.org> # 5.2+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/acpi/acpi_bus.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -78,9 +78,6 @@ acpi_evaluate_dsm_typed(acpi_handle hand
 bool acpi_dev_found(const char *hid);
 bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
 
-struct acpi_device *
-acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
-
 #ifdef CONFIG_ACPI
 
 #include <linux/proc_fs.h>
@@ -683,6 +680,9 @@ static inline bool acpi_device_can_power
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
+struct acpi_device *
+acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
+
 static inline void acpi_dev_put(struct acpi_device *adev)
 {
 	put_device(&adev->dev);


