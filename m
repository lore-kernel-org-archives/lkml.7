Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4A121841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfCVPuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:50:18 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfCVPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:50:17 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8XLj-1gu9844C3d-014W3f; Fri, 22 Mar 2019 16:50:02 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 25/25] USB: core: only clean up what we allocated
Date:   Fri, 22 Mar 2019 16:44:16 +0100
Message-Id: <20190322154425.3852517-26-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wMbSPcHeSmT84A30VtzrJGakHf9ZFJmOTa7BcDHtx3x+ETBZjeh
 g1H/1BcB1LCrojY2Jz+mQUWSKoezbqp0L5g+iL2aDa/1oYctHJsCCJTDKta7kganqTUCiGT
 WbKhG6iBsGx1g/hvksxHEEYIHbL42951pU922HTHUGc825K3zatuFLlhqb1fV0TgtqHMmz0
 C55FXJMdjpfPIcCx2UNvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lwFKb9FP7Ag=:jlGQtNhVji5W71GscMmPXR
 tuf4mA//DTvfP3p2NjiHpVVvxrCE43li+qSBjKknSL06/G4ocjZE62mANptUCT/+CjP6ut8qZ
 lY59K8HuRhWsQAkqlLHPC5FdpABgBZKLrOWOcWPG+NLeWrhxldZcBsZECpNavRZmjHMLY6IfH
 67E6f597G988MU9VtO4ixky/jn/W1ty6xApNpFVBvF7QsHCc3EN9fQ8XRXVdlwCYh3eKs5sh8
 b2LsR+Ja4vHZoArcvWQ0S44Y3tRMyXfs01slU1tncNrjkbCxu5mBgFxdRJY2t9+we50ZGgo71
 py9ka778ry8OF1EsAM+b7Cu3/EKg+ZA9Pk4Chj9RO4M7vWFhVI0plzVrd4RtOgmyQXC9/cG5R
 BsI3nWY0BmtBTltL6dTrxJWj8E/PkORh8t6YEpWNhJB4AbrbfWUS5OzuhZKE2Gio93X0Fwhk4
 YHZy0QHTkf8uS8hJWlO51Ykg3QPAcDfXmohlPUtnzMMhlNMkccie8korS0q2qeHlL9VnMeTF6
 VowTtsmbW+2wjQEZegYRtgOItZlwI2JqBa0mtJEMhGilHeKMsDdoee8xaW2GamKoabh5rzb3V
 rkFfg3GgOOmxE3Tur9jkqaSuRkYqo7Ou8yTBVHybhSNQbOwGvf9VAV3yyxNuDxrzXa3Dw4cSA
 xWhM4DWZupT3PiVVp4tjgV4ER23WtTgsSUGaIo7tofDdeVErCeZzQJFftBaFjpIikxX7u10mG
 VqfYIeF6jZgR0EO0itBKLSK7IWaxe30qqnBYeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

When cleaning up the configurations, make sure we only free the number
of configurations and interfaces that we could have allocated.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 32fd87b3bbf5f7a045546401dfe2894dbbf4d8c3)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/core/config.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 6a287c81a7be..b8eb289e0b17 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -734,18 +734,21 @@ void usb_destroy_configuration(struct usb_device *dev)
 		return;
 
 	if (dev->rawdescriptors) {
-		for (i = 0; i < dev->descriptor.bNumConfigurations; i++)
+		for (i = 0; i < dev->descriptor.bNumConfigurations &&
+				i < USB_MAXCONFIG; i++)
 			kfree(dev->rawdescriptors[i]);
 
 		kfree(dev->rawdescriptors);
 		dev->rawdescriptors = NULL;
 	}
 
-	for (c = 0; c < dev->descriptor.bNumConfigurations; c++) {
+	for (c = 0; c < dev->descriptor.bNumConfigurations &&
+			c < USB_MAXCONFIG; c++) {
 		struct usb_host_config *cf = &dev->config[c];
 
 		kfree(cf->string);
-		for (i = 0; i < cf->desc.bNumInterfaces; i++) {
+		for (i = 0; i < cf->desc.bNumInterfaces &&
+				i < USB_MAXINTERFACES; i++) {
 			if (cf->intf_cache[i])
 				kref_put(&cf->intf_cache[i]->ref,
 					  usb_release_interface_cache);
-- 
2.20.0

