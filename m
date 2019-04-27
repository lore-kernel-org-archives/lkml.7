Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445FAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A301206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfD0P0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:26:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34822 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727408AbfD0PZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:25:58 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-0000z8-1b; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004Rf-IR; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Vineet Gupta" <vgupta@synopsys.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.902743036@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 051/202] ARC: mm: do_page_fault fixes #1: relinquish
 mmap_sem if signal arrives while handle_mm_fault
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vineet Gupta <vgupta@synopsys.com>

commit 4d447455e73b47c43dd35fcc38ed823d3182a474 upstream.

do_page_fault() forgot to relinquish mmap_sem if a signal came while
handling handle_mm_fault() - due to say a ctl+c or oom etc.
This would later cause a deadlock by acquiring it twice.

This came to light when running libc testsuite tst-tls3-malloc test but
is likely also the cause for prior seen LTP failures. Using lockdep
clearly showed what the issue was.

| # while true; do ./tst-tls3-malloc ; done
| Didn't expect signal from child: got `Segmentation fault'
| ^C
| ============================================
| WARNING: possible recursive locking detected
| 4.17.0+ #25 Not tainted
| --------------------------------------------
| tst-tls3-malloc/510 is trying to acquire lock:
| 606c7728 (&mm->mmap_sem){++++}, at: __might_fault+0x28/0x5c
|
|but task is already holding lock:
|606c7728 (&mm->mmap_sem){++++}, at: do_page_fault+0x9c/0x2a0
|
| other info that might help us debug this:
|  Possible unsafe locking scenario:
|
|       CPU0
|       ----
|  lock(&mm->mmap_sem);
|  lock(&mm->mmap_sem);
|
| *** DEADLOCK ***
|

------------------------------------------------------------
What the change does is not obvious (note to myself)

prior code was

| do_page_fault
|
|   down_read()		<-- lock taken
|   handle_mm_fault	<-- signal pending as this runs
|   if fatal_signal_pending
|       if VM_FAULT_ERROR
|           up_read
|       if user_mode
|          return	<-- lock still held, this was the BUG

New code

| do_page_fault
|
|   down_read()		<-- lock taken
|   handle_mm_fault	<-- signal pending as this runs
|   if fatal_signal_pending
|       if VM_FAULT_RETRY
|          return       <-- not same case as above, but still OK since
|                           core mm already relinq lock for FAULT_RETRY
|    ...
|
|   < Now falls through for bug case above >
|
|   up_read()		<-- lock relinquished

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arc/mm/fault.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -131,12 +131,17 @@ good_area:
 	 */
 	fault = handle_mm_fault(mm, vma, address, flags);
 
-	/* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
 	if (unlikely(fatal_signal_pending(current))) {
-		if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
-			up_read(&mm->mmap_sem);
-		if (user_mode(regs))
+
+		/*
+		 * if fault retry, mmap_sem already relinquished by core mm
+		 * so OK to return to user mode (with signal handled first)
+		 */
+		if (fault & VM_FAULT_RETRY) {
+			if (!user_mode(regs))
+				goto no_context;
 			return;
+		}
 	}
 
 	if (likely(!(fault & VM_FAULT_ERROR))) {

