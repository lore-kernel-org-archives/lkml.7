Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C29C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149162073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfDPT6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:58:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPT6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:58:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GJwGf33581812
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 12:58:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GJwFxV3581808;
        Tue, 16 Apr 2019 12:58:15 -0700
Date:   Tue, 16 Apr 2019 12:58:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-2d65c42b43e53d61f1fd6b8d0a097451a4cffa24@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com, mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, gustavo@embeddedor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190410170914.GA16161@embeddedor>
References: <20190410170914.GA16161@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/devres: Use struct_size() in devm_kzalloc()
Git-Commit-ID: 2d65c42b43e53d61f1fd6b8d0a097451a4cffa24
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

Commit-ID:  2d65c42b43e53d61f1fd6b8d0a097451a4cffa24
Gitweb:     https://git.kernel.org/tip/2d65c42b43e53d61f1fd6b8d0a097451a4cffa24
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Wed, 10 Apr 2019 12:09:14 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 16 Apr 2019 21:54:03 +0200

genirq/devres: Use struct_size() in devm_kzalloc()

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = devm_kzalloc(dev, size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper.

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190410170914.GA16161@embeddedor

---
 kernel/irq/devres.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f808c6a97dcc..f6e5515ee077 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -220,9 +220,8 @@ devm_irq_alloc_generic_chip(struct device *dev, const char *name, int num_ct,
 			    irq_flow_handler_t handler)
 {
 	struct irq_chip_generic *gc;
-	unsigned long sz = sizeof(*gc) + num_ct * sizeof(struct irq_chip_type);
 
-	gc = devm_kzalloc(dev, sz, GFP_KERNEL);
+	gc = devm_kzalloc(dev, struct_size(gc, chip_types, num_ct), GFP_KERNEL);
 	if (gc)
 		irq_init_generic_chip(gc, name, num_ct,
 				      irq_base, reg_base, handler);
