Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F49FC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E052621848
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419385;
	bh=HzoVKaeU0K7PaWefxAW4JNM4kk/S7e41tfZFV/SlCqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G6140717OzpJXeNO1Q0lxRl3eIQJU8+Idzs4ZfxuPvYOveFtMLJEP9Gwr476IAsLb
	 poxCai9SZ+1NbB7Q25PVpd2+53DuVyeyPOAd6Q3UqHq/wSF2sp0n4x4qdgPNJdnBqd
	 fpSvMqUQbOSSIEOt6TmLHyOcMW037wRVFeIFNgAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391041AbfGRDJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390234AbfGRDJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:09:41 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9013D20818;
        Thu, 18 Jul 2019 03:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419380;
        bh=HzoVKaeU0K7PaWefxAW4JNM4kk/S7e41tfZFV/SlCqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JBo6KONT22SKSvymtBl6hkcx1N69FRN2CDKiWFyuEc7fpFEKF5yIsM7xECMJX6Cq
         nznSQHM/ZYMrojGTf5dalfo0J82M47SUEiGRTfZgrYo4+3ysQDdBcP7apFV0poP6SU
         37a9+x5E4yzAvy1k8akcczIyuwJrBRTpO8KHclPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 24/80] KVM: arm/arm64: vgic: Fix kvm_device leak in vgic_its_destroy
Date:   Thu, 18 Jul 2019 12:01:15 +0900
Message-Id: <20190718030100.661792292@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
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
index dc06f5e40041..526d808ecbbd 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1677,6 +1677,7 @@ static void vgic_its_destroy(struct kvm_device *kvm_dev)
 	mutex_unlock(&its->its_lock);
 
 	kfree(its);
+	kfree(kvm_dev);/* alloc by kvm_ioctl_create_device, free by .destroy */
 }
 
 int vgic_its_has_attr_regs(struct kvm_device *dev,
-- 
2.20.1



