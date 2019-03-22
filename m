Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6CDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E26A218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254317;
	bh=Jek7D92YEUvqBoul9eRmVxbfP6R8VPCvr1DK4KdufSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uWzVCcexCOf9cDNfcvhdNSflJTb80ujNUzKyO6R+EbWa3BxyhH4NmrDUiPQ3OBncv
	 t7VZd8gTMkh8MrxikJF+B/Iz6jfh0v8F+T46S2evVnedP4Rom/XyxeKDnmypA7OKQH
	 faHKdqMENWJIkvCAXnZ1EbAUht7sM97P5NPLpC28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfCVLbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbfCVLbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4D621917;
        Fri, 22 Mar 2019 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254310;
        bh=Jek7D92YEUvqBoul9eRmVxbfP6R8VPCvr1DK4KdufSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mw7WDho9+xIc9RPpLb/0dgC8jyJGJXhTuuaKnZs1a42B++Ppq5uC9gJgwZBIwdNKS
         Pzw3DGyC4/Fuab2TIgwhE2w7zJSa27dYHaemgQVip+e7pzp5+iGFCzuWHoU9O/3Mma
         uiCV9cCEC/jlx7I0J+Dw1AuEaijY675n7lf4rpV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 096/230] platform/x86: Fix unmet dependency warning for SAMSUNG_Q10
Date:   Fri, 22 Mar 2019 12:13:54 +0100
Message-Id: <20190322111243.345433851@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 988ebe9a6b90..953974b5a9a9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -881,6 +881,7 @@ config INTEL_OAKTRAIL
 config SAMSUNG_Q10
 	tristate "Samsung Q10 Extras"
 	depends on ACPI
+	depends on BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver provides support for backlight control on Samsung Q10
-- 
2.19.1



