Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6042EC2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370D922314
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="CuenhOgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfLSAgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:36:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38884 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSAgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:36:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so2167714pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sxbAlXpABK/W64yfjeUTt7MDV8jfwT8E3maFR+CaL8=;
        b=CuenhOgJpQr2nu4AdM2tW86k5v6/hCnF0GhwIuOz0ouFzJzdbtXuJyD22YYHOifcsJ
         9W5/842eIyhsVN7iaHJG1xs6VB1GSSQxmEgwvBfOXay9yRhrOifUNgCwX4EgHgcQ8jkh
         NqI+TkWQOjH0NbVXQy47gLC+t5Dz4QizhrJQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sxbAlXpABK/W64yfjeUTt7MDV8jfwT8E3maFR+CaL8=;
        b=SgiBnOi7lO4Ws1w80B2aRfIV9FrMj404qPZBupwXuKK5aBkylD7ZNQESkP+lox7zeb
         nA1rElHF9WU3wY80Qc9ixs+cad04dKt0gFZZhfSUlqGwY6ImN3n7he/+E1135hKBJRJl
         hyl7jb5G3CFlSdL1lnLyeWf3F4GmFtZp9tEFBfJspkqlKRScO5VnVQ50zFi3Z9Tn3vgE
         EvjkI92maUqtWZzUEsbLWpZuzI7QwFxDyviAZ0qF+rMrBqEiuBR6csRTt5j2M4VV+GQ0
         1W4KfrqXDWaBQmb0pQCcwozUr/N7HplFpBViixEN/tJHT0ZO+pBD3hdOfn6CZowOQtSW
         NKAA==
X-Gm-Message-State: APjAAAU4mCCv4aCtVxBW0MGkOGhBSklaH9ZZtRQO/wcehDCZsCAg+XYo
        Wb/f3qCw3fsJVzjWErEkCjQjkh/6O08=
X-Google-Smtp-Source: APXvYqznKl2qHe3h4t5NRUXtsuhY81bvYVDUMuRyRmPbFQfp/C8Q/PeVNQDr7G+aIxQpiuIiwvtwVw==
X-Received: by 2002:a63:1447:: with SMTP id 7mr6070116pgu.22.1576715805301;
        Wed, 18 Dec 2019 16:36:45 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-b05d-cbfe-b2ee-de17.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b05d:cbfe:b2ee:de17])
        by smtp.gmail.com with ESMTPSA id e16sm4799301pff.181.2019.12.18.16.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 16:36:44 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 2/4] kasan: Document support on 32-bit powerpc
Date:   Thu, 19 Dec 2019 11:36:28 +1100
Message-Id: <20191219003630.31288-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219003630.31288-1-dja@axtens.net>
References: <20191219003630.31288-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/dev-tools/kasan.rst |  3 ++-
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index e4d66e7c50de..4af2b5d2c9b4 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -22,7 +22,8 @@ global variables yet.
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
-architectures, and tag-based KASAN is supported only for arm64.
+architectures. It is also supported on 32-bit powerpc kernels. Tag-based KASAN
+is supported only on arm64.
 
 Usage
 -----
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..a85ce2ff8244
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is not currently supported, but modules
+are.
-- 
2.20.1

