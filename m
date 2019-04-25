Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89BDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C59205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hbqoZuBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfDYTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43728 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387832AbfDYTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:54:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so356641pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=YlT1r5bmAsoa4DEBXIEQB9y+1vwhu/lhRDvwSPK3b8o=;
        b=hbqoZuBr5k64uC6MJ04hMIpeFXrE5NUfk1ioXPsaG0n1rXPN5sdIyqdbh7bL9C9hgY
         zFEPROTz/pAmbwzwJNXKKNTzOPrf0okgEmwCYtuJbMTjzAG5tuA4nJSLwSFHyH6jZg51
         jrERHEu7DD3v93rCss7PPjA0SuV6clusJaR19NUTrKaHX+Jyf68Bzf9GVZ6LbyFWzhk7
         o/ojJhymBa949DO6b7+m0wrscl7E/q36HdYR05cezVU1+1L+W7UJhgSIlIwPb7KC/A3S
         YvMOxa5wm4I8ftUnj/lqanfgy2O8Jim5cJ3Di6LeI5v8xcQuQLbV2q1YP8kgB3zTEp2c
         bjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=YlT1r5bmAsoa4DEBXIEQB9y+1vwhu/lhRDvwSPK3b8o=;
        b=sqUER8glmW2yziURhuDHvNil5fqTZ/9FK+xvhzKdHZVW06Gg9cgL4Q/YSPcpuuKCRV
         iWPw/zRRzUalszTrCmbHQmx/c41RxCrqUFyNfGr/83PXzNi2RIlIYsBP2b3zXGk16UI3
         Ipx3Ldf0urycQCiqmWyRoyTXcxZZBN9uldyKshpPs7DYP1nSiUkZ5gM8psUG1oUbE8Za
         9Ymlg8dQZrL2dnn6QudUfSxAq/82cfmYa4FNX8Ab3bFnAL+5/pognqGrPhFJ7bly33mA
         a2LKc1/Iyw2F78jg4mmU17zUZaiPoUZ/fYi8UYFuQwLvLSFeBWo2Y+WlThKVpnQ9xjRn
         3wHQ==
X-Gm-Message-State: APjAAAWgjqnovviLerv+3VVVa6pFsrGDiNoHRezx73MAhMjPAWv9m9mw
        l1/FHhnCOZCuYJJkBHYxSVCrRg==
X-Google-Smtp-Source: APXvYqw28Z8nn9J/DwyjzFLAUfMFodCz3acr9qmTa+YA/9G8zHUeAoKw4IKxIqqnhohQhL08QAUSIw==
X-Received: by 2002:a63:8dc8:: with SMTP id z191mr3029696pgd.9.1556222076070;
        Thu, 25 Apr 2019 12:54:36 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id a80sm47000946pfj.61.2019.04.25.12.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:54:34 -0700 (PDT)
Subject: [PATCH] KVM: PPC: Book3S HV: smb->smp comment fixup
Date:   Thu, 25 Apr 2019 12:53:39 -0700
Message-Id: <20190425195339.12609-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     benh@kernel.crashing.org, mpe@ellerman.id.au,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     paulus@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I made the same typo when trying to grep for uses of smp_wmb and figured
I might as well fix it.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 06964350b97a..842ab9511b54 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -749,7 +749,7 @@ static bool kvmppc_doorbell_pending(struct kvm_vcpu *vcpu)
 	/*
 	 * Ensure that the read of vcore->dpdes comes after the read
 	 * of vcpu->doorbell_request.  This barrier matches the
-	 * smb_wmb() in kvmppc_guest_entry_inject().
+	 * smp_wmb() in kvmppc_guest_entry_inject().
 	 */
 	smp_rmb();
 	vc = vcpu->arch.vcore;
-- 
2.21.0

