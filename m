Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410CFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064E020693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDOMez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:34:55 -0400
Received: from [110.188.70.11] ([110.188.70.11]:41896 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727129AbfDOMey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:34:54 -0400
X-Greylist: delayed 1561 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 08:34:53 EDT
Received: from spam2.hygon.cn (localhost [127.0.0.2] (may be forged))
        by spam2.hygon.cn with ESMTP id x3FC8xIO059284;
        Mon, 15 Apr 2019 20:08:59 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id x3FC7f4O059224;
        Mon, 15 Apr 2019 20:07:41 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
        by MK-DB.hygon.cn with ESMTP id x3FC7Vax053939;
        Mon, 15 Apr 2019 20:07:31 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from harry-Inspiron-5675.higon.com (172.23.18.44) by
 cncheex02.Hygon.cn (172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 15 Apr
 2019 20:07:35 +0800
From:   Hao Feng <fenghao@hygon.cn>
To:     "'Paolo Bonzini '" <pbonzini@redhat.com>,
        =?UTF-8?q?=27=20Radim=20Kr=C4=8Dm=C3=A1=C5=99=20=27?= 
        <rkrcmar@redhat.com>
CC:     "'Zhaohui Du '" <duzhaohui@hygon.cn>,
        "'Zhiwei Ying '" <yingzhiwei@hygon.cn>,
        "'Wen Pu '" <puwen@hygon.cn>, Hao Feng <fenghao@hygon.cn>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] KVM: Define Hygon SEV commands
Date:   Mon, 15 Apr 2019 20:04:26 +0800
Message-ID: <1555329868-17895-5-git-send-email-fenghao@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
References: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex02.Hygon.cn
 (172.23.18.12)
X-MAIL: spam2.hygon.cn x3FC7f4O059224
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. KVM_SEV_GM_GET_DIGEST
------------------------
The command is used to get the key digest from SEV firmware, guest
owner will check the key digest to see if the key negotiation is
successful or not.

2. KVM_SEV_GM_VERIFY_DIGEST
---------------------------
The command is used to send guest owner's key digest to SEV firmware,
firmware will check the key digest to see if the key negotiation is
successful or not.

Signed-off-by: Hao Feng <fenghao@hygon.cn>
---
 include/uapi/linux/kvm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6d4ea4b..3eb8858 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1469,6 +1469,10 @@ enum sev_cmd_id {
 	/* Guest certificates commands */
 	KVM_SEV_CERT_EXPORT,
 
+	/* GM specific commands */
+	KVM_SEV_GM_GET_DIGEST,
+	KVM_SEV_GM_VERIFY_DIGEST,
+
 	KVM_SEV_NR_MAX,
 };
 
@@ -1520,6 +1524,16 @@ struct kvm_sev_dbg {
 	__u32 len;
 };
 
+struct kvm_sev_gm_get_digest {
+	__u64 uaddr;
+	__u32 len;
+};
+
+struct kvm_sev_gm_verify_digest {
+	__u64 uaddr;
+	__u32 len;
+};
+
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
 #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-- 
2.7.4

