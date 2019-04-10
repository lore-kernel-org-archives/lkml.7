Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E521741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbfDJPvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:51:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387491AbfDJPvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:51:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74EC430B32F0;
        Wed, 10 Apr 2019 15:51:10 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F33B110A180;
        Wed, 10 Apr 2019 15:51:09 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 4/9] livepatch: Add klp-convert annotation helpers
Date:   Wed, 10 Apr 2019 11:50:53 -0400
Message-Id: <20190410155058.9437-5-joe.lawrence@redhat.com>
In-Reply-To: <20190410155058.9437-1-joe.lawrence@redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 10 Apr 2019 15:51:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Define macros KLP_MODULE_RELOC and KLP_SYMPOS in
include/linux/livepatch.h to improve user-friendliness of the
livepatch annotation process.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Joao Moreira <jmoreira@suse.de>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 include/linux/livepatch.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 16b48e8b29a2..947cfc2d1980 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -236,6 +236,18 @@ void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
 void klp_shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor);
 void klp_shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor);
 
+/* Used to annotate symbol relocations in livepatches */
+#define KLP_MODULE_RELOC(obj)						\
+	struct klp_module_reloc						\
+	__attribute__((__section__(".klp.module_relocs." #obj)))	\
+	__attribute__((aligned (4)))
+
+#define KLP_SYMPOS(symbol, pos)						\
+	{								\
+		.sym = &symbol,						\
+		.sympos = pos,						\
+	},
+
 #else /* !CONFIG_LIVEPATCH */
 
 static inline int klp_module_coming(struct module *mod) { return 0; }
-- 
2.20.1

