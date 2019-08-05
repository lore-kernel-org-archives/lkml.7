Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75AC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C92720880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtpyPKBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfHEMWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:22:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42571 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:22:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so36457743plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4dmv+a7M10+vcMcRGJokNUoylYUqcGnL45osAB1FuE=;
        b=jtpyPKBEVrMUIfDD5ScmDJwXPy1WGC6QvtVv3lgtPxU7XVr9sai//cOmH2ONrRAQAX
         LSuZ3w5N3daJWEsEd0tXYZ9uRQB0BiNj7MvocZ5K+UDJxwftxlehae0/lB+yJ8B7HR9g
         uB3aCFljol4mrXt52dvhqbb8UK0l9nzpy3Z7VVJCbDuPjdFgkqFuZzygJYhYJDcvNox2
         6qBBXrzYiR4znXUO4mO6xidXqqFK6t551QKvxLDj6PJg4iHxr4SXbbuOqKDGXhvHgxhb
         2wuHZU3lUFnu5pAKWe1U5GG9a99X+YH1PiYzPNqk5FeOTmA7ZNBEZ7IuOnrefu9LezlM
         W9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4dmv+a7M10+vcMcRGJokNUoylYUqcGnL45osAB1FuE=;
        b=AuMGlM2UQcFEMd3FVBy8EzmI8POmb8SpKA7FZKm8COFBfjUU+H/EW0N5Nh+VvNBoIq
         hgbwOO6the/aEGagFkd8DiTrEVn24IVQDvZtkUhN9DKLTdafoGQweXHNVtOZWB4qqWxO
         U9XPcQP10FuVUDzg2quMt1wWKjXy1BZHUWA/ua7IP1j8m2DYWySKk+d0OCm3aNRf7Lun
         lF1H2fWxyzxk+rdM6PdkvROxQX1DO+36Z0/mk02uzlcDyCD24m9O8WZFZVAEHNhBBi1z
         Pcc5VQ84LouNHapdmPgvPC3E8cZ/lD0PfYTYXXvFaTkb71jImWOhcXGufgaPZ+u5WrFM
         Iw3A==
X-Gm-Message-State: APjAAAWDlesByBUNl4Rp9C9WR/nH/C2kk364rMy5vqxyJ/kerLhuP4Qo
        GqAEcKaukNpX4Aia+jsq78UFOG0grKkNKg==
X-Google-Smtp-Source: APXvYqwWsWbFfXOUDKcJQgreRMkuSWb6fnqiCq5whJuAgwTIEFMjf9uLwbjbY8VQYkrH4/a03hRxlQ==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr146699397plp.18.1565007761834;
        Mon, 05 Aug 2019 05:22:41 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id u134sm81795363pfc.19.2019.08.05.05.22.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:22:41 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 2/8] module: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:22:34 +0800
Message-Id: <20190805122234.12932-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Revise the description.

 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 5933395af9a0..7defa2a4a701 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2251,7 +2251,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 		switch (sym[i].st_shndx) {
 		case SHN_COMMON:
 			/* Ignore common symbols */
-			if (!strncmp(name, "__gnu_lto", 9))
+			if (str_has_prefix(name, "__gnu_lto"))
 				break;
 
 			/* We compiled with -fno-common.  These are not
-- 
2.20.1

