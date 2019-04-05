Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595F2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B7A21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hnr5WZBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfDEFy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:54:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEFy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0ElSP3JGAMxV4PKBAmgjNsswF1zAiAvQvIKeo2t7kxM=; b=hnr5WZBWyfpphSungyKH/Ftql
        2oJOBCJIov3AJuJeOLyOeEgeArN04VHM6qloJubeFhyG0yYlrINWiViVbb4IFcDBXwBbWEWRv9qEs
        h/CI0LZqgO+Q3uqsX5rJKmezWn3HKcXOPX8UGN+db8qfBawiWTjMdR2rFiJLXT4x5XzW8/Yi57SGI
        x2gwwLUovAW5hNYT1XcKCJLBgFlflgjGHWYPuy6CA9qbdZJ1HPGjQojH8oQ6bTNrS49XolqXjRkI7
        EFkleg2rz77pe1mivc4yMbc2wKou53PibtRP9v2RbdOPq07P9aj9J5Bqi9kH/k0S44tVCUqM+X/nk
        zV4UlEFWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCHnx-0001w0-Ii; Fri, 05 Apr 2019 05:54:21 +0000
Date:   Thu, 4 Apr 2019 22:54:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] RISC-V: Fix Maximum Physical Memory 2GiB option for
 64bit systems
Message-ID: <20190405055421.GA7087@infradead.org>
References: <20190405054909.3238-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405054909.3238-1-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:49:34AM +0000, Anup Patel wrote:
> The Maximum Physical Memory 2GiB option for 64bit systems is currently
> broken because kernel hangs at boot-time when this option is enabled
> and the underlying system has more than 2GiB memory.
> 
> This issue can be easily reproduced on SiFive Unleashed board where
> we have 8GiB of memory.
> 
> This patch fixes above issue by removing unusable memory region in
> setup_bootmem().
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, what is the rationale behind even offering the 2GiB option and
the medlow model on 64-bit?  Do we reall have use cases where the
slightly more effient generated code matters so much to keep up
the support burden of this mostly unused and unusual configuration?
