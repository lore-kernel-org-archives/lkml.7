Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB91FC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C4B24687
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781610;
	bh=RkCqlMxkWpQHQAgkiX7rCYVVXYAeeMu3h4lelkadcqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gdn0yEPJG0417oscR4rUyhkKFYjWGQnxr8Xv6M6v7vKLLBpZSf69iC8Z85zE25A7U
	 HE9iSMUbuE1ZFVW3OWsYqmtzfi2PlfDm/+GbGYABqrT5DqZJeEZFdUPve4KoMI2JDO
	 4mz4SMYhjq/XCmdql/Mf3UfUMmjSSMau2APUt3R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfLSSx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbfLSSxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:53:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92CD227BF;
        Thu, 19 Dec 2019 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781605;
        bh=RkCqlMxkWpQHQAgkiX7rCYVVXYAeeMu3h4lelkadcqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8e6RzqMNtkAyvM6fMLGIeVX1ep17Yq4Ho2qEZVdJ7lzCM/5xwcM1pxpFl3Hkri+h
         8KEmpF7RQ+d1qxJgK91/izN2Zq/I6Vv3NLP18Nl0XsuM4dI7gRhjAzjQnnEDbEcrsi
         +ztGr7pNg/QPvWBXAHJZt773G6D6feibLZZh2KhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiang Yi <giangyi@amazon.com>,
        Marc Zyngier <maz@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.19 39/47] vfio/pci: call irq_bypass_unregister_producer() before freeing irq
Date:   Thu, 19 Dec 2019 19:34:53 +0100
Message-Id: <20191219182944.555038993@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182857.659088743@linuxfoundation.org>
References: <20191219182857.659088743@linuxfoundation.org>
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
@@ -297,8 +297,8 @@ static int vfio_msi_set_vector_signal(st
 	irq = pci_irq_vector(pdev, vector);
 
 	if (vdev->ctx[vector].trigger) {
-		free_irq(irq, vdev->ctx[vector].trigger);
 		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
+		free_irq(irq, vdev->ctx[vector].trigger);
 		kfree(vdev->ctx[vector].name);
 		eventfd_ctx_put(vdev->ctx[vector].trigger);
 		vdev->ctx[vector].trigger = NULL;


