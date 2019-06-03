Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91958C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6698D2542C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SMfc16Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfFCNq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:46:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38627 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfFCNq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:46:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DkC3g614372
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:46:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DkC3g614372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569573;
        bh=bDHxt74Fnq2Ngwtk+dwyw38Uiew9Fi1d3UAGaytTcLU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SMfc16KrejFlX8eyRcpvVHsFWCVmJa0XQL2VVOaWw7cpJeDxyYhCqJA4Jpffmu//t
         vASYTMKwnAc/XpKaQnmhlg2USwDQd0zC/U6hj7+VilD/jMBNZGo7GcM0za6+WloAnx
         UCTFqm3oVhZe1C90y9O9M11OGdZyU9A0FL9jq3W69txrb1od73sfukO88pHrFBFEK2
         7vSwbNL4GjJsTMtv33SHHGTeM1Hq2M/dQRTkaJW7vaR3hXIhOptuxLgff7dzO+A3gD
         4/rEXb0oVSQehvRKuG7TD5UuX2YI2MfG4JstMDpKBGwKBlkw2i1w1YlBQQRDrVBtQi
         QaGZOstgIZVsA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DkCO6614369;
        Mon, 3 Jun 2019 06:46:12 -0700
Date:   Mon, 3 Jun 2019 06:46:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-6a6a9d5fb9f26d2c2127497f3a42adbeb5ccc2a4@git.kernel.org>
Cc:     heiko.carstens@de.ibm.com, mingo@kernel.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, hpa@zytor.com, mark.rutland@arm.com,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, heiko.carstens@de.ibm.com, will.deacon@arm.com,
          mark.rutland@arm.com, hpa@zytor.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20190522132250.26499-19-mark.rutland@arm.com>
References: <20190522132250.26499-19-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, s390/pci: Remove redundant casts
Git-Commit-ID: 6a6a9d5fb9f26d2c2127497f3a42adbeb5ccc2a4
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

Commit-ID:  6a6a9d5fb9f26d2c2127497f3a42adbeb5ccc2a4
Gitweb:     https://git.kernel.org/tip/6a6a9d5fb9f26d2c2127497f3a42adbeb5ccc2a4
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:50 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:57 +0200

locking/atomic, s390/pci: Remove redundant casts

Now that atomic64_read() returns s64 consistently, we don't need to
explicitly cast its return value. Drop the redundant casts.

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
Link: https://lkml.kernel.org/r/20190522132250.26499-19-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/s390/pci/pci_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 45eccf79e990..3408c0df3ebf 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -75,7 +75,7 @@ static void pci_sw_counter_show(struct seq_file *m)
 
 	for (i = 0; i < ARRAY_SIZE(pci_sw_names); i++, counter++)
 		seq_printf(m, "%26s:\t%llu\n", pci_sw_names[i],
-			   (s64)atomic64_read(counter));
+			   atomic64_read(counter));
 }
 
 static int pci_perf_show(struct seq_file *m, void *v)
