Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8CEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E2A206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568409232;
	bh=YSViKEGx/uSWqjR94tt13jk8+7wNpx5qdHUeqsbDgWo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mhR9jN81L8q5wJ/BObhujvJVWWUGdCG8qvQ2+IqDYNAGNNKc4PbRR5yux9O0sJcs+
	 ocZ7ivp08v2j+t4UgmHCmIbRFmi5hKv2Sd48YHSbDjn1Ax4u2mG/5rXNgowkqBInrQ
	 5czNVok/ZUT/2nAY+/GJj1BOIS0HppvQlIJzwa2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfIMVNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:13:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36079 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfIMVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:13:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so30696307oto.3;
        Fri, 13 Sep 2019 14:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGerZQ1lZMxixYWpuVLCQeykiTnMK0boWr8rN0knwKI=;
        b=g/+Lwyv/WVsE1tbESSBQmsYedr1PC6c6BrVWTahePRjDSFZ56tluk8OZWYdEyLuvgT
         +ri4BOuaFAA8YkDImgVZizkp0V+B97iVq13a4h1Bwr2jP0iYevH6rgBDGB0r9ZX3C7X6
         6r2OEDWQHSM3F8zd9EubE2VqqLCQwUTHybTx22I3WX1/rxhtUrykS2eJ8MEZ/4ZqKahd
         vK3HUuildnhbEpwCyCgf41dlQKHukXQOc9h7esJHv5OsTfmr/KWfUcG94tR5RC247tHL
         BzMyLYChvdlxMopjphFYaOz53UlLcYIkQDeIfwB7n3f19OPQUh4cKFAxeef6fM/KLwQ9
         myLQ==
X-Gm-Message-State: APjAAAUunFL0XBNLAD1BatbhSzLva2XsJoaKtW5k0MX3scprYEE+Tnqq
        158ieSbUXd+dfcDdRhVe20RmUeQ=
X-Google-Smtp-Source: APXvYqw5COv6c3ies/fIb2InT2kKS1ZrEjNrMAEsVjYqXvF5qr30TGd02Qm2T/HwWOrgHuBOLmHAIg==
X-Received: by 2002:a9d:371:: with SMTP id 104mr42653238otv.253.1568409230044;
        Fri, 13 Sep 2019 14:13:50 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j23sm3916084otp.67.2019.09.13.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 14:13:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH] checkpatch: Warn if DT bindings are not in schema format
Date:   Fri, 13 Sep 2019 16:13:49 -0500
Message-Id: <20190913211349.28245-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings are moving to using a json-schema based schema format
instead of freeform text. Add a checkpatch.pl check to encourage using
the schema for new bindings. It's not yet a requirement, but is
progressively being required by some maintainers.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..1cbd85f16e32 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2822,6 +2822,14 @@ sub process {
 			     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
 		}
 
+# Check for adding new DT bindings not in schema format
+		if (!$in_commit_log &&
+		    ($line =~ /^new file mode\s*\d+\s*$/) &&
+		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
+			WARN("DT_SCHEMA_BINDING_PATCH",
+			     "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
+		}
+
 # Check for wrappage within a valid hunk of the file
 		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
 			ERROR("CORRUPTED_PATCH",
-- 
2.20.1

