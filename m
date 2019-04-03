Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABFAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0632620882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luXAbXnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfDCHCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:02:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39569 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCHCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:02:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so7552892plb.6;
        Wed, 03 Apr 2019 00:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=jNVqIdkQAScEraNgcu9ceQ0w+kYTL5wKNdPzTcIDlJY=;
        b=luXAbXnDU/p+ppmXlPcONno4pW0wV7ew0QOa4GTHSfrsGEEqoCiiHcQFJg1AtnnwaL
         LMEgHqfMJ75JgaXHUgFa1XCwqg7keppAEGUEO+UthIXK1p6VpbV4jZiW2/JbnKG0s8d8
         Cq/l2pz45Upw3b1s+XcDkoGkWVaL3vdGthJZfhIATfF7/UxhHHYRnss9FbQK26DkbOwA
         P2aCRnTvRpN4XraKBFkkAHTMQHYcab6eu/M4uAIU7f9TZTHL7Dg3lHFxZgi3w+di5lrT
         zT5fDLjW/ghrt7o9PxKPQnoVHVRcgdVM/JteOP8OKGaQxE4347cJhX3K/DIcOBJqzycP
         JHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=jNVqIdkQAScEraNgcu9ceQ0w+kYTL5wKNdPzTcIDlJY=;
        b=uKMtRpAQVOkvnLw1AKVZjcmmd22VFkzTi9yiDCYBP5TGvWuCqK2/b9FStfZaaE+sVn
         pa2ZYmghIvOBaj77n8hXYEamPFq7WQez3b4VlAvSDj9lSmAWb5OABIJdGRCIVg/RmBft
         RkjKJxw6P0hBu46THSgMbcCpJFeAxwILZ+0gNXX1YylQtWbUNapSzlobtcfchhZxTj/U
         Qkt2TrP4Rp7ThwcAN+eM0jeakveRfmE/9wWuCbNDfqP7st06r4Zww4zWY/KCSUHFQDlp
         8k/q1yOQfJRKsxZpHyyvqhSAsSlAEXfYgt2b9yC8XpFGuhZ0wurQezClsCrTvIFjUnrq
         jycA==
X-Gm-Message-State: APjAAAXMUXQK1JaSc2VMxkF32g7QkVbpMER5v+g4oBzcKNncIjDLo1rI
        sytT1RrqWEaI0wl4tiyEqTJ5Hss=
X-Google-Smtp-Source: APXvYqyqo8W/vbheA5rzlhe+jJh45BQlslGVg0jAkAzAU570ZVghufi+XzcamzUkx8ZU+NWa7JTxyA==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr75622852plk.109.1554274941649;
        Wed, 03 Apr 2019 00:02:21 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id v6sm19121830pgv.92.2019.04.03.00.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 00:02:20 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/power: turbostat: fix buffer overrun
Date:   Wed,  3 Apr 2019 16:02:14 +0900
Message-Id: <1554274934-12649-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

turbostat could be terminated by general protection fault on some latest
hardwares which (for example) support 9 levels of C-states and show 18
"tADDED" lines. That bloats the total output and finally causes buffer
overrun.  So let's extend the buffer to avoid this.

This patch also removes duplicated "pc10:" line to reduce buffer usage.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git v5.1-rc3-mmotm-2019-04-02-17-16/tools/power/x86/turbostat/turbostat.c v5.1-rc3-mmotm-2019-04-02-17-16_patched/tools/power/x86/turbostat/turbostat.c
index c7727be..17b1f544 100644
--- v5.1-rc3-mmotm-2019-04-02-17-16/tools/power/x86/turbostat/turbostat.c
+++ v5.1-rc3-mmotm-2019-04-02-17-16_patched/tools/power/x86/turbostat/turbostat.c
@@ -861,7 +861,6 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "pc8: %016llX\n", p->pc8);
 		outp += sprintf(outp, "pc9: %016llX\n", p->pc9);
 		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
-		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
 		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
 		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
 		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
@@ -5135,7 +5134,7 @@ int initialize_counters(int cpu_id)
 
 void allocate_output_buffer()
 {
-	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
+	output_buffer = calloc(1, (1 + topo.num_cpus) * 2048);
 	outp = output_buffer;
 	if (outp == NULL)
 		err(-1, "calloc output buffer");
-- 
2.7.0

