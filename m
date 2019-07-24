Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF08C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FFE2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999935;
	bh=Z6+ShQJG+hOKLklCzcB3DfvNdkX2JB1PAfPefi98eWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uz4lbT4yLB1hb0k7oHVrLS1iIKRcgzpiEUqd2ZCglv6Hdoyi1Nzs61Aksg7bKsJ49
	 PfZwL5X4fp/XO5A+mijSK+XE2WUPitfgVWoWy3O3JCnrBpeIwBMM3VMkssTNNSFmp8
	 6bhvhiRtxRO9WvdxWDQaWemb4k4uejRr59xI746c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbfGXTi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389801AbfGXTiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:38:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9874C217D4;
        Wed, 24 Jul 2019 19:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997134;
        bh=Z6+ShQJG+hOKLklCzcB3DfvNdkX2JB1PAfPefi98eWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhD7qR69EqBRLx1loewvCSVo2V5ONu979sG25gp2fe5sIop2NTMlxzvVP7+wMn0GC
         UR/KWmnFoXIejILeueXVp31CTPOb9uZEBtQUFsBvtgp6WLUILpFEz/PA/zmWdW/7Kf
         K8exAp6UtGdfRtJv1zG15Z+1XSfxF/xMAEw9HOPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.2 331/413] KVM: Properly check if "page" is valid in kvm_vcpu_unmap
Date:   Wed, 24 Jul 2019 21:20:22 +0200
Message-Id: <20190724191759.523869258@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KarimAllah Ahmed <karahmed@amazon.de>

commit b614c6027896ff9ad6757122e84760d938cab15e upstream.

The field "page" is initialized to KVM_UNMAPPED_PAGE when it is not used
(i.e. when the memory lives outside kernel control). So this check will
always end up using kunmap even for memremap regions.

Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
Cc: stable@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/kvm_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1790,7 +1790,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcp
 	if (!map->hva)
 		return;
 
-	if (map->page)
+	if (map->page != KVM_UNMAPPED_PAGE)
 		kunmap(map->page);
 #ifdef CONFIG_HAS_IOMEM
 	else


