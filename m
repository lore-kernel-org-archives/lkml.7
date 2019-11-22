Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3008F2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403957;
	bh=jbC6ZhBxthZDxgG7DkeDeiHxtbSvJq26q5IiyQFNSwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1sZ7Z7ln98NtTL4d/T8Sq27DTe6NzTXnjFG9IBxb874V7EenbwYzRrvwrxg/sXysP
	 eg48K9kI39TO/PgkB0KKdE6j5ziq5o0XmbeRMzM6A1Z7LO9zyJ6HOwWF4T5jrcpT3q
	 nA6/iESSfQKJkjOyoBwvf+78/6CiMAtTOumn2DdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfKVGZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbfKVFu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85CB12070E;
        Fri, 22 Nov 2019 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401856;
        bh=jbC6ZhBxthZDxgG7DkeDeiHxtbSvJq26q5IiyQFNSwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=id6C97YUSF+Dcn08NN5WnXrVqwI3tyFODngAYFxi3MFXPDiLB/fP4FJqD24ruQcmH
         w5m2Cwc+939pqJtGJuU0D+PCViJxDqFoHQwmW6V5RBuq4KvdOEC35xxuZhuBFwpzNt
         BDQKFJTeW3nNJ9Fz8a99nktr0dVhoDaNVSq7yUZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Mueller <mimu@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 093/219] KVM: s390: unregister debug feature on failing arch init
Date:   Fri, 22 Nov 2019 00:47:05 -0500
Message-Id: <20191122054911.1750-86-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Mueller <mimu@linux.ibm.com>

[ Upstream commit 308c3e6673b012beecb96ef04cc65f4a0e7cdd99 ]

Make sure the debug feature and its allocated resources get
released upon unsuccessful architecture initialization.

A related indication of the issue will be reported as kernel
message.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181130143215.69496-2-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/kvm-s390.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3c317bc6b7997..db3196aebaa1c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -416,19 +416,30 @@ static void kvm_s390_cpu_feat_init(void)
 
 int kvm_arch_init(void *opaque)
 {
+	int rc;
+
 	kvm_s390_dbf = debug_register("kvm-trace", 32, 1, 7 * sizeof(long));
 	if (!kvm_s390_dbf)
 		return -ENOMEM;
 
 	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view)) {
-		debug_unregister(kvm_s390_dbf);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out_debug_unreg;
 	}
 
 	kvm_s390_cpu_feat_init();
 
 	/* Register floating interrupt controller interface. */
-	return kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
+	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
+	if (rc) {
+		pr_err("Failed to register FLIC rc=%d\n", rc);
+		goto out_debug_unreg;
+	}
+	return 0;
+
+out_debug_unreg:
+	debug_unregister(kvm_s390_dbf);
+	return rc;
 }
 
 void kvm_arch_exit(void)
-- 
2.20.1

