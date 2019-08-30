Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1901C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D8C2342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKz8xGKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfH3VsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:48:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37237 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfH3VsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:48:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so9289714qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gdRSBCutQVNtWSzAzPyx1octfk+39c+uxWTd5tKxUbY=;
        b=jKz8xGKFpu+c8nYrAc35wyY7pPoBrGP5xK7ltVDmwY6lBDr8W3PV2fyZpvhtuVrLdw
         EAkWttd27Uh4QFgvLt7qELObeTcwXL96A8pL+NwzzGtaZn/1a4iI1aUEoBh/Dc5lzXfb
         jgzARfKEilEgTU/CMZi4CJB6HJkJ60brtwTX0cgq3WbWGiNl/HCvN2dyh0ePbyrKCnas
         J2EaWMhbke6MU0lLrYfUnTkzKpl/ANGJzTMZgUaWNqamTbSScPAh4NPtZ4rBaM7aw9ZC
         JzLCmHYS1XA0OO31Qnl9T3P7XfvvNRN1gYdkT0TsZ83TaQJDOPkUzraHjussXaNqM8np
         VycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gdRSBCutQVNtWSzAzPyx1octfk+39c+uxWTd5tKxUbY=;
        b=HqWc7tLBRzZCb5MhFYT7D3Ear2U2jTUAsUwEWT4VlYkNGLpiY9EdBpdgkisQrJMMC8
         bTDYzYD4/xhayORZsrkAfpann+9eXFyVExXuanjIjiD0xK4M0mDZOAnu2QsYlISHAPXL
         p9mqRPgZS+jzQ27kMP315+MXSMsHzP8Bm4D36X9icslhCC4lwlnYFEQ2gIgoZsdfVDku
         j9C93/DUxe25YiPwnmtA7SVgTyPUWCU8vgim7kG5qNSD8621Yf+4PtVwfk5c3ZWjbg12
         O/W0csV4Uj4CqupcKGl+YmBcZf/d1VdUUVDz5ANkF87u1grZgdnCPuCVJkQcwkz76zC6
         vIqA==
X-Gm-Message-State: APjAAAUtVJpCjwtTuNgiW5gofF5H2dqRDRbP+zRoxfZUNCVRRs5f1Qpr
        ByPQ3Q38bUyR8Ic09oHTS/S1F8E=
X-Google-Smtp-Source: APXvYqyPtJhIMxl82/ZDva8dZ5twe6IV5MJfZKkw3Jqt5FDzMNrAdWbQMSPfzVrcvK+0fZ/5O32ptA==
X-Received: by 2002:a05:6214:1086:: with SMTP id o6mr11695709qvr.107.1567201680533;
        Fri, 30 Aug 2019 14:48:00 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4sm4857834qtb.17.2019.08.30.14.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:48:00 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] x86/boot: Wrap up the SRAT traversing code into subtable_parse()
Date:   Fri, 30 Aug 2019 17:47:03 -0400
Message-Id: <20190830214707.1201-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830214707.1201-1-msys.mizuma@gmail.com>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Wrap up the SRAT traversing code into subtable_parse().

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 149795c36..908a1bfab 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -362,6 +362,19 @@ static unsigned long get_acpi_srat_table(void)
 	return 0;
 }
 
+static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
+{
+	struct acpi_srat_mem_affinity *ma;
+
+	ma = (struct acpi_srat_mem_affinity *)sub_table;
+
+	if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
+		immovable_mem[*num].start = ma->base_address;
+		immovable_mem[*num].size = ma->length;
+		(*num)++;
+	}
+}
+
 /**
  * count_immovable_mem_regions - Parse SRAT and cache the immovable
  * memory regions into the immovable_mem array.
@@ -395,14 +408,8 @@ int count_immovable_mem_regions(void)
 	while (table + sizeof(struct acpi_subtable_header) < table_end) {
 		sub_table = (struct acpi_subtable_header *)table;
 		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
-			struct acpi_srat_mem_affinity *ma;
 
-			ma = (struct acpi_srat_mem_affinity *)sub_table;
-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
-				immovable_mem[num].start = ma->base_address;
-				immovable_mem[num].size = ma->length;
-				num++;
-			}
+			subtable_parse(sub_table, &num);
 
 			if (num >= MAX_NUMNODES*2) {
 				debug_putstr("Too many immovable memory regions, aborting.\n");
-- 
2.18.1

