Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA36FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A520835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0NJGCtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfCTXtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:49:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfCTXtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oCTw3ZG9mEPSISHtXPnTm6YFLfqMCHQGBUSczruFKI8=; b=l0NJGCtJnDHrILLMM/JPwc3Rq
        qx0JqR8TiY+S3nLH/KaBReHIPWB6f/CvQitDhjekL8UvS78ALgxDe4Mi2UFRuTzwXY4BLHLG89OsM
        gl8HcxxgkMV1Wyg1+uNr3Udp+rYFC8huZ41Vw8vjl5JjdoU/XDCV2LaT2RRWTE/Dgq/Q1EldIW42d
        ozG140eVEXiUk0G0BHmJzD6EtjV4/Dz6P1A9F7zmQyGJYssvsq1Y6yrIhQGo7piRUeirBwpTfcK0r
        P2L5pJ6LJFyKno+9YIearMclaZZrf0JnRYlv5cCG5TFon0rXbJkKpl32BSomicvqcSjy+kRhWMEqT
        1f41n1zog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6kx8-0001i1-UI; Wed, 20 Mar 2019 23:48:58 +0000
Date:   Wed, 20 Mar 2019 16:48:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "alistair23@gmail.com" <alistair23@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip: plic: Fix priority base offset
Message-ID: <20190320234858.GA5304@infradead.org>
References: <20190320223853.1209-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320223853.1209-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:39:52PM +0000, Alistair Francis wrote:
> According to the FU540 and E31 manuals the PLIC source priority
> address starts at an offset of 0x04 and not 0x00. To aviod confusion
> update the address and source offset to match the documentation. This
> causes no difference in functionality.

Well, it starts at 0x00, but the first one is reserved.  If you think
that is too confusing I'd rather throw in a comment explaining this
fact rather than making the calculating more complicated.
