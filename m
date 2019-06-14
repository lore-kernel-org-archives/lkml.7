Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA14C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA2C2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="0TtnhhOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFNHlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:41:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35247 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:41:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so916851pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3J9aX54K+uLhfj4AuSsCr3d9oObOMNCMjlw2UizAl94=;
        b=0TtnhhOcm0GJGXOEwdkAk4uIxFHD8KcKtxfkxymzK7jMusm+7rDSfSpzNKdY2klglp
         wqiVAxFXbwNcJaOfGdQGK5VDP/4I5r7woQ/KoxEq3SMXKDwOqXrPXF51UWDi75oJ7QxU
         1feWaB0ayynYlpZ9ZXhNU1xBhC6sl8Og8sLBa4RqIL+KCTJ0LGIonQSfXzDYYWoHKcjF
         tydlrv5P95Szv+V8GG4QeoEVRrwYohsxkFt7pWT7DRnFtr3msLtCqfAoXUSTd/xjZG1A
         yxMvEX9B8sgDJsDGontKFGhOr5h2DeS2Qdr7/MtQ756NfQTp44SaoQC2lFmv8HWJth9x
         jIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3J9aX54K+uLhfj4AuSsCr3d9oObOMNCMjlw2UizAl94=;
        b=NnhW9NgT1Vc/t5dyB3XrknZzFXZbLcDdz5GQKwEFy9DRKjnEP9hC9zC/y6Tu08A2uy
         cMdm4vM/S0gNyHGyBpPtWH/MgEI3VpRTbWlvFyvjIh+i4VjBOy4kpNb9du3tcgQ6iy7x
         Z+uuV4nRUe74sc9nJqhxvu0BhsRTVbPcJuFYFT370U0V7S2D/E/dPU29HoTvbS/tXouE
         FIOmQBjcmAmh+GtRd6OJMx6NH2dlGiwtNcBhnLrksP7nJSQasIArSwjcEoJc1DVD/2Z1
         gu23IE4KGqk+Sh9dc1otqWVjF3t4+gBRTpnFjAeiSam9FQFq7/eErAXX0dsl7OL07DfI
         Ty4A==
X-Gm-Message-State: APjAAAUyhXCxEKMCCMdi0AP4osJND7hIoim2Dj77wzjCync0gdbYDz9m
        uQtlGgX+G4c6VV7ZkhUwCyVLHg==
X-Google-Smtp-Source: APXvYqy/hlUI23oUSi/Beu9WGn3OJWqV70szPkyF8Zo11ZQsjAjKtIYF0wJHrYwUi2SNN/lOgER4pg==
X-Received: by 2002:a17:90a:3ac2:: with SMTP id b60mr9821149pjc.74.1560498072307;
        Fri, 14 Jun 2019 00:41:12 -0700 (PDT)
Received: from localhost.localdomain (p1227188-ipngn14401marunouchi.tokyo.ocn.ne.jp. [153.205.136.188])
        by smtp.gmail.com with ESMTPSA id o13sm3113636pfh.23.2019.06.14.00.41.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 00:41:11 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     rostedt@goodmis.org, mingo@redhat.com, srikar@linux.vnet.ibm.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH 2/2] tracing/uprobe: Fix obsolete comment on trace_uprobe_create()
Date:   Fri, 14 Jun 2019 16:40:26 +0900
Message-Id: <20190614074026.8045-2-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614074026.8045-1-devel@etsukata.com>
References: <20190614074026.8045-1-devel@etsukata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0597c49c69d5 ("tracing/uprobes: Use dyn_event framework for
uprobe events") cleaned up the usage of trace_uprobe_create(), and the
function has been no longer used for removing uprobe/uretprobe.

Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 kernel/trace/trace_uprobe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 7dc8ee55cf84..7860e3f59fad 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -426,8 +426,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 /*
  * Argument syntax:
  *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS]
- *
- *  - Remove uprobe: -:[GRP/]EVENT
  */
 static int trace_uprobe_create(int argc, const char **argv)
 {
-- 
2.21.0

