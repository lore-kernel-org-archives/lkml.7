Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D02C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7307821880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QTY7+sCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbfHHPd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:33:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733113AbfHHPdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fPGllWDdh64nUfOs1aS3QjslyfGjQ/iJx/2zlaF/SN4=; b=QTY7+sCwU0BZU2WjQGtou3n1/
        RaWyLK5P/qG+bA80TktmQ4ddbXbYiDiqrC1m10wB4vGdGam/nfd3GWLHcEtUEQXnojGvCXInVqA8V
        ee1yHncvrQI8DqawF3fKeaPiDKYLwzb2rlkHGIWG2Xs56d6OFpVCrJmUTCDG0SVuabWVuZ5lSYg0f
        FDjUOR1WkYhep9qQgHGvKkYDcsTUS7X/VrMUXEneveGR/4KIexnaGhqwBecUTIRGg6gBkvx0TIs/F
        7njM+Q1mXMwVT7z3jzQrcMNuZ6tshLHJqB3FYBJvinsQcaKKHi+5CfzC9KOjUE4EYU1F4tceKSDHo
        wImVvIJ8g==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkQG-0005A3-GY; Thu, 08 Aug 2019 15:33:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: turn hmm migrate_vma upside down v2
Date:   Thu,  8 Aug 2019 18:33:37 +0300
Message-Id: <20190808153346.9061-1-hch@lst.de>
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

    5 files changed, 281 insertions(+), 607 deletions(-)

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git migrate_vma-cleanup.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/migrate_vma-cleanup.2

Changes since v1:
 - fix a few whitespace issues
 - drop the patch to remove MIGRATE_PFN_WRITE for now
 - various spelling fixes
 - clear cpages and npages in migrate_vma_setup
 - fix the nouveau_dmem_fault_copy_one return value
 - minor improvements to some nouveau internal calling conventions
