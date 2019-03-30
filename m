Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6690C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B833F2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909850;
	bh=kWhj8/bIaPGCa6WIfHjsvItK2SOu/uykrgSNdmB1U2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uBRJ58QIYxuwy1LuDuCbiG52ONX4sgefPnbd0ZEv3V55aQMEiFJQPvemB3tewO4Uw
	 bCzrQ4QuoFKgFCdQXElb3Aevdl4uu/J0xPHTsp7WqIG2detedziNd2z4YuAxM7KLW/
	 aH0EWM7UOnwaPft2pw+zVv6ZATOa1G/BQZDaXafE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfC3Bh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbfC3Baw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E25712184C;
        Sat, 30 Mar 2019 01:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909452;
        bh=kWhj8/bIaPGCa6WIfHjsvItK2SOu/uykrgSNdmB1U2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiVImN3Tn8vWFgCX4wpmeOMjGCtb/uiHwJB9NKRgkosXxPmjSoOp79EeGLq+IDNzf
         2UhpRWwk4mKW+0prZIkiGP+65Rwc2q2ftPQqB6t36pvU+wTfo0jNFLqFY8Gh+BnWAI
         6Fbr952QZPjwrHYPkGBlpJIXfMnBoys3b1Pl+TEo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Jonathan Dieter <jdieter@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 12/37] usbip: fix vhci_hcd controller counting
Date:   Fri, 29 Mar 2019 21:29:55 -0400
Message-Id: <20190330013020.379-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

[ Upstream commit e0a2e73e501c77037c8756137e87b12c7c3c9793 ]

Without this usbip fails on a machine with devices
that lexicographically come after vhci_hcd.

ie.
  $ ls -l /sys/devices/platform
  ...
  drwxr-xr-x. 4 root root    0 Sep 19 16:21 serial8250
  -rw-r--r--. 1 root root 4096 Sep 19 23:50 uevent
  drwxr-xr-x. 6 root root    0 Sep 20 13:15 vhci_hcd.0
  drwxr-xr-x. 4 root root    0 Sep 19 16:22 w83627hf.656

Because it detects 'w83627hf.656' as another vhci_hcd controller,
and then fails to be able to talk to it.

Note: this doesn't actually fix usbip's support for multiple
controllers... that's still broken for other reasons
("vhci_hcd.0" is hardcoded in a string macro), but is enough to
actually make it work on the above machine.

See also:
  https://bugzilla.redhat.com/show_bug.cgi?id=1631148

Cc: Jonathan Dieter <jdieter@gmail.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Maciej Żenczykowski <zenczykowski@gmail.com>
Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Tested-by: Jonathan Dieter <jdieter@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/usb/usbip/libsrc/vhci_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index ed8c9d360c0f..4225d462701d 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -150,7 +150,7 @@ static int get_nports(struct udev_device *hc_device)
 
 static int vhci_hcd_filter(const struct dirent *dirent)
 {
-	return strcmp(dirent->d_name, "vhci_hcd") >= 0;
+	return !strncmp(dirent->d_name, "vhci_hcd.", 9);
 }
 
 static int get_ncontrollers(void)
-- 
2.19.1

