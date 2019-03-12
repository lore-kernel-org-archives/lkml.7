Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DDAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3A52087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413261;
	bh=Pfal4VrzdWj5ycOE/UcwQLbQsEy0XKkf1+tXF3t/xXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dG8Vzmbv7XLE/zkwhX4nk/oaUcFgYiz/BOgaoc+yK+NpTNzSnIpS3sx6zK05ta6wa
	 GYQWMgacnyjkwiuWmDHA57bIJnHSQw/nQslMOe4geKgwr4xtJIpafe7ZmUALSPe/dI
	 EEuEBVz6YeLtzj+q4uC6lONG748IresCpcEgDOkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfCLRyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfCLROL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:11 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2102186A;
        Tue, 12 Mar 2019 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410851;
        bh=Pfal4VrzdWj5ycOE/UcwQLbQsEy0XKkf1+tXF3t/xXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfIOCrYrr3VHRXALFAx9HrLYbyLIixsV0b9O0W/ioAtvU6Qs4Wv86PB05YOzm/RGK
         4jwD3GNIaFXTHS7J11c4AWBA+WVNjARRL6mMbDLvwJCsSfQOqaxh7QMP0xNQpk+mjE
         WhXKaG+R59+yeKBLt1E6HA1LxkWxkwMX2GpXR4jE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/149] platform/x86: Fix unmet dependency warning for SAMSUNG_Q10
Date:   Tue, 12 Mar 2019 10:07:43 -0700
Message-Id: <20190312170353.540894091@linuxfoundation.org>
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

[ Upstream commit 0ee4b5f801b73b83a9fb3921d725f2162fd4a2e5 ]

Add BACKLIGHT_LCD_SUPPORT for SAMSUNG_Q10 to fix the
warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.

SAMSUNG_Q10 selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
depends on BACKLIGHT_LCD_SUPPORT.

Copy BACKLIGHT_LCD_SUPPORT dependency into SAMSUNG_Q10 to fix:

WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
  Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
  Selected by [y]:
  - SAMSUNG_Q10 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y]

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 96afca4648d5..7563c07e14e4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1078,6 +1078,7 @@ config INTEL_OAKTRAIL
 config SAMSUNG_Q10
 	tristate "Samsung Q10 Extras"
 	depends on ACPI
+	depends on BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver provides support for backlight control on Samsung Q10
-- 
2.19.1



