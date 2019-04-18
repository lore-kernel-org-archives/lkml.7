Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D96C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5389217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610460;
	bh=5V62lUEdLmCtaS+NBlXGPV8GZQJwJkOClSPYavQmJNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I57Cj3RSQ1w42pIk6OMgfB+0mMw7XMPbylUY0uYBzoLwux9/qTpLvVf6yUa2BCi+2
	 dVMLKQ+Vp3tVyRizrTpYxxHszLklTH+KS54gJrIHaZoPiZmDzu+DAyT3rYYF/taH7I
	 LHHAWT13k1W4JbsAaK3GVcgbeTGchLy0iycQs6Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbfDRSA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390451AbfDRSA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:00:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B76206B6;
        Thu, 18 Apr 2019 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610455;
        bh=5V62lUEdLmCtaS+NBlXGPV8GZQJwJkOClSPYavQmJNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7ewULW1AvD5aL22SsHNzw6vNFJtzQpa57Svvf2Sbo//lsN2gw0P67P1oOLtYSGPg
         3Hb1YveolDJyL43t3NNVIInU1UJ64YGJYN3aj6Y7VElF6SqNTb4h8qhxyjkWIBr0/U
         b9XEoKSPkXJjKxqqdrWcqLXxfsIIOtsF89xM6cII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Dieter <jdieter@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/110] usbip: fix vhci_hcd controller counting
Date:   Thu, 18 Apr 2019 19:56:58 +0200
Message-Id: <20190418160444.880926530@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
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
index 4204359c9fee..8159fd98680b 100644
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



