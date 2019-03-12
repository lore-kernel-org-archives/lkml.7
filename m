Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7A22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ud4o9CIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCLAdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:33:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39313 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfCLAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:33:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id i20so479208pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8PABx0OHKc8ecQvYTILU00A3ovg0RAcr/xS/uNWnrJI=;
        b=ud4o9CIhP2Dw8m03b4Qb3bUQJrMmdYk/qvFgclJ+n4goizacfjRLluBiKDfF977Oy6
         muk5lDqOP/rxFUijP+3ChrB8LUYa7vLBRw0lac5mO/QJ+DYcD7LgNaU7+M7YIn0dor3L
         oZRF5WqP5OPbZxc2r66qUFb451TfFhgnuGZDIJ6e+b3zoI4CcE2bTBbPecShF4aUUvrQ
         oxGIxYmJtqu0/SiVLAHG5qfHxAH+D5jGAs3MST7p4wyXk3+rh3UTHkQrO+QI1/cHRuDS
         9PH+CCkYkMbx+iTwcRO6VBo+s7ir7mN++SfHI+JE/2nPMVBmIRz8rmEpdmOVq3uVHShy
         UdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8PABx0OHKc8ecQvYTILU00A3ovg0RAcr/xS/uNWnrJI=;
        b=UnxmAVgwWdSTJw1xWt3815WO42lW4zlq85oL0Gg24CiS982vWLiNyJIubxdjAjRFE5
         TuuqqAae6KLBpYi0PVYzYEQtXdfupZ8oAnhJ+YwqplNbwhPliu6FSaEHQcRmc787yPlM
         m2GvdYyxrHgiT2clPEchCTQo32SWbBi1k+Z+xFOVK58GxVRKb2tP9MWP1M5q3bkKfUxH
         FQh2TuLesluKFZAiZHT+X4CVW3723To8VNNfvSt5dL0bBMtRU1KCDALsSxNTrB3SgZ3D
         nxrLbq+0ukL9XbWEotl3taAu8UNHArT2DRyroi1RdilEQPJn76b9wPeaNVJKhbGa5C3y
         EU6w==
X-Gm-Message-State: APjAAAU6EQo57deNnByzEwGPQRWn3u90DSw/pI9sQo5JfVRvkg7k9ujO
        gERtHPBkq8nJcz+ogC18ib4ARohouAAz
X-Google-Smtp-Source: APXvYqzrZJ7IWraZK6cKOfdcMMT1ns3pioGtmDVwxG60opdOw95n6EQ78RRJhRQ83g6qHLEGeNYCJA==
X-Received: by 2002:a17:902:70c9:: with SMTP id l9mr11496692plt.131.1552350786482;
        Mon, 11 Mar 2019 17:33:06 -0700 (PDT)
Received: from host.hxtcorp.net ([240e:e0:f08d:5bc1:25ae:36fa:3a9e:cfcf])
        by smtp.gmail.com with ESMTPSA id d86sm15002274pfm.18.2019.03.11.17.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 17:33:05 -0700 (PDT)
From:   John Gong <johngong0791@gmail.com>
To:     christoffer.dall@arm.com
Cc:     Shengmin Gong <shengmin.gong@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Jia He <hejianet@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: fix potential bug
Date:   Tue, 12 Mar 2019 08:32:41 +0800
Message-Id: <20190312003243.6712-1-johngong0791@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since intid always >= VGIC_NR_PRIVATE_IRQS, so then even vcpu == NULL,
it never return -EINVAL.

Signed-off-by: Shengmin Gong <shengmin.gong@gmail.com>
Signed-off-by: John Gong <johngong0791@gmail.com>
---
 virt/kvm/arm/vgic/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index abd9c7352677..d3cb1ce880e2 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -424,7 +424,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
 		return ret;
 
 	vcpu = kvm_get_vcpu(kvm, cpuid);
-	if (!vcpu && intid < VGIC_NR_PRIVATE_IRQS)
+	if (!vcpu)
 		return -EINVAL;
 
 	irq = vgic_get_irq(kvm, vcpu, intid);
-- 
2.17.1

