Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFA8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D721019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS4Slwo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfEWKZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:25:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36753 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:25:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id j187so5194475wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhXKgTFg9TGyapt/Wg0K0EHXXYsIVuNn8IRint8KwaY=;
        b=hS4Slwo3RwY1NewVpLWNl2+kR4blGJ/6yaEYtj7DsYTFV147VMXN4gUbn3wgwf5Wxx
         rvn5sSr0yAN3RWEOyb7cGkMlcsGyvJtvcOB2LvmU8egwtW8DsswH3UivToQL+mEZ74KW
         h+7Omca6Qfc8iGh/gi2UIizPRlgBtn20xP9sk3CgwzB6KDL/mnlgj9R/T5d0MAPLjG34
         o/EPZ/9izbLqwIVYLKuA8Ie8YUbi3Y8izlvmcTftUCeRI9bQ5cLaWZWSTL9pXhi2F0lW
         iBN+DR1qawy45dymIxfjZxaGMIjdsYZqVQtIl/Jl1OjXADQwjFU5UXvm+vMgbocHA+i9
         3dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jhXKgTFg9TGyapt/Wg0K0EHXXYsIVuNn8IRint8KwaY=;
        b=LsxpWoH7DqzIOTgJM9ghpzPDnKYwO7r3v7Bxt2pfEEhzj21ZsKCI1M2crUgRRHcgIW
         d3f8Mzsiw/B0XOkDq8VGcoyIC/qZwSyT9Cj8J1sisHO7l2stzJGQr4RWtmT8LIV0v1l4
         HDHJtpS5YkLBC8FFHfrwPhOygnM4/9sOlfVhs2FaSgTrxw2uXLG557Jy3QXl4BVcFOXx
         Y9AvUS8wsrFRJ6o4JvYXiNiS3Oxnb1eJHLYoZeVOQWKtwiYwqta8VzpMYn3SxtCAEAn8
         z6nuxKc+W2MQNbSaubHOkBK/gTJaq4NaUDfCcvT2JR7hy7HxIZ0FkzfBvGbY4eEpDG1F
         WtMA==
X-Gm-Message-State: APjAAAWST8YkGATJj8Nn9hGNP9zi0vEFHm70omdRZXt1L81O/qvV4MFQ
        eLxwRGsxGMdgDSDOVJC0r88=
X-Google-Smtp-Source: APXvYqy6AZ8N3abqshqgIWcdkAkzE2sYArWIM4dCqSpWjtdBCh4+BA62g62qbgTWHlJU1efLcQhTWg==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr10567550wmo.13.1558607124467;
        Thu, 23 May 2019 03:25:24 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id s11sm51472858wrb.71.2019.05.23.03.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 03:25:23 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id AC4D21146DCB; Thu, 23 May 2019 12:25:22 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?powerpc:=20Remove=20variable=20=E2=80=98path?= =?UTF-8?q?=E2=80=99=20since=20not=20used?=
Date:   Thu, 23 May 2019 12:25:20 +0200
Message-Id: <20190523102520.20585-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit eab00a208eb6 ("powerpc: Move `path` variable inside
DEBUG_PROM") DEBUG_PROM sentinels were added to silence a warning
(treated as error with W=1):

  arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set but not used [-Werror=unused-but-set-variable]

Rework the original patch and simplify the code, by removing the
variable ‘path’ completely. Fix line over 90 characters.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/prom_init.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7edb23861162..f6df4ddebb82 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1566,9 +1566,6 @@ static void __init reserve_mem(u64 base, u64 size)
 static void __init prom_init_mem(void)
 {
 	phandle node;
-#ifdef DEBUG_PROM
-	char *path;
-#endif
 	char type[64];
 	unsigned int plen;
 	cell_t *p, *endp;
@@ -1590,9 +1587,6 @@ static void __init prom_init_mem(void)
 	prom_debug("root_size_cells: %x\n", rsc);
 
 	prom_debug("scanning memory:\n");
-#ifdef DEBUG_PROM
-	path = prom_scratch;
-#endif
 
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
@@ -1617,9 +1611,10 @@ static void __init prom_init_mem(void)
 		endp = p + (plen / sizeof(cell_t));
 
 #ifdef DEBUG_PROM
-		memset(path, 0, sizeof(prom_scratch));
-		call_prom("package-to-path", 3, 1, node, path, sizeof(prom_scratch) - 1);
-		prom_debug("  node %s :\n", path);
+		memset(prom_scratch, 0, sizeof(prom_scratch));
+		call_prom("package-to-path", 3, 1, node, prom_scratch,
+			  sizeof(prom_scratch) - 1);
+		prom_debug("  node %s :\n", prom_scratch);
 #endif /* DEBUG_PROM */
 
 		while ((endp - p) >= (rac + rsc)) {
-- 
2.20.1

