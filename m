Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5FCC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8684A25D85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="q+CTCZb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfFCNo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:44:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfFCNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:44:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DiiA2614049
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:44:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DiiA2614049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569485;
        bh=I6bucJmuOsEloEQTOfg2YM3pP8k+T5TGAAh3PxQmNPA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=q+CTCZb5G2NVtfRk8+gfrdjuiahogZOdkQpStPNxuNpAb1dQIkIxP5EecV890/Jz2
         zgH4FXVOvRGhy62WFsG325ZVVhLuNCnT9Jztzey3V6X6dkScjGM+zO4649Q9pY+I54
         gTC5JY0wiv64OZc3QsaiLoUC1QXyrkpL8ursujLZinx235zB1bYCjqhQhXsQw2zDnT
         68uEWx8jIdJBuvRT5nlI/Ux53lTAVTRxep6Yz+Eau/YXRdCG0Xop/fhVfpNyLTDKC1
         0NW/ntCbUHPTwOJHrr0Gomw3dBpOqBMwmY8xiDO///GmlVnMLule62b/qdd3Z/jbTR
         Ml8yxV/U9K0Cg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53Dii3C614046;
        Mon, 3 Jun 2019 06:44:44 -0700
Date:   Mon, 3 Jun 2019 06:44:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-3724921396dd1a07c93e3516b8d7c9ff570d17a9@git.kernel.org>
Cc:     tglx@linutronix.de, mark.rutland@arm.com, hpa@zytor.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, will.deacon@arm.com
Reply-To: mark.rutland@arm.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          will.deacon@arm.com
In-Reply-To: <20190522132250.26499-17-mark.rutland@arm.com>
References: <20190522132250.26499-17-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic: Use s64 for atomic64_t on 64-bit
Git-Commit-ID: 3724921396dd1a07c93e3516b8d7c9ff570d17a9
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

Commit-ID:  3724921396dd1a07c93e3516b8d7c9ff570d17a9
Gitweb:     https://git.kernel.org/tip/3724921396dd1a07c93e3516b8d7c9ff570d17a9
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:48 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:57 +0200

locking/atomic: Use s64 for atomic64_t on 64-bit

Now that all architectures use 64 consistently as the base type for the
atomic64 API, let's have the CONFIG_64BIT definition of atomic64_t use
s64 as the underlying type for atomic64_t, rather than long, matching
the generated headers.

On architectures where atomic64_read(v) is READ_ONCE(v->counter), this
patch will cause the return type of atomic64_read() to be s64.

As of this patch, the atomic64 API can be relied upon to consistently
return s64 where a value rather than boolean condition is returned. This
should make code more robust, and simpler, allowing for the removal of
casts previously required to ensure consistent types.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
Cc: heiko.carstens@de.ibm.com
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
Link: https://lkml.kernel.org/r/20190522132250.26499-17-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 231114ae38f4..05030f608be3 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -174,7 +174,7 @@ typedef struct {
 
 #ifdef CONFIG_64BIT
 typedef struct {
-	long counter;
+	s64 counter;
 } atomic64_t;
 #endif
 
