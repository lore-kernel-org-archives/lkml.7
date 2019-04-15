Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78FEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ED72077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfDOMhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:37:14 -0400
Received: from [110.188.70.11] ([110.188.70.11]:40560 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727513AbfDOMhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:37:13 -0400
Received: from spam1.hygon.cn (localhost [127.0.0.2] (may be forged))
        by spam1.hygon.cn with ESMTP id x3FCAnZR027062;
        Mon, 15 Apr 2019 20:10:49 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam1.hygon.cn with ESMTP id x3FC81TD026732;
        Mon, 15 Apr 2019 20:08:01 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
        by MK-DB.hygon.cn with ESMTP id x3FC7sc5053956;
        Mon, 15 Apr 2019 20:07:54 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from harry-Inspiron-5675.higon.com (172.23.18.44) by
 cncheex02.Hygon.cn (172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 15 Apr
 2019 20:07:58 +0800
From:   Hao Feng <fenghao@hygon.cn>
To:     "'Joerg Roedel '" <joro@8bytes.org>,
        "'Paolo Bonzini '" <pbonzini@redhat.com>,
        =?UTF-8?q?=27=20Radim=20Kr=C4=8Dm=C3=A1=C5=99=20=27?= 
        <rkrcmar@redhat.com>, "'Thomas Gleixner '" <tglx@linutronix.de>,
        "'Ingo Molnar '" <mingo@redhat.com>,
        "'Borislav Petkov '" <bp@alien8.de>,
        "' H. Peter Anvin '" <hpa@zytor.com>
CC:     "'Zhaohui Du '" <duzhaohui@hygon.cn>,
        "'Zhiwei Ying '" <yingzhiwei@hygon.cn>,
        "'Wen Pu '" <puwen@hygon.cn>, Hao Feng <fenghao@hygon.cn>,
        <x86@kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] KVM: SVM: Add support for KVM_SEV_GM_VERIFY_DIGEST command
Date:   Mon, 15 Apr 2019 20:04:28 +0800
Message-ID: <1555329868-17895-7-git-send-email-fenghao@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
References: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex02.Hygon.cn
 (172.23.18.12)
X-MAIL: spam1.hygon.cn x3FC81TD026732
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command is used to send guest owner's key digest to SEV firmware,
firmware will check the key digest to see if the key negotiation is
successful or not.

Signed-off-by: Hao Feng <fenghao@hygon.cn>
Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kvm/svm.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f8e7042..4dbdccf 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7015,6 +7015,50 @@ static int sev_gm_get_digest(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int sev_gm_verify_digest(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	void __user *digest = (void __user *)(uintptr_t)argp->data;
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_gm_verify_digest *data = NULL;
+	struct kvm_sev_gm_verify_digest params;
+	void *digest_blob = NULL;
+	int *error = &argp->error;
+	int ret;
+
+	if (!sev_guest(kvm))
+		return -ENOTTY;
+
+	if (copy_from_user(&params, digest, sizeof(params)))
+		return -EFAULT;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (params.uaddr) {
+		digest_blob = psp_copy_user_blob(params.uaddr, params.len);
+		if (IS_ERR(digest_blob)) {
+			ret = PTR_ERR(digest_blob);
+			goto e_free;
+		}
+
+		data->address = __psp_pa(digest_blob);
+		data->len = params.len;
+	}
+
+	data->handle = sev->handle;
+	ret = sev_issue_cmd(kvm, SEV_CMD_GM_VERIFY_DIGEST, data, error);
+	if (ret)
+		goto e_free_digest;
+
+e_free_digest:
+	kfree(digest_blob);
+e_free:
+	kfree(data);
+
+	return ret;
+}
+
 static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -7059,6 +7103,9 @@ static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_GM_GET_DIGEST:
 		r = sev_gm_get_digest(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_GM_VERIFY_DIGEST:
+		r = sev_gm_verify_digest(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
-- 
2.7.4

