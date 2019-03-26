Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57510C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F7C2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582412;
	bh=xUPRejf6ov5JB02EL8bohu6/bgbzeJbqSlBOJZ6c5RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J6mL5s+Hq9KIJ6CIRyeI/M0hWJRlaOvcPQGuJ22uDmjPrIFLnEXCY5PuifD10gKeR
	 toy0LUwoAd8EOntFAntWIhXvKg/yCVhR5R1EHDjjPuhyngIuDsz+3Le2ZatCfId79C
	 /904g7buVbAJkkd+4vS0mA5/ZqU0OkOBPrr2IhuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbfCZGkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbfCZGkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:06 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A77D2086C;
        Tue, 26 Mar 2019 06:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582405;
        bh=xUPRejf6ov5JB02EL8bohu6/bgbzeJbqSlBOJZ6c5RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S38FE4aaAFY+K7Cw9bRScvAUWuAEE0a2qbRzgTGEncNuLxG7Oak6ZE4xp2UPKgiQc
         usS82V9cbvoZ2Px3yxu5x7htmWIe0r8cQc5KX8dWfkdzjJTbVALrp7+CpSkSqwTUTB
         YDuh63hFvGF0yRThsc8L1dKuTue5P48Ifnus2p0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Drnec <jaydee@email.cz>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 17/52] powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038
Date:   Tue, 26 Mar 2019 15:30:04 +0900
Message-Id: <20190326042701.778799744@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit b5b4453e7912f056da1ca7572574cada32ecb60c upstream.

Jakub Drnec reported:
  Setting the realtime clock can sometimes make the monotonic clock go
  back by over a hundred years. Decreasing the realtime clock across
  the y2k38 threshold is one reliable way to reproduce. Allegedly this
  can also happen just by running ntpd, I have not managed to
  reproduce that other than booting with rtc at >2038 and then running
  ntp. When this happens, anything with timers (e.g. openjdk) breaks
  rather badly.

And included a test case (slightly edited for brevity):
  #define _POSIX_C_SOURCE 199309L
  #include <stdio.h>
  #include <time.h>
  #include <stdlib.h>
  #include <unistd.h>

  long get_time(void) {
    struct timespec tp;
    clock_gettime(CLOCK_MONOTONIC, &tp);
    return tp.tv_sec + tp.tv_nsec / 1000000000;
  }

  int main(void) {
    long last = get_time();
    while(1) {
      long now = get_time();
      if (now < last) {
        printf("clock went backwards by %ld seconds!\n", last - now);
      }
      last = now;
      sleep(1);
    }
    return 0;
  }

Which when run concurrently with:
 # date -s 2040-1-1
 # date -s 2037-1-1

Will detect the clock going backward.

The root cause is that wtom_clock_sec in struct vdso_data is only a
32-bit signed value, even though we set its value to be equal to
tk->wall_to_monotonic.tv_sec which is 64-bits.

Because the monotonic clock starts at zero when the system boots the
wall_to_montonic.tv_sec offset is negative for current and future
dates. Currently on a freshly booted system the offset will be in the
vicinity of negative 1.5 billion seconds.

However if the wall clock is set past the Y2038 boundary, the offset
from wall to monotonic becomes less than negative 2^31, and no longer
fits in 32-bits. When that value is assigned to wtom_clock_sec it is
truncated and becomes positive, causing the VDSO assembly code to
calculate CLOCK_MONOTONIC incorrectly.

That causes CLOCK_MONOTONIC to jump ahead by ~4 billion seconds which
it is not meant to do. Worse, if the time is then set back before the
Y2038 boundary CLOCK_MONOTONIC will jump backward.

We can fix it simply by storing the full 64-bit offset in the
vdso_data, and using that in the VDSO assembly code. We also shuffle
some of the fields in vdso_data to avoid creating a hole.

The original commit that added the CLOCK_MONOTONIC support to the VDSO
did actually use a 64-bit value for wtom_clock_sec, see commit
a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support to
32 bits kernel") (Nov 2005). However just 3 days later it was
converted to 32-bits in commit 0c37ec2aa88b ("[PATCH] powerpc: vdso
fixes (take #2)"), and the bug has existed since then AFAICS.

Fixes: 0c37ec2aa88b ("[PATCH] powerpc: vdso fixes (take #2)")
Cc: stable@vger.kernel.org # v2.6.15+
Link: http://lkml.kernel.org/r/HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz
Reported-by: Jakub Drnec <jaydee@email.cz>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/vdso_datapage.h  |    8 ++++----
 arch/powerpc/kernel/vdso64/gettimeofday.S |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -82,10 +82,10 @@ struct vdso_data {
 	__u32 icache_block_size;		/* L1 i-cache block size     */
 	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
 	__u32 icache_log_block_size;		/* L1 i-cache log block size */
-	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
-	__s32 wtom_clock_nsec;
-	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
-	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
+	__u32 stamp_sec_fraction;		/* fractional seconds of stamp_xtime */
+	__s32 wtom_clock_nsec;			/* Wall to monotonic clock nsec */
+	__s64 wtom_clock_sec;			/* Wall to monotonic clock sec */
+	struct timespec stamp_xtime;		/* xtime as at tb_orig_stamp */
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 };
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -92,7 +92,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	 * At this point, r4,r5 contain our sec/nsec values.
 	 */
 
-	lwa	r6,WTOM_CLOCK_SEC(r3)
+	ld	r6,WTOM_CLOCK_SEC(r3)
 	lwa	r9,WTOM_CLOCK_NSEC(r3)
 
 	/* We now have our result in r6,r9. We create a fake dependency
@@ -125,7 +125,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	bne     cr6,75f
 
 	/* CLOCK_MONOTONIC_COARSE */
-	lwa     r6,WTOM_CLOCK_SEC(r3)
+	ld	r6,WTOM_CLOCK_SEC(r3)
 	lwa     r9,WTOM_CLOCK_NSEC(r3)
 
 	/* check if counter has updated */


