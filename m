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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A113C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AD626588
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLR3sftf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFCXUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:20:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35435 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfFCXUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:20:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so11493496pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4T+U/8TbuerdJ9T+PIwJr+AsgCnk93w+4V0fRYDj/0=;
        b=DLR3sftfc4blBJP/VPCJ77k0R7fxa0BXTclfKSebuAgMGEOpt3mfsFhIta5LbsuK92
         mHUN5DAFajTo+ozCIwNKkCC3JnLnJaGUYtWK3XsBXsfwF0jnMg8iXRllg+lEFpXpF2C7
         3kpWokmVJCiJPRGDLjEe8mnPdXemwJs34ZmFpmMoVpXFy6kzQqw3Bcgsx7Zc7TalRC78
         vrtBZLdzJiIdEYNQKSZZdYY7qYG8LuqEbqFvMVsYQ7WIzNtj63K8oAht8vy/H6Iqh+i4
         wWNiXL1dZeaYoBuEfNj28ohPJjk7UDYEdeHSBXGd7/ScnLyCShvcT6mcNvgEYPAJ/a/T
         bzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4T+U/8TbuerdJ9T+PIwJr+AsgCnk93w+4V0fRYDj/0=;
        b=lUtvuOfGsFq3bAlUvA6u+I/9jyuAkPmYHrMe2TD85epXvI6SDXtj4QnE8IRQiFA+sn
         N3FMMjMoLeSyKf5kRGLgTomYLOKYOJ73h6Yz6nU0isiqUzTQ+UQnHHPDGvZ+n4jmG8KH
         fPhX5mnr7bbE3yvm7Sa6Hnwz2hUD+LB1YAYMPeKM8gZ2cFIEnkTiXrmYFL2MS8jqPCTT
         JXWuCwj3Pam/O/z3+hRvkHeLz0rb3m3CM/MahG5q8Xr4GV0P10QIIAu+0gYw/LGa/EsM
         /9SRq12wyda7xfTucxaYJG5/8B+jfAc2mAa0psnk4Jm8cJkXN/BtRTX8+QyGpsrdndQg
         gMDw==
X-Gm-Message-State: APjAAAU4Hbx50RDwaY5hIpXPAZfB7lNtO95uQmW3GH6iHUhy7eDFdSZW
        CsaykAtLoGb40XueIKY9/4U=
X-Google-Smtp-Source: APXvYqwl2gxrcOEMEZNo4B3s4crG6no+t0Xfk5Bt4ktRQPsXt2yywQdZP/9R/yN0ZUtgpLES9UgsOQ==
X-Received: by 2002:a63:4826:: with SMTP id v38mr31703087pga.417.1559604000699;
        Mon, 03 Jun 2019 16:20:00 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a64sm12666564pgc.53.2019.06.03.16.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:19:59 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     rmk+kernel@armlinux.org.uk,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] ARM: smp: Moved cpu_logical_map[] to smp.h
Date:   Mon,  3 Jun 2019 16:18:30 -0700
Message-Id: <20190603231830.24129-3-f.fainelli@gmail.com>
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
 arch/arm/include/asm/smp.h      | 6 ++++++
 arch/arm/include/asm/smp_plat.h | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 451ae684aaf4..112d78e82f35 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -20,6 +20,12 @@
 
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
+/*
+ * Logical CPU mapping.
+ */
+extern u32 __cpu_logical_map[];
+#define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
+
 struct seq_file;
 
 /*
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index f2c36acf9886..ca6b91d400cf 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -66,11 +66,6 @@ static inline int cache_ops_need_broadcast(void)
 }
 #endif
 
-/*
- * Logical CPU mapping.
- */
-extern u32 __cpu_logical_map[];
-#define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
 /*
  * Retrieve logical cpu index corresponding to a given MPIDR[23:0]
  *  - mpidr: MPIDR[23:0] to be used for the look-up
-- 
2.17.1

