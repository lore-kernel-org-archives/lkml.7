Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A20C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDFD215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfICNUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:20:41 -0400
Received: from 8bytes.org ([81.169.241.247]:52978 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfICNUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:20:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B7FA5284; Tue,  3 Sep 2019 15:20:39 +0200 (CEST)
Date:   Tue, 3 Sep 2019 15:20:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu: Don't use sme_active() in generic code
Message-ID: <20190903132038.GE11530@8bytes.org>
References: <20190902163951.6280e030@canb.auug.org.au>
 <20190902140347.GA23482@8bytes.org>
 <d2493e6b-08fa-9ea8-a0a4-076def54e91b@amd.com>
 <20190903152849.770ae819@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903152849.770ae819@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:28:49PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 2 Sep 2019 14:26:40 +0000 "Lendacky, Thomas" <Thomas.Lendacky@amd.com> wrote:
> > Maybe we should make this mem_encrypt_active(), since this will probably
> > be needed if/when an IOMMU device is eventually added to a guest, and the
> > referenced commit below doesn't remove that call.
> 
> I have done that for today:

Thanks Stephen and Tom. I queued the attached patch into the iommu tree
to fix the problem.

From 2896ba40d0becdb72b45f096cad70633abc014f6 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Tue, 3 Sep 2019 15:15:44 +0200
Subject: [PATCH] iommu: Don't use sme_active() in generic code

Switch to the generic function mem_encrypt_active() because
sme_active() is x86 specific and can't be called from
generic code on other platforms than x86.

Fixes: 2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 66cfacaa483d..d658c7c6a2ab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -120,8 +120,8 @@ static int __init iommu_subsys_init(void)
 		else
 			iommu_set_default_translated(false);
 
-		if (iommu_default_passthrough() && sme_active()) {
-			pr_info("SME detected - Disabling default IOMMU Passthrough\n");
+		if (iommu_default_passthrough() && mem_encrypt_active()) {
+			pr_info("Memory encryption detected - Disabling default IOMMU Passthrough\n");
 			iommu_set_default_translated(false);
 		}
 	}
-- 
2.16.4

