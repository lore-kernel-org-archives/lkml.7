Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E4C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A002077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="W4GdLTHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgAIVzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:55:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36571 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgAIVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:55:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so8775plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/8o+kyBEAj2d3eFIaF+64h5g3MKBrDlOpfsw5qo46Q=;
        b=W4GdLTHa0RU3+IRGX8fp6NbUWpr+SppZgJL2AzCPqpugzjv4uH9lylKs7OyF31HcSC
         TK0ir8n3m7G3+bzNgnbQqhBNe37NWcpQbicM16y8y+PHLtkQ9P2ZiPd8QCfXfNySN7yU
         z/Mkk9/q+oX8r4RG0l+iLBcSN7PdcLJRfJPiDlvg1sbBexaMVTpcsM9T1yEByLwWehDs
         T1Exy6NZ9mKE66r1N5sSZ8W/NQY3RUhJlJBeqYPrpzCFfrHMWOoFW06eBjQ9dxisvIN2
         1fn6jUwopNeG6eNnCXZKZ2PZSxGBC53xev1eB5/VPCwsGqiSOZOrb4oDKzcmLEwOb0jN
         H0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/8o+kyBEAj2d3eFIaF+64h5g3MKBrDlOpfsw5qo46Q=;
        b=uK7Hno7CBt6hb7M4bKG6u0QzXbUrmATBa8cM1f6nE0FQ/6X4uOfxS26CLZo0KCcIV7
         rQPFiKr8s8C5W8BE3ChcQ3GmAY2h80HDXbqyDytx7ZcMqyuyQGdM7tB4lQEHHhHX77bM
         jm7sUoZn0DfRn/q+Q13+xxgJQvjxwfoDSGHsAWXBVpSWfTmqOxBXopy4fGjB0bNQ1c5k
         tUch63m02aPp1y00ph/4xVEydgURblZH6ud9Gk9Vii2IW5M70hfGEp80o7VBgxStVYJQ
         DTtfy9HHiFbxIQrZ3Hlw9Iac6acSYIs1CbNHoviqEUKjVDTGVvRle3eUhQJ2S9HZZEEv
         vG6A==
X-Gm-Message-State: APjAAAVfAZeggJ8MjFtU1y3ugHu8r4kRLoHTEX5cvy1vOkb1FU59QFCb
        ow9OWqCWT/TCkWme2mqc8ZeP3Fofzcg=
X-Google-Smtp-Source: APXvYqxvO3RT7QlpeAFhe8S1Ky3JMGdmgpdyZvr9ClXXJaV7j+0MNBA+k/w52oJCRmkjCQqJ7noetA==
X-Received: by 2002:a17:90a:1b0a:: with SMTP id q10mr300748pjq.126.1578606910746;
        Thu, 09 Jan 2020 13:55:10 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r20sm8711536pgu.89.2020.01.09.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:55:09 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH-next 2/3] sysctl/sysrq: Remove __sysrq_enabled copy
Date:   Thu,  9 Jan 2020 21:54:43 +0000
Message-Id: <20200109215444.95995-3-dima@arista.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109215444.95995-1-dima@arista.com>
References: <20200109215444.95995-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many embedded boards have a disconnected TTL level serial which can
generate some garbage that can lead to spurious false sysrq detects.

Currently, sysrq can be either completely disabled for serial console
or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")

At Arista, we have such boards that can generate BREAK and random
garbage. While disabling sysrq for serial console would solve
the problem with spurious false sysrq triggers, it's also desirable
to have a way to enable sysrq back.

Having the way to enable sysrq was beneficial to debug lockups with
a manual investigation in field and on the other side preventing false
sysrq detections.

As a preparation to add sysrq_toggle_support() call into uart,
remove a private copy of sysrq_enabled from sysctl - it should reflect
the actual status of sysrq.

Furthermore, the private copy isn't correct already in case
sysrq_always_enabled is true. So, remove __sysrq_enabled and use a
getter-helper for sysrq enabled status.

Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c   |  7 +++++++
 include/linux/sysrq.h |  1 +
 kernel/sysctl.c       | 41 ++++++++++++++++++++++-------------------
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f724962a5906..ef3e78967146 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -73,6 +73,13 @@ static bool sysrq_on_mask(int mask)
 	       (sysrq_enabled & mask);
 }
 
+int sysrq_get_mask(void)
+{
+	if (sysrq_always_enabled)
+		return 1;
+	return sysrq_enabled;
+}
+
 static int __init sysrq_always_enabled_setup(char *str)
 {
 	sysrq_always_enabled = true;
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 8c71874e8485..4a0b351fa2d3 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -50,6 +50,7 @@ int unregister_sysrq_key(int key, struct sysrq_key_op *op);
 struct sysrq_key_op *__sysrq_get_key_op(int key);
 
 int sysrq_toggle_support(int enable_mask);
+int sysrq_get_mask(void);
 
 #else
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d396aaaf19a3..6ddb4d7df0e1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -229,25 +229,8 @@ static int proc_dopipe_max_size(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp, loff_t *ppos);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-/* Note: sysrq code uses its own private copy */
-static int __sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
-
 static int sysrq_sysctl_handler(struct ctl_table *table, int write,
-				void __user *buffer, size_t *lenp,
-				loff_t *ppos)
-{
-	int error;
-
-	error = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (error)
-		return error;
-
-	if (write)
-		sysrq_toggle_support(__sysrq_enabled);
-
-	return 0;
-}
-
+			void __user *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
 static struct ctl_table kern_table[];
@@ -747,7 +730,7 @@ static struct ctl_table kern_table[] = {
 #ifdef CONFIG_MAGIC_SYSRQ
 	{
 		.procname	= "sysrq",
-		.data		= &__sysrq_enabled,
+		.data		= NULL,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= sysrq_sysctl_handler,
@@ -2844,6 +2827,26 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
 }
 #endif
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static int sysrq_sysctl_handler(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int tmp, ret;
+
+	tmp = sysrq_get_mask();
+
+	ret = __do_proc_dointvec(&tmp, table, write, buffer,
+			       lenp, ppos, NULL, NULL);
+	if (ret || !write)
+		return ret;
+
+	if (write)
+		sysrq_toggle_support(tmp);
+
+	return 0;
+}
+#endif
+
 static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int write,
 				     void __user *buffer,
 				     size_t *lenp, loff_t *ppos,
-- 
2.24.1

