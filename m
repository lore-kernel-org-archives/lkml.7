Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82900C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F56216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599089;
	bh=8FpICHuT4EzRHKjUENx9XgG+eDTgSw8j6i1/lxfkXT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pTjP8d/YLXYEwoDZhq6smgwhVUhp7Yiy2hgPdrcr+C9SqqhEoLZlU6mWI4bgqauUd
	 W1f4PnqEcRbDoRMm71eAILv/U8CgwBl9HmboijSIfZKYfsJCEbYynC0jhD3dTc++bi
	 UK79XXVRAS8Mu+bhCZiQyMO2UItu4GaC+sOYxpVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbfGHPSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfGHPSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:18:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF772166E;
        Mon,  8 Jul 2019 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599085;
        bh=8FpICHuT4EzRHKjUENx9XgG+eDTgSw8j6i1/lxfkXT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNE1aP46lDYhrCrUA0AtDlPhEsT5IEvDZUqfFEsjkgKr7u71Rv6FjsPwZ7qYwVIRM
         7nlEibyxLxwoaVri2lZTB+PmPoxbzytLU6emvIaVDkbV8oXs6aT+L1h4PFhKF6/XIs
         At+Txw6dypbkerYQkBBwEhrZ5siZjtj3hP9ZRyiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 72/73] KVM: x86: degrade WARN to pr_warn_ratelimited
Date:   Mon,  8 Jul 2019 17:13:22 +0200
Message-Id: <20190708150525.030241522@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
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
@@ -1293,7 +1293,7 @@ static int set_tsc_khz(struct kvm_vcpu *
 			vcpu->arch.tsc_always_catchup = 1;
 			return 0;
 		} else {
-			WARN(1, "user requested TSC rate below hardware speed\n");
+			pr_warn_ratelimited("user requested TSC rate below hardware speed\n");
 			return -1;
 		}
 	}
@@ -1303,8 +1303,8 @@ static int set_tsc_khz(struct kvm_vcpu *
 				user_tsc_khz, tsc_khz);
 
 	if (ratio == 0 || ratio >= kvm_max_tsc_scaling_ratio) {
-		WARN_ONCE(1, "Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
-			  user_tsc_khz);
+		pr_warn_ratelimited("Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
+			            user_tsc_khz);
 		return -1;
 	}
 


