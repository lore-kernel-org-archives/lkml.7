Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D75C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DF420811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050003;
	bh=SPxXSvOW/mMl7eb36t/DsmXEuvSe4qiF1H+LgWNrRJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LVESFU16/TefWIF2IWsJQ+4THBjQHe+zoJ3FckOWU8/QK1z2/E8hjybrxkY6FVC69
	 t25tRBIRt2eDEj96l480Yy9u3FKXWFXS+m4jdyG4ORV4CrDskuUSoHAlSfAyrZWmlO
	 PhuwfZqZ5X917niE7revUfiHiaJey9ZvTl8PgHJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfCHNAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfCHNAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B43A20449;
        Fri,  8 Mar 2019 13:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050000;
        bh=SPxXSvOW/mMl7eb36t/DsmXEuvSe4qiF1H+LgWNrRJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6r0rtmylHf4bpzKFQhbBFFVQ4Ko3iuTYN8ytr0MJ6PbHwQ+v+oCCy867dg0WIjlM
         JNs8Gy0ccJmbuZ5pB5OmZgsTPz1hi5hcyQeGW8Ndb8Qk3exkFsRDmE8mYrspDGed0t
         wsg1L9qcnmkrMTMb2Kt17qklf2etVRr8azyVkNPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.19 53/68] x86/CPU/AMD: Set the CPB bit unconditionally on F17h
Date:   Fri,  8 Mar 2019 13:50:23 +0100
Message-Id: <20190308124913.248273597@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit 0237199186e7a4aa5310741f0a6498a20c820fd7 upstream.

Some F17h models do not have CPB set in CPUID even though the CPU
supports it. Set the feature bit unconditionally on all F17h.

 [ bp: Rewrite commit message and patch. ]

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181120030018.5185-1-jiaxun.yang@flygoat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/amd.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -818,11 +818,9 @@ static void init_amd_bd(struct cpuinfo_x
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
-	/*
-	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
-	 * all up to and including B1.
-	 */
-	if (c->x86_model <= 1 && c->x86_stepping <= 1)
+
+	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
+	if (!cpu_has(c, X86_FEATURE_CPB))
 		set_cpu_cap(c, X86_FEATURE_CPB);
 }
 


