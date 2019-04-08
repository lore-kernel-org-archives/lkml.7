Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB354C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD4820857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cKVLwp5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDHQHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:07:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36333 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDHQHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:07:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so7894748pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TCLGovzegw701/u4c+RSrYN+SJq+Buy7ekNIjiUF7iE=;
        b=cKVLwp5sjVO3yDLjmDytFvAVPNES9IV5smEidd9Dv+mM0QcVpWWHI3nF+xKCvEY57I
         VC9dYpNiZklSKd8VMOX+831rRJQcmNdsRBfyu6nAwckQJZF0rNnpexRxYQx+xy/oCinC
         wcY/Gh+Zp+acbo10+hQwTFuBGmw4gafJrBDZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TCLGovzegw701/u4c+RSrYN+SJq+Buy7ekNIjiUF7iE=;
        b=dSE7yNn5VnmlQpMjyTxYakCwBc9t4mxq0qOhra+y6ja70enqZ+Qfz2IZCTrK75Znl0
         D6InMg9OUCDj6sv+suNAoZb/8UkBdsv+/hPbvWKwJ9EyOILB6HepdIMeM3ATN/oRyNzV
         c5tVzNQM936bmNkp9C/S4ZVQoURP9TP30swPWG+cvtmxPtu1ZvVRMoY/wU2Pjcsb3gwn
         uMNRMAjvD+58jZNc40ZY0Dr4gthUAk1HYknom+pAlgVT0KfvJ89BW4LkqBlrNgbFS5LD
         oFkD/OhSNrVajOYvNAzyQbOSIuWPtgArSu/MHouxBbyLTm16z0RW/V/Xi1Ez4D114kfX
         Xvrg==
X-Gm-Message-State: APjAAAXD05Jb4cFtHFEgD2c3Dw3HgkuFvuZHbhFTSDYEyFzBORP5WWUA
        z3ISXMbZe6KGoEz2k5QickR8+060BBI=
X-Google-Smtp-Source: APXvYqxb6q7VwwjBHoiQ4mPiJKKDVAgFOwj3jEDSgduZAHBnpeX5be1MSsDDDANk7YBLsq/8b4hjrQ==
X-Received: by 2002:a63:7444:: with SMTP id e4mr29603061pgn.261.1554739628321;
        Mon, 08 Apr 2019 09:07:08 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u5sm3105935pfa.169.2019.04.08.09.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 09:07:07 -0700 (PDT)
Date:   Mon, 8 Apr 2019 09:07:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     David Rheinsberg <david.rheinsberg@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Restore Y/N in /sys for apparmor's "enabled"
Message-ID: <20190408160706.GA18786@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit c5459b829b71 ("LSM: Plumb visibility into optional "enabled"
state"), /sys/module/apparmor/parameters/enabled would show "Y" or "N"
since it was using the "bool" handler. After being changed to "int",
this switched to "1" or "0", breaking the userspace AppArmor detection
of dbus-broker. This restores the Y/N output while keeping the LSM
infrastructure happy.

Before:
	$ cat /sys/module/apparmor/parameters/enabled
	1

After:
	$ cat /sys/module/apparmor/parameters/enabled
	Y

Reported-by: David Rheinsberg <david.rheinsberg@gmail.com>
Link: https://lkml.kernel.org/r/CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com
Fixes: c5459b829b71 ("LSM: Plumb visibility into optional "enabled" state")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This fix, if John is okay with it, is needed in v5.1 to correct the
userspace regression reported by David.
---
 security/apparmor/lsm.c | 49 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 49d664ddff44..87500bde5a92 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1336,9 +1336,16 @@ module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR);
 bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
+static int param_get_aaintbool(char *buffer, const struct kernel_param *kp);
+static int param_set_aaintbool(const char *val, const struct kernel_param *kp);
+#define param_check_aaintbool param_check_int
+static const struct kernel_param_ops param_ops_aaintbool = {
+	.set = param_set_aaintbool,
+	.get = param_get_aaintbool
+};
 /* Boot time disable flag */
 static int apparmor_enabled __lsm_ro_after_init = 1;
-module_param_named(enabled, apparmor_enabled, int, 0444);
+module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
@@ -1413,6 +1420,46 @@ static int param_get_aauint(char *buffer, const struct kernel_param *kp)
 	return param_get_uint(buffer, kp);
 }
 
+/* Can only be set before AppArmor is initialized (i.e. on boot cmdline). */
+static int param_set_aaintbool(const char *val, const struct kernel_param *kp)
+{
+	struct kernel_param kp_local;
+	bool value;
+	int error;
+
+	if (apparmor_initialized)
+		return -EPERM;
+
+	/* Create local copy, with arg pointing to bool type. */
+	value = !!*((int *)kp->arg);
+	memcpy(&kp_local, kp, sizeof(kp_local));
+	kp_local.arg = &value;
+
+	error = param_set_bool(val, &kp_local);
+	if (!error)
+		*((int *)kp->arg) = *((bool *)kp_local.arg);
+	return error;
+}
+
+/*
+ * To avoid changing /sys/module/apparmor/parameters/enabled from Y/N to
+ * 1/0, this converts the "int that is actually bool" back to bool for
+ * display in the /sys filesystem, while keeping it "int" for the LSM
+ * infrastructure.
+ */
+static int param_get_aaintbool(char *buffer, const struct kernel_param *kp)
+{
+	struct kernel_param kp_local;
+	bool value;
+
+	/* Create local copy, with arg pointing to bool type. */
+	value = !!*((int *)kp->arg);
+	memcpy(&kp_local, kp, sizeof(kp_local));
+	kp_local.arg = &value;
+
+	return param_get_bool(buffer, &kp_local);
+}
+
 static int param_get_audit(char *buffer, const struct kernel_param *kp)
 {
 	if (!apparmor_enabled)
-- 
2.17.1


-- 
Kees Cook
