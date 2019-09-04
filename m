Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431F7C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEBB233FF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620305;
	bh=rQzTqad7vYVA9aEKCauaJxkfbmis2wcKr2tEhpPOAME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQV8n5PKYT1Yt1q0EZu/m0BzjK/YK9HLbPZswgETJA3ICNEPd50ePDDrUyqFNteg7
	 0/pan0OxyoUl7EL29EwTaQy+6s6oXj8WfULCfyBkGTeUaIU9MnGvYMEYHaQFFNsfwD
	 2WuCyXguvYyS1d/aN9pKbTDdCcNY8OVNIxZHRUCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfIDSFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389184AbfIDSFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:05:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B969208E4;
        Wed,  4 Sep 2019 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620299;
        bh=rQzTqad7vYVA9aEKCauaJxkfbmis2wcKr2tEhpPOAME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/TREYCpyE/hgHfxeUZohrhdkq5VStTnYtxI4DN7qaZxt1jN8cZqk99DbQaTkmw4f
         U7u/TWIWHiukVGRd+7sU06ORP9Rr4q9vgv1vl0htqtSEOxt0RBOuwxHz3m3yydIDr5
         ZhKV8vSNqyxkfypoLYWJ4YX5U0LQ8Rli/QRTC/ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>,
        Heyi Guo <guoheyi@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 50/57] KVM: arm/arm64: vgic: Fix potential deadlock when ap_list is long
Date:   Wed,  4 Sep 2019 19:54:18 +0200
Message-Id: <20190904175306.782871082@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d4a8061a7c5f7c27a2dc002ee4cb89b3e6637e44 ]

If the ap_list is longer than 256 entries, merge_final() in list_sort()
will call the comparison callback with the same element twice, causing
a deadlock in vgic_irq_cmp().

Fix it by returning early when irqa == irqb.

Cc: stable@vger.kernel.org # 4.7+
Fixes: 8e4447457965 ("KVM: arm/arm64: vgic-new: Add IRQ sorting")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
[maz: massaged commit log and patch, added Fixes and Cc-stable]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/vgic/vgic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 9d4e01f109499..07ee8e4e00a21 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -199,6 +199,13 @@ static int vgic_irq_cmp(void *priv, struct list_head *a, struct list_head *b)
 	bool penda, pendb;
 	int ret;
 
+	/*
+	 * list_sort may call this function with the same element when
+	 * the list is fairly long.
+	 */
+	if (unlikely(irqa == irqb))
+		return 0;
+
 	spin_lock(&irqa->irq_lock);
 	spin_lock_nested(&irqb->irq_lock, SINGLE_DEPTH_NESTING);
 
-- 
2.20.1



