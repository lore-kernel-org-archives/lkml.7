Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BE0C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CB620820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CHzp2/jM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbfFJUJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:09:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbfFJUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:09:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5AK80w34057172
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 Jun 2019 13:08:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5AK80w34057172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560197281;
        bh=8CH7/Z39abKKy8RxsnD113lmL8hqQ7iG7mCzh9v8ZA0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CHzp2/jMzL+O+QKahhWaAReCCbdOR4iL1hk7If1xKZQEqSI9A6OsLL/NPV27dCZlB
         MEUur3Yx6SgOmihSRCTMZJJSJAl3Gf5TsS5YHQ2tsARPYsuw5aFs6JM9pnBztD7f4n
         gt20VnH9KeBQo+sNiGkFn3lHGy6mLaQ278J0etQQjzEnmuuq4QJaF368xx/gtDAi/A
         0rhZynrE69CMC2p9Ewk+K1manBlUw+er0QN38nz7MFLT4j9O2y79ks6VxlOySs/ncI
         pemNtM/ufSmesXncrZk/3PyMz+gr5lQHRMFPDRT2pLjKX30Cm1Np+AcMXTxaKa0jOX
         6yrub/9PjFTjg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5AK7xvJ4057162;
        Mon, 10 Jun 2019 13:07:59 -0700
Date:   Mon, 10 Jun 2019 13:07:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kairui Song <tipbot@zytor.com>
Message-ID: <tip-5a949b38839e284b1307540c56b03caf57da9736@git.kernel.org>
Cc:     rjw@rjwysocki.net, bp@suse.de, dyoung@redhat.com,
        j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org,
        kasong@redhat.com, x86@kernel.org, mingo@kernel.org,
        fanc.fnst@cn.fujitsu.com, tglx@linutronix.de, lijiang@redhat.com,
        bhe@redhat.com, dirk.vandermerwe@netronome.com, hpa@zytor.com
Reply-To: hpa@zytor.com, dirk.vandermerwe@netronome.com, bhe@redhat.com,
          lijiang@redhat.com, tglx@linutronix.de, fanc.fnst@cn.fujitsu.com,
          mingo@kernel.org, kasong@redhat.com, x86@kernel.org,
          linux-kernel@vger.kernel.org, dyoung@redhat.com,
          j-nomura@ce.jp.nec.com, bp@suse.de, rjw@rjwysocki.net
In-Reply-To: <20190610073617.19767-1-kasong@redhat.com>
References: <20190610073617.19767-1-kasong@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/kexec: Add the ACPI NVS region to the ident map
Git-Commit-ID: 5a949b38839e284b1307540c56b03caf57da9736
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5a949b38839e284b1307540c56b03caf57da9736
Gitweb:     https://git.kernel.org/tip/5a949b38839e284b1307540c56b03caf57da9736
Author:     Kairui Song <kasong@redhat.com>
AuthorDate: Mon, 10 Jun 2019 15:36:17 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 10 Jun 2019 22:00:26 +0200

x86/kexec: Add the ACPI NVS region to the ident map

With the recent addition of RSDP parsing in the decompression stage,
a kexec-ed kernel now needs ACPI tables to be covered by the identity
mapping. And in commit

  6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI tables to the ident map")

the ACPI tables memory region was added to the ident map.

But some machines have only an ACPI NVS memory region and the ACPI
tables are located in that region. In such case, the kexec-ed kernel
will still fail when trying to access ACPI tables if they're not mapped.

So add the NVS memory region to the ident map as well.

 [ bp: Massage. ]

Fixes: 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI tables to the ident map")
Suggested-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: kexec@lists.infradead.org
Cc: Lianbo Jiang <lijiang@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190610073617.19767-1-kasong@redhat.com
---
 arch/x86/kernel/machine_kexec_64.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3c77bdf7b32a..b2b88dcaaf88 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -54,14 +54,26 @@ static int mem_region_callback(struct resource *res, void *arg)
 static int
 map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 {
-	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	struct init_pgtable_data data;
+	unsigned long flags;
+	int ret;
 
 	data.info = info;
 	data.level4p = level4p;
 	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
-				   &data, mem_region_callback);
+
+	ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
+				  &data, mem_region_callback);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	/* ACPI tables could be located in ACPI Non-volatile Storage region */
+	ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
+				  &data, mem_region_callback);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	return 0;
 }
 #else
 static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
