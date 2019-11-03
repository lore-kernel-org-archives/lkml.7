Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0117CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 11:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58E8214E0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 11:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cELr4Q3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfKCLkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 06:40:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfKCLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WYmoxt5EscE5r7grbtiPN7YMN6PCvdXJNdomuLZNkP4=; b=cELr4Q3c4Nkcm145dSMIL9RtR
        VY5bbN3wOjxgu4t3k2oglC6gGo4R4phq+u80vxU7jOmt13yrNucXh6evU2/d+Bcv5xWH/ZypqWCu4
        x003Ec2E5ytZ+MBBe/HmwjUY08PSUNNxouT370/AqhSOeKHNcV2YGHEv80zrvBC1/Z4gBkI4ewe5V
        cwuSqQoBLcZWjx+SCddQYgGoEVaH3VL/dV5r3VqkakSFGjt3DGtonsl2jPmM12ZpKxMboxDHzz+qx
        zfZo12QOEVpqyosvJjukZuL72keU9v0JynLx4AaAyv7sCzGs3hwdiw/qUND4o/7tu5FzrPTHq83v0
        /s6HgYehg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iREEz-0007px-JS; Sun, 03 Nov 2019 11:40:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 0/5] Misc XArray, IDR & Radix Tree patches
Date:   Sun,  3 Nov 2019 03:40:06 -0800
Message-Id: <20191103114012.30027-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These patches all fix various bugs, some of which people have tripped
over and some of which have been caught by automatic tools.  Find them
in this git tree:

http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray

Matthew Wilcox (Oracle) (5):
  XArray: Fix xas_next() with a single entry at 0
  idr: Fix idr_get_next_ul race with idr_remove
  radix tree: Remove radix_tree_iter_find
  idr: Fix integer overflow in idr_for_each_entry
  idr: Fix idr_alloc_u32 on 32-bit systems

 include/linux/idr.h        |  2 +-
 include/linux/radix-tree.h | 18 ------------------
 lib/idr.c                  | 31 +++++++++++--------------------
 lib/radix-tree.c           |  2 +-
 lib/test_xarray.c          | 24 ++++++++++++++++++++++++
 lib/xarray.c               |  4 ++++
 6 files changed, 41 insertions(+), 40 deletions(-)

-- 
2.24.0.rc1

