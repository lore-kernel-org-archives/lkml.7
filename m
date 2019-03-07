Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5048A20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="XJND2SXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCGMxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:53:21 -0500
Received: from mail.nic.cz ([217.31.204.67]:34467 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfCGMxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:53:19 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 7AFD3634DB;
        Thu,  7 Mar 2019 13:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551963195; bh=JhjzD6sP86wquqqfoj4NhdLlwH9pKTMau6z/RKGV0fY=;
        h=From:To:Date;
        b=XJND2SXvHdHbDwWkKZnrS7FBVUo4C8FttshXspcourfM39Bfzh2d/2WeOT2pRxLi9
         kbCVItU1nryqgYTdmD4CXPGpvSYbXf9KNgMKW/T715N4QVCJ9YXZPc8Wrqp4Wd2hka
         Lew6YPasgfJTaN/0CwoSGsKY2cCg7QR8haeZ5iiE=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v4 armsoc/drivers/bus+gpio 3/5] bus: moxtet: Add sysfs and debugfs documentation
Date:   Thu,  7 Mar 2019 13:52:49 +0100
Message-Id: <20190307125251.724-4-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307125251.724-1-marek.behun@nic.cz>
References: <20190307125251.724-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs ABI documentation for the attribute files module_id and
module_name

Add debugfs ABI documentation for reading input from the shift registers
and reading last written output or write output to the shift registers.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 Documentation/ABI/testing/debugfs-moxtet      | 23 +++++++++++++++++++
 .../ABI/testing/sysfs-bus-moxtet-devices      | 17 ++++++++++++++
 MAINTAINERS                                   |  2 ++
 3 files changed, 42 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-moxtet
 create mode 100644 Documentation/ABI/testing/sysfs-bus-moxtet-devices

diff --git a/Documentation/ABI/testing/debugfs-moxtet b/Documentation/ABI/testing/debugfs-moxtet
new file mode 100644
index 000000000000..32a02e7d0f4e
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-moxtet
@@ -0,0 +1,23 @@
+What:		/sys/kernel/debug/moxtet/input
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Read input from the shift registers, in hexadecimal.
+		Returns N+1 bytes, where N is the number of Moxtet connected
+		modules. The first byte is from the CPU board itself.
+		Example: 101214
+			 10: CPU board with SD card
+			 12: 2 = PCIe module, 1 = IRQ not active
+			 14: 4 = Peridot module, 1 = IRQ not active
+
+What:		/sys/kernel/debug/moxtet/output
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(RW) Read last written value to the shift registers, in
+		hexadecimal, or write values to the shift registers, also
+		in hexadecimal.
+		Example: 0102
+			 01: 01 was last written, or is to be written, to the
+			     first module's shift register
+			 02: the same for second module
diff --git a/Documentation/ABI/testing/sysfs-bus-moxtet-devices b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
new file mode 100644
index 000000000000..3e3256b37a3c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
@@ -0,0 +1,17 @@
+What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_description
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Moxtet module description. Format: string
+
+What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_id
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Moxtet module ID. Format: %x
+
+What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_name
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Moxtet module name. Format: string
diff --git a/MAINTAINERS b/MAINTAINERS
index 3f461a2d776a..43de8eaa284b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1502,6 +1502,8 @@ ARM/CZ.NIC TURRIS MOX SUPPORT
 M:	Marek Behun <marek.behun@nic.cz>
 W:	http://mox.turris.cz
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-moxtet
+F:	Documentation/ABI/testing/sysfs-bus-moxtet-devices
 F:	Documentation/devicetree/bindings/bus/moxtet.txt
 F:	include/linux/moxtet.h
 F:	drivers/bus/moxtet.c
-- 
2.19.2

