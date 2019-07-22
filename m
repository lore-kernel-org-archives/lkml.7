Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1445C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81F120578
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="v1QN7TO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfGVJLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:11:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41047 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfGVJLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:11:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M9BaXw3755349
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 02:11:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M9BaXw3755349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563786697;
        bh=NL8XG6AKJuYvtCg9d3NUabfxpNd9eWvK2R4AwlJVqKs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=v1QN7TO5ION+ty5gkddRUcu/uIjxBzdFKGGfBcfC/SBOQ53hym4JPxlH40E8ux0Ph
         a5w4ipT/eGIu8HWqRZ4sxSl3DviTIFrKb1BSZ63H8wD9Bet/Lu+wTzVoRaSVvWvpzV
         exY5z3A3JHt8v/Fh1C+5WCF+8SIyAwINnsvYFemJjcMfWgriRfGpIDfP/7TjzY9pXd
         pTy2W4rSWjHlkaZfcQzO4wdul1zpFBnxRzD9RAOH9HiSrxrHn9oYHMcWeIHmWe7N4t
         kL2bPp0Kjc+kVq0HXHEzwT6FtvLIULPQdArqhNVrd/hwSgg41MGck8lMl/ua6FVSSa
         4m03JCy8aL2yw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M9BaRj3755346;
        Mon, 22 Jul 2019 02:11:36 -0700
Date:   Mon, 22 Jul 2019 02:11:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Maya Nakamura <tipbot@zytor.com>
Message-ID: <tip-83527ef7abf7c02c33a90b00f0954db35415adbd@git.kernel.org>
Cc:     m.maya.nakamura@gmail.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        sashal@kernel.org, vkuznets@redhat.com, mingo@kernel.org
Reply-To: mikelley@microsoft.com, linux-kernel@vger.kernel.org,
          m.maya.nakamura@gmail.com, vkuznets@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, sashal@kernel.org, hpa@zytor.com
In-Reply-To: <0d9e80ecabcc950dc279fdd2e39bea4060123ba4.1562916939.git.m.maya.nakamura@gmail.com>
References: <0d9e80ecabcc950dc279fdd2e39bea4060123ba4.1562916939.git.m.maya.nakamura@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] drivers: hv: vmbus: Replace page definition with
 Hyper-V specific one
Git-Commit-ID: 83527ef7abf7c02c33a90b00f0954db35415adbd
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

Commit-ID:  83527ef7abf7c02c33a90b00f0954db35415adbd
Gitweb:     https://git.kernel.org/tip/83527ef7abf7c02c33a90b00f0954db35415adbd
Author:     Maya Nakamura <m.maya.nakamura@gmail.com>
AuthorDate: Fri, 12 Jul 2019 08:25:18 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 11:06:45 +0200

drivers: hv: vmbus: Replace page definition with Hyper-V specific one

Replace PAGE_SIZE with HV_HYP_PAGE_SIZE because the guest page size may not
be 4096 on all architectures and Hyper-V always runs with a page size of
4096.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Acked-by: Sasha Levin <sashal@kernel.org>
Link: https://lkml.kernel.org/r/0d9e80ecabcc950dc279fdd2e39bea4060123ba4.1562916939.git.m.maya.nakamura@gmail.com

---
 drivers/hv/hyperv_vmbus.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 362e70e9d145..6bf64cb6e31a 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -192,11 +192,11 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       u64 *requestid, bool raw);
 
 /*
- * Maximum channels is determined by the size of the interrupt page
- * which is PAGE_SIZE. 1/2 of PAGE_SIZE is for send endpoint interrupt
- * and the other is receive endpoint interrupt
+ * The Maximum number of channels (16348) is determined by the size of the
+ * interrupt page, which is HV_HYP_PAGE_SIZE. 1/2 of HV_HYP_PAGE_SIZE is to
+ * send endpoint interrupts, and the other is to receive endpoint interrupts.
  */
-#define MAX_NUM_CHANNELS	((PAGE_SIZE >> 1) << 3)	/* 16348 channels */
+#define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
 
 /* The value here must be in multiple of 32 */
 /* TODO: Need to make this configurable */
