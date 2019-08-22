Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64199C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46720856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495660;
	bh=FaT5FQecb8EjfqwtrvETdTKkobJhqQVNVnVT3NtjbAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kY4wnIGwy5QbYufWVrg6BLpkBrkQzmPyh8TfhdNJC7+/7Bm8s8ZnhfAAyHQ0DWmQE
	 oVEPb/Rg3JJCsoM6Em//OB4+e5zg1NGPXxprn7TpqG9Jd1CAhH3xRh9o4U4KRjwxV6
	 9aQTmCAIUD6FbEJluMPVwG64YG66BXcW4AvKyAz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404030AbfHVRYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403970AbfHVRXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:39 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9AB23426;
        Thu, 22 Aug 2019 17:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494617;
        bh=FaT5FQecb8EjfqwtrvETdTKkobJhqQVNVnVT3NtjbAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDplekty9t3uYV+Fub7I6ak5gaAzWrANWgl8/3p7GgjiSjsYNg4sxsDYcMCPh4RCJ
         2bbG1Ucsve+laUWeHFmfhyEnrLPOZFrFuzGdF4ecPVqgX1R4wdHhO0BMIG2QyxgT2y
         mGnXDvrM9T//ye8tbhXblA8S/EXZZhH128CXfdVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 046/103] bpf: restrict access to core bpf sysctls
Date:   Thu, 22 Aug 2019 10:18:34 -0700
Message-Id: <20190822171730.662419102@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit 2e4a30983b0f9b19b59e38bbf7427d7fdd480d98 upstream.

Given BPF reaches far beyond just networking these days, it was
never intended to allow setting and in some cases reading those
knobs out of a user namespace root running without CAP_SYS_ADMIN,
thus tighten such access.

Also the bpf_jit_enable = 2 debugging mode should only be allowed
if kptr_restrict is not set since it otherwise can leak addresses
to the kernel log. Dump a note to the kernel log that this is for
debugging JITs only when enabled.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[bwh: Backported to 4.9:
 - We don't have bpf_dump_raw_ok(), so drop the condition based on it. This
   condition only made it a bit harder for a privileged user to do something
   silly.
 - Drop change to bpf_jit_kallsyms]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sysctl_net_core.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -232,6 +232,41 @@ static int proc_do_rss_key(struct ctl_ta
 	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
 }
 
+#ifdef CONFIG_BPF_JIT
+static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
+					   void __user *buffer, size_t *lenp,
+					   loff_t *ppos)
+{
+	int ret, jit_enable = *(int *)table->data;
+	struct ctl_table tmp = *table;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	tmp.data = &jit_enable;
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret) {
+		*(int *)table->data = jit_enable;
+		if (jit_enable == 2)
+			pr_warn("bpf_jit_enable = 2 was set! NEVER use this in production, only for JIT debugging!\n");
+	}
+	return ret;
+}
+
+# ifdef CONFIG_HAVE_EBPF_JIT
+static int
+proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
+				    void __user *buffer, size_t *lenp,
+				    loff_t *ppos)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+}
+# endif
+#endif
+
 static struct ctl_table net_core_table[] = {
 #ifdef CONFIG_NET
 	{
@@ -293,7 +328,7 @@ static struct ctl_table net_core_table[]
 		.data		= &bpf_jit_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax_bpf_enable,
 # ifdef CONFIG_BPF_JIT_ALWAYS_ON
 		.extra1		= &one,
 		.extra2		= &one,
@@ -308,7 +343,7 @@ static struct ctl_table net_core_table[]
 		.data		= &bpf_jit_harden,
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
 		.extra1		= &zero,
 		.extra2		= &two,
 	},


