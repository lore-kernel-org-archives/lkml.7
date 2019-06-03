Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A124C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40EB27E0A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ED+5eubQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfFCNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:35:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfFCNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:35:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DYn3e610698
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:34:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DYn3e610698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568890;
        bh=oSVN5YJc3E2Qqys1BtEdV27ASDQot3Pvhf7UHa3K/Ew=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ED+5eubQYmpVVggsrqBCRTW/SAjP1HXCvI/V9O3xGgz+RuC9EQBuQDhJ119dsPl9s
         5xrvQa/+FIOzY6gH1kZ+2fKC/YWH0lU5yY/fDzFBfgXfI7cBPe9KHhMkwfuBm0bkXn
         u5hJFqVZo/PCSFPW0sR/sN9hxe35IAItJXkTkTAdbceT1qXK1Cirxk0+Dbp/jnyT6t
         IghahWfM0XdybG7ejuPPacgPmql0N4oM6XEiGw3IuR7fUCCJd8yC4rffN6DuvnBG+e
         BMaHOMNyKC7yxIcxBJdOtoKbMxjKHo0iR2tbpjBL1kNq3Ye5BODE859+wV1oNSmIJX
         ZPHjN+ha/7tDg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DYm70610695;
        Mon, 3 Jun 2019 06:34:48 -0700
Date:   Mon, 3 Jun 2019 06:34:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-982164d62a4b2097c0db28ae7c31fc905af26bb8@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, tglx@linutronix.de, heiko.carstens@de.ibm.com,
        mark.rutland@arm.com, peterz@infradead.org, hpa@zytor.com,
        torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, hpa@zytor.com,
          torvalds@linux-foundation.org, mark.rutland@arm.com,
          tglx@linutronix.de, will.deacon@arm.com,
          heiko.carstens@de.ibm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190522132250.26499-3-mark.rutland@arm.com>
References: <20190522132250.26499-3-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, s390/pci: Prepare for
 atomic64_read() conversion
Git-Commit-ID: 982164d62a4b2097c0db28ae7c31fc905af26bb8
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

Commit-ID:  982164d62a4b2097c0db28ae7c31fc905af26bb8
Gitweb:     https://git.kernel.org/tip/982164d62a4b2097c0db28ae7c31fc905af26bb8
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:34 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, s390/pci: Prepare for atomic64_read() conversion

The return type of atomic64_read() varies by architecture. It may return
long (e.g. powerpc), long long (e.g. arm), or s64 (e.g. x86_64). This is
somewhat painful, and mandates the use of explicit casts in some cases
(e.g. when printing the return value).

To ameliorate matters, subsequent patches will make the atomic64 API
consistently use s64.

As a preparatory step, this patch updates the s390 pci debug code to
treat the return value of atomic64_read() as s64, using an explicit
cast. This cast will be removed once the s64 conversion is complete.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aou@eecs.berkeley.edu
Cc: arnd@arndb.de
Cc: bp@alien8.de
Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: fenghua.yu@intel.com
Cc: herbert@gondor.apana.org.au
Cc: ink@jurassic.park.msu.ru
Cc: jhogan@kernel.org
Cc: linux@armlinux.org.uk
Cc: mattst88@gmail.com
Cc: mpe@ellerman.id.au
Cc: palmer@sifive.com
Cc: paul.burton@mips.com
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-3-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/s390/pci/pci_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 6b48ca7760a7..45eccf79e990 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -74,8 +74,8 @@ static void pci_sw_counter_show(struct seq_file *m)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pci_sw_names); i++, counter++)
-		seq_printf(m, "%26s:\t%lu\n", pci_sw_names[i],
-			   atomic64_read(counter));
+		seq_printf(m, "%26s:\t%llu\n", pci_sw_names[i],
+			   (s64)atomic64_read(counter));
 }
 
 static int pci_perf_show(struct seq_file *m, void *v)
