Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2523C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7846321925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497937;
	bh=L1kLxcvshvOYxkYmrXxv0EM21Jlx7kQrRA384vulsYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bhxDditV8hi3NRm0xGchI1/kXDNW8+UV6H6Z87qyM9SRIFYJV46gDD6b+68fjgNl1
	 t+JbAyL0FCKoaOOUo15uoSWqfhOBXGmsqKGw4L5iVVyxR4aYyOxxDlNoSDHzKT2UvC
	 6+BS4orF2fBm/kSPKz9Elve838AeLvMYBXN5NvL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfKKSpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbfKKSpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:45:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDCB21655;
        Mon, 11 Nov 2019 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497933;
        bh=L1kLxcvshvOYxkYmrXxv0EM21Jlx7kQrRA384vulsYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXI8PJHvRNC6rYEBlha3oDm7cc8NDJtCxc+pLRTECOF9PNZNkgRunEGewWok4AdsM
         KJTnI7kZ07FGGnPRxx5kLygnBYGXchDsfVEp4bIXNDbovZRWBSayhH8xld5BhPkoz/
         /6Zf5wXE27Ctief3nPr8RaSqRHt4zCY0rBrLLHqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, GwanYeong Kim <gy741.kim@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 100/125] usbip: tools: Fix read_usb_vudc_device() error path handling
Date:   Mon, 11 Nov 2019 19:28:59 +0100
Message-Id: <20191111181453.260215108@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: GwanYeong Kim <gy741.kim@gmail.com>

[ Upstream commit 28df0642abbf6d66908a2858922a7e4b21cdd8c2 ]

This isn't really accurate right. fread() doesn't always
return 0 in error. It could return < number of elements
and set errno.

Signed-off-by: GwanYeong Kim <gy741.kim@gmail.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20191018032223.4644-1-gy741.kim@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/usb/usbip/libsrc/usbip_device_driver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/usb/usbip/libsrc/usbip_device_driver.c b/tools/usb/usbip/libsrc/usbip_device_driver.c
index ec3a0b794f159..67ae6c1557b8c 100644
--- a/tools/usb/usbip/libsrc/usbip_device_driver.c
+++ b/tools/usb/usbip/libsrc/usbip_device_driver.c
@@ -81,7 +81,7 @@ int read_usb_vudc_device(struct udev_device *sdev, struct usbip_usb_device *dev)
 	FILE *fd = NULL;
 	struct udev_device *plat;
 	const char *speed;
-	int ret = 0;
+	size_t ret;
 
 	plat = udev_device_get_parent(sdev);
 	path = udev_device_get_syspath(plat);
@@ -91,8 +91,10 @@ int read_usb_vudc_device(struct udev_device *sdev, struct usbip_usb_device *dev)
 	if (!fd)
 		return -1;
 	ret = fread((char *) &descr, sizeof(descr), 1, fd);
-	if (ret < 0)
+	if (ret != 1) {
+		err("Cannot read vudc device descr file: %s", strerror(errno));
 		goto err;
+	}
 	fclose(fd);
 
 	copy_descr_attr(dev, &descr, bDeviceClass);
-- 
2.20.1



