Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CDDC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 06:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089D21927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 06:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfLUGuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 01:50:22 -0500
Received: from [167.172.186.51] ([167.172.186.51]:39626 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfLUGuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 01:50:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9DFC4DFC9F;
        Sat, 21 Dec 2019 06:50:22 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0QoOZXV2rgXD; Sat, 21 Dec 2019 06:50:21 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A9ABFDFC8A;
        Sat, 21 Dec 2019 06:50:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WDwk2-J3pCBA; Sat, 21 Dec 2019 06:50:21 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 10F50DFCCB;
        Sat, 21 Dec 2019 06:50:21 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 3/3] USB: EHCI: ehci-mv: drop pxa_ehci_type and some device IDs
Date:   Sat, 21 Dec 2019 07:50:08 +0100
Message-Id: <20191221065008.266445-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221065008.266445-1-lkundrak@v3.sk>
References: <20191221065008.266445-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is merely a cleanup. None of these is used anywhere.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Changed the wording a bit

 drivers/usb/host/ehci-mv.c           | 6 ++----
 include/linux/platform_data/mv_usb.h | 8 --------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index c8717f06cd8cb..91602e3492084 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -257,10 +257,8 @@ static int mv_ehci_remove(struct platform_device *pd=
ev)
 MODULE_ALIAS("mv-ehci");
=20
 static const struct platform_device_id ehci_id_table[] =3D {
-	{"pxa-u2oehci", PXA_U2OEHCI},
-	{"pxa-sph", PXA_SPH},
-	{"mmp3-hsic", MMP3_HSIC},
-	{"mmp3-fsic", MMP3_FSIC},
+	{"pxa-u2oehci", 0},
+	{"pxa-sph", 0},
 	{},
 };
=20
diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platfor=
m_data/mv_usb.h
index 5376b6d799d5d..20d239c02bf3a 100644
--- a/include/linux/platform_data/mv_usb.h
+++ b/include/linux/platform_data/mv_usb.h
@@ -6,14 +6,6 @@
 #ifndef __MV_PLATFORM_USB_H
 #define __MV_PLATFORM_USB_H
=20
-enum pxa_ehci_type {
-	EHCI_UNDEFINED =3D 0,
-	PXA_U2OEHCI,	/* pxa 168, 9xx */
-	PXA_SPH,	/* pxa 168, 9xx SPH */
-	MMP3_HSIC,	/* mmp3 hsic */
-	MMP3_FSIC,	/* mmp3 fsic */
-};
-
 enum {
 	MV_USB_MODE_OTG,
 	MV_USB_MODE_HOST,
--=20
2.24.1

