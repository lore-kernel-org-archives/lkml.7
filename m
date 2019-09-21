Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93157C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 11:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DA221882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 11:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLJgXSqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437795AbfIULhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 07:37:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46590 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437746AbfIULhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 07:37:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id e17so9421291ljf.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 04:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBEVpRa3M9pfrSHP02Se6xtzULSWLwMDoZcb3jdctzI=;
        b=cLJgXSqUgHJHwDJXIou+DCTrW8QwpklMCJQ0gQCLvTPkKK9UDWT9WJPiVSKEs31iG9
         cra28zWfv5wmLm+XBIJiIlqxJ7e22/jJiI6GsHWvRhXre4s+Bz+YQ7lQfhKOiaa3rJHm
         TfktS0ZqQKCl+hUdFvkg4NtnOWYMIAGuQ3VYkpkLe7IAWVDDky8ImbYhgp6fHsp8YFSf
         JxDH5eKCb2DOtyFx0WB6icUKVp2M0nwl49L3TaNHQhqT3z0A4b36zzuL8gYCRqKqkNM3
         Zh85g12BjYEElm8FjBJPvjVIlIvdwN7O7FjfmhQ87a8w1g1Skblc1ghjAZLuLSn5EQrz
         pBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBEVpRa3M9pfrSHP02Se6xtzULSWLwMDoZcb3jdctzI=;
        b=FiCASudTzDIri+GuzMVMg34/WYLgjmWs2aWzDgsO86QoLy/7+h5S2PnzPFiDyhFLao
         Zrpv3PgF6uafrY/tSBzwztyh+5lJaRJRLTq8oaERECWiSu/+m96GieYjdbBC/dTTQGVK
         Qjyzm/MESHjMIb86c/I6vgpk33ASP12YJOcGx4MDPoYSjSnRf00Y4A5MgkrbJsCQiiTU
         PGbqPztZ0Z5kyNvnODNyD7+9E5xnbEhhhOXioOhCG0Af4NwKs0VjU+KO62AJMpbiyaVu
         Wi59q/TVuXUdtPnzCfjZ0uGEI5fYB0KLH9rUCuK0Fe8hOJ7SslIESwtSrJOptNWhG/GT
         246Q==
X-Gm-Message-State: APjAAAXGgefCN4Zj6IZNDsHUeYEd12Duf+jcqd/jO5yLboccxC8PFjw1
        9p4lQyb1/wicEml0MsRUFtS7Vi8phEs=
X-Google-Smtp-Source: APXvYqziPq3LAciLzecfIis/fegLiivoFXCL7SoRq13LnWol1wUfK2un9e2lrc9RqqME2M9QVdfMeA==
X-Received: by 2002:a2e:3a06:: with SMTP id h6mr12226404lja.128.1569065853449;
        Sat, 21 Sep 2019 04:37:33 -0700 (PDT)
Received: from pc-sasha.localdomain ([146.120.244.3])
        by smtp.gmail.com with ESMTPSA id o2sm1059219lfl.20.2019.09.21.04.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 04:37:32 -0700 (PDT)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: [PATCH] gen-insn-attr-x86.awk: Fix regexp warnings
Date:   Sat, 21 Sep 2019 14:37:11 +0300
Message-Id: <20190921113711.6255-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the regexp warnings shown below:
  GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator

The ':' and '&' characters need not escaping when used in string constants
as part of regular expressions.

[Test-run]
awk -f /home/sasha/torvalds/arch/x86/tools/gen-insn-attr-x86.awk \
	/home/sasha/torvalds/arch/x86/lib/x86-opcode-map.txt >tmp/inat-tables.c

diff -U0 /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c \
tmp/inat-tables.c; echo $?
0

[Debugging output]
DBG:ext:(66&F2)
DBG:match(ext, ...):(66&F2)
DBG:match(..., lprefix3_expr):\((F2|!F3|66&F2)\)

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 arch/x86/tools/gen-insn-attr-x86.awk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index b02a36b2c14f..a42015b305f4 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -69,7 +69,7 @@ BEGIN {

 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
-	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
+	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
 	lprefix_expr = "\\((66|F2|F3)\\)"
 	max_lprefix = 4

@@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 	return add_flags(imm, mod)
 }

-/^[0-9a-f]+\:/ {
+/^[0-9a-f]+:/ {
 	if (NR == 1)
 		next
 	# get index
--
2.23.0

