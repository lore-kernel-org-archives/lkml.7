Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD24C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDBC20879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640172;
	bh=DkMFBUH8q41ZeGEIbJ9dFUwRW/KljHpVFXL34aCZG2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h77jba/3MlWB+HJ3sDDve7yXjSjEeSVNRTK2ZTIT1O0MmrnycKOsj2Zagoi8fgrCG
	 LdxunkJfQVJN7bx1fiJ8hTfRrzJUI3I4BfaOx75NTIlKi319Og7E6Lpb407oElDm3t
	 5L7dclyY5DBVdHG9+EEIeyyV5dE8GBvEztmkFfNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbfEWTZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390854AbfEWTZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:25:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B700206BA;
        Thu, 23 May 2019 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639554;
        bh=DkMFBUH8q41ZeGEIbJ9dFUwRW/KljHpVFXL34aCZG2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JkLgVbnWlJe1elnHNqXiHOs6j1EX5VfQGkJyGV1f7rPqo1ktTlp64GNB70UtAulJ3
         vxT9Gx1CTIs6hULW5EzxapptQ5J1xjhvlmN94Btnx9cXp2MMUJE02+mfupx85CfLl/
         +egSkUsnNBFC9ToYcZzPOq73GlEw+Bc/FcX5VLSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 128/139] KVM: selftests: make hyperv_cpuid test pass on AMD
Date:   Thu, 23 May 2019 21:06:56 +0200
Message-Id: <20190523181735.895664692@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit eba3afde1cea7dbd7881683232f2a85e2ed86bfe ]

Enlightened VMCS is only supported on Intel CPUs but the test shouldn't
fail completely.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 264425f75806b..9a21e912097c4 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -141,7 +141,13 @@ int main(int argc, char *argv[])
 
 	free(hv_cpuid_entries);
 
-	vcpu_ioctl(vm, VCPU_ID, KVM_ENABLE_CAP, &enable_evmcs_cap);
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_ENABLE_CAP, &enable_evmcs_cap);
+
+	if (rv) {
+		fprintf(stderr,
+			"Enlightened VMCS is unsupported, skip related test\n");
+		goto vm_free;
+	}
 
 	hv_cpuid_entries = kvm_get_supported_hv_cpuid(vm);
 	if (!hv_cpuid_entries)
@@ -151,6 +157,7 @@ int main(int argc, char *argv[])
 
 	free(hv_cpuid_entries);
 
+vm_free:
 	kvm_vm_free(vm);
 
 	return 0;
-- 
2.20.1



