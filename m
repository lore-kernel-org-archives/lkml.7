Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD18C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA4620665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600725;
	bh=AWJ23jwBSxiKwBy12/lKgZfKk5wUHXCa/NwUSw44VtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Am/80FiaVxbEwnRcM2RZ1YiliS6IcR9BNliJFJA1ioRsBqEC2LjxzQKb49qe2/Are
	 gQRRqt/yGBc2WGco2sEl8OKlGQovw+JNnzBCFbrMIaFlx5/d9odCcwnoPM8m8hEeDw
	 3hjIHRe5RJjcBdMtyhbgU7rRqw0U0EI7JgiFgbeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfGHPW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387935AbfGHPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:22:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4966F2182B;
        Mon,  8 Jul 2019 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599340;
        bh=AWJ23jwBSxiKwBy12/lKgZfKk5wUHXCa/NwUSw44VtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtvcKWbduDeI1d3eryD9Wo5JZiCVX/PiWS9fP2mjbf2Kv8/g7cC+F50iIx8mAB7hO
         q+lRL5q/rbq70pkuo7DjdctwBQutMTsszuBCKxIcDOY80rVL/zOUj6VfNw/5riWHW1
         Hf015TUVHo8u0E4G2BNrY/0t/fpAxj4u2cdfOeOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 083/102] KVM: x86: degrade WARN to pr_warn_ratelimited
Date:   Mon,  8 Jul 2019 17:13:16 +0200
Message-Id: <20190708150530.766568321@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
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
@@ -1365,7 +1365,7 @@ static int set_tsc_khz(struct kvm_vcpu *
 			vcpu->arch.tsc_always_catchup = 1;
 			return 0;
 		} else {
-			WARN(1, "user requested TSC rate below hardware speed\n");
+			pr_warn_ratelimited("user requested TSC rate below hardware speed\n");
 			return -1;
 		}
 	}
@@ -1375,8 +1375,8 @@ static int set_tsc_khz(struct kvm_vcpu *
 				user_tsc_khz, tsc_khz);
 
 	if (ratio == 0 || ratio >= kvm_max_tsc_scaling_ratio) {
-		WARN_ONCE(1, "Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
-			  user_tsc_khz);
+		pr_warn_ratelimited("Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
+			            user_tsc_khz);
 		return -1;
 	}
 


