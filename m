Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E94C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED106205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413279;
	bh=1dNwFVDz8lHRMuujSu3tsbGnWcceyYymBVaJgltluPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJZfFl5Pxf+QXtgQ2ktezXv7lYcwzq1Dl7+dvpWz7ZZPj19FhBmUvXN7p/F187p09
	 8XV5u8Reh37vcZbuctRZ9AKpri0D1BFQ/KQ4B7TxlsX1c2x464jWjpxj0eIAfa+S/4
	 JvsAh/fO8bJIlKNsbWXQQm8mJh+cLugvqYQx8F2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfCLRyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfCLROK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:10 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A06721850;
        Tue, 12 Mar 2019 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410850;
        bh=1dNwFVDz8lHRMuujSu3tsbGnWcceyYymBVaJgltluPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDKFSvo+n9T8OpXTP/TzaD5JAF/6gjYTY9ejM0sYFKYrJb6bRr61Es3+q2srdzOqe
         nw98SdgYcgLopLkbkcBxXLOWcCbK3fLEU3sFdbYP/kOrZRDC0X2MAKaWyNhCiVyjeA
         i0gNH7mwmkjTHE9hiHKyX4V6e2KdDoVDDmTlfHqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/149] platform/x86: Fix unmet dependency warning for ACPI_CMPC
Date:   Tue, 12 Mar 2019 10:07:42 -0700
Message-Id: <20190312170353.441806048@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 0c1aa6c314f5..96afca4648d5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -856,6 +856,7 @@ config TOSHIBA_WMI
 config ACPI_CMPC
 	tristate "CMPC Laptop Extras"
 	depends on ACPI && INPUT
+	depends on BACKLIGHT_LCD_SUPPORT
 	depends on RFKILL || RFKILL=n
 	select BACKLIGHT_CLASS_DEVICE
 	help
-- 
2.19.1



