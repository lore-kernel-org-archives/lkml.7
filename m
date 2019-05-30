Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E5C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D6B252B0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189936;
	bh=pBp0MadGZ6iq4Rn25Lwz6Ox1cKj7Tsg+bto5JUfxHtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLf50C2NHjab1xEGUBY1cgVf29+10cJSKvgeFyynJOWouqXMLQy+XnkUqytuT17Xx
	 WKWmkEy9oNRnmnwIdoo+mgSB8D1D9dyaQ0/nTt3yO4rRWdmd/tLjLZJjYU7RcqS6tX
	 XH8fnUXXLjHLLf0U92xefJk/Hfy5aAn/ys6njzd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfE3DP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbfE3DMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:51 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC7E244E8;
        Thu, 30 May 2019 03:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185971;
        bh=pBp0MadGZ6iq4Rn25Lwz6Ox1cKj7Tsg+bto5JUfxHtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nK5dPtAK2GhZMz0I+TaPDw4DsliUuBH3BSXe8SkJf3Sk6QBRMIcG3migqLbCYG1LS
         kNP9o/QgnfpM9xdIZVNZUyRiwAf5uuWudZ48y11S+pAt0Y0A4JZT/YA37coH5NhCkK
         cM109w/fB0JU7LbTh6IWbB0svTCcx7Q7WVzo7s/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 402/405] extcon: axp288: Add a depends on ACPI to the Kconfig entry
Date:   Wed, 29 May 2019 20:06:40 -0700
Message-Id: <20190530030600.887026935@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fa3c098c2d52a268f6372fa053932e11f50cecb1 ]

As Hans de Goede pointed, using this driver without ACPI
makes little sense, so add ACPI dependency to Kconfig entry
to fix a build error while CONFIG_ACPI is not set.

drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
    put_device(&adev->dev);

Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 540e8cd16ee6e..db3bcf96b98fb 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -30,7 +30,7 @@ config EXTCON_ARIZONA
 
 config EXTCON_AXP288
 	tristate "X-Power AXP288 EXTCON support"
-	depends on MFD_AXP20X && USB_SUPPORT && X86
+	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
 	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB peripheral detection
-- 
2.20.1



