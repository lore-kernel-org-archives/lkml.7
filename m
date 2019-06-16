Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E05C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4B42087F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="bSbCWQu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfFPXPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:15:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33714 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfFPXPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:15:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so4618173pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LisjUcQynEyutHjcXsklrzKxwrxgiMqBcx84t9sp8SU=;
        b=bSbCWQu24OBmXvfrVDwrOpERHEraXzWyIGcgWvqTNuBUz3F6XNDkGYw6KIxUUjB+KP
         9F95IzONT3TCxeU9+CSpsYO3e/BEqD9x0UOLCeLE1W4KksJmc3/wd2bzehVMBxLyb8rh
         UkXpRFKKudx0vRvHfyfTxT5oZj0U0Gq07yTVW6wRDPrvdg+ziz/H9P1iPPIy4pBnvaJw
         elOjdHJyDuCt9q9AXVk2akJ2yy2tI0lHqth8TO6JXjFez3ZTSB674DeemzcmlEjsyJAC
         Zt//0BcxFt63Q2EiEq9nL+pEExLC8akAGnIzvcgJ6OT1Cyeyuk25uvdYgxGPX13fFv/Z
         e0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LisjUcQynEyutHjcXsklrzKxwrxgiMqBcx84t9sp8SU=;
        b=PNvFSBZy7e4t8rbern3goIpwjn9R5lVl6l9UV3HccZNbOZ4I/qxG0ptZxKOI4XGZPg
         PRcuBZYvDSkpjV0Wtb7QJz8CsALamBeivJZ3lDAU9HLybuAKzYXEquiA8RmJ55HCwjzA
         9FYAFknr0Z8cS5zZrlQS/WbXFAon44mW90utMr4egpcyg9YdTmkuIrLhF0oN8hdsMlLG
         G3NCo8cWFy5EdeeMlKfnsYdCmRgz17bX53IBd7tIEH3Mdm2bCbFVDYBFhH7m0eCGsO4B
         LuDZEgdh4BbkVe+Z3vgsa13WMOKIrksyAMyDzo52nkfz/IhDpG+3xQymKEd8z4rzOpIA
         uGcg==
X-Gm-Message-State: APjAAAWZ40gc9jI1EmeSBC1HIZ3rSEwfpQrQkn84RS+wHT98d1JJHaNX
        wwc4aCBrjYXTWTX3Icj2xTaoaQ==
X-Google-Smtp-Source: APXvYqyrwfghEFvC2DlBNDu9ly6M2Y9AECBryhe5iiG4xbRkvU7M9Al8iNwtfCFJuAgdZ9VAFWE+0g==
X-Received: by 2002:a62:4e48:: with SMTP id c69mr88327597pfb.176.1560726901504;
        Sun, 16 Jun 2019 16:15:01 -0700 (PDT)
Received: from localhost ([2601:647:5180:35d7::cf52])
        by smtp.gmail.com with ESMTPSA id d13sm7446684pjs.32.2019.06.16.16.15.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 16:15:01 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        elftoolchain-developers@lists.sourceforge.net
Subject: [PATCH 1/2] objtool: Rename elf_open to prevent conflict with libelf from elftoolchain
Date:   Sun, 16 Jun 2019 16:14:59 -0700
Message-Id: <20190616231500.8572-1-mforney@mforney.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 tools/objtool/check.c | 2 +-
 tools/objtool/elf.c   | 2 +-
 tools/objtool/elf.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..6ed46c36c54f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2407,7 +2407,7 @@ int check(const char *_objname, bool orc)
 
 	objname = _objname;
 
-	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_open_path(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
 		return 1;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index e99e1be19ad9..4116f564a0b0 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -401,7 +401,7 @@ static int read_relas(struct elf *elf)
 	return 0;
 }
 
-struct elf *elf_open(const char *name, int flags)
+struct elf *elf_open_path(const char *name, int flags)
 {
 	struct elf *elf;
 	Elf_Cmd cmd;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index e44ca5d51871..c59100d243ac 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -74,7 +74,7 @@ struct elf {
 };
 
 
-struct elf *elf_open(const char *name, int flags);
+struct elf *elf_open_path(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
-- 
2.20.1

