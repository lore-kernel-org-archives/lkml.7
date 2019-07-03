Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B5C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A20218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZoXDWaM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfGCWCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:02:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfGCWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aR9uGMKGXKbHfq0jNFOgm2SkQaXqyDisE482MLvao/8=; b=ZoXDWaM0JtTHhc2otW2p82e/T
        /jNnbQZZmVgh2h79y9++LJbnLByPF/oaDm7Qo7iKHdL2D4Ih95NUhDkWF3aTF78fDdiRt4AArcezL
        HbG1KY2whzTjugStJ0zV9TMW005Tf85+ZyT8SLxtOeO5JSTgxOIzL8b7Sx0xaCtGUxic8y+uI4Moj
        bpjSCQsQetvIZf757cl9CAMduvgTlsWQBWKzRSxxwPAOi7TNaZ1BZD6oqtaqqwD1QdwQl/X9DJJhn
        TRzWUblKWO70fd5ENlz40DeZ3x7FAWOeqQradP3mRmuFpOzbg63IOXzNu4J8MfzJzyqrXb1PfSjVV
        oappvp1fQ==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hinKR-0004EN-KS; Wed, 03 Jul 2019 22:02:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: hmm_range_fault related fixes and legacy API removal v2
Date:   Wed,  3 Jul 2019 15:02:08 -0700
Message-Id: <20190703220214.28319-1-hch@lst.de>
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

below is a series against the hmm tree which fixes up the mmap_sem
locking in nouveau and while at it also removes leftover legacy HMM APIs
only used by nouveau.

Changes since v1:
 - don't return the valid state from hmm_range_unregister
 - additional nouveau cleanups
