Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C972820B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557237359;
	bh=XRpO1rL4NgKkwtmwDTpMCF5+yRxjT0rBPYnhC4JeY8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWVmlt9C7L86nsZ6mMUosjY8UkNHvJ6CgNBbbCMgo0z4JzRhKJnJGJTvZFseKHslV
	 Vv7Tex3sLUG7odmp4qyfbkuynlSkNlnH0fF5NT2qcb4BMfHE2VkpnRjjyqIZBmzV+v
	 DJiZ6/XkFktp+klZWyhQUGZiHd1b3Z2bzhn+xB0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfEGNz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfEGNz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:55:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9501D20873;
        Tue,  7 May 2019 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557237357;
        bh=XRpO1rL4NgKkwtmwDTpMCF5+yRxjT0rBPYnhC4JeY8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=are/QFBA0j/pBiuDH0aD7gOuXju0iEoRrCwT2coxBXPWrsi/z+Fo5fw6ofhoU9UV9
         WVioWBwrTpWDXYHhsof3vWUeNwjCvUSCLZhOfZEhi8R5InwddyxtfgL8WflqWXSeSs
         obUfB7/Tu6CbAGFFCXbbsCyxwfmmFrNeAVzhB+SE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] tracing: probeevent: Do not accumulate on ret variable
Date:   Tue,  7 May 2019 22:55:52 +0900
Message-Id: <155723735237.9149.3192150444705457531.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155723732200.9149.10482668315693777743.stgit@devnote2>
References: <155723732200.9149.10482668315693777743.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not accumulate strlen result on "ret" local variable, because
it is accumulated on "total" local variable for array case.

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe_tmpl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 4737bb8c07a3..c30c61f12ddd 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -88,7 +88,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
 		if (code->op == FETCH_OP_ST_STRING) {
-			ret += fetch_store_strlen(val + code->offset);
+			ret = fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
 		} else

