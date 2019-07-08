Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6EAC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EBB204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600218;
	bh=xca8CYeIjzR1uo/T5EIi/0+4EJ+hh7CYFRBwbcFEwBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QnZDJVB10ldUZzeJpNCYRAlU1yn2kbhIfXYV1UNKEKMOk4+Ii8bRgLmkVuPJz20H4
	 kCvwRvwX1TYDnC6U2AsQSy05znCo+7HEqhS+UFGYr1kifghBTHb3bKGW2pCPZvv7nL
	 1wqHxfXabQ/sP0MByDMOv41m/hZJ9ZWhHs6vmp0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390949AbfGHPgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390543AbfGHPeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:34:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062DF204EC;
        Mon,  8 Jul 2019 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600075;
        bh=xca8CYeIjzR1uo/T5EIi/0+4EJ+hh7CYFRBwbcFEwBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=im/odn07bZqIZJdy8KlF9w7/tRE8NGlRFIW4Ya13LpVn+1UX1dB0/9ksBpVtA4ksP
         yBhseCrWSbycZAzTSfnDlmSg0ks79qSQefW1gU0BthSdEubNCFco0O9UIkh2AxlQCu
         /XwLfYvq/RFZGmMIgMPX1EAYacrG93UzEprHh5+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.1 85/96] KVM: x86: degrade WARN to pr_warn_ratelimited
Date:   Mon,  8 Jul 2019 17:13:57 +0200
Message-Id: <20190708150531.038899561@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 3f16a5c318392cbb5a0c7a3d19dff8c8ef3c38ee upstream.

This warning can be triggered easily by userspace, so it should certainly not
cause a panic if panic_on_warn is set.

Reported-by: syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com
Suggested-by: Alexander Potapenko <glider@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1547,7 +1547,7 @@ static int set_tsc_khz(struct kvm_vcpu *
 			vcpu->arch.tsc_always_catchup = 1;
 			return 0;
 		} else {
-			WARN(1, "user requested TSC rate below hardware speed\n");
+			pr_warn_ratelimited("user requested TSC rate below hardware speed\n");
 			return -1;
 		}
 	}
@@ -1557,8 +1557,8 @@ static int set_tsc_khz(struct kvm_vcpu *
 				user_tsc_khz, tsc_khz);
 
 	if (ratio == 0 || ratio >= kvm_max_tsc_scaling_ratio) {
-		WARN_ONCE(1, "Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
-			  user_tsc_khz);
+		pr_warn_ratelimited("Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
+			            user_tsc_khz);
 		return -1;
 	}
 


