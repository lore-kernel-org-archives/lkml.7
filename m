Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C56C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1BE233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495284;
	bh=LdEnyO9tKd0qgPoiJi5ySVpeoiZm3yCzkrV6/xj0118=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdAUV28LjxfieEhOFMHsgld/tDDThXjnRyq1TuJbL2D427kn5n43HDjb6Scvrumu2
	 meEB9ciwSJ6lSVpkaWx0zWrqkmAn/xB7nW61FMLbGZDXBa59QVXBUAbQyyzjk36mnY
	 cLYtEFUqGGMvHrMIzixnMuDFux1f7p4xOe8ljcv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404200AbfHVRej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404372AbfHVRZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:18 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23496206DD;
        Thu, 22 Aug 2019 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494718;
        bh=LdEnyO9tKd0qgPoiJi5ySVpeoiZm3yCzkrV6/xj0118=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0kXytcKir79WNusZeu/8qmPN6VH0c8re5mMWRYUJA91xFco6UkbW51I2ge2EpRUs
         8czPwZkOv9pl6mm30n8bMJR/O4nHcotq486gWP7x8erqv8ZMDafnqYXSmHIJGeNU00
         5kP3h1cC9ODf/56fzk/uWHIXGhexbBDUDij8UBAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 47/71] usb: gadget: udc: renesas_usb3: Fix sysfs interface of "role"
Date:   Thu, 22 Aug 2019 10:19:22 -0700
Message-Id: <20190822171729.899786297@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 5dac665cf403967bb79a7aeb8c182a621fe617ff upstream.

Since the role_store() uses strncmp(), it's possible to refer
out-of-memory if the sysfs data size is smaller than strlen("host").
This patch fixes it by using sysfs_streq() instead of strncmp().

Fixes: cc995c9ec118 ("usb: gadget: udc: renesas_usb3: add support for usb role swap")
Cc: <stable@vger.kernel.org> # v4.12+
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/sys_soc.h>
 #include <linux/uaccess.h>
 #include <linux/usb/ch9.h>
@@ -2315,9 +2316,9 @@ static ssize_t role_store(struct device
 	if (usb3->forced_b_device)
 		return -EBUSY;
 
-	if (!strncmp(buf, "host", strlen("host")))
+	if (sysfs_streq(buf, "host"))
 		new_mode_is_host = true;
-	else if (!strncmp(buf, "peripheral", strlen("peripheral")))
+	else if (sysfs_streq(buf, "peripheral"))
 		new_mode_is_host = false;
 	else
 		return -EINVAL;


