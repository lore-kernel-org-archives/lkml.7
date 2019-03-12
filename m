Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8648FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D9B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414135;
	bh=M8COW1q4tXAq0WQxdWnnlpwEUxJDwKsXLSgkTsxTVuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVK0C9nBnln0ZozYcRmD6D7374tSnOBZQo5WqlMMQU247Qo3mU2M/3Bf4/7OvZD7F
	 AxZoTQaIfOPfOahYCx2RCGkCrfGeD6f+cIlp1AvP7j70CkZ2olwYPFN/ahpzIgiiXG
	 xK/exwpJ1vW74xQJBSW9bmCmeQ45SfwkOaqSQ8Bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfCLSIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfCLRML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:11 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5828A2083D;
        Tue, 12 Mar 2019 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410730;
        bh=M8COW1q4tXAq0WQxdWnnlpwEUxJDwKsXLSgkTsxTVuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzwEauEb9Lp4+cx1NRdPU71DVCt4Ke4NRIpmKZOrJ9BVItLIJuIxvBli4zpT250p2
         Z0Mjnl7Bl9i2YRnQEQzgGmZ8a54yuxsKzyUTEkntaYrlITJX/xGz9r/MqoP2t4fkRC
         4MhH+PBjU94C4ssNe5kWtfHXfbi2oR8IzTxMG6AA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 050/171] platform/x86: Fix unmet dependency warning for ACPI_CMPC
Date:   Tue, 12 Mar 2019 10:07:10 -0700
Message-Id: <20190312170352.421367223@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d58bf90a32a33becec78c3034e781735049fcd25 ]

Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.

ACPI_CMPC selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
depends on BACKLIGHT_LCD_SUPPORT.

Copy BACKLIGHT_LCD_SUPPORT dependency into ACPI_CMPC to fix

WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
  Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
  Selected by [y]:
  - ACPI_CMPC [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && INPUT [=y] && (RFKILL [=n] || RFKILL [=n]=n)

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 54f6a40c75c6..458f92aac92e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -901,6 +901,7 @@ config TOSHIBA_WMI
 config ACPI_CMPC
 	tristate "CMPC Laptop Extras"
 	depends on ACPI && INPUT
+	depends on BACKLIGHT_LCD_SUPPORT
 	depends on RFKILL || RFKILL=n
 	select BACKLIGHT_CLASS_DEVICE
 	help
-- 
2.19.1



