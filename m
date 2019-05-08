Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68800C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EAF21734
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1PxITYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfEHRoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:44:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43558 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEHRoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:44:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so13013444wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c438EoirYtGSQ+tCOgK093jqQ5FnSDzmnrTdaZP0MAc=;
        b=f1PxITYMDDxs1Dn8JVDeiL4kVuwVXrpNXZBwu4Pg7KNsXHxsIbrxmEvY1E234bpUkE
         RAPAZvLzwFrYmQWvbOUOg59U0+v5L9kQknIzVG7T7wYP6Gmn37am6UEFMdTzyVcVX+rc
         oefUUbS3Hte1154Utj6Vk+Y60V7AzbhFg774aiaw2lxVeu9oFwmP8Qh57U2jaIvMfgym
         C4fC/fFaTiVb9aGSNlF7SqOtbcx7Vn0bKnep9BSUZPAdMVQ0vvNHyNuDkUZOnarbAKSg
         7nks0wt1V5oUmhG5CbPnVcZFsdLI0bOQBZ8MOAuQc6uQEMwcwyZNpH39W65rjnGgWprB
         DmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c438EoirYtGSQ+tCOgK093jqQ5FnSDzmnrTdaZP0MAc=;
        b=GnxAmL2kcaQbwEAX3ZPdxd9Y6Zx8YbUaxkvPxflf3Opu3+Xs+l4ipL/LeyDq0cIViP
         bhBd4Z1zVPGArAqHbn1rnGrFy6KcX09FRu/5Gcrt9f4aeCqG2zxKYCJrGRRkkehNWC/I
         cDrGoRqlQMXQwInHRstn1io70goAKLLBa/fzBd5dbdPl3GN4K5aqJPeTDklRG12OoZ6D
         AT8BMkKFCxzEcXO4ed08cn/KHRMT5sdCtzwVcDCJ8XcQs1B3UU/QDmVtKafXwQl3rPLv
         So2FMdzCmG3XUTSTpw42l0BAsWhPhxLK3r43/8YSIuxS2IsctGUh2wwFK2q1CZUQj/T3
         27kA==
X-Gm-Message-State: APjAAAVvZAk90w2ezc1UHjltCin8WdkrvLoDLviRVMTKPowxIeSCf1i8
        4zX2NKEUSfJKCxZzHuX+Y72nKYNXjUg=
X-Google-Smtp-Source: APXvYqxKlcSIfzTh9cQWJiCGjq9bLJPSn/baQTa9NOrntljRSFBuAiKjXEOi+J81VBweTWXo/78Rtw==
X-Received: by 2002:a05:6000:c2:: with SMTP id q2mr16893594wrx.324.1557337439591;
        Wed, 08 May 2019 10:43:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:edb8:72e0:1074:1d8f:2a88:25e6])
        by smtp.gmail.com with ESMTPSA id k1sm1836630wmi.48.2019.05.08.10.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:43:58 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: fix multiple const * types
Date:   Wed,  8 May 2019 19:43:47 +0200
Message-Id: <20190508174347.13901-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1574a29f8e76 ("checkpatch: allow multiple const * types")
claims to support repetition of pattern "const *", but it actually
allows only one extra instance.
Check the following lines
	int a(char const * const x[]);
	int b(char const * const *x);
	int c(char const * const * const x[]);
	int d(char const * const * const *x);
with command
	./scripts/checkpatch.pl --show-types -f filename
to find that only the first line passes the test, while a warning
is triggered by the other 3 lines:
	WARNING:FUNCTION_ARGUMENTS: function definition argument
	'char const * const' should also have an identifier name
The reason is that the pattern match halts at the second asterisk
in the line, thus the remaining text starting with asterisk fails
to match a valid name for a variable.

Fixed by replacing "?" (Match 1 or 0 times) with "{0,4}" (Match
no more than 4 times) in the regular expression.
Fix also the similar test for types in unusual order.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Fixes: 1574a29f8e76 ("checkpatch: allow multiple const * types")
---
v1->v2
	use a max match {0,4} instead of *, to limit the memory
	used by perl

 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a09333fd7cef..916a3fbd4d47 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -802,12 +802,12 @@ sub build_types {
 		  }x;
 	$Type	= qr{
 			$NonptrType
-			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)?
+			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+){0,4}
 			(?:\s+$Inline|\s+$Modifier)*
 		  }x;
 	$TypeMisordered	= qr{
 			$NonptrTypeMisordered
-			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)?
+			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+){0,4}
 			(?:\s+$Inline|\s+$Modifier)*
 		  }x;
 	$Declare	= qr{(?:$Storage\s+(?:$Inline\s+)?)?$Type};
-- 
2.21.0

