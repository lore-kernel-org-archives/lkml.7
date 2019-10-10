Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBCDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8864720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJzkF6Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfJJPQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:16:10 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:46481 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfJJPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:16:07 -0400
Received: by mail-wr1-f74.google.com with SMTP id z17so2902154wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1ARHOj6w9aLyVTJEhzjEUyZm1gwUAbrQST+T57l1TKQ=;
        b=GJzkF6KyMP2v5SqFDiGZJugryBGiWEYtoB5Op7MJqsvBGEf1CmHYnQ8lhAWb8rJ5eH
         U1d3KEhCjV9KKwOYgyXJQ2FjPpDgWhGPRsjzCi3CjTkjf/j+DfstrQNGUtEhO5IanBNo
         TN2iZtJvoFLSVDwtNDfXGsg2Sjjf8e8rdF9pQX1efteHrrB4z1Q77M9PFWlabzr0lrtv
         t7GYMczsCoi8TkgZrhAud5IwHrAmQbSwfT6b7CIJESHL3/S1vbL1e14GevU22E0Ls6Ha
         Aq6QXeBCZ+dmN+V/1MsQONiaamFlStqgk0h2VdqlLhl5jF25igC9mEzhrdhI+yPbiTXr
         bOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1ARHOj6w9aLyVTJEhzjEUyZm1gwUAbrQST+T57l1TKQ=;
        b=Z4Iv8jDfGphaVRjR8MvExS1mY2VZ6t73XOxQqBBynVxMvwoBI7L6Vv9IGay+v8vbpC
         av0W8Kwxbu00zwWE2+dIBJPcM4840otYwLwMUoroc7e688XMDhsmko+D83m9yXIVMnsb
         yZOD5MHnvmqx6/K9QmwuN2A7GWji+e7KJ6/DluLsLAX8FHHtkpC0fHWjGgvgI6DopFch
         9QiSiQbs8yNqz+V+V6+/rVn4XSQmCfYwwkfL1PJ+DOtb9zWJrQMNJJdHx72BzGo4RWdd
         WhWbxmEDDZW+Ev8CPwtB+t6Tb/3Lcu07EjHHhH/hFZHjOXT9e8sH/sC+9k/aXGq4GL4x
         1aaw==
X-Gm-Message-State: APjAAAVh67JSI1gyawdVHxCAZUquwyYOdUewjONRYldpz1j6Vg7WQ548
        jyho7rBioc9LNR4fz76w2zD4y3EaR8aM+uICvr+MISQmEYgeDEouCOy8n4DnRzWn9eAmbZ5pKwk
        qRF6Uy6y4Zf4L1TQ9Hl2QhIIVOHeR63vRVca11lL+JChAof6hfrzQS2qvHkx9xVyMDCWLtsASkQ
        c=
X-Google-Smtp-Source: APXvYqyLuvisTP6JI3eALfLl1SscfJp8IEhzE6/QbZAsoJJkpvtr4f8EkjksGu0SFkAYCwb3cUbZwM1xdQ7ydQ==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr8853717wrx.319.1570720566104;
 Thu, 10 Oct 2019 08:16:06 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:14:41 +0100
In-Reply-To: <20191010151443.7399-1-maennich@google.com>
Message-Id: <20191010151443.7399-3-maennich@google.com>
Mime-Version: 1.0
References: <20191010151443.7399-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 2/4] modpost: make updating the symbol namespace explict
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Shaun Ruffell <sruffell@sruffell.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the symbol namespace of a symbol within sym_add_exported feels
displaced and lead to issues in the current implementation of symbol
namespaces. This patch makes updating the namespace an explicit call to
decouple it from adding a symbol to the export list.

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 scripts/mod/modpost.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9f5dcdff4d2f..46137b730447 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -382,8 +382,8 @@ static void sym_update_namespace(const char *symname, const char *namespace)
  * Add an exported symbol - it may have already been added without a
  * CRC, in this case just update the CRC
  **/
-static struct symbol *sym_add_exported(const char *name, const char *namespace,
-				       struct module *mod, enum export export)
+static struct symbol *sym_add_exported(const char *name, struct module *mod,
+				       enum export export)
 {
 	struct symbol *s = find_symbol(name);
 
@@ -399,7 +399,6 @@ static struct symbol *sym_add_exported(const char *name, const char *namespace,
 			s->module = mod;
 		}
 	}
-	sym_update_namespace(name, namespace);
 	s->preloaded = 0;
 	s->vmlinux   = is_vmlinux(mod->name);
 	s->kernel    = 0;
@@ -761,7 +760,8 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		if (strstarts(symname, "__ksymtab_")) {
 			name = symname + strlen("__ksymtab_");
 			namespace = sym_extract_namespace(&name);
-			sym_add_exported(name, namespace, mod, export);
+			sym_add_exported(name, mod, export);
+			sym_update_namespace(name, namespace);
 			free(namespace);
 		}
 		if (strcmp(symname, "init_module") == 0)
@@ -2469,12 +2469,12 @@ static void read_dump(const char *fname, unsigned int kernel)
 			mod = new_module(modname);
 			mod->skip = 1;
 		}
-		s = sym_add_exported(symname, namespace, mod,
-				     export_no(export));
+		s = sym_add_exported(symname, mod, export_no(export));
 		s->kernel    = kernel;
 		s->preloaded = 1;
 		s->is_static = 0;
 		sym_update_crc(symname, mod, crc, export_no(export));
+		sym_update_namespace(symname, namespace);
 	}
 	release_file(file, size);
 	return;
-- 
2.23.0.581.g78d2f28ef7-goog

