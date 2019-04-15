Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C740C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C5B2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfDOMgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:36:44 -0400
Received: from [110.188.70.11] ([110.188.70.11]:28988 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727440AbfDOMgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:36:43 -0400
Received: from spam1.hygon.cn (localhost [127.0.0.2] (may be forged))
        by spam1.hygon.cn with ESMTP id x3FCAaXJ027058;
        Mon, 15 Apr 2019 20:10:36 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id x3FC7ofR026700;
        Mon, 15 Apr 2019 20:07:50 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
        by MK-FE.hygon.cn with ESMTP id x3FC7Ix1022141;
        Mon, 15 Apr 2019 20:07:18 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from harry-Inspiron-5675.higon.com (172.23.18.44) by
 cncheex02.Hygon.cn (172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 15 Apr
 2019 20:07:48 +0800
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
Subject: [PATCH 5/6] KVM: SVM: Add support for KVM_SEV_GM_GET_DIGEST command
Date:   Mon, 15 Apr 2019 20:04:27 +0800
Message-ID: <1555329868-17895-6-git-send-email-fenghao@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
References: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex02.Hygon.cn
 (172.23.18.12)
X-MAIL: spam1.hygon.cn x3FC7ofR026700
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command is used to get the key digest from SEV firmware, guest
owner will check the key digest to see if the key negotiation is
successful or not.

Signed-off-by: Hao Feng <fenghao@hygon.cn>
Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kvm/svm.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index e0a791c..f8e7042 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6946,6 +6946,75 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int sev_gm_get_digest(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	void __user *digest = (void __user *)(uintptr_t)argp->data;
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_gm_get_digest *data;
+	struct kvm_sev_gm_get_digest params;
+	void __user *p = NULL;
+	void *blob = NULL;
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
+	/* User wants to query the blob length */
+	if (!params.len)
+		goto cmd;
+
+	p = (void __user *)(uintptr_t)params.uaddr;
+	if (p) {
+		if (params.len > SEV_FW_BLOB_MAX_SIZE) {
+			ret = -EINVAL;
+			goto e_free;
+		}
+
+		ret = -ENOMEM;
+		blob = kmalloc(params.len, GFP_KERNEL);
+		if (!blob)
+			goto e_free;
+
+		data->address = __psp_pa(blob);
+		data->len = params.len;
+	}
+
+cmd:
+	data->handle = sev->handle;
+	ret = sev_issue_cmd(kvm, SEV_CMD_GM_GET_DIGEST, data, &argp->error);
+
+	/*
+	 * If we query the session length, FW responded with expected data.
+	 */
+	if (!params.len)
+		goto done;
+
+	if (ret)
+		goto e_free_blob;
+
+	if (blob) {
+		if (copy_to_user(p, blob, params.len))
+			ret = -EFAULT;
+	}
+
+done:
+	params.len = data->len;
+	if (copy_to_user(digest, &params, sizeof(params)))
+		ret = -EFAULT;
+e_free_blob:
+	kfree(blob);
+e_free:
+	kfree(data);
+	return ret;
+}
+
 static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -6987,6 +7056,9 @@ static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_LAUNCH_SECRET:
 		r = sev_launch_secret(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_GM_GET_DIGEST:
+		r = sev_gm_get_digest(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
-- 
2.7.4

