Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E925C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2325B22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uAFmJsF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfIDMRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:17:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfIDMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Obe2gdTCPdX2dJrsCnj1Gz4iZ+S/dsGP5h5Qib8KSnU=; b=uAFmJsF/nRbf4aZMB9yGxwJO5
        UUzPaS5YHSyHl6qr2zo6NOm/kOxGFV/rwokaS0z3i9y1efM2MVkGqNdIKUPyjqR3MdHOeaTrqCHKV
        VbH8SqGMWaJCRUD/TKXDurR/+g4RBZ3RPUcWLhO68TH5Qr1FariV9OCWyd9ERYMlS+4FAGxnO8SxX
        AvfmfHUeHiGXvV7iBCPiIWxA8glb5hOLpNX3KVYfUtzu9SUfQO1Eel2x7ovw4eooMTzB2n3jIxvLO
        ZJXVW0jmw6YWiMQ3WKRtYwFYquSsHv1//FkOT0kZu7CDa8dMu+CSVYBIaNgoAkj/sf+DBHQxY0bDP
        RWs87zYkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5UDy-0004No-6L; Wed, 04 Sep 2019 12:17:22 +0000
Date:   Wed, 4 Sep 2019 05:17:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma api errors with swiotlb
Message-ID: <20190904121722.GA15601@infradead.org>
References: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to dma_max_mapping_size() to limit the maximum I/O size solves
that problem.  With the latest kernel that should actually be done
automatically by the SCSI midlayer for you.
