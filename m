Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8073AC7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D0A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167529;
	bh=FEs3TMM0ZYwBf3dusmpCVE/U5ogVTBo5jlcOMzlVOu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fC8h9L+t6F0HvrKblCvZGRenz4ETtwWXvqeRdtvOOEElOdC2jSlAE/wDr512phT6l
	 vlnIugP+4TOoAEeuRgazBKcKhPoD+lytFClxkBsFXTs1hcPM+LvwYZpimwln2WyMRb
	 426WdEgWnmTMYNYFrbJntclja+V2ZBs4FFnPnByM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfGOFMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfGOFMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:12:08 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF39620868;
        Mon, 15 Jul 2019 05:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167527;
        bh=FEs3TMM0ZYwBf3dusmpCVE/U5ogVTBo5jlcOMzlVOu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jc5HCRNtGy31jz2P+m/nHdZqFo8SeZdOlg3kLURGc/Ut32o4Qi4j79saQkK+H/lIz
         hu3pCa/i43EdE6VO63k4TfI7h35L+Vku3zKvGIqCQkcf7lbqskrLX/LkR74rvWNA3e
         mrAtYWH5hP05oid8ZzYlzOy4TlcumfRIEaS3d5PU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tim Bird <Tim.Bird@sony.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v2 05/15] tracing: Accept different type for synthetic event fields
Date:   Mon, 15 Jul 2019 14:12:02 +0900
Message-Id: <156316752214.23477.15002557629670000175.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156316746861.23477.5815110570539190650.stgit@devnote2>
References: <156316746861.23477.5815110570539190650.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the synthetic event accepts a different type field to record.
However, the size and signed flag must be same.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ca6b0dff60c5..a7f447195143 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4063,8 +4063,11 @@ static int check_synth_field(struct synth_event *event,
 
 	field = event->fields[field_pos];
 
-	if (strcmp(field->type, hist_field->type) != 0)
-		return -EINVAL;
+	if (strcmp(field->type, hist_field->type) != 0) {
+		if (field->size != hist_field->size ||
+		    field->is_signed != hist_field->is_signed)
+			return -EINVAL;
+	}
 
 	return 0;
 }

