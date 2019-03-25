Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71876C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAD620811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GD4ekwVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfCYOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:55:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7boLzv7OU15Y19S5FvbZQWmwpOQOYrnoODQNpdHMVgI=; b=GD4ekwVzqNCOzaOhuFM2SWuli
        yHytAUlgLfSKawG2OgIl/YGWahFGnQMb+Rm6wFGxCLeXzKmgQ6e04g+cyVKgf3hNwpex7psRwBsIH
        pSEj/H+WI8ibooNp2hCPpGmc+ZSRc9sFiipMNPYWAtHHVhIoq8lbypqzMVlkrqdEnTiO0C8g60hW1
        QFN+GBLdOSbtsza0WxRSy8zloi5NMZTYwpt70AvPcbQ9gnjJkkP+W6Y8U7aQL0TBBmzwmRf3UJv3h
        /aD61iYHrjslVSnABB3QGY6hQwKJLzybwvWwzPLJ21i+hF8TStmDitpXUsRtZoc/ouTZJSrOqI6vO
        x4VMOiKhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8R0q-0005Da-1o; Mon, 25 Mar 2019 14:55:44 +0000
Date:   Mon, 25 Mar 2019 07:55:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned
 address
Message-ID: <20190325145543.GA14826@infradead.org>
References: <20190325092234.5451-1-anup.patel@wdc.com>
 <20190325092234.5451-5-anup.patel@wdc.com>
 <20190325113935.GD27843@infradead.org>
 <CAAhSdy3MZFayMDTiEEV7WseUsxgcWT_um=nbPgXUBFik19OYuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3MZFayMDTiEEV7WseUsxgcWT_um=nbPgXUBFik19OYuQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 06:12:28PM +0530, Anup Patel wrote:
> It uses new code for 2M mappings as well.

That seems to be an odd view - yes some code is shared, but we still
have two different ways using ifdefs.  

> The code is lot better, readable and flexible.

better is in the eye of the beholder.  It very much is not easier
readable with the spurious indirect calls at least.  And it is a lot
bigger.
