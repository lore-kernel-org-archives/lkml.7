Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D948C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A6722527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uy0br++x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfLLMvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:51:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfLLMvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oSRXOSEob+GwTZ/RqtmUmQb3EJbz7IDcRAl8Llq9EHU=; b=uy0br++xhd/1zHgbIfpoQhVfN
        dvjpj42ZcEZbpSsh3gFbG8q6icweHNtUE3bQGkGT18YZDay/5awdRJeKmi9BUWVxWFvAkNw+MYqHl
        /k8j2aYyVngKxUYevHE4XUc32qDoraVyXHNL22Db1n+qKsfRciTQDC7IZfe2s/ubAUpvOPlsBFdRh
        u7H/sSbLtINFXQvX0eVB48f66DBqT+hQUi5EDiOljS6TUX3pNiPvUGfrjBENxJx54DhZzZm4YCmgf
        SXS2BVfRz0T9TB01N8Hc5nPmZKKH/0lIDDPiTAEl0m78KprC5vubs8PXI+vtsvLfN1tBK0uG4H9FF
        391G5tlCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifNw4-0002G9-Bs; Thu, 12 Dec 2019 12:51:16 +0000
Date:   Thu, 12 Dec 2019 04:51:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/irq: don't use current_stack_pointer() in
 do_IRQ()
Message-ID: <20191212125116.GA3381@infradead.org>
References: <1bb34d3ea006c308221706290613e6cc5dc3cb74.1575802064.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb34d3ea006c308221706290613e6cc5dc3cb74.1575802064.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why can't current_stack_pointer be turned into an inline function using
inline assembly?  That would reduce the overhead for all callers.
