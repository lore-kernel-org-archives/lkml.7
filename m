Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F84CC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2F020685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940235;
	bh=Z6JhT0u8/9UtMYsFOz2EZSHggvUG3hivJ2f2+pt5beQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rvvFejm8LJ3qGqQCw7OLH4BongZtXtDH7MYv4vVepCm3BPMmTEidDFZ/JWu3CkJEc
	 o0kuPYyGSBpa7BtJlK8OR4w/3/HGMNX2QfZ9lwyWNjwRCdhU8sENyTicZhmnnaQepU
	 RJFZMuvz0vAC0t6ivYagwGhzHcy93a3HHtpQw4vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfDVNhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:37:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfDVN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1J8qC3DE2LwTQwTPUMGMRYMUzcmDeLBnXHElrVtNjvM=; b=V7A1m758FzlA9J0glcbR4AOo15
        4buVv95qVFXJEJTxSeP2v22pSShA7aRdiFkzLwBCImqca0Ltn55YeQFy+auesPuNsgO7A04MX56cW
        AM1WkIlePVa9z1iyupO0cRbKUSjcURkLVa/MDUh6miTxvdLRe7w3GTCvq/6nHTkeT/LWGlJohIzye
        HECIlTLV1xUHC1g8eDfAnufYpgaROMCFoNvWKmxqWYtMoj0mTcWw3iLUOQj9B4tbmhx/p1YOqICM+
        XJ+/3OK+ztMtKQ5JykcbXFe4jPTUrnQPEV2vEg+mC+GvPy0VphT5dupgIjLi5i8n4XEYBioHMJfLd
        fRhNggnA==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzU-0005Hi-PN; Mon, 22 Apr 2019 13:28:12 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzS-0005kc-MN; Mon, 22 Apr 2019 10:28:10 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 15/79] docs: gpio: convert docs to ReST and rename to *.rst
Date:   Mon, 22 Apr 2019 10:27:04 -0300
Message-Id: <03cdacc3db76c5ff984c1507ea6434650d36d822.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The API described at sysfs.txt is deprecated.

