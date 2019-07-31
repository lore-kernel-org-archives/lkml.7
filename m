Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40284C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120F1206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GisN2VOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfGaPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:21:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39552 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbfGaPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:19:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so66044806edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zVMT74rDUltFrg5s5cNC7M6LQV7b9+aLo+/S3q5hiw=;
        b=GisN2VOHWd3D2xd2nqgN/O4RiDCWZV8MPtYrQVY6TlWY8EHqrabeuC1r3NX9u0NUOO
         BH2o2lVkrCrb9gk1MKTOTG948p8DjJmLwuCxvSnHSCG2lQ5LlWSSW0TudDJxop3vUybS
         iS5zXgJkjFJwjSE1VsEQrLIg9PkOFtoA/PrYofcbBQsb/QBWbIN8wq9TtqNGnZW57NXu
         FygrvM5q/WyuM25UdOJmx6Q3wWqh1eJzizEsGx5+xS2vf/v8J+0H+RHMoHy2oBvIHwmm
         KlIaNODZHWgCOQ3B780DUv+UnF1kRJdgXgyEo5fMmqmMlzcNCEgAUZoRuuxXG8JEW+4G
         Cplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zVMT74rDUltFrg5s5cNC7M6LQV7b9+aLo+/S3q5hiw=;
        b=BDN4lzRR3A1YKQPDETLaiykeRbZXFO+mb2IwKh127RSJq0+GOghjDfI+LGrFTWBhLB
         9nMtZyB3QoHtDOqCv7qgZf6kXRT5a8JidfIcLz4M78a+82jjVXg368tAZ70jwHkn8P2I
         ltJ2WlIfDsG1yUzR/6/lzjTd95ZJg8aw8oA8OQ1mo2s6ipfUzy+oMVhdwe1+RqBZi4IU
         D/Cf5dz1MMkIywxgpDrn8CDZ+5lYlBAmOZVJgv+0y+J4aazqUt+OY8kE1drzNsjUU+Kx
         26KWw6VkiibrDK2Mvj/+jC8NY7gBV8GCzuG+oz7g9TH8yFyfetGCAODK7kyFcY1lHK4T
         Tj9g==
X-Gm-Message-State: APjAAAXvOVouJRpXOc5RtsWYSZbNeFL/0xfAawllp5SnWgQFmxBCbLJ8
        nxdPHakwKKUtd76rxpAN3BQ=
X-Google-Smtp-Source: APXvYqwlNY51UchCswKgnSs9+WfX2oW8BlZl27GF1PmsG2m8MqrdBgD47IA24LwOZbfQr2I0vImeXg==
X-Received: by 2002:a50:8b9c:: with SMTP id m28mr109889326edm.53.1564586039271;
        Wed, 31 Jul 2019 08:13:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id ns22sm12486254ejb.9.2019.07.31.08.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:57 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id DAD501045F8; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 34/59] acpi: Remove __init from acpi table parsing functions
Date:   Wed, 31 Jul 2019 18:07:48 +0300
Message-Id: <20190731150813.26289-35-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

ACPI table parsing functions are useful after init time.

For example, the MKTME (Multi-Key Total Memory Encryption) key
service will evaluate the ACPI HMAT table when the first key
creation request occurs.  This will happen after init time.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/acpi/tables.c | 10 +++++-----
 include/linux/acpi.h  |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b32327759380..9d40af7f07fb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -33,7 +33,7 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-static int acpi_apic_instance __initdata;
+static int acpi_apic_instance;
 
 enum acpi_subtable_type {
 	ACPI_SUBTABLE_COMMON,
@@ -49,7 +49,7 @@ struct acpi_subtable_entry {
  * Disable table checksum verification for the early stage due to the size
  * limitation of the current x86 early mapping implementation.
  */
-static bool acpi_verify_table_checksum __initdata = false;
+static bool acpi_verify_table_checksum = false;
 
 void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 {
@@ -280,7 +280,7 @@ acpi_get_subtable_type(char *id)
  * On success returns sum of all matching entries for all proc handlers.
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
-static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
+static int acpi_parse_entries_array(char *id, unsigned long table_size,
 		struct acpi_table_header *table_header,
 		struct acpi_subtable_proc *proc, int proc_num,
 		unsigned int max_entries)
@@ -355,7 +355,7 @@ static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
 	return errs ? -EINVAL : count;
 }
 
-int __init acpi_table_parse_entries_array(char *id,
+int acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
 			 struct acpi_subtable_proc *proc, int proc_num,
 			 unsigned int max_entries)
@@ -386,7 +386,7 @@ int __init acpi_table_parse_entries_array(char *id,
 	return count;
 }
 
-int __init acpi_table_parse_entries(char *id,
+int acpi_table_parse_entries(char *id,
 			unsigned long table_size,
 			int entry_id,
 			acpi_tbl_entry_handler handler,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9426b9aaed86..fc1e7d4648bf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -228,11 +228,11 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
-int __init acpi_table_parse_entries(char *id, unsigned long table_size,
+int acpi_table_parse_entries(char *id, unsigned long table_size,
 			      int entry_id,
 			      acpi_tbl_entry_handler handler,
 			      unsigned int max_entries);
-int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
+int acpi_table_parse_entries_array(char *id, unsigned long table_size,
 			      struct acpi_subtable_proc *proc, int proc_num,
 			      unsigned int max_entries);
 int acpi_table_parse_madt(enum acpi_madt_type id,
-- 
2.21.0

