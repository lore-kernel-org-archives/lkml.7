Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E74DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE69205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437316;
	bh=Wrj2WyIXcBmoMoV7uSeARcm4AvsIXTFlsWvCPMKuVqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNc7vllzZoWzVLEN242VoLYvlS1Su5U6S+4Q9kTgWsmW/PQSQB3UMH9sh8IPOPC9Y
	 HBFds73txExzXw+8pJQy5oKt40hAHo9Y7RCKZb+zNACI78X+Kl2mMdbODGAhRavKbr
	 4OL3tzu+LPgfhcX9JjSD1UsHVYessOeQhi0Tl2os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfJRWGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbfJRWGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:06:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237C320679;
        Fri, 18 Oct 2019 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436365;
        bh=Wrj2WyIXcBmoMoV7uSeARcm4AvsIXTFlsWvCPMKuVqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zb4mqdJ5WAR7sM0Z0MJdaCcj8xgh1oaAZEnDcOl9+u5WOE2QbmmbHojUTNk2hauZy
         OJbtNZzDcOp4r6/OqnLcpUNtWOBD/5rtujcTFAy2KYb/VCtH0CeJuw4LxUqvOgQsw+
         3sU9tgPpsZMwtW30eEKFfwKertDAfOWN0Vmb+fGY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 020/100] platform/x86: Add the VLV ISP PCI ID to atomisp2_pm
Date:   Fri, 18 Oct 2019 18:04:05 -0400
Message-Id: <20191018220525.9042-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 8a7d7141528ad67e465bc6afacc6a3144d1fe320 ]

If the ISP is exposed as a PCI device VLV machines need the
same treatment as CHV machines to power gate the ISP. Otherwise
s0ix will not work.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_atomisp2_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel_atomisp2_pm.c b/drivers/platform/x86/intel_atomisp2_pm.c
index 9371603a0ac90..4a2ec5eeb6d8a 100644
--- a/drivers/platform/x86/intel_atomisp2_pm.c
+++ b/drivers/platform/x86/intel_atomisp2_pm.c
@@ -99,6 +99,7 @@ static UNIVERSAL_DEV_PM_OPS(isp_pm_ops, isp_pci_suspend,
 			    isp_pci_resume, NULL);
 
 static const struct pci_device_id isp_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x0f38), },
 	{ PCI_VDEVICE(INTEL, 0x22b8), },
 	{ 0, }
 };
-- 
2.20.1

