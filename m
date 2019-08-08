Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EFEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029962173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CGR53+Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbfHHPms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:42:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732680AbfHHPms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ToKAXlut0bLzp0i2AEiO/Hgmk4iALY2Z3psq1k6MNzg=; b=CGR53+Ky/s5jodPOMrXDgVQqS
        nIdN8nlQ47Y/ET8+fk0jhQd86MbectDChtyIUnt+xMS+RhRlI9NSsrlraqp29G7BYyOtJAkn0aSFT
        znF+t0JxjzDTt8PdyUXzdAtr+80QUiW/K4dYv5VqKL78yv9h6sfZqMCQQqt6PEMCdvyROJa2DqKQt
        PxIcs9ozNrf1Eo9IOeLx3NpHC8EnLwGEw7EZuzK9CquVY6m28XgydRpMAd2ECum8NAR4W9ASeBCkI
        RTcDjFSXl9cWQk9TSzLzbY5W9+LBOcXqP+WjLl/3K42pRVwOQWUqAlHxb2SnvmI/1ZPE26TaDYbIE
        5dTFevMXw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkYs-0008UM-8p; Thu, 08 Aug 2019 15:42:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: cleanup the walk_page_range interface
Date:   Thu,  8 Aug 2019 18:42:37 +0300
Message-Id: <20190808154240.9384-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series is based on a patch from Linus to split the callbacks
passed to walk_page_range and walk_page_vma into a separate structure
that can be marked const, with various cleanups from me on top.

Note that both Thomas and Steven have series touching this area pending,
and there are a couple consumer in flux too - the hmm tree already
conflicts with this series, and I have potential dma changes on top of
the consumers in Thomas and Steven's series, so we'll probably need a
git tree similar to the hmm one to synchronize these updates.


This series is also available as a git tre here:

    git://git.infradead.org/users/hch/misc.git pagewalk-cleanup

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pagewalk-cleanup


Diffstat:

    14 files changed, 285 insertions(+), 278 deletions(-)
