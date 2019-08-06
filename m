Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6372C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9182520C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eIIvEQvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbfHFQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:06:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfHFQGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5MxxtDMNs1Lvn21R+Aqvcobycge3qF/vKSqdu5UNw7E=; b=eIIvEQvbf6HxKp4vB8rYWilc1
        Y+u02rLmHHgGDQ0BTiNLEYHLedfAofs5F3rHecD7klB5qWZyLsUVZ6dxMkLS2pAWxn04GZTAsbBO/
        ouTJ85EOwF/aluMfxLMuqi+nHzvOBHhK79wk9TKTlzEO/ORS3GGMIcaDAA5aQ/dikzACu9/rM2gl6
        pdRKvVBCY0KTPXd1q47Fs+imhFbAzx721LUs3CqY+31uYX516XCJ473j9veaAi1jB50nfgfna6Gf6
        LLlbHAeFh+Cb66JQz5UcvMUc+Bju9mEnnjbibagKSd8OEOzKmC4fRTXUeOQC3Q/7CRnpMm8MDH+Ro
        R8ayd9OvQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yG-0000Ve-2p; Tue, 06 Aug 2019 16:05:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: hmm cleanups, v2
Date:   Tue,  6 Aug 2019 19:05:38 +0300
Message-Id: <20190806160554.14046-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jérôme, Ben, Felix and Jason,

below is a series against the hmm tree which cleans up various minor
bits and allows HMM_MIRROR to be built on all architectures.

Diffstat:

    11 files changed, 94 insertions(+), 210 deletions(-)

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git hmm-cleanups.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-cleanups.2

Changes since v1:
 - fix the cover letter subject
 - improve various patch descriptions
 - use svmm->mm in nouveau_range_fault
 - inverse the hmask field when using it
 - select HMM_MIRROR instead of making it a user visible option
