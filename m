Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71B7CA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A35621D7C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6lvtzKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfKBBJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 21:09:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39655 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfKBBJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 21:09:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id t8so15401187qtc.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HiTrRYovNg8dXt0LJIo4hhRMok+7+qAUJqR1zx6Do2E=;
        b=u6lvtzKoWjJoOBknp7TwHbV/v2Tqs8QuJik3YlZjUj8zDpkzhPFpryTKGjMywxDhhu
         aWiRM6VbVHaDAm3rmN3YR18Kx+WZKuhblnMad9t/2K/w71VOsRudJW4AmW3IPiETOWLf
         JsWubH0TBT3aWGHa1w6O5bYE9hP2q+oK6C67bGXl2KqyRP1VqorqkJIomgTmBz7YOIPy
         smf/qBmjaTe7qqLfkC06edme14n0oSdlAOd46jJlV4wFQ0NnpPjlRxG6U009qsX8aAWG
         dgP8wqVqbXtaI8C9uWUDh6os3RrJ37nv19Thxr7ck//+Iyi9tNMh9w3KbAaSQUZaukAN
         kZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HiTrRYovNg8dXt0LJIo4hhRMok+7+qAUJqR1zx6Do2E=;
        b=LHGRnILREGDeGCFnVxOuLGZdpuL4wcdNl5BAs+3fXTB1K3r3+MZU6L73FqUuNEr2Ca
         CE1Lddf0c2T7VFrPyKlHmmhw7ERB/pmw29zlxGRY9r05Hh6eIzU2I2gINd65hek/hQ9F
         7KDT6/86jhqERjciAr35ZH584MXrQglhZtkvIf/xDBUIEAezGNZhvqqfY0JKeqhaJEpy
         lNxjkTK2QzKktM9uUvDYikXd84/mVzDdbF/6tSuLFQ/6mR0hLGn0qiovswSfYxFVUqZJ
         k8UapniLljvHroH1aUDXaMzfXp8ww/ERoeqiFaBTy+r6Zw337B3TYnylIdIyjfbcYxYx
         fcTg==
X-Gm-Message-State: APjAAAXXfCSwobA17huvsAcCMwEA9b8E97BFeKIDkGAxnIhRMyPTcK3L
        CJGHevhUNJ98U548MPjaVg==
X-Google-Smtp-Source: APXvYqzIzpwtWkY90RosJ5Cm5G1MQW+9Wmg+DGEhb6MRmt/6PDQ4ETYO1GHRUzWl07ykHjyaBt/KzQ==
X-Received: by 2002:aed:3f63:: with SMTP id q32mr2560523qtf.340.1572656972727;
        Fri, 01 Nov 2019 18:09:32 -0700 (PDT)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id i66sm4234340qkb.105.2019.11.01.18.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 18:09:32 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] x86/boot: Wrap up the SRAT traversing code into subtable_parse()
Date:   Fri,  1 Nov 2019 21:09:08 -0400
Message-Id: <20191102010911.21460-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191102010911.21460-1-msys.mizuma@gmail.com>
References: <20191102010911.21460-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Wrap up the SRAT traversing code into subtable_parse().

Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 25019d42a..a0f81438a 100644
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
2.20.1

