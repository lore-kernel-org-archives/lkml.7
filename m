Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5883C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C472175B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mrXpMPII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDFSR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:17:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44552 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfDFSR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 14:17:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id y5so5723533qkc.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WeOmR6bsjMUrYlOj6qdJ5nj8AL60jTAGWVEpYntMZVg=;
        b=mrXpMPIIgWApzXUKPhQnSzQe96bYBJ4fEjcVXheRtFd6yfvIIZON9Ti9NbE90ZzPKc
         r+bJqtBatn9iqJDYmS9l+uGgbXPCjPBkcqXNiLq1B7ApxpjSfwg48bDOYWVrB26veVFJ
         eLgqI/9c5FGgen0AZfP04dBGZjaZD6A8vlDrYSiAOmvdLKjVVKLkd9x3CPA9Kh2S0ZsP
         yP1yJK6ntiVw02ZjHtxKD/WwEpv61RRe3Dg270vhmWR4ySmraRxTyfXzjIFW3HXErQHG
         lRrxZrLF/nW+ZhPN6WJ/8Y/6/FPg3WHlP7Z+CEXStd+nCNvNnMa4iIK6hRGmzGqEB7GL
         Uogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WeOmR6bsjMUrYlOj6qdJ5nj8AL60jTAGWVEpYntMZVg=;
        b=W8xDdOfsURPE4YNeJVRyx/iQGoE49ixfXeGHQP+urcH1i8DNIrlmZUD79npUyV0YmD
         xda2RFyZqyaX2mj+A80WpdgbocVms1L9UBQ2EQgpkg9NiEG49mxTpfjV9uQSXH2fq9OK
         cKLPUXNzR2Er1OwLIC4qKDXiKnHrlTouLWZAB/JenhcFalNRMJjQM/S3EUQsyv/pb0t0
         1y3+A8sYggUMEn3ZR7EmNbVVv+i9d1lgUWjcEEDrzL3puSTy2Q243fQ/o/GCzcy2xyh2
         9cuB9OufY+tQhGuZ82csg+5n+nO2h0mj8WndArjRxb+bImOM/kEkaLzgH11/lD7nropj
         5ypg==
X-Gm-Message-State: APjAAAX5BzdXUUR36Jfge/JCOF/HtBDliAQ5VzjcAfc73u4Zca4OliDK
        Tnw577uyo94I1YKWbo/3XHOw4Q==
X-Google-Smtp-Source: APXvYqwmIqqrcRSc6NhoPo4dm3+3yokTAMrz25Rf/vxdVBa5kWpYmXAh1FKnjKgrzHcXYWefENgh7A==
X-Received: by 2002:a37:650c:: with SMTP id z12mr15961249qkb.115.1554574677396;
        Sat, 06 Apr 2019 11:17:57 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f47sm17314947qta.80.2019.04.06.11.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 11:17:56 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     keith.busch@intel.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
Date:   Sat,  6 Apr 2019 14:17:04 -0400
Message-Id: <20190406181704.33574-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
memory") introduced some memory leaks below due to it fails to release
the heap memory in an error path, and then the stack __initdata memory
which reference them get freed during boot renders those heap memory as
leaks.

unreferenced object 0xc8ff8008349e9400 (size 128):
  comm "swapper/0", pid 1, jiffies 4294709236 (age 48121.476s)
  hex dump (first 32 bytes):
    00 d0 9e 34 08 80 ff 84 d8 00 43 11 00 10 ff ff  ...4......C.....
    00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000869d4503>] __kmalloc+0x568/0x600
    [<0000000070fd6afb>] alloc_memory_target+0x50/0xd8
    [<00000000efa2081e>] srat_parse_mem_affinity+0x58/0x5c
    [<000000008bfaef74>] acpi_parse_entries_array+0x1c8/0x2c0
    [<0000000022804877>] acpi_table_parse_entries_array+0x11c/0x138
    [<00000000ffe9cd34>] acpi_table_parse_entries+0x7c/0xac
    [<00000000a7023afd>] hmat_init+0x90/0x174
    [<00000000694a86c1>] do_one_initcall+0x2d8/0x5f8
    [<0000000024889da9>] do_initcall_level+0x37c/0x3fc
    [<000000009be02908>] do_basic_setup+0x38/0x50
    [<0000000037b3ac0a>] kernel_init_freeable+0x194/0x258
    [<00000000f5741184>] kernel_init+0x18/0x334
    [<000000007b30f423>] ret_from_fork+0x10/0x18
    [<000000006c7147a8>] 0xffffffffffffffff

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/acpi/hmat/hmat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b7824a0309f7..c9b8abcf012c 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -637,7 +637,7 @@ static __init int hmat_init(void)
 
 	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
 	if (ACPI_FAILURE(status))
-		return 0;
+		goto out_free;
 
 	hmat_revision = tbl->revision;
 	switch (hmat_revision) {
@@ -659,8 +659,9 @@ static __init int hmat_init(void)
 	}
 	hmat_register_targets();
 out_put:
-	hmat_free_structures();
 	acpi_put_table(tbl);
+out_free:
+	hmat_free_structures();
 	return 0;
 }
 subsys_initcall(hmat_init);
-- 
2.17.2 (Apple Git-113)

