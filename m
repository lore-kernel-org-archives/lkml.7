Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261E420651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDOIhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:37:35 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOIhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:37:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N5VXu-1go1wo0ujq-016ziD; Mon, 15 Apr 2019 10:37:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] s390: fix clang -Wpointer-sign warnigns in boot code
Date:   Mon, 15 Apr 2019 10:35:54 +0200
Message-Id: <20190415083605.2560074-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415083605.2560074-1-arnd@arndb.de>
References: <20190415083605.2560074-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+JLbIUuIMXUUPdWleBO4UIdDpQXAcS7S8uDzo+R8B83y56R+Hvu
 XGoRP9oLGyU14AEItutj+PkwLAyqnfeCqtQsbETN3cNZ1j28tGrAyN3oebAdKLQI92crUc8
 y0XpSFbMkkszbb1VMi5K1m/he65dwHdy7u2PL+lBD1Y7QEV027R9Zax9nGmKVbXwBK0uYeo
 iXx8SWGR3Ztv1P4J0D2fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w1XYhVbg3xY=:gFk97015++gDbZ6IlRyeOl
 nV+w001qkxAdzXfIW+eBNi3ZgwfAKYjgs1sSwgyPh/Cz3226Ga8E9z8i/e1PdG2WpEyYD+LMY
 FRJK0tOhXWvgW0l4YQaROAX6TvWuxvzIVxri6b869enQsdejL+KGs3iimEm/fLJitDKbYFpxX
 hs3Mh/XoEJrhjpz12nLZJuJcKdTF3inUqU5rIsvJX4gshrh+mLP/bhnhTNNQTnSzX4iwBtd7R
 VGlFqu3aJFL55aJA0bHlFSLRJ5hhI/Y6AQIT1zMfuEhFfgk/4yEfM/wjnp8WalQNJW/3gRufD
 bXFYAdJRZKykVP/hlA0El6reruVzptW3b6Wr6bqEqnR/SBIrzuOEvT6a3v2m+tMWn9rmR4UJf
 Zszjb53VKks5UviKj4gkOE2qf9XW1Q+6sDNZ9M7SVxzt8HCnnZlRWKM76CdnA/v+ozQEU5msU
 CeQPwGA6PtTNRRPe9svb9SyUCy7CJy6Yz42eaY/WE7UgGK8LmBovxpjL5gWrJv8uT+YU9ahuR
 nbRXp363x7/7nnT60/m0sZP3nbXv8+ldT+I6J5+Ks3hArETmQPeLK3VqGCKcC0W5KmcW1ZAW/
 +hfaz+iA/1KbBPsopc9NBNMkbvKwOz2nxY1/kUWW45VMgc4FYcwTidOqFOd/XCCm6H6puaFeO
 NhryD8lVB32nM8wU5KDB90XejG5iD/3J17IbMzXyImhFCMFEoSQTLQsO+z8w8ZnDphS6O9JcM
 mCcYpdxALx7FuKP0Cm/98bW/PDvu1Cjvj/ykyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch/s390/boot directory is built with its own set of compiler
options that does not include -Wno-pointer-sign like the rest of
the kernel does, this causes a lot of harmess but correct warnings
when building with clang.

For the atomics, we can add type casts to avoid the warnings, for
everything else the easiest way is to slightly adapt the types
to be more consistent.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/boot/ipl_parm.c       |  2 +-
 arch/s390/include/asm/bitops.h  | 12 ++++++------
 arch/s390/include/asm/ebcdic.h  |  2 +-
 arch/s390/include/asm/lowcore.h |  2 +-
 drivers/s390/char/sclp.h        |  4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 36beb56de021..3f2f0a9f1dad 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -51,7 +51,7 @@ void store_ipl_parmblock(void)
 		early_ipl_block_valid = 1;
 }
 
-static size_t scpdata_length(const char *buf, size_t count)
+static size_t scpdata_length(const u8 *buf, size_t count)
 {
 	while (count) {
 		if (buf[count - 1] != '\0' && buf[count - 1] != ' ')
diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index d1f8a4d94cca..9900d655014c 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -73,7 +73,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *ptr)
 	}
 #endif
 	mask = 1UL << (nr & (BITS_PER_LONG - 1));
-	__atomic64_or(mask, addr);
+	__atomic64_or(mask, (long *)addr);
 }
 
 static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
@@ -94,7 +94,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
 	}
 #endif
 	mask = ~(1UL << (nr & (BITS_PER_LONG - 1)));
-	__atomic64_and(mask, addr);
+	__atomic64_and(mask, (long *)addr);
 }
 
 static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
@@ -115,7 +115,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
 	}
 #endif
 	mask = 1UL << (nr & (BITS_PER_LONG - 1));
-	__atomic64_xor(mask, addr);
+	__atomic64_xor(mask, (long *)addr);
 }
 
 static inline int
@@ -125,7 +125,7 @@ test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
 	unsigned long old, mask;
 
 	mask = 1UL << (nr & (BITS_PER_LONG - 1));
-	old = __atomic64_or_barrier(mask, addr);
+	old = __atomic64_or_barrier(mask, (long *)addr);
 	return (old & mask) != 0;
 }
 
@@ -136,7 +136,7 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
 	unsigned long old, mask;
 
 	mask = ~(1UL << (nr & (BITS_PER_LONG - 1)));
-	old = __atomic64_and_barrier(mask, addr);
+	old = __atomic64_and_barrier(mask, (long *)addr);
 	return (old & ~mask) != 0;
 }
 
@@ -147,7 +147,7 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
 	unsigned long old, mask;
 
 	mask = 1UL << (nr & (BITS_PER_LONG - 1));
-	old = __atomic64_xor_barrier(mask, addr);
+	old = __atomic64_xor_barrier(mask, (long *)addr);
 	return (old & mask) != 0;
 }
 
diff --git a/arch/s390/include/asm/ebcdic.h b/arch/s390/include/asm/ebcdic.h
index 29441beb92e6..d3ce6adacb10 100644
--- a/arch/s390/include/asm/ebcdic.h
+++ b/arch/s390/include/asm/ebcdic.h
@@ -20,7 +20,7 @@ extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
 extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
 
 static inline void
-codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
+codepage_convert(const __u8 *codepage, volatile char* addr, unsigned long nr)
 {
 	if (nr-- <= 0)
 		return;
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index cc0947e08b6f..f3a637afd485 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -128,7 +128,7 @@ struct lowcore {
 	/* SMP info area */
 	__u32	cpu_nr;				/* 0x0398 */
 	__u32	softirq_pending;		/* 0x039c */
-	__u32	preempt_count;			/* 0x03a0 */
+	__s32	preempt_count;			/* 0x03a0 */
 	__u32	spinlock_lockval;		/* 0x03a4 */
 	__u32	spinlock_index;			/* 0x03a8 */
 	__u32	fpu_flags;			/* 0x03ac */
diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index 367e9d384d85..5918479ffa0e 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -365,14 +365,14 @@ sclp_ascebc(unsigned char ch)
 
 /* translate string from EBCDIC to ASCII */
 static inline void
-sclp_ebcasc_str(unsigned char *str, int nr)
+sclp_ebcasc_str(char *str, int nr)
 {
 	(MACHINE_IS_VM) ? EBCASC(str, nr) : EBCASC_500(str, nr);
 }
 
 /* translate string from ASCII to EBCDIC */
 static inline void
-sclp_ascebc_str(unsigned char *str, int nr)
+sclp_ascebc_str(char *str, int nr)
 {
 	(MACHINE_IS_VM) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
 }
-- 
2.20.0

