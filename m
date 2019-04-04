Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3221C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43F320882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJ9aqoeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfDDUYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:24:04 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:33105 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbfDDUYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:24:04 -0400
Received: by mail-yb1-f201.google.com with SMTP id j8so2749972ybh.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6sOLFOHDFXTunsmV2eys8G03orm7eMnBLakMzQ3gFIk=;
        b=YJ9aqoeoFLzb44VJhlBW4d+pUzTWv8Y4dv+lDJDet7pRuQLNX3Avj7jZotZIP4X48Y
         3quXy49xmIk4MwD3zbWNJ3S729pU9QktfmM0XvucPbp09R/+jj1agexdoAYnnxb9LR+d
         n86JIj2W9+YIF4xDrx9pPJoiR6cdWqScopMOq7q7GMysWESNhSg31u5qRi4PMx0Knv0n
         bZ7w+ra/oe33/NE/uNFwGzzL8Ubhmq2Fskv5mihTWLTn4QIFHxSj4uGqadwe4ZvihwRZ
         D8OvJHFOOEO02tc3+KB145tpjldMMhqpFj0n6OQFiC2kxuhwq/5Y6nph19kfuX4SNagw
         vHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6sOLFOHDFXTunsmV2eys8G03orm7eMnBLakMzQ3gFIk=;
        b=JhUGUvEr0oWc5bI61OlPKk5G+Bno3xsdo4sQAcVSakjUORzxb9mKvpztA2zqW3yhKF
         7qTKmyS2F6OfsbdXSVpqd4E7w3E0QGMHOx2FMCEflJoJM8u9d441mruUsX2OwnMKMLwN
         tQUCVaotb+PvVdpULMOoTt0l72xyVt1iY6OAIL2XleBJqO6os/aavE127merGNuxbAO3
         a+u3un7dC5hEhsr7o7+GN7vu4X1mA4MscGCkBuMxC5SDFw+bAb1fHombvDwnznKPpl+P
         /B29FfdygTKH21ibBh7fo2BNZC5RmHASsI1wZT0jDuUSYys1GnSSTmQnL/mHyPVI4bQN
         EOjQ==
X-Gm-Message-State: APjAAAXcYQYOLIegpSQhT4xj+0feNHs9vHBl42ljFAk+VkBl4+gJ7P2H
        CA7lR8Fw6y7s76QqAaw/XVs6scV0
X-Google-Smtp-Source: APXvYqyFaoHGS3HNPj5EWd2K/BhPSlUcoTmVHBLr0Z5zTPlAZeE70MMV7qFTBOEVT7TpcMEfZut11KZU
X-Received: by 2002:a81:6184:: with SMTP id v126mr1721915ywb.17.1554409443175;
 Thu, 04 Apr 2019 13:24:03 -0700 (PDT)
Date:   Thu,  4 Apr 2019 16:23:42 -0400
Message-Id: <20190404202345.133553-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 0/3] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yu.c.zhang@intel.com,
        yi.z.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series depends on DAX pages not being PageReserved.  Once
that is in place, these changes will let KVM use huge pages with
DAX-backed files.

From previous discussions[1], it sounds like DAX might not need to keep
the PageReserved bit, but that it hadn't been sorted out yet.

Without the PageReserved change, KVM and DAX still work with these
patches, simply without huge pages - which is the current situation.

If you want to test the huge-page functionality as if DAX pages weren't
PageReserved for KVM, this hack does the trick:

------------------
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c44985375e7f..ee539eec1fb8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -153,6 +153,10 @@ __weak int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 
 bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 {
+       // XXX hack
+       if (is_zone_device_page(pfn_to_page(pfn)))
+               return false;
+
        if (pfn_valid(pfn))
                return PageReserved(pfn_to_page(pfn));
 
------------------

Perhaps if we are going to leave DAX pages marked PageReserved, then I
can make that hack into a proper commit and have KVM alone treat DAX
pages as if they are not reserved.

v2 -> v3:
v2: https://lore.kernel.org/lkml/20181114215155.259978-1-brho@google.com/
- Updated Acks/Reviewed-by
- Rebased onto linux-next

v1 -> v2:
https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
- Updated Acks/Reviewed-by
- Minor touchups
- Added patch to remove redundant PageReserved() check
- Rebased onto linux-next

RFC/discussion thread:
https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/

[1] https://lore.kernel.org/lkml/ee8cc068-903c-d87e-f418-ade46786249e@redhat.com/

Barret Rhoden (3):
  mm: make dev_pagemap_mapping_shift() externally visible
  kvm: Use huge pages for DAX-backed files
  kvm: remove redundant PageReserved() check

 arch/x86/kvm/mmu.c  | 33 +++++++++++++++++++++++++++++++--
 include/linux/mm.h  |  3 +++
 mm/memory-failure.c | 38 +++-----------------------------------
 mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c |  8 ++------
 5 files changed, 73 insertions(+), 43 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