Still, as it is still part of the Kernel (and will likely be
there for some time, as we don't simply remove APIs). So,
it makes sense to keep it there.

The conversion of this file is trivial:
  - add blank lines and identation in order to identify paragraphs;
  - mark a literal block as such.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/gpio/index.rst                | 17 +++++++++
 Documentation/gpio/{sysfs.txt => sysfs.rst} | 39 +++++++++++++--------
 2 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/gpio/index.rst
 rename Documentation/gpio/{sysfs.txt => sysfs.rst} (86%)

diff --git a/Documentation/gpio/index.rst b/Documentation/gpio/index.rst
new file mode 100644
index 000000000000..09a4a553f434
--- /dev/null
+++ b/Documentation/gpio/index.rst
@@ -0,0 +1,17 @@
+:orphan:
+
+====
+gpio
+====
+
+.. toctree::
+    :maxdepth: 1
+
+    sysfs
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/gpio/sysfs.txt b/Documentation/gpio/sysfs.rst
similarity index 86%
rename from Documentation/gpio/sysfs.txt
rename to Documentation/gpio/sysfs.rst
index 58eeab81f349..ec09ffd983e7 100644
--- a/Documentation/gpio/sysfs.txt
+++ b/Documentation/gpio/sysfs.rst
@@ -1,10 +1,12 @@
 GPIO Sysfs Interface for Userspace
 ==================================
 
-THIS ABI IS DEPRECATED, THE ABI DOCUMENTATION HAS BEEN MOVED TO
-Documentation/ABI/obsolete/sysfs-gpio AND NEW USERSPACE CONSUMERS
-ARE SUPPOSED TO USE THE CHARACTER DEVICE ABI. THIS OLD SYSFS ABI WILL
-NOT BE DEVELOPED (NO NEW FEATURES), IT WILL JUST BE MAINTAINED.
+.. warning::
+
+  THIS ABI IS DEPRECATED, THE ABI DOCUMENTATION HAS BEEN MOVED TO
+  Documentation/ABI/obsolete/sysfs-gpio AND NEW USERSPACE CONSUMERS
+  ARE SUPPOSED TO USE THE CHARACTER DEVICE ABI. THIS OLD SYSFS ABI WILL
+  NOT BE DEVELOPED (NO NEW FEATURES), IT WILL JUST BE MAINTAINED.
 
 Refer to the examples in tools/gpio/* for an introduction to the new
 character device ABI. Also see the userspace header in
@@ -51,13 +53,15 @@ The control interfaces are write-only:
 
     /sys/class/gpio/
 
-    	"export" ... Userspace may ask the kernel to export control of
+	"export" ...
+		Userspace may ask the kernel to export control of
 		a GPIO to userspace by writing its number to this file.
 
 		Example:  "echo 19 > export" will create a "gpio19" node
 		for GPIO #19, if that's not requested by kernel code.
 
-    	"unexport" ... Reverses the effect of exporting to userspace.
+	"unexport" ...
+		Reverses the effect of exporting to userspace.
 
 		Example:  "echo 19 > unexport" will remove a "gpio19"
 		node exported using the "export" file.
@@ -67,7 +71,8 @@ and have the following read/write attributes:
 
     /sys/class/gpio/gpioN/
 
-	"direction" ... reads as either "in" or "out". This value may
+	"direction" ...
+		reads as either "in" or "out". This value may
 		normally be written. Writing as "out" defaults to
 		initializing the value as low. To ensure glitch free
 		operation, values "low" and "high" may be written to
@@ -78,7 +83,8 @@ and have the following read/write attributes:
 		it was exported by kernel code that didn't explicitly
 		allow userspace to reconfigure this GPIO's direction.
 
-	"value" ... reads as either 0 (low) or 1 (high). If the GPIO
+	"value" ...
+		reads as either 0 (low) or 1 (high). If the GPIO
 		is configured as an output, this value may be written;
 		any nonzero value is treated as high.
 
@@ -92,14 +98,16 @@ and have the following read/write attributes:
 		file and read the new value or close the file and re-open it
 		to read the value.
 
-	"edge" ... reads as either "none", "rising", "falling", or
+	"edge" ...
+		reads as either "none", "rising", "falling", or
 		"both". Write these strings to select the signal edge(s)
 		that will make poll(2) on the "value" file return.
 
 		This file exists only if the pin can be configured as an
 		interrupt generating input pin.
 
-	"active_low" ... reads as either 0 (false) or 1 (true). Write
+	"active_low" ...
+		reads as either 0 (false) or 1 (true). Write
 		any nonzero value to invert the value attribute both
 		for reading and writing. Existing and subsequent
 		poll(2) support configuration via the edge attribute
@@ -112,11 +120,14 @@ read-only attributes:
 
     /sys/class/gpio/gpiochipN/
 
-    	"base" ... same as N, the first GPIO managed by this chip
+	"base" ...
+		same as N, the first GPIO managed by this chip
 
-    	"label" ... provided for diagnostics (not always unique)
+	"label" ...
+		provided for diagnostics (not always unique)
 
-        "ngpio" ... how many GPIOs this manages (N to N + ngpio - 1)
+	"ngpio" ...
+		how many GPIOs this manages (N to N + ngpio - 1)
 
 Board documentation should in most cases cover what GPIOs are used for
 what purposes. However, those numbers are not always stable; GPIOs on
@@ -129,7 +140,7 @@ the correct GPIO number to use for a given signal.
 Exporting from Kernel code
 --------------------------
 Kernel code can explicitly manage exports of GPIOs which have already been
-requested using gpio_request():
+requested using gpio_request()::
 
 	/* export the GPIO to userspace */
 	int gpiod_export(struct gpio_desc *desc, bool direction_may_change);
-- 
2.20.1

