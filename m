Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830502053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015647;
	bh=/vREOKb9jodj8o9mPrlJrZrDr+M2BGghOsruvxTRfek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HjsVtSM0piT/MwmZrhWCDhflxGv5dfHRjq0W76a+I+LATY/WaS+Q8NKsI6lCNYr7b
	 tL7em2gpjPurXQXhEaTNss2OhHhsiVrywK1/aWJ0iy6qaT21p6ANA1ossh0T5d9i40
	 OfPF9QMtEF0AQKFy1oLCkW9wSCjxDiIZoWrqOvWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfLJWH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbfLJWFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:05:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00C520637;
        Tue, 10 Dec 2019 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015508;
        bh=/vREOKb9jodj8o9mPrlJrZrDr+M2BGghOsruvxTRfek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBs/swIlsTILNPOTnxcDfYdbpNgjWY7fD0zkf3XsjE8vyQDRgCWwaUIdzsAU1hyPp
         QX3lfOT/gzYjje+t5cEfpBDAfjL/39y6bWXrOBuLWwbPU4GsnLq4O6oGoyO0IrLUqj
         iSuWLXHSmh9GGgmECueB9tuDu++cQOYQPDUx5r2E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 107/130] parport: load lowlevel driver if ports not found
Date:   Tue, 10 Dec 2019 17:02:38 -0500
Message-Id: <20191210220301.13262-107-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

[ Upstream commit 231ec2f24dad18d021b361045bbd618ba62a274e ]

Usually all the distro will load the parport low level driver as part
of their initialization. But we can get into a situation where all the
parallel port drivers are built as module and we unload all the modules
at a later time. Then if we just do "modprobe parport" it will only
load the parport module and will not load the low level driver which
will actually register the ports. So, check the bus if there is any
parport registered, if not, load the low level driver.

We can get into the above situation with all distro but only Suse has
setup the alias for "parport_lowlevel" and so it only works in Suse.
Users of Debian based distro will need to load the lowlevel module
manually.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Link: https://lore.kernel.org/r/20191016144540.18810-3-sudipm.mukherjee@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/parport/share.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 7b4ee33c19354..15c81cffd2de2 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -230,6 +230,18 @@ static int port_check(struct device *dev, void *dev_drv)
 	return 0;
 }
 
+/*
+ * Iterates through all the devices connected to the bus and return 1
+ * if the device is a parallel port.
+ */
+
+static int port_detect(struct device *dev, void *dev_drv)
+{
+	if (is_parport(dev))
+		return 1;
+	return 0;
+}
+
 /**
  *	parport_register_driver - register a parallel port device driver
  *	@drv: structure describing the driver
@@ -282,6 +294,15 @@ int __parport_register_driver(struct parport_driver *drv, struct module *owner,
 		if (ret)
 			return ret;
 
+		/*
+		 * check if bus has any parallel port registered, if
+		 * none is found then load the lowlevel driver.
+		 */
+		ret = bus_for_each_dev(&parport_bus_type, NULL, NULL,
+				       port_detect);
+		if (!ret)
+			get_lowlevel_driver();
+
 		mutex_lock(&registration_lock);
 		if (drv->match_port)
 			bus_for_each_dev(&parport_bus_type, NULL, drv,
-- 
2.20.1

