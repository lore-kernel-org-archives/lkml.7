Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612862133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724494;
	bh=/XV0Lf1+v5A5+dZYKZRvrLY7ujezjFZFVQPsCF8DacE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/bVyXaXHYRnssB5AhPjUv5rsqfOJO6V40FnkLM+vUl+glvYBhWMAelFewwlt7KTy
	 npalXPkALql4EC0lBP8lLb6ePISYKJv/LUzD/0V9NOzzSQ2VeEQiZC5fWcrKHYNBLu
	 P2HXPv/rNshdUpzt9dItGiPMPqsII5rDSEjKH5sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfF1MU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:20:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfF1MUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oOwOSCxbZh/8uQiBXY+7QLjNRJOPdEk2ewzEqFQcDtU=; b=p5kvvJ+rs+cLmQ+c0oXFGTXbL4
        rmUqAfjducYKYD6conb47hi0BDJrU+kLj2HAzG0XTR8a960cy8waVhBKgVFEIgmeY+NQPRZbXIglk
        vA37C/K49ysh+9Gtf7WIt0BIxqDsaKK1X9ybULB1/DsuBOWhu6BHcVJG+YNY4ir4HbriROod1oEPc
        wwXV6eIIrG5ChE4YhULSUVZ18E4DJKeAHv71PodC5DHzuOfG9m8TGUYiNY3vDhyp76xczxyyPtpxf
        V2ettC5wrN8c3CTsEp86XImKdnb/KB4h7Ge0fZcXHgilw2W1hfR3M+AqxTtQMQYtAt86NibUWSYxl
        aouz/TlA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-00009y-8k; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00057f-Ae; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 11/43] docs: console.txt: convert docs to ReST and rename to *.rst
Date:   Fri, 28 Jun 2019 09:20:07 -0300
Message-Id: <e8cee712026b042eacf3e003a57578d963f24ad8.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert this small file to ReST in preparation for adding it to
the driver-api book.

While this is not part of the driver-api book, mark it as
:orphan:, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../console/{console.txt => console.rst}      | 63 ++++++++++---------
 Documentation/fb/fbcon.rst                    |  4 +-
 drivers/tty/Kconfig                           |  2 +-
 3 files changed, 38 insertions(+), 31 deletions(-)
 rename Documentation/console/{console.txt => console.rst} (80%)

diff --git a/Documentation/console/console.txt b/Documentation/console/console.rst
similarity index 80%
rename from Documentation/console/console.txt
rename to Documentation/console/console.rst
index d73c2ab4beda..b374141b027e 100644
--- a/Documentation/console/console.txt
+++ b/Documentation/console/console.rst
@@ -1,3 +1,6 @@
+:orphan:
+
+===============
 Console Drivers
 ===============
 
@@ -17,25 +20,26 @@ of driver occupying the consoles.) They can only take over the console that is
 occupied by the system driver. In the same token, if the modular driver is
 released by the console, the system driver will take over.
 
-Modular drivers, from the programmer's point of view, have to call:
+Modular drivers, from the programmer's point of view, have to call::
 
 	 do_take_over_console() - load and bind driver to console layer
 	 give_up_console() - unload driver; it will only work if driver
 			     is fully unbound
 
-In newer kernels, the following are also available:
+In newer kernels, the following are also available::
 
 	 do_register_con_driver()
 	 do_unregister_con_driver()
 
 If sysfs is enabled, the contents of /sys/class/vtconsole can be
 examined. This shows the console backends currently registered by the
-system which are named vtcon<n> where <n> is an integer from 0 to 15. Thus:
+system which are named vtcon<n> where <n> is an integer from 0 to 15.
+Thus::
 
        ls /sys/class/vtconsole
        .  ..  vtcon0  vtcon1
 
-Each directory in /sys/class/vtconsole has 3 files:
+Each directory in /sys/class/vtconsole has 3 files::
 
      ls /sys/class/vtconsole/vtcon0
      .  ..  bind  name  uevent
@@ -46,27 +50,29 @@ What do these files signify?
         read, or acts to bind or unbind the driver to the virtual consoles
         when written to. The possible values are:
 
-	0 - means the driver is not bound and if echo'ed, commands the driver
+	0
+	  - means the driver is not bound and if echo'ed, commands the driver
 	    to unbind
 
-        1 - means the driver is bound and if echo'ed, commands the driver to
+        1
+	  - means the driver is bound and if echo'ed, commands the driver to
 	    bind
 
-     2. name - read-only file. Shows the name of the driver in this format:
+     2. name - read-only file. Shows the name of the driver in this format::
 
