Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBCBC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F2E2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956856;
	bh=+yWe9rpL5FUIWMN487HivcLFqW6BzYsEEe45+YarmzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CyB32uz/WS+/gILiQthDxe0pnNgnTzFBq2qgBWpilQyJGV2VPwDB6+PPKGqSKT9ET
	 mezxCaA4TWa7VJhini+5tUqbBazRFKTNULQvDMOGes8omg+b7mmw9mTmF6TpHInrI8
	 FDIgTqxtBwt7RhuV8FtoTY6BU5C6+hDhZleryh60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfFSPHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfFSPHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:07:34 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0A2218A0;
        Wed, 19 Jun 2019 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956853;
        bh=+yWe9rpL5FUIWMN487HivcLFqW6BzYsEEe45+YarmzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YK6jytfIiH5b4IpMm4cCPdr5/3Nir6RfMf4LixmB9rrEM1zUXx2BgXDttTu/WTFgs
         4JFXWfIwI5BhfAvekU5HfzZXxGmCN6P6wvm0lNgVTnIHjYbJaabqRTteCHV+iGeA5l
         yc+B/Uz/7syKBX3Sui+omCGis7hloj0E15NiqYhA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 02/12] tracing/dynevent: Delete all matched events
Date:   Thu, 20 Jun 2019 00:07:29 +0900
Message-Id: <156095684958.28024.16597826267117453638.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156095682948.28024.14190188071338900568.stgit@devnote2>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user gives an event name to delete, delete all
matched events instead of the first one.

This means if there are several events which have same
name but different group (subsystem) name, those are
removed if user passed only the event name, e.g.

  # cat kprobe_events
  p:group1/testevent _do_fork
  p:group2/testevent fork_idle
  # echo -:testevent >> kprobe_events
  # cat kprobe_events
  #

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_dynevent.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index fa100ed3b4de..1cc55c50c491 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -61,10 +61,12 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 	for_each_dyn_event_safe(pos, n) {
 		if (type && type != pos->ops)
 			continue;
-		if (pos->ops->match(system, event, pos)) {
-			ret = pos->ops->free(pos);
+		if (!pos->ops->match(system, event, pos))
+			continue;
+
+		ret = pos->ops->free(pos);
+		if (ret)
 			break;
-		}
 	}
 	mutex_unlock(&event_mutex);
 

