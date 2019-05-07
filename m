Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C06C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7297D20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557237369;
	bh=Sv73nYWGhZw1cOvFhxh3v968yU9VwS0c9hkb5H6C49o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EC838n7Zv1vhjSR9jA5AqwBMiGwdjBrjHHO1HVmJEUjELgIPN0uhxseDPMoDTUrQ2
	 K1BkjRxleK9lPUxN1t1v3Kmdt3idIyZF25hJL+BazkYb0KkesfPR79uMnMKHu2MoMt
	 7DLsFByt6wqT1UJ6lp7Xw2e6hgCqx4XUk7Yr3P7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfEGN4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfEGN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:56:07 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54AF5205C9;
        Tue,  7 May 2019 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557237366;
        bh=Sv73nYWGhZw1cOvFhxh3v968yU9VwS0c9hkb5H6C49o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p37yYl5Vv8wb6Q9xWjcVQnSRffvZ8HLfLPF1U27nrLMz4waYgrkTjkYq4KrRmqwCr
         6f5+90RrekblphPiprBeAN58xP/RR7JjLYQ+p/jJIFP31LFIwJYOEhiVB3WKVP8IrH
         qwLHeld1nV98hwAwaxED8Mg/nquLzqy1ocOoAZNg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] tracing: probeevent: Fix to make the type of $comm string
Date:   Tue,  7 May 2019 22:56:02 +0900
Message-Id: <155723736241.9149.14582064184468574539.stgit@devnote2>
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

Fix to make the type of $comm "string".
If we set the other type to $comm argument, it shows
meaningless value or wrong data. Currently probe events
allow us to set string array type (e.g. ":string[2]"), or
other digit types like x8 on $comm. But since clearly
$comm is just a string data, it should not be fetched
by other types including array.

Fixes: 35abb67de744 ("tracing: expose current->comm to [ku]probe events")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_probe.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4cc2d467d34c..e0d1d5353464 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -533,13 +533,14 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			}
 		}
 	}
-	/*
-	 * The default type of $comm should be "string", and it can't be
-	 * dereferenced.
-	 */
-	if (!t && strcmp(arg, "$comm") == 0)
+
+	/* Since $comm can not be dereferred, we can find $comm by strcmp */
+	if (strcmp(arg, "$comm") == 0) {
+		/* The type of $comm must be "string", and not an array. */
+		if (parg->count || (t && strcmp(t, "string")))
+			return -EINVAL;
 		parg->type = find_fetch_type("string");
-	else
+	} else
 		parg->type = find_fetch_type(t);
 	if (!parg->type) {
 		trace_probe_log_err(offset + (t ? (t - arg) : 0), BAD_TYPE);

