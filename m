Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE1DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1752022CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/yPzpVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfHTATL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:11 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:37469 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfHTATI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:08 -0400
Received: by mail-vk1-f201.google.com with SMTP id v135so2386455vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xx9Xy1LVHNW0tgTSSnVwIoZL9BHfKDcopwVECPb1wsc=;
        b=F/yPzpVt2wy+/RI8gQkTjcBM7pMdfOqXRs/Rcx+HXbPreTgnQ44pNYo0mDGDUxvGEX
         bEWLJ9FU/qcn5HXlisW13gVjagvurjM7pXRJDLFO3k0QBYCIGITFcWsSSLhvoSXZhZ4v
         zf/nuuJTriWiZ1FX8j5uaG8iyW6Tq8BCyiQrxilehohXoQjUKJTcI7b92Q+sV+IRM3eb
         gsu02kbge5xj064n08ySG2E0hadOem6mN26HMordi9Z3QSRdBgmpiSuP/uu7ZDxdm5pm
         /ex9tUgx95/DmzWh00bg/8OYGi0Y5GIbzkzb0djk5Qvro5V/+6OpxnvCdu8sR6WlEcQD
         z62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xx9Xy1LVHNW0tgTSSnVwIoZL9BHfKDcopwVECPb1wsc=;
        b=trBA8e0XHYQb3TR3n/hN+9Us+dm+xXsW7sWUaevXI449h41JGo09sDi9EFSEknijOR
         lQqXsdXOrdq5r+e3HQ8c2E0RE8HmmLXlOen1S9UlQVWV6IE6MWBCnQz5XODnIjYTFAbd
         AhxM+FnwEy275p6yv+76L9wJtK2MhGZ0nbkwK+S6+15OH0jWMXRoqGS7PcJW7Dg3p8k+
         yvkR8rcI3sR3bTX6XEzUmMIpH+K9y8ce+zQYY2QDwXsYvniUkslcncszM+Lt9jvu2qJR
         pfVeVa82bSytXlm52XUpagMtf5dftCP867rzGBTPHdP2S2V12SRUYilhehpOmtM4b7hm
         qzew==
X-Gm-Message-State: APjAAAWs5oL08nNkEF2fv8anpK/a0S3c6zzJOD0fx3RVFZLDp4VjTV9U
        WWmayaSXQbKq0dx5oeC32InKVnq+suDcg4vxsucyAg==
X-Google-Smtp-Source: APXvYqyflZ+iCWxBsvHiYwKTezANKF/iZUuKUhXjSOpdFAAPQb73YcqwsuEdzoBQl/jf+20nh/mNpSEz6S9+q3d7ROeUiw==
X-Received: by 2002:ab0:67d6:: with SMTP id w22mr15722265uar.68.1566260347590;
 Mon, 19 Aug 2019 17:19:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:58 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 22/29] lockdown: Lock down tracing and perf kprobes when
 in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the creation of perf and ftrace kprobes when the kernel is
locked down in confidentiality mode by preventing their registration.
This prevents kprobes from being used to access kernel memory to steal
crypto data, but continues to allow the use of kprobes from signed
modules.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     | 1 +
 kernel/trace/trace_kprobe.c  | 5 +++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 669e8de5299d..0b2529dbf0f4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,6 +117,7 @@ enum lockdown_reason {
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
+	LOCKDOWN_KPROBES,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7d736248a070..fcb28b0702b2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
+#include <linux/security.h>
 
 #include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
@@ -415,6 +416,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	ret = security_locked_down(LOCKDOWN_KPROBES);
+	if (ret)
+		return ret;
+
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 403b30357f75..27b2cf51e443 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -32,6 +32,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
+	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

