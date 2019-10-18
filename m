Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C86E21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua0IlvQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409762AbfJRJcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:32:04 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:32862 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409752AbfJRJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:32:03 -0400
Received: by mail-wm1-f73.google.com with SMTP id r187so4707925wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VWGgVtR20by6j5rWakK1xLjIPHuT7TbYDPbUDce3jrs=;
        b=Ua0IlvQYhxOOW8wlwRn+1w0mDAE59j1sHlig/IMGI74mwajHhYIjQ9GKXDeOOyTgSZ
         ZGl7isYwxCBZtNDYo1vf+29g/OCYPgiD98wV9UE0KnFfyXsQoX6Zbt8Ak9nnFy+/X4AH
         CPZMiK3s2JYPYvDDU5WrDeu0S0G2hho5YKlZC9/vN9X50jfxqM+EmkZ9Erfzz1GjuVWg
         59KXAHzuI2yp1hSPgTO6MZGoZjfN2N48kYPenYgZr1Thv0lsOfs372ZBQKuLTpc9NyDl
         wajPxgxdjn1brnWwhIHvTcQyQxzG6fYrKMqKr7i0VfHVi3NfZXaxG8Xi3IFY+uG3O6Qn
         ADIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VWGgVtR20by6j5rWakK1xLjIPHuT7TbYDPbUDce3jrs=;
        b=rZCM4XAgI49wIYI6LiSfET762flsMbr4DhBsgmCerN1S15tMko9dN0f4cW9HO0ufbs
         N+pucjxdm6MPrDnvvFL3mQZEsnAfcPj2aLlxds9avDAd7j2/D9T5GsaGSyW/mPDmRszj
         tbC2L9pprVqK34glH3VPpgSsTl2HvNmYEeb4pY+6LTw51fikGO7ZML+Y0lylZDXP4yZ0
         +LqFDoScUijuu7Chy+y9d0yY1F8wgzlgiNwUEfGTiRSAiitPNp/oszQVlOdTy/oZb8fM
         uFpGsT7TBQ9wI02UgcpBm2OmZ7lqy/V2QhZyCClq2CG0nv9yiTzIwW+c6hEo2bVlKrLz
         0Iug==
X-Gm-Message-State: APjAAAXWuToyj0TpIS+MnKFNrNlyqRegZ8MVEuDVefn32rlBOyYuAIsq
        5FrETLa7kBQE2zldKkiTmyBiu5sOEImwW7pGS28HjsskMBm66riYrAjQQtapflzED3wPEl+wlBt
        cK5YQzkAN9zmSPMUjoiM4LtgofZLxcJT0sk8HMPKQoV6Q50nJGJDipOT+FN06FbjJQSjHRNBLke
        c=
X-Google-Smtp-Source: APXvYqys3kM1GQPDID5IamEIJmq2t+9rGBLKuJ1Nxz6Q9/oGyOyyywzsfxCxcMrStAkX4m3Nn3FWNdhhUwceLA==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr7076584wrj.345.1571391119582;
 Fri, 18 Oct 2019 02:31:59 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:31:40 +0100
In-Reply-To: <20191018093143.15997-1-maennich@google.com>
Message-Id: <20191018093143.15997-2-maennich@google.com>
Mime-Version: 1.0
References: <20191010151443.7399-1-maennich@google.com> <20191018093143.15997-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 1/4] modpost: delegate updating namespaces to separate function
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

Let the function 'sym_update_namespace' take care of updating the
namespace for a symbol. While this currently only replaces one single
location where namespaces are updated, in a following patch, this
function will get more call sites.

The function signature is intentionally close to sym_update_crc and
taking the name by char* seems like unnecessary work as the symbol has
to be looked up again. In a later patch of this series, this concern
will be addressed.

This function ensures that symbol::namespace is either NULL or has a
valid non-empty value. Previously, the empty string was considered 'no
namespace' as well and this lead to confusion.

Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 scripts/mod/modpost.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4d2cdb4d71e3..dbfa3997136b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -362,6 +362,25 @@ static char *sym_extract_namespace(const char **symname)
 	return namespace;
 }
 
+static void sym_update_namespace(const char *symname, const char *namespace)
+{
+	struct symbol *s = find_symbol(symname);
+
+	/*
+	 * That symbol should have been created earlier and thus this is
+	 * actually an assertion.
+	 */
+	if (!s) {
+		merror("Could not update namespace(%s) for symbol %s\n",
+		       namespace, symname);
+		return;
+	}
+
+	free(s->namespace);
+	s->namespace =
+		namespace && namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
+}
+
 /**
  * Add an exported symbol - it may have already been added without a
  * CRC, in this case just update the CRC
@@ -383,8 +402,7 @@ static struct symbol *sym_add_exported(const char *name, const char *namespace,
 			s->module = mod;
 		}
 	}
-	free(s->namespace);
-	s->namespace = namespace ? strdup(namespace) : NULL;
+	sym_update_namespace(name, namespace);
 	s->preloaded = 0;
 	s->vmlinux   = is_vmlinux(mod->name);
 	s->kernel    = 0;
@@ -2196,7 +2214,7 @@ static int check_exports(struct module *mod)
 		else
 			basename = mod->name;
 
-		if (exp->namespace && exp->namespace[0]) {
+		if (exp->namespace) {
 			add_namespace(&mod->required_namespaces,
 				      exp->namespace);
 
-- 
2.23.0.866.gb869b98d4c-goog

