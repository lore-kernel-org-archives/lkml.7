Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCCFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F221734
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q3ru68zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfGYOVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:21:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbfGYOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:21:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PELMTR1037407
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:21:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PELMTR1037407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064482;
        bh=bJO2fH+x7prVuH+z+1/XyhzqXDoq04T9vV0sRE/RPc4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Q3ru68zmLUeRfvHKWf1VZrS63KonCV/MRYfq0H994Q8ra3ZJIMzHdJsPuUbuo+E1g
         Nh1HhfHd1uoUIL6SiqE13VzIoFWHyLTIppkDPHqTULq5TcpxO0Bd0V+aNTuLUgeUhQ
         f03YCrHjP78xgmG6rXl8Gm4xjMZR1ZakR/yv1RC2VX4AeZPWECgPWZ1/KrR9zXwrej
         GqgrUbEQG0/QDU+hxRQnhimHPJYTRoDn5Y2/Zx1qVBDlXXVF1sPYmPJHbgNRFRhJHk
         Z5Or+0yhlC2MmSiGdz69rrnU9JWP6LaqlSa73S82JLWq6ch7j2/19qId1I7QbK/waA
         EdrNYqlDCRVVw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PELLSM1037404;
        Thu, 25 Jul 2019 07:21:21 -0700
Date:   Thu, 25 Jul 2019 07:21:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-39c89dff9c366ad98d2e5598db41ff9b1bdb9e88@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190722105218.962517234@linutronix.de>
References: <20190722105218.962517234@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Invoke perf_events_lapic_init() after
 enabling APIC
Git-Commit-ID: 39c89dff9c366ad98d2e5598db41ff9b1bdb9e88
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

Commit-ID:  39c89dff9c366ad98d2e5598db41ff9b1bdb9e88
Gitweb:     https://git.kernel.org/tip/39c89dff9c366ad98d2e5598db41ff9b1bdb9e88
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:56 +0200

x86/apic: Invoke perf_events_lapic_init() after enabling APIC

If the APIC is soft disabled then unmasking an LVT entry does not work and
the write is ignored. perf_events_lapic_init() tries to do so.

Move the invocation after the point where the APIC has been enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105218.962517234@linutronix.de

---
 arch/x86/kernel/apic/apic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 84032bf81476..fa0846d4e000 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1517,7 +1517,6 @@ static void setup_local_APIC(void)
 	int logical_apicid, ldr_apicid;
 #endif
 
-
 	if (disable_apic) {
 		disable_ioapic_support();
 		return;
@@ -1532,8 +1531,6 @@ static void setup_local_APIC(void)
 		apic_write(APIC_ESR, 0);
 	}
 #endif
-	perf_events_lapic_init();
-
 	/*
 	 * Double-check whether this APIC is really registered.
 	 * This is meaningless in clustered apic mode, so we skip it.
@@ -1617,6 +1614,8 @@ static void setup_local_APIC(void)
 	value |= SPURIOUS_APIC_VECTOR;
 	apic_write(APIC_SPIV, value);
 
+	perf_events_lapic_init();
+
 	/*
 	 * Set up LVT0, LVT1:
 	 *
