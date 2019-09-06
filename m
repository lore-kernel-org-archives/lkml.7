Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B08FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57F121670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bo2NORtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395000AbfIFP7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:59:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfIFP7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=22s3suVEwybuDGOmnl63bE4bs9K3fxHohFliCUIcsdI=; b=bo2NORtcqX+pna5uqNLOVaY3lP
        GcjxJLygzVcRUR9QCu2ryEqYBNUsSitjTcyCcA73nnV6tftFfy573yMV/iR0JmPi1m9YtArvHdF50
        1NnKeUwaQCOqb/Bk9eGmrlHkHcWIKJpwi7GmjHBZytCSrxdxWSKbMxjAJvnhgwNjHMAzKrmWTB22K
        5sOCIH2N5bXeUNHWif3K4FEerULx2MpVhdIhMT0MPeGAD8X4C7H5hBFFCoumISrpMw8JpqNypN7gs
        SKVKbigK6tOH3wRKQ+zIGt2NsYILncqRydAEp1DJAIijZLRKVO3JaXcCBfqMA02pCd29ccfSBi3Sb
        yU4ueQpg==;
Received: from 213-225-38-191.nat.highway.a1.net ([213.225.38.191] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6Gda-0004lW-9k; Fri, 06 Sep 2019 15:59:02 +0000
Date:   Fri, 6 Sep 2019 17:56:50 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs fixes for 5.3
Message-ID: <20190906155650.GA32004@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these late configfs fixe from Al that fix pretty nasty
removal vs attribute access races.

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.3

for you to fetch changes up to b0841eefd9693827afb9888235e26ddd098f9cef:

  configfs: provide exclusion between IO and removals (2019-09-04 22:33:51 +0200)

----------------------------------------------------------------
configfs fixes for 5.3

 - fix removal vs attribute read/write races (Al Viro)

----------------------------------------------------------------
Al Viro (4):
      configfs: stash the data we need into configfs_buffer at open time
      configfs_register_group() shouldn't be (and isn't) called in rmdirable parts
      configfs: new object reprsenting tree fragments
      configfs: provide exclusion between IO and removals

 fs/configfs/configfs_internal.h |  15 ++-
 fs/configfs/dir.c               | 137 +++++++++++++++-----
 fs/configfs/file.c              | 280 ++++++++++++++++++++--------------------
 3 files changed, 257 insertions(+), 175 deletions(-)
