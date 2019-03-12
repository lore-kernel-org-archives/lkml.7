Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0939EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29BD2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412231;
	bh=IFPo867nMChE/YcInazRkZt2YRXX1obVid5NeXxkYTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSFkiwGCoqgCVqtnWHyuKxIIAyP08NrvFxFm663Vg70AoPJUMtMO/U5PeRYKf6cvD
	 gOhwPpVPbrwyMrTF+K2l2Rh/Wruac7gRQEELLSW5ogY2tuquJwuihYPUHHN3AVfOot
	 Z77nb+VMWXQ3iVS3C2wLRLN1MAIX6rsm876ku2ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfCLRQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbfCLRPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:35 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3EF62184E;
        Tue, 12 Mar 2019 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410934;
        bh=IFPo867nMChE/YcInazRkZt2YRXX1obVid5NeXxkYTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBuSCJ4+S11l2aH6V139CV88dbStPeaN6/G2zKI//Rzi3k6xuMvU8xfsvE3EEVJbz
         SAoOSgr9Rp/3fGF3Uxrt79rNaOWgCTUQCIPrDEu5V11+bp4NnMs4LfmQ3kQErvyBcH
         hPI/GB9QXcn++FzI7HzMAqvbkpHTckRVVN9qil2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 4.19 145/149] driver core: Postpone DMA tear-down until after devres release
Date:   Tue, 12 Mar 2019 10:09:23 -0700
Message-Id: <20190312170401.442948836@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 376991db4b6464e906d699ef07681e2ffa8ab08c upstream.

When unbinding the (IOMMU-enabled) R-Car SATA device on Salvator-XS
(R-Car H3 ES2.0), in preparation of rebinding against vfio-platform for
device pass-through for virtualization:

    echo ee300000.sata > /sys/bus/platform/drivers/sata_rcar/unbind

the kernel crashes with:

    Unable to handle kernel paging request at virtual address ffffffbf029ffffc
    Mem abort info:
      ESR = 0x96000006
      Exception class = DABT (current EL), IL = 32 bits
      SET = 0, FnV = 0
      EA = 0, S1PTW = 0
    Data abort info:
      ISV = 0, ISS = 0x00000006
      CM = 0, WnR = 0
    swapper pgtable: 4k pages, 39-bit VAs, pgdp = 000000007e8c586c
    [ffffffbf029ffffc] pgd=000000073bfc6003, pud=000000073bfc6003, pmd=0000000000000000
    Internal error: Oops: 96000006 [#1] SMP
    Modules linked in:
    CPU: 0 PID: 1098 Comm: bash Not tainted 5.0.0-rc5-salvator-x-00452-g37596f884f4318ef #287
    Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
    pstate: 60400005 (nZCv daif +PAN -UAO)
    pc : __free_pages+0x8/0x58
    lr : __dma_direct_free_pages+0x50/0x5c
    sp : ffffff801268baa0
    x29: ffffff801268baa0 x28: 0000000000000000
    x27: ffffffc6f9c60bf0 x26: ffffffc6f9c60bf0
    x25: ffffffc6f9c60810 x24: 0000000000000000
    x23: 00000000fffff000 x22: ffffff8012145000
    x21: 0000000000000800 x20: ffffffbf029fffc8
    x19: 0000000000000000 x18: ffffffc6f86c42c8
    x17: 0000000000000000 x16: 0000000000000070
    x15: 0000000000000003 x14: 0000000000000000
    x13: ffffff801103d7f8 x12: 0000000000000028
    x11: ffffff8011117604 x10: 0000000000009ad8
    x9 : ffffff80110126d0 x8 : ffffffc6f7563000
    x7 : 6b6b6b6b6b6b6b6b x6 : 0000000000000018
    x5 : ffffff8011cf3cc8 x4 : 0000000000004000
    x3 : 0000000000080000 x2 : 0000000000000001
    x1 : 0000000000000000 x0 : ffffffbf029fffc8
    Process bash (pid: 1098, stack limit = 0x00000000c38e3e32)
    Call trace:
     __free_pages+0x8/0x58
     __dma_direct_free_pages+0x50/0x5c
     arch_dma_free+0x1c/0x98
     dma_direct_free+0x14/0x24
     dma_free_attrs+0x9c/0xdc
     dmam_release+0x18/0x20
     release_nodes+0x25c/0x28c
     devres_release_all+0x48/0x4c
     device_release_driver_internal+0x184/0x1f0
     device_release_driver+0x14/0x1c
     unbind_store+0x70/0xb8
     drv_attr_store+0x24/0x34
     sysfs_kf_write+0x4c/0x64
     kernfs_fop_write+0x154/0x1c4
     __vfs_write+0x34/0x164
     vfs_write+0xb4/0x16c
     ksys_write+0x5c/0xbc
     __arm64_sys_write+0x14/0x1c
     el0_svc_common+0x98/0x114
     el0_svc_handler+0x1c/0x24
     el0_svc+0x8/0xc
    Code: d51b4234 17fffffa a9bf7bfd 910003fd (b9403404)
    ---[ end trace 8c564cdd3a1a840f ]---

While I've bisected this to commit e8e683ae9a736407 ("iommu/of: Fix
probe-deferral"), and reverting that commit on post-v5.0-rc4 kernels
does fix the problem, this turned out to be a red herring.

On arm64, arch_teardown_dma_ops() resets dev->dma_ops to NULL.
Hence if a driver has used a managed DMA allocation API, the allocated
DMA memory will be freed using the direct DMA ops, while it may have
been allocated using a custom DMA ops (iommu_dma_ops in this case).

Fix this by reversing the order of the calls to devres_release_all() and
arch_teardown_dma_ops().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
[rm: backport for 4.12-4.19 - kernels before 5.0 will not see
 the crash above, but may get silent memory corruption instead]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/dd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -963,9 +963,9 @@ static void __device_release_driver(stru
 			drv->remove(dev);
 
 		device_links_driver_cleanup(dev);
-		dma_deconfigure(dev);
 
 		devres_release_all(dev);
+		dma_deconfigure(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
 		if (dev->pm_domain && dev->pm_domain->dismiss)


