Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84697C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2FB2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbfDBNpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:45:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43276 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731453AbfDBNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:06 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002no-B2; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004wV-FP; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Andrew Honig" <ahonig@google.com>,
        "Marc Orr" <marcorr@google.com>, "Cfir Cohen" <cfir@google.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Jim Mattson" <jmattson@google.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.932552984@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 75/99] kvm: Disallow wraparound in kvm_gfn_to_hva_cache_init
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit f1b9dd5eb86cec1fcf66aad17e7701d98d024a9a upstream.

Previously, in the case where (gpa + len) wrapped around, the entire
region was not validated, as the comment claimed. It doesn't actually
seem that wraparound should be allowed here at all.

Furthermore, since some callers don't check the return code from this
function, it seems prudent to clear ghc->memslot in the event of an
error.

Fixes: 8f964525a121f ("KVM: Allow cross page reads and writes from cached translations.")
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Cfir Cohen <cfir@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Cc: Andrew Honig <ahonig@google.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1555,31 +1555,33 @@ int kvm_gfn_to_hva_cache_init(struct kvm
 	gfn_t end_gfn = (gpa + len - 1) >> PAGE_SHIFT;
 	gfn_t nr_pages_needed = end_gfn - start_gfn + 1;
 	gfn_t nr_pages_avail;
+	int r = start_gfn <= end_gfn ? 0 : -EINVAL;
 
 	ghc->gpa = gpa;
 	ghc->generation = slots->generation;
 	ghc->len = len;
-	ghc->memslot = gfn_to_memslot(kvm, start_gfn);
-	ghc->hva = gfn_to_hva_many(ghc->memslot, start_gfn, NULL);
-	if (!kvm_is_error_hva(ghc->hva) && nr_pages_needed <= 1) {
+	ghc->hva = KVM_HVA_ERR_BAD;
+
+	/*
+	 * If the requested region crosses two memslots, we still
+	 * verify that the entire region is valid here.
+	 */
+	while (!r && start_gfn <= end_gfn) {
+		ghc->memslot = gfn_to_memslot(kvm, start_gfn);
+		ghc->hva = gfn_to_hva_many(ghc->memslot, start_gfn,
+					   &nr_pages_avail);
+		if (kvm_is_error_hva(ghc->hva))
+			r = -EFAULT;
+		start_gfn += nr_pages_avail;
+	}
+
+	/* Use the slow path for cross page reads and writes. */
+	if (!r && nr_pages_needed == 1)
 		ghc->hva += offset;
-	} else {
-		/*
-		 * If the requested region crosses two memslots, we still
-		 * verify that the entire region is valid here.
-		 */
-		while (start_gfn <= end_gfn) {
-			ghc->memslot = gfn_to_memslot(kvm, start_gfn);
-			ghc->hva = gfn_to_hva_many(ghc->memslot, start_gfn,
-						   &nr_pages_avail);
-			if (kvm_is_error_hva(ghc->hva))
-				return -EFAULT;
-			start_gfn += nr_pages_avail;
-		}
-		/* Use the slow path for cross page reads and writes. */
+	else
 		ghc->memslot = NULL;
-	}
-	return 0;
+
+	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_gfn_to_hva_cache_init);
 

