Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC5C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBB92075D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sruffell-net.20150623.gappssmtp.com header.i=@sruffell-net.20150623.gappssmtp.com header.b="DJbXmdHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfIZWZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:25:16 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36510 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfIZWZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:25:16 -0400
Received: by mail-yb1-f196.google.com with SMTP id p23so1401807yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sruffell-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edRQoE0qo3Vju2FjZHUikDVE4Hgnyy4ct+4trIoQN8A=;
        b=DJbXmdHqf/oQZgftq5qa4criW+0nMSKyAQ477zDg+1bIbfqHCaYzn1oBkR8ZzZT3KV
         GpzB51DKIAb/lGRzf97ADzF8iXdk+vQfdpdeSkb0gUyloWagOXdGhRsUMuW82nAY2TLI
         Amiedz1q4zkcSqjV/WXCRphlWiG0KupEJzDg2wUyRxwAHU8M2YmOlFZRxo9yzRKsZlDi
         xUtwrOUAMJ27M/g5QxX809v+XovpVLiU7DX8L5kgo4bJb9BveBArVNFvQk656iBn7C4Q
         1tcJCLI9IS6/gWEZ4ld54EiTG1OPJFFIz1C659IdZ6Feob98PGwxGLaVHxdXynWVqWzv
         NiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edRQoE0qo3Vju2FjZHUikDVE4Hgnyy4ct+4trIoQN8A=;
        b=iRoWSVFaF6DUvrAZXwW3dFc2mPc84WKZwd+ORB1WOM3RmCIgqtvDs7Ad5aNBlUyxib
         DAhZwXkEh4OPP01zemK/8zda5lvruJbRMCmMbbygWjuPjyppkTeUiQEfcGWfXsMFX40h
         WoKtpkroCAAhv7jjBcB0ucjEMXsAhCswBlQ+4iVDThbIrvl4BjDbnsH36aArdtJshWYD
         X1Lv/RD5QJhYoFf+f+KUgnn1g7UqxCY9e9xoSs9ik9YIdb62Z89jk28K7HH9bynZWSYd
         QTanjU29dIAcam5ApqWf2ZhDShKYREhTCxDDYN2tLYKzvL43wT7wx5+ZCadv+nXyqo/+
         6e6g==
X-Gm-Message-State: APjAAAVb7++PySm29jGUKog3mD9A6vdasoT0eq+o4dYi1x78CRRZBamj
        2jGB1XyqvigpqOT5J3C8BUcx6hJ8lgWF
X-Google-Smtp-Source: APXvYqzeuqw6VtM+KJGIqC2RGPrkjwniSJpt+4JSPvMCFPK0xX12la9mjDYU5fIUtvhV6WKF/VslMQ==
X-Received: by 2002:a25:8e0c:: with SMTP id p12mr3725527ybl.254.1569536714942;
        Thu, 26 Sep 2019 15:25:14 -0700 (PDT)
Received: from sruffell-newdesktop.sruffell.internal ([136.53.91.217])
        by smtp.gmail.com with ESMTPSA id s1sm139525ywa.67.2019.09.26.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 15:25:14 -0700 (PDT)
From:   Shaun Ruffell <sruffell@sruffell.net>
To:     linux-kernel@vger.kernel.org
Cc:     Shaun Ruffell <sruffell@sruffell.net>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] modpost: Copy namespace string into 'struct symbol'
Date:   Thu, 26 Sep 2019 17:24:46 -0500
Message-Id: <20190926222446.30510-1-sruffell@sruffell.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906103235.197072-5-maennich@google.com>
References: <20190906103235.197072-5-maennich@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building an out-of-tree module I was receiving many warnings from
modpost like:

  WARNING: module dahdi_vpmadt032_loader uses symbol __kmalloc from namespace ts/dahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
  WARNING: module dahdi_vpmadt032_loader uses symbol vpmadtreg_register from namespace linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
  WARNING: module dahdi_vpmadt032_loader uses symbol param_ops_int from namespace ahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
  WARNING: module dahdi_vpmadt032_loader uses symbol __init_waitqueue_head from namespace ux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
  ...

The fundamental issue appears to be that read_dump() is passing a
pointer to a statically allocated buffer for the namespace which is
reused as the file is parsed.

This change makes it so that 'struct symbol' holds a copy of the
namespace string in the same way that it holds a copy of the symbol
string. Because a copy is being made, handle_modversion can now free the
temporary copy

Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthias Maennich <maennich@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Shaun Ruffell <sruffell@sruffell.net>
---

Hi,

I didn't test that this change works with the namespaces, or investigate why
read_dump() is only called first while building out-of-tree modules, but it does
seem correct to me for the symbol to own the memory backing the namespace
string.

I also realize I'm jumping the gun a bit by testing against master before
5.4-rc1 is tagged.

Shaun

 scripts/mod/modpost.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3961941e8e7a..349832ead200 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -364,6 +364,24 @@ static const char *sym_extract_namespace(const char **symname)
 	return NULL;
 }
 
+static const char *dup_namespace(const char *namespace)
+{
+	if (!namespace || (namespace[0] == '\0'))
+		return NULL;
+	return NOFAIL(strdup(namespace));
+}
+
+static bool is_equal(const char *n1, const char *n2)
+{
+	if (n1 && !n2)
+		return false;
+	if (!n1 && n2)
+		return false;
+	if (!n1 && !n2)
+		return true;
+	return strcmp(n1, n2) == 0;
+}
+
 /**
  * Add an exported symbol - it may have already been added without a
  * CRC, in this case just update the CRC
@@ -375,7 +393,7 @@ static struct symbol *sym_add_exported(const char *name, const char *namespace,
 
 	if (!s) {
 		s = new_symbol(name, mod, export);
-		s->namespace = namespace;
+		s->namespace = dup_namespace(namespace);
 	} else {
 		if (!s->preloaded) {
 			warn("%s: '%s' exported twice. Previous export was in %s%s\n",
@@ -384,6 +402,12 @@ static struct symbol *sym_add_exported(const char *name, const char *namespace,
 		} else {
 			/* In case Module.symvers was out of date */
 			s->module = mod;
+
+			/* In case the namespace was out of date */
+			if (!is_equal(s->namespace, namespace)) {
+				free((char *)s->namespace);
+				s->namespace = dup_namespace(namespace);
+			}
 		}
 	}
 	s->preloaded = 0;
@@ -672,7 +696,6 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 	unsigned int crc;
 	enum export export;
 	bool is_crc = false;
-	const char *name, *namespace;
 
 	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
 	    strstarts(symname, "__ksymtab"))
@@ -744,9 +767,13 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 	default:
 		/* All exported symbols */
 		if (strstarts(symname, "__ksymtab_")) {
+			const char *name, *namespace;
+
 			name = symname + strlen("__ksymtab_");
 			namespace = sym_extract_namespace(&name);
 			sym_add_exported(name, namespace, mod, export);
+			if (namespace)
+				free((char *)name);
 		}
 		if (strcmp(symname, "init_module") == 0)
 			mod->has_init = 1;
-- 
2.17.1

