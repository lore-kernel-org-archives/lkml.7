Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0EAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEED206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSlvDtmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbgAIQDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38453 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731296AbgAIQDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRwsZXslrF8qlI5MyK0VLDbXIL7BVk96fwOyF4VyYbw=;
        b=DSlvDtmpDmwbVfzwyBtjcR+SnSNVvnfEAz5DGW0zCn+H+p2uJxxF2OjmTdxzJq8aM9YY7a
        w1KGU3MvkdHrjh0q3HRc6Y+uJJ2BnkGw9PHAf3uTYXDENU0DueX/B92Wd0ObQHun93UIgd
        xu+GwY2Q/DWUuNbZig4WoeGAVfElBKE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-49f7B0j3P2yvqkbWD8-3Cg-1; Thu, 09 Jan 2020 11:03:51 -0500
X-MC-Unique: 49f7B0j3P2yvqkbWD8-3Cg-1
Received: by mail-wr1-f70.google.com with SMTP id v17so3034516wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRwsZXslrF8qlI5MyK0VLDbXIL7BVk96fwOyF4VyYbw=;
        b=fNXsDTmLDNI35xHy/JvbQp1s0Wk4LLbsV60zqskCOvSHOmuoBZy/LP7YYTDijyOBp+
         CUOsVMvukuEkNOoYQDxnmvYJhfty0Tg2u00Fhroxca7QgV+1vzrLJjpalT1KvxzCWxgK
         FPIeiZPPDYvsGRe/Lyn8R0/FmLS9QUsTpyQ1Rff/39yuVpirwty/P4HsOr81ovdZE+f7
         P/GpUblO734dbz23j5MtePSGPBnt3u2VhwLAhTKIHKTgHyuqwZuH/4g6wb5vRgRXeGDm
         gh5FtyB8JJz6d0sFVixubHC7Y/2kFwJoh+TgC4XxnXMtiG6l3CVh8Xow9xe2bn6iZlpn
         wPYw==
X-Gm-Message-State: APjAAAVeNeTQwp16XnwLDjav9y3/mZl2ci25znWnx58r4LzdhQY8VA4J
        i/faPBzhJ3rtIGJA86jcmHhxCRL4xnXI9YXcZSpMLWEYMacLt3nwiJKaT874KH/3+aukXiiJ/JO
        Iap+xQANOfA969cimL5iSElS7
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr11697760wru.40.1578585830109;
        Thu, 09 Jan 2020 08:03:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdTwKmwk+TMSvNrwowSzjOiXNj+qkJd4Gz4AqQII7UyixaAnIcNddNNeu3UQ7anmhP/LotHQ==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr11697736wru.40.1578585829847;
        Thu, 09 Jan 2020 08:03:49 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m126sm3321546wmf.7.2020.01.09.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:49 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 06/57] objtool: Give ORC functions consistent name
Date:   Thu,  9 Jan 2020 16:02:09 +0000
Message-Id: <20200109160300.26150-7-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename ORC manipulating functions to have more consistent name. Have
"orc_" as a prefix for all of them.

No functionality change.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c   |  4 ++--
 tools/objtool/orc.h     |  4 ++--
 tools/objtool/orc_gen.c | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6a5f78cca27c..dd155095251c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2481,11 +2481,11 @@ int check(const char *_objname, bool orc)
 	}
 
 	if (orc) {
-		ret = create_orc(&file);
+		ret = orc_init(&file);
 		if (ret < 0)
 			goto out;
 
-		ret = create_orc_sections(&file);
+		ret = orc_create_sections(&file);
 		if (ret < 0)
 			goto out;
 
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
index ee2832221e62..cd44417487e4 100644
--- a/tools/objtool/orc.h
+++ b/tools/objtool/orc.h
@@ -10,8 +10,8 @@
 
 struct objtool_file;
 
-int create_orc(struct objtool_file *file);
-int create_orc_sections(struct objtool_file *file);
+int orc_init(struct objtool_file *file);
+int orc_create_sections(struct objtool_file *file);
 
 int orc_dump(const char *objname);
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 27a4112848c2..29bee7bd212a 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -10,7 +10,7 @@
 #include "check.h"
 #include "warn.h"
 
-int create_orc(struct objtool_file *file)
+int orc_init(struct objtool_file *file)
 {
 	struct instruction *insn;
 
@@ -81,9 +81,9 @@ int create_orc(struct objtool_file *file)
 	return 0;
 }
 
-static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
-				unsigned int idx, struct section *insn_sec,
-				unsigned long insn_off, struct orc_entry *o)
+static int orc_create_entry(struct section *u_sec, struct section *ip_relasec,
+			    unsigned int idx, struct section *insn_sec,
+			    unsigned long insn_off, struct orc_entry *o)
 {
 	struct orc_entry *orc;
 	struct rela *rela;
@@ -116,7 +116,7 @@ static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
 	return 0;
 }
 
-int create_orc_sections(struct objtool_file *file)
+int orc_create_sections(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
 	struct section *sec, *u_sec, *ip_relasec;
@@ -182,7 +182,7 @@ int create_orc_sections(struct objtool_file *file)
 			if (!prev_insn || memcmp(&insn->orc, &prev_insn->orc,
 						 sizeof(struct orc_entry))) {
 
-				if (create_orc_entry(u_sec, ip_relasec, idx,
+				if (orc_create_entry(u_sec, ip_relasec, idx,
 						     insn->sec, insn->offset,
 						     &insn->orc))
 					return -1;
@@ -194,7 +194,7 @@ int create_orc_sections(struct objtool_file *file)
 
 		/* section terminator */
 		if (prev_insn) {
-			if (create_orc_entry(u_sec, ip_relasec, idx,
+			if (orc_create_entry(u_sec, ip_relasec, idx,
 					     prev_insn->sec,
 					     prev_insn->offset + prev_insn->len,
 					     &empty))
-- 
2.21.0

