Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4903721880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LULD5ZqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfHHGwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:52:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbfHHGwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:52:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x786q6Y73020017
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 7 Aug 2019 23:52:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x786q6Y73020017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565247126;
        bh=X8IaFASAX4PNtkoNcQqu1RVvB8EK57wuV23coB9N5gQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LULD5ZqNV0LGTUqip1L9v+3rkGqmFTU063EteFgruRHLHxMovb+LO54AM6qLOGyzE
         5afMO1J+CogCvYCpug/3TxOLup+8DDrVjnczHRscTGVDRxLZDhOAsf7pg0j3cnNF0U
         HddeVwOwONhG61ntvGx3hkI7qBh6/w0xMkhsZuFZM+MhdBaxxFH7dtl93Sru3uBh7d
         dUCoCg+mKQvR5e+OhNAnbv2au79rDMb6LNajLd0wudspzCr+l+JMtQHL8AC7L8fNz2
         hqhjurN4R0aViABSwaflIzVMbxYU00W7qvO54gwgqiWzWByIB0ED0fMO+tbnyqfpe+
         FNWntxMMcVydw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x786q5SC3020014;
        Wed, 7 Aug 2019 23:52:05 -0700
Date:   Wed, 7 Aug 2019 23:52:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ming Lei <tipbot@zytor.com>
Message-ID: <tip-491beed3b102b6e6c0e7734200661242226e3933@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: ming.lei@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190805011906.5020-1-ming.lei@redhat.com>
References: <20190805011906.5020-1-ming.lei@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq/affinity: Create affinity mask for single
 vector
Git-Commit-ID: 491beed3b102b6e6c0e7734200661242226e3933
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

Commit-ID:  491beed3b102b6e6c0e7734200661242226e3933
Gitweb:     https://git.kernel.org/tip/491beed3b102b6e6c0e7734200661242226e3933
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Mon, 5 Aug 2019 09:19:06 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Aug 2019 08:47:55 +0200

genirq/affinity: Create affinity mask for single vector

Since commit c66d4bd110a1f8 ("genirq/affinity: Add new callback for
(re)calculating interrupt sets"), irq_create_affinity_masks() returns
NULL in case of single vector. This change has caused regression on some
drivers, such as lpfc.

The problem is that single vector requests can happen in some generic cases:

  1) kdump kernel

  2) irq vectors resource is close to exhaustion.

If in that situation the affinity mask for a single vector is not created,
every caller has to handle the special case.

There is no reason why the mask cannot be created, so remove the check for
a single vector and create the mask.

Fixes: c66d4bd110a1f8 ("genirq/affinity: Add new callback for (re)calculating interrupt sets")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190805011906.5020-1-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4352b08ae48d..6fef48033f96 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -251,11 +251,9 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 * Determine the number of vectors which need interrupt affinities
 	 * assigned. If the pre/post request exhausts the available vectors
 	 * then nothing to do here except for invoking the calc_sets()
-	 * callback so the device driver can adjust to the situation. If there
-	 * is only a single vector, then managing the queue is pointless as
-	 * well.
+	 * callback so the device driver can adjust to the situation.
 	 */
-	if (nvecs > 1 && nvecs > affd->pre_vectors + affd->post_vectors)
+	if (nvecs > affd->pre_vectors + affd->post_vectors)
 		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	else
 		affvecs = 0;
