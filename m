Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887C020836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688515;
	bh=NFYK4QflxG6hUn/W+pV0q6EzVFrcpnYki1aNStLrfF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9Q1AEfvJzpw1yX1WeZuQMnaHdtQo5L2nijawqECK6il8uyLEy3aOzD12og1X5UWo
	 zHCAstXXTwHf996eFovCJEWQsSNRkOBBTNMwOn4uAriT/LCWmYkci2vhJfPPxxWfhK
	 vB5f4vvepd66fQLx1a82vCW14KAVzlFSvDVWiO4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfCDIfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbfCDIfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134D920836;
        Mon,  4 Mar 2019 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688507;
        bh=NFYK4QflxG6hUn/W+pV0q6EzVFrcpnYki1aNStLrfF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GunDyYsqNgrlbDs/NEHYf/p3PSBF9LAg2u2aJouK6bs3Ev0K9pkLdZjIwBJTXU5BJ
         6s8mtU1ck2H2fdjWYk2k1OHpqAjr7u7Q7OH8H9OLrjTNexTRonArRp515hvc1rlfyT
         4ZNMC7qlIrjQd0tTfqLLAWax/ggeCo1tWM+TCURw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 67/88] KVM: selftests: check returned evmcs version range
Date:   Mon,  4 Mar 2019 09:22:50 +0100
Message-Id: <20190304081633.235146201@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 35b531a1e7fc30ac8c62e5ac1794eb1460da614e ]

Check that KVM_CAP_HYPERV_ENLIGHTENED_VMCS returns correct version range.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/x86_64/evmcs_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index ea3c73e8f4f6e..c49c2a28b0eb2 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -103,6 +103,12 @@ int main(int argc, char *argv[])
 
 	vcpu_ioctl(vm, VCPU_ID, KVM_ENABLE_CAP, &enable_evmcs_cap);
 
+	/* KVM should return supported EVMCS version range */
+	TEST_ASSERT(((evmcs_ver >> 8) >= (evmcs_ver & 0xff)) &&
+		    (evmcs_ver & 0xff) > 0,
+		    "Incorrect EVMCS version range: %x:%x\n",
+		    evmcs_ver & 0xff, evmcs_ver >> 8);
+
 	run = vcpu_state(vm, VCPU_ID);
 
 	vcpu_regs_get(vm, VCPU_ID, &regs1);
-- 
2.19.1



