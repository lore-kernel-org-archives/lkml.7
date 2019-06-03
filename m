Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC5C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F032654B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEC8Zapl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFCXUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:20:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43709 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCXUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:20:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so2444970plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 16:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DA76H/bozL9s89efCzw79MTHBgMNQxOdRNDrML9aLgk=;
        b=tEC8Zapld27PhCE3RE8dwRauNzqNr/N9F3L8uJ53XsogbkSPMl0RMKixu5PsOmV5e7
         jJU5tIV0lx3C+7+aoTS4zLeRAd/bCTjhRu9/j6PsKK4zGhpcptpWAqzzlLeq3p2ToixR
         dxbPy8JLcxVBVBCsykThjni9BkyERzR/chQ7xyqNldB7jmfbjxa+QKQSWkIsP4RVyqhq
         qvMBBOiZcyCVjzoJmTVQEmjEmEEIDZaZrwsmQjAoHEvdA6+djjW8bXqtyrQgWlmbTAr3
         BEiWyas3DcSwvwJCEfl9BEfkWiOXshgWmiYRQZ+2v1LWcai55aubJQ7J+d5AriF4m/1i
         2Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DA76H/bozL9s89efCzw79MTHBgMNQxOdRNDrML9aLgk=;
        b=T9Q5ZMHMEyqRKxjwjIwUa6L/qBdfQa2Vr7W0zkcNOvXNiznk36fj09hGsK3KuTsjRt
         s/rBfKV2YCBN3NSjQpNTZpwUqfhQ7s3Y1cKPVp1qsg6Ex7FwdfkxG3faIH+GNlmwuwdz
         DjF2w0Kyw7bf6CxrnVcCxCBCkrXo1u1HAveau6KNpyJ/Oyr9S5Us58jzkzIVHz8VWN8P
         zyyLth/dmqVbr3ckiYaKSISfCacdu1MS4bggUOhZp5rMC287YBCxglxmRimaK2Iqz3Mx
         w7zgml5Hloo98ehsA8mX+cwshpToILtbBHAZPefw4X1ut5bfZmHCPJSpveYnbEVC00gr
         GBmw==
X-Gm-Message-State: APjAAAUuVx3xAIT4aT6wkl81h07tu9cmI8kIAF8qmfMXITfzo0OPRzaY
        1GoHG5Kpox9Dy9Hxe5eATJI=
X-Google-Smtp-Source: APXvYqwbjVTuVfxT29zpnh9h9ExmfjecYSOEcey70DwBVxstu9XpO1WQ17koX3hD8voBlBJUsfPBXQ==
X-Received: by 2002:a17:902:165:: with SMTP id 92mr4875038plb.197.1559603999263;
        Mon, 03 Jun 2019 16:19:59 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a64sm12666564pgc.53.2019.06.03.16.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:19:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     rmk+kernel@armlinux.org.uk,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] arm64: smp: Moved cpu_logical_map[] to smp.h
Date:   Mon,  3 Jun 2019 16:18:29 -0700
Message-Id: <20190603231830.24129-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603231830.24129-1-f.fainelli@gmail.com>
References: <20190603231830.24129-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/smp.h is included by linux/smp.h and some drivers, in particular
irqchip drivers can access cpu_logical_map[] in order to perform SMP
affinity tasks. Make arm64 consistent with other architectures here.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/smp.h      | 6 ++++++
 arch/arm64/include/asm/smp_plat.h | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 18553f399e08..eae2d6c01262 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -53,6 +53,12 @@ DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
  */
 #define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
 
+/*
+ * Logical CPU mapping.
+ */
+extern u64 __cpu_logical_map[NR_CPUS];
+#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
+
 struct seq_file;
 
 /*
diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index af58dcdefb21..7a495403a18a 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -36,11 +36,6 @@ static inline u32 mpidr_hash_size(void)
 	return 1 << mpidr_hash.bits;
 }
 
-/*
- * Logical CPU mapping.
- */
-extern u64 __cpu_logical_map[NR_CPUS];
-#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
 /*
  * Retrieve logical cpu index corresponding to a given MPIDR.Aff*
  *  - mpidr: MPIDR.Aff* bits to be used for the look-up
-- 
2.17.1

