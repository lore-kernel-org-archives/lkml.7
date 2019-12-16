Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38002C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0779A206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520640;
	bh=b6FHj+maMhZUKVUQhdEcWTeoceobhOMs2XG/SnLR0FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qiJ7iYjwf7xeS8PNk2b1Zd7ICGav+ZA3WSXpAgbA2+rQDO0fuuypsgn/9AeGSGWAW
	 YPkW+Z+rRu4i0Vpo2dnCrjA4FB5ZTVL8Q4GDoRb4h+ca1QxG8QfcuvEOJrwKDv+oVB
	 q7lNoy3MInnVUcz5iDKmLcgl8gOyBgHIaBkP5uWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfLPSTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731802AbfLPSTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:19:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9CF21775;
        Mon, 16 Dec 2019 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520369;
        bh=b6FHj+maMhZUKVUQhdEcWTeoceobhOMs2XG/SnLR0FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcX7U7CSeTA+AhugY7Vf3g4AlE/a//yOgo3C7Bo4DE4jTMPFUhCUzvaZpe551jcgr
         BSiolTkZL81z0owKctG6isnD/Es36DICVqaroSTTmtgrPSKB1TpCLe+NubnzCd7HtU
         wF2d0gLao5pFb+RqXAK9WGbwNrZIbbJHxZfTVJF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 124/177] ACPI: LPSS: Add LNXVIDEO -> BYT I2C1 to lpss_device_links
Date:   Mon, 16 Dec 2019 18:49:40 +0100
Message-Id: <20191216174843.681112398@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit b3b3519c04bdff91651d0a6deb79dbd4516b5d7b upstream.

Various Asus Bay Trail devices (T100TA, T100CHI, T200TA) have an embedded
controller connected to I2C1 and the iGPU (LNXVIDEO) _PS0/_PS3 methods
access it, so we need to add a consumer link from LNXVIDEO to I2C1 on
these devices to avoid suspend/resume ordering problems.

Fixes: 2d71ee0ce72f ("ACPI / LPSS: Add a device link from the GPU to the BYT I2C5 controller")
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_lpss.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -477,6 +477,8 @@ static const struct lpss_device_links lp
 	{"808622C1", "7", "80860F14", "3", DL_FLAG_PM_RUNTIME},
 	/* CHT iGPU depends on PMIC I2C controller */
 	{"808622C1", "7", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
+	/* BYT iGPU depends on the Embedded Controller I2C controller (UID 1) */
+	{"80860F41", "1", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
 	/* BYT CR iGPU depends on PMIC I2C controller (UID 5 on CR) */
 	{"80860F41", "5", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
 	/* BYT iGPU depends on PMIC I2C controller (UID 7 on non CR) */


