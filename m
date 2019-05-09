Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CDD217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428118;
	bh=UXy7aui7yC9NiQsI/1El6Ml1ENsUM4xMnXKn11cKhM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hhMedqWOhuL6r8Y7VMWiE+fmjjHy6WOdYOE2MIQl5j/Jt5syOXkZk+eoNzCwsjD+w
	 CXg3muLzxnaUatInIAcopXlTJEEdKR07BqVRCEGcYoS2kkbSxvJKOKWavV8BrCatzz
	 so0bEh7n8H3KMMpWye3MeSzP9cnW12GSqo6UT3Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfEISzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbfEISzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:55:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8FF204FD;
        Thu,  9 May 2019 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428111;
        bh=UXy7aui7yC9NiQsI/1El6Ml1ENsUM4xMnXKn11cKhM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovq2cib8WtsXRdFrz60eIkKaInAjvBqrhwQMNpOplq76/3CfJfMBTnl8FKWW+MwxT
         gei39FlYaWQm05Z0U1jtqvgVnEmdn2B2a50BbbpltH3D3QTgXMIMZLhgjz1pfBTfU7
         VymqNMjzWzItt49aU4PqPy2J10P0zaB8R24V8R6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH 5.1 07/30] usb: dwc3: Allow building USB_DWC3_QCOM without EXTCON
Date:   Thu,  9 May 2019 20:42:39 +0200
Message-Id: <20190509181252.205048287@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Gonzalez <marc.w.gonzalez@free.fr>

commit 77a4946516fe488b6a33390de6d749f934a243ba upstream.

Keep EXTCON support optional, as some platforms do not need it.

Do the same for USB_DWC3_OMAP while we're at it.

Fixes: 3def4031b3e3f ("usb: dwc3: add EXTCON dependency for qcom")
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/Kconfig |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -54,7 +54,8 @@ comment "Platform Glue Driver Support"
 
 config USB_DWC3_OMAP
 	tristate "Texas Instruments OMAP5 and similar Platforms"
-	depends on EXTCON && (ARCH_OMAP2PLUS || COMPILE_TEST)
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on EXTCON || !EXTCON
 	depends on OF
 	default USB_DWC3
 	help
@@ -115,7 +116,8 @@ config USB_DWC3_ST
 
 config USB_DWC3_QCOM
 	tristate "Qualcomm Platform"
-	depends on EXTCON && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on EXTCON || !EXTCON
 	depends on OF
 	default USB_DWC3
 	help


