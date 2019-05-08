Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B5C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A942054F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWKUGvcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfEHM1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:27:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55947 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfEHM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:27:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id y2so3020072wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRwIoLbrgaDyISJQ98nmN4m412SakVoeJ2YGFQFGJt4=;
        b=YWKUGvcARHmGtsDe2IWIy61tBAYUIlR0q/ANHxzU6qjDl15roJ6/YwNTeUX+l7Q7q3
         PmSeV/Akcczpov3+tiMh1P5FzRQCplb+OGeMlK2SvPwAD92aCBR7jAUlpQL7Gyohs4EC
         dxrlhbn+sarCAXqzN9bb5/DbTfjpvmZH9r/vckPyz/J/fJOolo0kL/jdnbdVcoUK4dB1
         FaUhpyDXSuvUBt+MFGR4MFs894FJgYPlkjfZyalCvAOQ7E/9ot8MnLpkjtHewTe+0DAk
         MJtxnQV0GTFred3OY8w98mXS5BbUy+uLgwzlZkSiJUO0Gg3F2MIAGGfbDP49k8TP8sqW
         6LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRwIoLbrgaDyISJQ98nmN4m412SakVoeJ2YGFQFGJt4=;
        b=PNGVD9vHN8ucWoYHcKA7BmiYDiBjHDx49Rfa7ZbOUrLdRZynhsV/g78VC209kLt0Hf
         5qaSAragOHzLhlolKoZfbvyYFr+yb+sFqiR/d0yoOPLpMccAOma6RnWaF76IEsKfjBmi
         Et8oXvEbv+3xP2qumtk/rAfJaZ6OLdhXCx4BOhpWcLoiI53i4hhvzqByKCdvtxE4Wq7v
         lxAJn6X7f1Fu1xsQ/opTXzWKKTansZTv7m1NM2daBtpULQ4EiU+Z2VtMfrLesW07qL2r
         BL5mJFPdZp4jcqXYSAZUEK832+WZIgH+J3uD0KRPTnPNewnCmB3b37OgVpyMKvGL9Gkd
         ni0A==
X-Gm-Message-State: APjAAAUdSefmU2j8dzcF9ww4muSoZDPZNgHbFKdTjsVt1exLMejIfn1r
        vebRq6SdDfqrQu8ZxZIFkhw=
X-Google-Smtp-Source: APXvYqy1B6/gkTa6VX/rG0RBzoMV6JSWsgD6HaG3ALo1mbynQx3Wa8FLzmaz4R6u2KJtsIbjDbfEWw==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr2970183wmq.144.1557318454378;
        Wed, 08 May 2019 05:27:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:edb8:72e0:1074:1d8f:2a88:25e6])
        by smtp.gmail.com with ESMTPSA id s124sm3217737wmf.42.2019.05.08.05.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 05:27:32 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] checkpatch: fix multiple const * types
Date:   Wed,  8 May 2019 14:27:18 +0200
Message-Id: <20190508122721.7513-1-borneo.antonio@gmail.com>
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

Fixed by replacing "?" (Match 1 or 0 times) with "*" (Match 0 or
more times) in the regular expression.
Fix also the similar test for types in unusual order.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Fixes: 1574a29f8e76 ("checkpatch: allow multiple const * types")
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a09333fd7cef..f40d4bb2fbb9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -802,12 +802,12 @@ sub build_types {
 		  }x;
 	$Type	= qr{
 			$NonptrType
-			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)?
+			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)*
 			(?:\s+$Inline|\s+$Modifier)*
 		  }x;
 	$TypeMisordered	= qr{
 			$NonptrTypeMisordered
-			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)?
+			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)*
 			(?:\s+$Inline|\s+$Modifier)*
 		  }x;
 	$Declare	= qr{(?:$Storage\s+(?:$Inline\s+)?)?$Type};
-- 
2.21.0

