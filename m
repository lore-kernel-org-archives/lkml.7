Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE24C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA0E222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780916;
	bh=w3xchpWSaeEifrs1U1NvINkb8ay7YrSJsH15zMdBVQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XnRP6tamKppwSX4UrEqmkBUNupmR6aK5L2HJ9LdhQXSVYF8zRtMIH1/ev5eYekN5Q
	 wQe8QY96SNnKX92jcCxbohm3r1e1CaoAMcYY0Cf4+e9Nvo/zc2PdwTAoJNyoDsiBd3
	 QC5DG+hXxLQL039UB6/8CUETt53c4Ldud3J9CgJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfLSSlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbfLSSlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:41:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B675F206D7;
        Thu, 19 Dec 2019 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780907;
        bh=w3xchpWSaeEifrs1U1NvINkb8ay7YrSJsH15zMdBVQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJZzukD3wDS/4Qdji8A3ZzqmW5ZGrmUZiOf9akHlBthRJPJbh39XGriNbg2tN9BI9
         AkRGi7BpcOAhOLuYvY5JYf4NSWzRPCSWmbjqPNqKqnLKuZfSMqpG/GYPdzCyD7CCIR
         TcsL5tITg4KLoVzN9ZznFrZxzhYKrv50/BLNEXgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiang Yi <giangyi@amazon.com>,
        Marc Zyngier <maz@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.4 157/162] vfio/pci: call irq_bypass_unregister_producer() before freeing irq
Date:   Thu, 19 Dec 2019 19:34:25 +0100
Message-Id: <20191219183217.321443381@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Yi <giangyi@amazon.com>

commit d567fb8819162099035e546b11a736e29c2af0ea upstream.

Since irq_bypass_register_producer() is called after request_irq(), we
should do tear-down in reverse order: irq_bypass_unregister_producer()
then free_irq().

Specifically free_irq() may release resources required by the
irqbypass del_producer() callback.  Notably an example provided by
Marc Zyngier on arm64 with GICv4 that he indicates has the potential
to wedge the hardware:

 free_irq(irq)
   __free_irq(irq)
     irq_domain_deactivate_irq(irq)
       its_irq_domain_deactivate()
         [unmap the VLPI from the ITS]

 kvm_arch_irq_bypass_del_producer(cons, prod)
   kvm_vgic_v4_unset_forwarding(kvm, irq, ...)
     its_unmap_vlpi(irq)
       [Unmap the VLPI from the ITS (again), remap the original LPI]

Signed-off-by: Jiang Yi <giangyi@amazon.com>
Cc: stable@vger.kernel.org # v4.4+
Fixes: 6d7425f109d26 ("vfio: Register/unregister irq_bypass_producer")
Link: https://lore.kernel.org/kvm/20191127164910.15888-1-giangyi@amazon.com
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
[aw: commit log]
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/pci/vfio_pci_intrs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -318,8 +318,8 @@ static int vfio_msi_set_vector_signal(st
 		return -EINVAL;
 
 	if (vdev->ctx[vector].trigger) {
-		free_irq(irq, vdev->ctx[vector].trigger);
 		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
+		free_irq(irq, vdev->ctx[vector].trigger);
 		kfree(vdev->ctx[vector].name);
 		eventfd_ctx_put(vdev->ctx[vector].trigger);
 		vdev->ctx[vector].trigger = NULL;


