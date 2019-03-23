Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19553C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6FE218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o1aVf4sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfCWRYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:24:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfCWRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1RnHrJKLinOTdv/ak7f9kAq9n9lscJauEZ8R2hd/aAU=; b=o1aVf4sKUfhE3CxCL3N82L9vI
        PgqjFQLZrS109Q+b/SadUTNorpVj7Xomf3oA0YFopNadCHCaKstj68XjHqtEQKGXYFQMpDfiyeq9Y
        oAihEUodyXtlx2PtqZ7JJcS/yCKSoE8dzzCU0KsWbVKZ2lJ9KPPmGQFXflZzj5nncgd2avgI+okaF
        TCssDWOgMKrCNb34M/RO1kj16oxjXEDf5TtmXL3Az/25XkcJUgJA3PBZ1n6yN6BFzfAlibhv+P0R1
        UiWU+n3ZpGFlwie/a5pNTFZp11QE7D0Yfh1izZpClwGS5M960+z2MxKBkway67B6Xj3i6c8tmf5tD
        eYZPKLvUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7kNZ-0003jE-92; Sat, 23 Mar 2019 17:24:21 +0000
Date:   Sat, 23 Mar 2019 10:24:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 3/5] RISC-V: Allow booting kernel from any 4KB aligned
 address
Message-ID: <20190323172421.GA14080@infradead.org>
References: <20190321094710.16552-1-anup.patel@wdc.com>
 <20190321094710.16552-4-anup.patel@wdc.com>
 <20190323154012.GA25149@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323154012.GA25149@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 05:40:12PM +0200, Mike Rapoport wrote:
> I have no general objection, but I presume the patch will be significantly
> simplified if the addition of 4K pages support will follow the removal of
> the trampoline_pd_dir. 
> 
> That said, I didn't look into the details, since they will change
> substantially, only some comments on the Kconfig part.
> 
> On the high level, have you considered using large pages in setup_vm() and
> the remapping everything with 4K pages in setup_vm_final()?  This might
> save you the whole ops-> churn.

That would be a great start.  That being said the current tiny memory
RISC-V devices don't even have a MMU, so the kernel pagetable mapping
isn't even relevant for them.  I'm just not sure adding more complexity
in the early boot path for a borderline case (MMU and tiny memory
with a tiny kernel image) is reall worth all the complexity.
