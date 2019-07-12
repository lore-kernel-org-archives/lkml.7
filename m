Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882DC742BB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D0320645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935176;
	bh=OPkQS4ZouFSkR3LiI4mp1tcYx6W9URNFMKjcq5dTkVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2U5It+IaRrD2RNsENsc6FUhIiLqLUabsidVJBLTDNQltOsPx4B92YLTeDsAZAQsSz
	 9eGVX5pHRsqNd6+9+0PKfTmS1RovGgD8zzMa19S8+T76I+N/LzkUram7ya2CbpRsgn
	 U8tk/qqmq0yAuebhr2FNqNsvuuMUSdmpF+qAZFtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfGLMjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfGLM1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:27:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6962621019;
        Fri, 12 Jul 2019 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934425;
        bh=OPkQS4ZouFSkR3LiI4mp1tcYx6W9URNFMKjcq5dTkVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avU34lyMvTqOBCCMpiyqnW1GzRNMSIxC+VG1R0rK8Bl6+sBdyVhGHqnO7491TslP2
         GICxGNjr1HO6kN5FaU7DHBEsVgESgV8Zd7Z6ZXL/bA/W0gHfQn621YdCkxgLBEpRja
         LMf2HDX7ozC8gVsrIP3Zlvd6Klzxe+cpnNAfeSrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 051/138] KVM: arm/arm64: vgic: Fix kvm_device leak in vgic_its_destroy
Date:   Fri, 12 Jul 2019 14:18:35 +0200
Message-Id: <20190712121630.622450958@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4729ec8c1e1145234aeeebad5d96d77f4ccbb00a ]

kvm_device->destroy() seems to be supposed to free its kvm_device
struct, but vgic_its_destroy() is not currently doing this,
resulting in a memory leak, resulting in kmemleak reports such as
the following:

unreferenced object 0xffff800aeddfe280 (size 128):
  comm "qemu-system-aar", pid 13799, jiffies 4299827317 (age 1569.844s)
  [...]
  backtrace:
    [<00000000a08b80e2>] kmem_cache_alloc+0x178/0x208
    [<00000000dcad2bd3>] kvm_vm_ioctl+0x350/0xbc0

Fix it.

Cc: Andre Przywara <andre.przywara@arm.com>
Fixes: 1085fdc68c60 ("KVM: arm64: vgic-its: Introduce new KVM ITS device")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 44ceaccb18cf..8c9fe831bce4 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1734,6 +1734,7 @@ static void vgic_its_destroy(struct kvm_device *kvm_dev)
 
 	mutex_unlock(&its->its_lock);
 	kfree(its);
+	kfree(kvm_dev);/* alloc by kvm_ioctl_create_device, free by .destroy */
 }
 
 static int vgic_its_has_attr_regs(struct kvm_device *dev,
-- 
2.20.1



