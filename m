Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA97C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E84120643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611967;
	bh=pkzGvBQSwiZVsnJsH9MSTLUl6m8IndwiPjURJPXby3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pTmFWQdA2QjPSfzixdnNNyo/LKnpPyY2MhbTeJKW5UsV889UxTYlcmEt7VFZVdjov
	 H04h3rmVJfdcrdel82OJA6nHbrcA5T11wQqH7NsTC7+03yU8EEwBpz+F+Aj9dXFxca
	 6jJ5QdCs63ZlWZNnWOiw4UOwa6CsSkWFSe3mCuB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403782AbfDRSE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391176AbfDRSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:04:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455C2206B6;
        Thu, 18 Apr 2019 18:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610693;
        bh=pkzGvBQSwiZVsnJsH9MSTLUl6m8IndwiPjURJPXby3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zs/ZNnEs8un0EIJNLIm6fTB98ke+PG5DgxTn+IRQc3AvCr100Em0fTxzXWmOMj2Cm
         J1jfmQWLnDPMyTs6JazsU2uSte8WRYd0e0IC9Cl7VqiNBKitXDntvHUYYIR/vCGd0J
         3Iayi4xKY2NdmBJY0aRUsT5MTNun9GNz6RljXzgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Dieter <jdieter@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 49/92] usbip: fix vhci_hcd controller counting
Date:   Thu, 18 Apr 2019 19:57:07 +0200
Message-Id: <20190418160434.377300492@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



