Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494EDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D6C2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gff8ZDQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbgAIQEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:04:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25899 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732890AbgAIQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xt5DbHzH/EVOyMc37NjjTNOfxPGZdHy+R4yzKk2QEI0=;
        b=gff8ZDQxdRcJyF1mUUlgIine/yt7C8A/cqPu/JG7fevme/1ORJqRK30xGb1k1B+uSsEjIf
        Wwo7FDxhm6wH3/ooCWTERhoMZVf5t2XT+lAIV68cR0rFvx04KOBp6n6WyJxZx4ws1LgnZu
        ANJ/zp11g5U0jW9Oj06wfviaQXSOnKg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Qv2DOBVZMMe1MtWdYkdx1A-1; Thu, 09 Jan 2020 11:04:31 -0500
X-MC-Unique: Qv2DOBVZMMe1MtWdYkdx1A-1
Received: by mail-wm1-f70.google.com with SMTP id 18so1103904wmp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xt5DbHzH/EVOyMc37NjjTNOfxPGZdHy+R4yzKk2QEI0=;
        b=VYg/qfBOhn6TzbwNCYtgJcNMCDhX0ijv7WLjfXcguPUznB7VMrB/JsUIr3Bit9b5Z0
         oQEdTcENmlLo0cWBva0VoNxYzNVRPDCSLfZkN/3dEZ55qR8CrNR70DNYlXwbnaXF/6+C
         uDsSJQ6Pz1fQ7sZeXKYiIxCE+1qHvSSGA7z4f17ASRExbtSKM2jCFmBt4wRL53yomMNw
         XJ5UVOrOQgBxycmV1T8pblSRuISZkU2r2dzHHNcBxkvqPEpsBPo1kzkqHVpxNwcOMWgX
         Jt8VIh4T2yTkLsfTKk5fH2o/QKiDtu76yP5jNG7vcAOUNcLiApIu2k8X78VBFCe9C1B8
         WwNw==
X-Gm-Message-State: APjAAAW9Xr2F8Yn5S+3+YOXOI4nmPx0geRDQlcAK50iU51FZLaOe3zT1
        tevgfhp1PUCjE8jnijaxYKfFcMiacFVMYz1yOoKJwtrN+ZZniFay52Ua7CWxjb0lInzohFJd7Jg
        cj4YHEJ6LLPdPMw7DurJmuzyp
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr5609170wmk.97.1578585868939;
        Thu, 09 Jan 2020 08:04:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzq/Alj0h2G/J2VQULJA01MqEGedUbxb2oF0V48iKffuNbHJbUHRhKAG5KbZl3knGLHvbjRuw==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr5609151wmk.97.1578585868751;
        Thu, 09 Jan 2020 08:04:28 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id b17sm8615898wrp.49.2020.01.09.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:04:28 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 12/57] objtool: check: Allow jumps from an alternative group to itself
Date:   Thu,  9 Jan 2020 16:02:15 +0000
Message-Id: <20200109160300.26150-13-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alternatives can contain instructions that jump to another instruction
in the same alternative group. This is actually a common pattern on
arm64.

Keep track of instructions jumping within their own alternative group
and carry on validating such branches.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 48 ++++++++++++++++++++++++++++++++++---------
 tools/objtool/check.h |  1 +
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8f2ff030936d..c7b3f1e2a628 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -722,6 +722,14 @@ static int handle_group_alt(struct objtool_file *file,
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
+		/* Is insn a jump to an instruction within the alt_group */
+		if (insn->jump_dest && insn->sec == insn->jump_dest->sec &&
+		    (insn->type == INSN_JUMP_CONDITIONAL ||
+		     insn->type == INSN_JUMP_UNCONDITIONAL)) {
+			dest_off = insn->jump_dest->offset;
+			insn->intra_group_jump = special_alt->orig_off <= dest_off &&
+				dest_off < special_alt->orig_off + special_alt->orig_len;
+		}
 
 		insn->alt_group = true;
 		last_orig_insn = insn;
@@ -1853,14 +1861,33 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
 	return validate_call(insn, state);
 }
 
+static int validate_branch_alt_safe(struct objtool_file *file,
+				    struct symbol *func,
+				    struct instruction *first,
+				    struct insn_state state);
+
+static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *first, struct insn_state state)
+{
+	if (first->alt_group && list_empty(&first->alts)) {
+		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
+			  first->sec, first->offset);
+		return 1;
+	}
+
+	return validate_branch_alt_safe(file, func, first, state);
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
  * each instruction and validate all the rules described in
  * tools/objtool/Documentation/stack-validation.txt.
  */
-static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *first, struct insn_state state)
+static int validate_branch_alt_safe(struct objtool_file *file,
+				    struct symbol *func,
+				    struct instruction *first,
+				    struct insn_state state)
 {
 	struct alternative *alt;
 	struct instruction *insn, *next_insn;
@@ -1871,12 +1898,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	insn = first;
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
-		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
-			  sec, insn->offset);
-		return 1;
-	}
-
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
@@ -2023,8 +2044,15 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 					return ret;
 
 			} else if (insn->jump_dest) {
-				ret = validate_branch(file, func,
-						      insn->jump_dest, state);
+				if (insn->intra_group_jump)
+					ret = validate_branch_alt_safe(file,
+								       func,
+								       insn->jump_dest,
+								       state);
+				else
+					ret = validate_branch(file, func,
+							      insn->jump_dest,
+							      state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(branch)", insn);
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index af87b55db454..d13ee02f28a4 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -46,6 +46,7 @@ struct instruction {
 	struct stack_op stack_op;
 	struct insn_state state;
 	struct orc_entry orc;
+	bool intra_group_jump;
 };
 
 struct objtool_file {
-- 
2.21.0

