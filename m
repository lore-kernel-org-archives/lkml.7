Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8367C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC6E2147A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049529;
	bh=H3zgb8VYJU5qUcRPWpKJ8G0uQ1YQ/7ofRDtV5eNbdqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CuEX4x14ay7ZJKQzefOf/ZKW/KOw1jkP0aooPQXSCxnS8+67kY9fjioFKEBw3aWWC
	 kmTlSEO8UaCAgqnvySRWvkDLoOZMEUI5v5CiZvyz5BXmvCdu96iftfzMfWHs3ynBmY
	 tp5ghIcOZC9EpYjLvu77mtc+9ugm8h3DihkCTZzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfCHMwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfCHMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 412802085A;
        Fri,  8 Mar 2019 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049525;
        bh=H3zgb8VYJU5qUcRPWpKJ8G0uQ1YQ/7ofRDtV5eNbdqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1pn2GkeLVb4uUHxqECNVYxxhY6yu3uSGONe+GDS/AOqANQ8mZc2Fs151WCS05k+X
         T9xIYX/xbZA6FrNE8M4qx4jELF4f5uoFIHyd3XXl3CovM9isb7DDBgO/FIKfyhLlLR
         VimPbbZqqVAy7WOSjQ6F9jJvSx+IkwBTLaYKB1D8=
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
Subject: [PATCH 5.0 29/46] x86/CPU/AMD: Set the CPB bit unconditionally on F17h
Date:   Fri,  8 Mar 2019 13:50:02 +0100
Message-Id: <20190308124904.151115316@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -819,11 +819,9 @@ static void init_amd_bd(struct cpuinfo_x
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
 


