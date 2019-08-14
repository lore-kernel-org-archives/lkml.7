Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DB8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6CC208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPKkluHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfHNH7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:59:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfHNH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JVLupnHp/2HEL1nOJxPMzcGzWGTuwVGtB/+M404XJkE=; b=JPKkluHXANV3awUUpuvJcS5NT
        5awHaFSwZn1/i0TJJtE3fi/qxiLHwIVJg48wdR8sIbS4qLVhXATdFK9VMQs4cbxoXMHMhxIyzbTUW
        0KENQgeMZoxmA8wU4/XAyAYaABLnh5rNbE/HUxdzRZz6CSQRGkDRkDXwDWabLnEcXkLaW+l6V4Yoz
        iLKh8dBjzqUKUouq8fpd863K42hkg5zIJasXrCRyFOWrbQRYdR/zDvHLaOuRyPks+RztFhMjOfdiS
        w8QfISAZRlHzyPnXoWix4EEZp+XuxvvVxVkdvGQYuWDO3lYQqJlfIAs5ZQg2P7JkByBv8Ib0+w3Ry
        P4J23sxPA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxoBu-0007vG-RS; Wed, 14 Aug 2019 07:59:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: turn hmm migrate_vma upside down v3
Date:   Wed, 14 Aug 2019 09:59:18 +0200
Message-Id: <20190814075928.23766-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jérôme, Ben and Jason,

below is a series against the hmm tree which starts revamping the
migrate_vma functionality.  The prime idea is to export three slightly
lower level functions and thus avoid the need for migrate_vma_ops
callbacks.

Diffstat:

    7 files changed, 282 insertions(+), 614 deletions(-)

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git migrate_vma-cleanup.3

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/migrate_vma-cleanup.3


Changes since v2:
 - don't unmap pages when returning 0 from nouveau_dmem_migrate_to_ram
 - minor style fixes
 - add a new patch to remove CONFIG_MIGRATE_VMA_HELPER

Changes since v1:
 - fix a few whitespace issues
 - drop the patch to remove MIGRATE_PFN_WRITE for now
 - various spelling fixes
 - clear cpages and npages in migrate_vma_setup
 - fix the nouveau_dmem_fault_copy_one return value
 - minor improvements to some nouveau internal calling conventions
