Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA304C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C36820665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YFtefH2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfFVKTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:19:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37619 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:19:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAJ7A32099253
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:19:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAJ7A32099253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198748;
        bh=UsSfDraEfVSFnWVAI9t0yLd4ILT3GbhHYLOpmImqmWU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YFtefH2QdIuyr0tUlln5LE48x56KpmOIu1REQZfEQ4E0n7dAFgM+c537oP/1GGMXu
         hLgiVDvsJvUpFSTBNFd2GNJ6TOcDVa1PAhjx9uv/7/UE/ASCYgWWwPM2r0/BOe120M
         Z9xPRXbvZZEqhkTivD9iaqdj6jFZ9LC8Y+VGTMWIi1ZWl3sgTr8TNJvfD2/8PGD/hb
         /MaubbW0PJLi7AE7SkrnvyCXIiD1xXlfRm0qh2CjKXjz7ewMSu5AUsVxAwX2ApyvYS
         HeVJ5s4ypKDVsqEKP+/m9i4zJhUcaasY7vpjzUscJ88JfPjSLqsQY2vOuRbGpiki7H
         Urz3bTSVgUxcg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAJ7X72099250;
        Sat, 22 Jun 2019 03:19:07 -0700
Date:   Sat, 22 Jun 2019 03:19:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-ea136a112d89bade596314a1ae49f748902f4727@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, bp@alien8.de,
        colin.king@canonical.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: bp@alien8.de, mingo@kernel.org, tglx@linutronix.de,
          colin.king@canonical.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190619181446.13635-1-colin.king@canonical.com>
References: <20190619181446.13635-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic: Fix integer overflow on 10 bit left
 shift of cpu_khz
Git-Commit-ID: ea136a112d89bade596314a1ae49f748902f4727
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

Commit-ID:  ea136a112d89bade596314a1ae49f748902f4727
Gitweb:     https://git.kernel.org/tip/ea136a112d89bade596314a1ae49f748902f4727
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Wed, 19 Jun 2019 19:14:46 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:59:31 +0200

x86/apic: Fix integer overflow on 10 bit left shift of cpu_khz

The left shift of unsigned int cpu_khz will overflow for large values of
cpu_khz, so cast it to a long long before shifting it to avoid overvlow.
For example, this can happen when cpu_khz is 4194305, i.e. ~4.2 GHz.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 8c3ba8d04924 ("x86, apic: ack all pending irqs when crashed/on kexec")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20190619181446.13635-1-colin.king@canonical.com

---
 arch/x86/kernel/apic/apic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 177aa8ef2afa..85be316665b4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1464,7 +1464,8 @@ static void apic_pending_intr_clear(void)
 		if (queued) {
 			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
 				ntsc = rdtsc();
-				max_loops = (cpu_khz << 10) - (ntsc - tsc);
+				max_loops = (long long)cpu_khz << 10;
+				max_loops -= ntsc - tsc;
 			} else {
 				max_loops--;
 			}
