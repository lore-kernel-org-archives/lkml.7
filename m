Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F7FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6D4206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UbD6SjMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfJHPqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:46:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHPqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0B4Il8PmhkOUmEhLQP9qNlA++eZXIw98dqX7m+U4L5k=; b=UbD6SjMaqVYPYvOMJ2h2Y3bgR
        ERHHDjvgiBvw2KL79vGFfa3ykXAq3tHK3WYnBcSKTl+1vLZOZ/H5IPxKnqeflnYr3Xm7LpcuSwq1d
        dqkzM9q9Vkq/vUKjRUlswvDlLWAZ9jRi2pVaXW/+uYJgE2K+IZNh1uPc+PhwluyCr1I5bcWtTkBOD
        8RwONzu05MbT6dUN44VleSgIzBwNp25GzonkYnEyYHTdWjRST6/NFkUfjvhXFAlqJANa4U7R8oaF7
        Assb1gm99kobpxSiEOoqMqVQbf5T+43G/N0c9QI+wRdbjE2MtWeY0p9PA2arkBB4wB3cIcUgu26dx
        4rdUOiM9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHrga-0004YZ-1L; Tue, 08 Oct 2019 15:46:04 +0000
Date:   Tue, 8 Oct 2019 08:46:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] microblaze: Include generic support for MSI irqdomains
Message-ID: <20191008154604.GA7903@infradead.org>
References: <aa6dd855474451ff4f2e82691d1f590f3a85ba68.1570530881.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6dd855474451ff4f2e82691d1f590f3a85ba68.1570530881.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 12:34:47PM +0200, Michal Simek wrote:
> index e5c9170a07fc..83417105c00a 100644
> --- a/arch/microblaze/include/asm/Kbuild
> +++ b/arch/microblaze/include/asm/Kbuild
> @@ -25,6 +25,7 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
> +generic-y += msi.h

Please just mark it as mandatory-y in the asm-generic makefile
instead of requiring a sniplet for every architecture.
