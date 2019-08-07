Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ABFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37A921E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHqJHhQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbfHGNbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:31:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbfHGNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3ckEXQQQWe0VyUcKIbErhvAUX+jxDacyLSy6gj/b2Og=; b=jHqJHhQLgqMSB2hRFu1qWolUP
        GIU2eQFAkl05c5ThRJ7LdSqlPxn+h+ei4beu4clpNhEFLx/qeTGsck+G3br2aFK4RtLaLDPrDMtqr
        OIJtT56W/LcN4GOIz9bWoJS9EVFYT/i3s02LagQCFNVuH73iaGDfWKeLdCH8fvrbwBfPA2nkmrs25
        emGISoNfwRFIwNCVZ+jk9Ysj2+rIovZxt8Hu8J5bbG3YMYlmckQyZQ3VnmVfmN0PUEv8CPzokZ3ik
        4CwkDjkniHjdJ1rsIqvrI5/eW/1lf6nEseunIeIZraTGnZzaYYiztVmV2z039KHW7Uth+HB/4NsKG
        2TK+ChC1w==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvM1k-0007oT-4Z; Wed, 07 Aug 2019 13:30:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: remove sn2, hpsim and ia64 machvecs
Date:   Wed,  7 Aug 2019 16:30:20 +0300
Message-Id: <20190807133049.20893-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

let me know what you think of this series.  This drops the pretty much
dead sn2 and hpsim support, which then allows us to build a single ia64
kernel image that supports all remaining systems without extra indirections
in the fast path.

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git ia64-remove-machvecs

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/ia64-remove-machvecs
