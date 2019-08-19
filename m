Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E250CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B892064A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HHgnOrh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfHSOBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:01:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfHSOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:01:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7JE16CS4169973
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 07:01:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7JE16CS4169973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566223267;
        bh=VEXomE9QNd6gB1XcE7lQbh06Yd7VvKl7S0Flkxa4Nm8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HHgnOrh6j1yB4WnDdp/NOVjoGirR7EBnsb7QB9APps0fNOX3rxZN5GQfT/DLWpp2U
         n6zFjMkc5o5kyohktb76B376ssn1IZJ9/Oyd29DqqaXhwQ1MYNp/o+YZf9GtrDdDEU
         JcUEqYgeR2ATdnXFudDXQpNqNsBTtOw4Ny6CJ+8Gb6IElj15oE5Qt6uOVtj4SlEdhT
         PBo1jnxJbW9yxC7CkFliO/QGcqtqutU0Ij5B8hu2iu9pwC/lGpFDajhFLWtCajz8Dv
         0g7ILGzDrMxU13CfFlNjiZH71pGWMMkcDep33Jys7P/mBbUNPXZHtb4Vc8F5g3l6Lc
         AERWV9RlqCTNQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7JE16MP4169970;
        Mon, 19 Aug 2019 07:01:06 -0700
Date:   Mon, 19 Aug 2019 07:01:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Kelley <tipbot@zytor.com>
Message-ID: <tip-e1ee29624746fbf667f80e8ae3815a76e4d1bd5b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          gregkh@linuxfoundation.org, mikelley@microsoft.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1564703564-4116-1-git-send-email-mikelley@microsoft.com>
References: <1564703564-4116-1-git-send-email-mikelley@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Properly pair kobject_del() with
 kobject_add()
Git-Commit-ID: e1ee29624746fbf667f80e8ae3815a76e4d1bd5b
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

Commit-ID:  e1ee29624746fbf667f80e8ae3815a76e4d1bd5b
Gitweb:     https://git.kernel.org/tip/e1ee29624746fbf667f80e8ae3815a76e4d1bd5b
Author:     Michael Kelley <mikelley@microsoft.com>
AuthorDate: Thu, 1 Aug 2019 23:53:53 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 19 Aug 2019 15:56:28 +0200

genirq: Properly pair kobject_del() with kobject_add()

If alloc_descs() fails before irq_sysfs_init() has run, free_desc() in the
cleanup path will call kobject_del() even though the kobject has not been
added with kobject_add().

Fix this by making the call to kobject_del() conditional on whether
irq_sysfs_init() has run.

This problem surfaced because commit aa30f47cf666 ("kobject: Add support
for default attribute groups to kobj_type") makes kobject_del() stricter
about pairing with kobject_add(). If the pairing is incorrrect, a WARNING
and backtrace occur in sysfs_remove_group() because there is no parent.

[ tglx: Add a comment to the code ]

Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1564703564-4116-1-git-send-email-mikelley@microsoft.com

---
 kernel/irq/irqdesc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 9484e88dabc2..51f42f3caf09 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -437,8 +437,14 @@ static void free_desc(unsigned int irq)
 	 *
 	 * The sysfs entry must be serialized against a concurrent
 	 * irq_sysfs_init() as well.
+	 *
+	 * If irq_sysfs_init() has not yet been invoked (early boot), then
+	 * irq_kobj_base is NULL and the descriptor was never added.
+	 * kobject_del() complains about a object with no parent, so make
+	 * it conditional.
 	 */
-	kobject_del(&desc->kobj);
+	if (irq_kobj_base)
+		kobject_del(&desc->kobj);
 	delete_irq_desc(irq);
 
 	/*
