Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B693CC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83098261D6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315913;
	bh=+yWe9rpL5FUIWMN487HivcLFqW6BzYsEEe45+YarmzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bxKk2FPxk29iP4T6zJwmTJ9HGxJfMuKrOJrA6zbcXGOi80mw1Lmsq8QPZKGDbTZUQ
	 OAe1LWAcgm+L7JFnGysRdcZX/bt2GI49s2w+aUHBWILCRzLMQXi735ILNn/UiZPlJ6
	 uGU3kpr6mhSSDT+RBospwFfjrdLGMNsDP8DwMII8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEaPSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEaPSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:18:32 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8969422CD9;
        Fri, 31 May 2019 15:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315911;
        bh=+yWe9rpL5FUIWMN487HivcLFqW6BzYsEEe45+YarmzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wtKlKIdmEE5+CB7dmgQZfgKR2QToi6c6P7cdDuRLnDSYKf9ihok/whgFiW8WRRF4E
         F7AmIhZzyVJpvRnVhQLI7yP16/3ib9a/X1ZezLQN3lJX9RlFI9NTHs+vQPR2VNEAvS
         RPoQDEnOhGmIMXBz3EzY6accFQbpjlTaj4kfqjN4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/21] tracing/dynevent: Delete all matched events
Date:   Sat,  1 Jun 2019 00:18:27 +0900
Message-Id: <155931590701.28323.1461198156382204342.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 

