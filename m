Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 04:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEB42186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 04:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552537837;
	bh=dohDzF0r0WbehamBz1hsqob3IowgXW1EfSROKvSDp7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O7T8p/ecvmnXvqibKcUMLBCIpLaY87NWNm4DUpl+YG2b6WQQ/L8ngtnSUogeAWtz0
	 CPMOzjVEIaP6STKfAmNM6CVnJyXqdPc54SDkmOmsnRtFUGdtjkFeLJO5lW3Jyl1iv6
	 QR5mY9GmCp9Lu38dIAdRWAe/n2nWkj1UmsfMAnF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCNEag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 00:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfCNEaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 00:30:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D83A92085A;
        Thu, 14 Mar 2019 04:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552537835;
        bh=dohDzF0r0WbehamBz1hsqob3IowgXW1EfSROKvSDp7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=We+CUL3xcGmwviCkuaM/Z8ABxXLMY+12H+rylsngRbjpOx83Zoa6qijCqFW08mQj5
         CVMdakoTlIBX9Gr8uQNeVAeqwksSmnp+q+z+OhGA+922h0zKETAt/j0Rv+UzEPKBHS
         Ngu+QRrABpEY6OGMvTYkXeWuXbJqv85auTbPqsfY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 3/7] tracing/probe: Check the size of argument name and body
Date:   Thu, 14 Mar 2019 13:30:30 +0900
Message-Id: <155253783029.14922.12650939303827581096.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155253778926.14922.14048967363017104338.stgit@devnote2>
References: <155253778926.14922.14048967363017104338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the size of argument name and expression is not 0
and smaller than maximum length.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    2 ++
 kernel/trace/trace_probe.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4cd50913cb5d..feae03056f0b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -554,6 +554,8 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, char *arg,
 
 	body = strchr(arg, '=');
 	if (body) {
+		if (body - arg > MAX_ARG_NAME_LEN || body == arg)
+			return -EINVAL;
 		parg->name = kmemdup_nul(arg, body - arg, GFP_KERNEL);
 		body++;
 	} else {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 8a63f8bc01bc..2177c206de15 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -32,6 +32,7 @@
 #define MAX_TRACE_ARGS		128
 #define MAX_ARGSTR_LEN		63
 #define MAX_ARRAY_LEN		64
+#define MAX_ARG_NAME_LEN	32
 #define MAX_STRING_SIZE		PATH_MAX
 
 /* Reserved field names */

