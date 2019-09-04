Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A78C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB7D23401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620013;
	bh=O9xcmVL1ugvK6IDKb2ZZ4aZt05qsMhZMS9zH5TEmKFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WTbEAw0DdXNrllYx4g/5PGSvF2eihX9IngcxPCv2SZXS2vpHSHV5Zi1iffKa1aNYL
	 k8doC56JSQp7FKYHkAAfFt6Zgzf2ZW3QPIQULO9oMAemW2jvMB4ll/dKaeBILXetxS
	 AIIsIpXkBAWx5gonyK96GHSjnh50GyeJrnDCzQKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbfIDSAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388358AbfIDSAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:00:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7601D23717;
        Wed,  4 Sep 2019 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620010;
        bh=O9xcmVL1ugvK6IDKb2ZZ4aZt05qsMhZMS9zH5TEmKFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNtcN4iOr04b6T5N3F5zoqpUeDPazzzv932ilwh2JGW7KHsNa9GV/AHeVsZZuerFm
         2NSg6E6hUDHQ/KyNkUMxU1Q4jnTclnBjH+ooJF3m+C07pKSP0MCA9zu4CX1VTOVS3o
         cuIUC9SgQPrg9ZfkjVVHEl30XITH9OfqOufVluyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 40/83] genirq: Properly pair kobject_del() with kobject_add()
Date:   Wed,  4 Sep 2019 19:53:32 +0200
Message-Id: <20190904175307.385238447@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

commit d0ff14fdc987303aeeb7de6f1bd72c3749ae2a9b upstream.

If alloc_descs() fails before irq_sysfs_init() has run, free_desc() in the
cleanup path will call kobject_del() even though the kobject has not been
added with kobject_add().

Fix this by making the call to kobject_del() conditional on whether
irq_sysfs_init() has run.

This problem surfaced because commit aa30f47cf666 ("kobject: Add support
for default attribute groups to kobj_type") makes kobject_del() stricter
about pairing with kobject_add(). If the pairing is incorrrect, a WARNING
and backtrace occur in sysfs_remove_group() because there is no parent.

[ tglx: Add a comment to the code and make it work with CONFIG_SYSFS=n ]

Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1564703564-4116-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/irqdesc.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -267,6 +267,18 @@ static void irq_sysfs_add(int irq, struc
 	}
 }
 
+static void irq_sysfs_del(struct irq_desc *desc)
+{
+	/*
+	 * If irq_sysfs_init() has not yet been invoked (early boot), then
+	 * irq_kobj_base is NULL and the descriptor was never added.
+	 * kobject_del() complains about a object with no parent, so make
+	 * it conditional.
+	 */
+	if (irq_kobj_base)
+		kobject_del(&desc->kobj);
+}
+
 static int __init irq_sysfs_init(void)
 {
 	struct irq_desc *desc;
@@ -297,6 +309,7 @@ static struct kobj_type irq_kobj_type =
 };
 
 static void irq_sysfs_add(int irq, struct irq_desc *desc) {}
+static void irq_sysfs_del(struct irq_desc *desc) {}
 
 #endif /* CONFIG_SYSFS */
 
@@ -406,7 +419,7 @@ static void free_desc(unsigned int irq)
 	 * The sysfs entry must be serialized against a concurrent
 	 * irq_sysfs_init() as well.
 	 */
-	kobject_del(&desc->kobj);
+	irq_sysfs_del(desc);
 	delete_irq_desc(irq);
 
 	/*


