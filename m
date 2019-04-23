Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C61421738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfDWLlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:41:18 -0400
Received: from mail2.tencent.com ([163.177.67.195]:49680 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWLlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:41:17 -0400
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail2.tencent.com (Postfix) with ESMTP id 852328EA8C;
        Tue, 23 Apr 2019 19:41:14 +0800 (CST)
Received: from localhost.localdomain (10.35.10.40) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Apr 2019 19:41:14 +0800
From:   Jiang Biao <benbjiang@tencent.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benbjiang@tencent.com>, <cohuck@redhat.com>
Subject: [PATCH v2] kvm_main: fix some comments
Date:   Tue, 23 Apr 2019 19:40:30 +0800
Message-ID: <20190423114030.75631-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.35.10.40]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_dirty has been renamed to flush, but the comment for it is
outdated. And the description about @flush parameter for
kvm_clear_dirty_log_protect() is missing, add it in this patch
as well.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 virt/kvm/kvm_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dc8edc97ba85..6cf7e99e6003 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1134,11 +1134,11 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
 
 #ifdef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
 /**
- * kvm_get_dirty_log_protect - get a snapshot of dirty pages, and if any pages
+ * kvm_get_dirty_log_protect - get a snapshot of dirty pages
  *	and reenable dirty page tracking for the corresponding pages.
  * @kvm:	pointer to kvm instance
  * @log:	slot id and address to which we copy the log
- * @is_dirty:	flag set if any page is dirty
+ * @flush:	true if TLB flush is needed by caller
  *
  * We need to keep it in mind that VCPU threads can write to the bitmap
  * concurrently. So, to avoid losing track of dirty pages we keep the
@@ -1223,6 +1223,7 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
  *	and reenable dirty page tracking for the corresponding pages.
  * @kvm:	pointer to kvm instance
  * @log:	slot id and address from which to fetch the bitmap of dirty pages
+ * @flush:	true if TLB flush is needed by caller
  */
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush)
-- 
2.17.2 (Apple Git-113)

