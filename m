Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C227BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6D820673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="urzXn1Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfD2MWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:22:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2MWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xl4MrYPDmF4P7eoHhj1V5OKIKtqTlTb2zUS6E3j/D/k=; b=urzXn1TjNfhZgYIXvoNGdwcEL4
        t32R7kXmkyDSDQ8U38vmgrR+PE3OEpsGs2J1p8qyU84uSDRMwJp4FZOCpIdDSVXWvMsDoT0+2JP2z
        XNYcto0rN83HQx8dovrIibRYuZiernalkybiVBLziDtJ4OVr90Gvho1ip9OXiRTryUyGidMlj7Kbv
        BkEwJrkIRessWqBBV40J+H7O5zd8oGPLTfKDWUwzoDo8wjTuHo4Sd8Q12kPlasjjsUM1hELMZ8n0/
        U7mTMPPQKj2Pu/Bopf53s0bWYZQJQKNBMgwLYhVlOLWfwrfJsQzL5lx0ACoA2NoJTUE78c4EzZlle
        bpg2Kz8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hL5IQ-0001hq-Mt; Mon, 29 Apr 2019 12:22:10 +0000
Date:   Mon, 29 Apr 2019 05:22:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Edward Cree <ecree@solarflare.com>
Cc:     Nicholas Mc Guire <der.herr@hofr.at>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rds: ib: force endiannes annotation
Message-ID: <20190429122210.GB32474@infradead.org>
References: <1556518178-13786-1-git-send-email-hofrat@osadl.org>
 <20443fd3-bd1e-9472-8ca3-e3014e59f249@solarflare.com>
 <20190429111836.GA17830@osadl.at>
 <2ffed5fc-a372-3f90-e655-bcbc740eed33@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ffed5fc-a372-3f90-e655-bcbc740eed33@solarflare.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 01:02:31PM +0100, Edward Cree wrote:
> ... are some bitwise ops on the values (bitwise ops are legal in any
>  endianness) and incrementation of the pointers (which cares only about
>  the pointee size, not type).

Oh, true.  That is why the underlying annotation is called __bitwise :)
I'll take my previous comment back.
