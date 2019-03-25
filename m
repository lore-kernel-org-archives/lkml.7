Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CE720830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfCYHVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:21:02 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38400 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbfCYHVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:21:02 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 2E27C768BC215687EE7B;
        Mon, 25 Mar 2019 15:20:54 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x2P7K9dr051101;
        Mon, 25 Mar 2019 15:20:09 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019032515201496-6222746 ;
          Mon, 25 Mar 2019 15:20:14 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  kvm: fix a function description error
Date:   Mon, 25 Mar 2019 23:43:51 +0800
Message-Id: <1553528631-74808-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-25 15:20:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-25 15:20:08,
        Serialize complete at 2019-03-25 15:20:08
X-MAIL: mse01.zte.com.cn x2P7K9dr051101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter's name of function description is different from
definition.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 virt/kvm/kvm_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5858452..4e11918 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1134,7 +1134,7 @@ int kvm_get_dirty_log(struct kvm *kvm,
  *	and reenable dirty page tracking for the corresponding pages.
  * @kvm:	pointer to kvm instance
  * @log:	slot id and address to which we copy the log
- * @is_dirty:	flag set if any page is dirty
+ * @flush:	flag set if any page is dirty (need to flush tlb)
  *
  * We need to keep it in mind that VCPU threads can write to the bitmap
  * concurrently. So, to avoid losing track of dirty pages we keep the
@@ -1221,6 +1221,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
  *	and reenable dirty page tracking for the corresponding pages.
  * @kvm:	pointer to kvm instance
  * @log:	slot id and address from which to fetch the bitmap of dirty pages
+ * @flush:	flag set if any page is dirty (need to flush tlb)
  */
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush)
-- 
1.8.3.1