-	cat /sys/class/vtconsole/vtcon0/name
-	(S) VGA+
+	  cat /sys/class/vtconsole/vtcon0/name
+	  (S) VGA+
 
-	    '(S)' stands for a (S)ystem driver, i.e., it cannot be directly
-	    commanded to bind or unbind
+	      '(S)' stands for a (S)ystem driver, i.e., it cannot be directly
+	      commanded to bind or unbind
 
-	    'VGA+' is the name of the driver
+	      'VGA+' is the name of the driver
 
-	cat /sys/class/vtconsole/vtcon1/name
-	(M) frame buffer device
+	  cat /sys/class/vtconsole/vtcon1/name
+	  (M) frame buffer device
 
-	    In this case, '(M)' stands for a (M)odular driver, one that can be
-	    directly commanded to bind or unbind.
+	      In this case, '(M)' stands for a (M)odular driver, one that can be
+	      directly commanded to bind or unbind.
 
      3. uevent - ignore this file
 
@@ -75,14 +81,17 @@ driver takes over the consoles vacated by the driver. Binding, on the other
 hand, will bind the driver to the consoles that are currently occupied by a
 system driver.
 
-NOTE1: Binding and unbinding must be selected in Kconfig. It's under:
+NOTE1:
+  Binding and unbinding must be selected in Kconfig. It's under::
 
-Device Drivers -> Character devices -> Support for binding and unbinding
-console drivers
+    Device Drivers ->
+	Character devices ->
+		Support for binding and unbinding console drivers
 
-NOTE2: If any of the virtual consoles are in KD_GRAPHICS mode, then binding or
-unbinding will not succeed. An example of an application that sets the console
-to KD_GRAPHICS is X.
+NOTE2:
+  If any of the virtual consoles are in KD_GRAPHICS mode, then binding or
+  unbinding will not succeed. An example of an application that sets the
+  console to KD_GRAPHICS is X.
 
 How useful is this feature? This is very useful for console driver
 developers. By unbinding the driver from the console layer, one can unload the
@@ -92,10 +101,10 @@ framebuffer console to VGA console and vice versa, this feature also makes
 this possible. (NOTE NOTE NOTE: Please read fbcon.txt under Documentation/fb
 for more details.)
 
-Notes for developers:
-=====================
+Notes for developers
+====================
 
-do_take_over_console() is now broken up into:
+do_take_over_console() is now broken up into::
 
      do_register_con_driver()
      do_bind_con_driver() - private function
@@ -104,7 +113,7 @@ give_up_console() is a wrapper to do_unregister_con_driver(), and a driver must
 be fully unbound for this call to succeed. con_is_bound() will check if the
 driver is bound or not.
 
-Guidelines for console driver writers:
+Guidelines for console driver writers
 =====================================
 
 In order for binding to and unbinding from the console to properly work,
@@ -140,6 +149,4 @@ The current crop of console drivers should still work correctly, but binding
 and unbinding them may cause problems. With minimal fixes, these drivers can
 be made to work correctly.
 
-==========================
 Antonino Daplas <adaplas@pol.net>
-
diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 1da65b9000de..26bc5cdaabab 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -187,7 +187,7 @@ the hardware. Thus, in a VGA console::
 Assuming the VGA driver can be unloaded, one must first unbind the VGA driver
 from the console layer before unloading the driver.  The VGA driver cannot be
 unloaded if it is still bound to the console layer. (See
-Documentation/console/console.txt for more information).
+Documentation/console/console.rst for more information).
 
 This is more complicated in the case of the framebuffer console (fbcon),
 because fbcon is an intermediate layer between the console and the drivers::
@@ -204,7 +204,7 @@ fbcon. Thus, there is no need to explicitly unbind the fbdev drivers from
 fbcon.
 
 So, how do we unbind fbcon from the console? Part of the answer is in
-Documentation/console/console.txt. To summarize:
+Documentation/console/console.rst. To summarize:
 
 Echo a value to the bind file that represents the framebuffer console
 driver. So assuming vtcon1 represents fbcon, then::
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 0e3e4dacbc12..1cb50f19d58c 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -93,7 +93,7 @@ config VT_HW_CONSOLE_BINDING
          select the console driver that will serve as the backend for the
          virtual terminals.
 
-	 See <file:Documentation/console/console.txt> for more
+	 See <file:Documentation/console/console.rst> for more
 	 information. For framebuffer console users, please refer to
 	 <file:Documentation/fb/fbcon.rst>.
 
-- 
2.21.0

