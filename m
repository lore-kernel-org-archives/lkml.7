Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4114CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2ED420659
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CkwdYGQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfJ2WsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:48:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41763 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfJ2WsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:48:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id t10so16554plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 15:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0G08DVDmHHpYBvqrNiRz2P/EWIDmTXItkvaTB27EiyI=;
        b=CkwdYGQthHbjeB7YJk2k7oOQyekpKWhBz8LE56+eFTTP9mqZeL9MuGgiv2GrcLSaBg
         rE2sCuLvAVGnNCs4vowlSz50Su8Mv9l48u1zbUbe4ZDaypaV5WsadZZAOOcYYKfOmOIf
         EmLxn+hz5Gpaz6QM1cM8GcO4kjJgDDwECBfv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0G08DVDmHHpYBvqrNiRz2P/EWIDmTXItkvaTB27EiyI=;
        b=GgSWVs6KmXZuctr4eoJuoF2FALypQGul1KAljHXc+NmGEkw7hsqvTg+YNeF/Ykv5g6
         gq4jGvehpM+ZG33g1SIvqfMac+hYto1vS9Hh9PYV94rYL9pGDYRDg7oE5VpKE4AfhcTa
         qtgrr0yygflCZ3KzRbVcBBVtegEVEr00k/9Ydy1peLiIKNOxpSrZFYyHll0rS8HCn8p0
         Vt3nTsTcKYcpw6Bx2JXcQE32pLgUTTbsyAwtkBKPvo4OOoR4lbD2Ywes+yMuPhujWbcW
         X0pDe3Iz42nCnjX0tg6Z9NTp5yRGLisrBpSSc70dfoptAGFoQzSg4NUURnm1sP3++z50
         ONEw==
X-Gm-Message-State: APjAAAWu5AgXaFhZHcKH5fCTmtPpUfEBca+0Fke/czSXzGnbBVTepSlH
        67KBzZ6H6uvTVskiW5Uuq6ZcBg==
X-Google-Smtp-Source: APXvYqy6v7l6MhB+p5gWacT10BGV47R2lNIZI3D56QBZanDs4YzchO4lyFefyJjvfINrgcE9a5Si7A==
X-Received: by 2002:a17:902:b091:: with SMTP id p17mr1086640plr.13.1572389286296;
        Tue, 29 Oct 2019 15:48:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e7sm254020pgr.25.2019.10.29.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:48:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] linux/stddef.h: Add sizeof_member() macro
Date:   Tue, 29 Oct 2019 15:47:55 -0700
Message-Id: <20191029224756.28618-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029224756.28618-1-keescook@chromium.org>
References: <20191029224756.28618-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

At present we have 2 different macros to calculate the size of a member
of a struct: FIELD_SIZEOF() and sizeof_field(). As a prerequisite to
bringing uniformity to the entire kernel source tree, add sizeof_member()
macro as it is both more pleasant (not upper case) and more correct
(sizeof()-family cannot operate on bit fields; this is meant to operate
on struct members), as discussed[1].

Future patches will replace all occurrences of above macros with
sizeof_member().

[1] https://www.openwall.com/lists/kernel-hardening/2019/07/02/2

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Link: https://lore.kernel.org/r/20190924105839.110713-2-pankaj.laxminarayan.bharadiya@intel.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h                 | 13 ++++++++++++-
 tools/testing/selftests/bpf/bpf_util.h |  6 +++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 998a4ba28eba..ecadb736c853 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -27,6 +27,17 @@ enum {
  */
 #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 
+/**
+ * sizeof_member(TYPE, MEMBER) - get the size of a struct's member
+ *
+ * @TYPE: the target struct
+ * @MEMBER: the target struct's member
+ *
+ * Return: the size of @MEMBER in the struct definition without having a
+ * declared instance of @TYPE.
+ */
+#define sizeof_member(TYPE, MEMBER)	(sizeof(((TYPE *)0)->MEMBER))
+
 /**
  * offsetofend(TYPE, MEMBER)
  *
@@ -34,6 +45,6 @@ enum {
  * @MEMBER: The member within the structure to get the end offset of
  */
 #define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+	(offsetof(TYPE, MEMBER)	+ sizeof_member(TYPE, MEMBER))
 
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index ec219f84e041..6b4b3e24ba9f 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -31,13 +31,13 @@ static inline unsigned int bpf_num_possible_cpus(void)
 # define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
 
-#ifndef sizeof_field
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#ifndef sizeof_member
+#define sizeof_member(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 #endif
 
 #ifndef offsetofend
 #define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+	(offsetof(TYPE, MEMBER)	+ sizeof_member(TYPE, MEMBER))
 #endif
 
 #endif /* __BPF_UTIL__ */
-- 
2.17.1

