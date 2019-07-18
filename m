Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92519C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662B1208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ef0RDKPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404049AbfGRTpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:45:19 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:33577 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404023AbfGRTpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:45:16 -0400
Received: by mail-vk1-f201.google.com with SMTP id l80so13043641vkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ir52NoHfEVr1DjuDuM2cD1YNKYnnMxmS3VGJXLDOV4g=;
        b=ef0RDKPA6T0RAn9J0sqYw8XkCSknEd2hcD11i6wHXfcPPIvp+kHcQuTKGy6w00SqR+
         z9qQt1r4ANYYmWGXYb/zrIS51+rehEPvjiBD8BsoRc85GIJA/5XJ8rEoVbUOvaBsreO5
         HyTRleR4vHF/0EKKO7RFGIPxbQT/JxOkuD6jn36TRWyw+aYsuC1hsbY+/ppIQdpCX+7A
         Sfp97RVIiaitFBHQlbGKZSmJZtsEr2sLie57ZFO9QPxGd7zWTrYiRIKdliEF+0OBm2No
         qMqVObVBnwecjTSPSJIRrBbq1BHDSIdLi5ITH5lvt+W8FLpJ59I85l/CGi6W3/EFNHxo
         ypnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ir52NoHfEVr1DjuDuM2cD1YNKYnnMxmS3VGJXLDOV4g=;
        b=rmirAXCp93ALXg+YNUUpkyUSoUmiXkprlFA++To/eI2ZWzeJOZqDEO2cWtuffVn3+U
         UlUmjbx/YeT7e+zf+4RFcSP3tCejQW0q7wOl0rFC/67PIOhqReO+FRGNssbzjIDzEEas
         3OWf6CtmuGhdXyqc/aQ4lZO8W988V1jeKIJHF7P8mV5FD5tpAAvZaCpBk2jYgTxhVfE1
         mEdwN836GfPqIiF/hVXdaHy0cmncN26wlRB5ted/wTsM9R96TZv9J+toQ4iocOIGBdeH
         m1+D8SxLATgnfxu/+OvZIfWkuGgT3khb7BqfkZCk4jpFQ7cppKv+KdnljBpp+VfWh2nB
         GYfQ==
X-Gm-Message-State: APjAAAV5RMSHVMlXBTwaA4n+bHtGRcg40/clPb0o7IoSayJFeuXRk+v7
        QqtIoTjXs4DFiCUzEsPPEhvbN1mSDh9Y64HF/3zuZA==
X-Google-Smtp-Source: APXvYqzH9MM86nix5yFe0Y1WfhHKn2G3jMnALVHH9DGne7xF3/1Ry4eiLc0uynUN0Z25bXkP2NVqz3B1jWPEaKP4cN480w==
X-Received: by 2002:ab0:2442:: with SMTP id g2mr11684721uan.47.1563479115556;
 Thu, 18 Jul 2019 12:45:15 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:08 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 22/29] Lock down tracing and perf kprobes when in
 confidentiality mode
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
---
 include/linux/security.h     | 1 +
 kernel/trace/trace_kprobe.c  | 5 +++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index f0cffd0977d3..987d8427f091 100644
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
index c050b82c7f9f..6b123cbf3748 100644
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
2.22.0.510.g264f2c817a-goog

