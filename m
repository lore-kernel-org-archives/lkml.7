Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A3CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DBC20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYmNphie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbfJaWBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:01:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46196 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbfJaWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:01:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id b3so2109835wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TSWfpuHlmZHBiZrAWDxgOb4uOk4kRce+AnQCKIxwQCA=;
        b=UYmNphie/gQPdtCpL+hIWLXiLGsjYbKuHWIKg2Ek8H5e8tWfy7gevZIMPHNPG8C11z
         lsJlMQ5hNr7TBkGgF/XR5L+T8OU6+oAiGiLN48KHunq1bmTmrDQ4y2Xo4iG2PvF2sB8+
         SJdUBnYF4dxhqC5s8yLtehKA4sTKNanVW3fBLXlzMF6QW+lAvZ2WkJanznmtfJk9cgeH
         8taZMEJmQtP57TIWusOYJDdNA4r0lx0IyqqjJ8iMCSCasiGv7VE74m9u9ukY23Ch6VP0
         7rKcz27gQ9FWanmFF6wGeLyZRtDH98JI/VDYzu7cQU/iRCiXByBoLyeFv53Nq+c4wvDT
         L8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TSWfpuHlmZHBiZrAWDxgOb4uOk4kRce+AnQCKIxwQCA=;
        b=Lx7y/+ThJ7zeYGb54IhC6E2bkDgZeXAbz28TqmjGw129VKnsiL7WxnxMZ/nauBn6zx
         iw8nPr21IMFK/QoN7UOKn14WFl6ud2pReQOq+oEM+CChrKPzThyqoKbfbhp8QyVuHPpB
         sNXQhQZLLlZFIZicGorHjglq0f9CiD87ZSUeOL4LKobeQB0xkCZOnpt5MbdNZGodasfL
         KlLNZfM1xuECw2yEha3Re4woRCAH24J32+pqxio+dCy0b+DNJPmCxenk3jztPuEvltw8
         HgyP5QJ1IFzrCqADdZ31z5N3e/alTUK99wx2Ipwmd2qq1qZpCMROxfjOD/zSbMQ0H4l5
         B9hw==
X-Gm-Message-State: APjAAAX4usIaAf9SNYWZUVc/kYjrYU8mc/vAlfDyhuT9yZ+KT+WYatWo
        PA+TfZONsRHPSjNxlojgqCw=
X-Google-Smtp-Source: APXvYqyLIoyqUyRVy0CLKSm5HCoIrvAuvATFFRdjjXa27GCEStef7EHk7MkbTQKmJWpNw/KX0PRu5g==
X-Received: by 2002:a5d:4644:: with SMTP id j4mr8245262wrs.355.1572559289699;
        Thu, 31 Oct 2019 15:01:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d4sm7514172wrc.54.2019.10.31.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:01:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com, catalin.marinas@arm.com,
        will@kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: spectre-v2: remove Brahma-B53 from hardening
Date:   Thu, 31 Oct 2019 15:00:51 -0700
Message-Id: <20191031220053.2720-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

When the default processor handling was added to the function
cpu_v7_spectre_init() it only excluded other ARM implemented processor
cores. The Broadcom Brahma B53 core is not implemented by ARM so it
ended up falling through into the set of processors that attempt to use
the ARM_SMCCC_ARCH_WORKAROUND_1 service to harden the branch predictor.

Since this workaround is not necessary for the Brahma-B53 this commit
explicitly checks for it and prevents it from applying a branch
predictor hardening workaround.

Fixes: 10115105cb3a ("ARM: spectre-v2: add firmware based hardening")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/proc-v7-bugs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 9a07916af8dd..a6554fdb56c5 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -65,6 +65,9 @@ static void cpu_v7_spectre_init(void)
 		break;
 
 #ifdef CONFIG_ARM_PSCI
+	case ARM_CPU_PART_BRAHMA_B53:
+		/* Requires no workaround */
+		break;
 	default:
 		/* Other ARM CPUs require no workaround */
 		if (read_cpuid_implementor() == ARM_CPU_IMP_ARM)
-- 
2.17.1

