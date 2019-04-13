Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457B9C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074B520869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZYOq66kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfDMHzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:55:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfDMHzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WaywDY2HZm18jBKPr1p1ZOnmZ3S+Qtg3xVeq74H9OUU=; b=ZYOq66kx4UAaJi9ef+jhFsvu1
        07O+Ga6cnQ21+YjflblEPJ/oqTw/Smvq8UNKX0/xz4A5xfSSGX1A6XHO+G2BjUtdv+v78eNn2/OLy
        9HI9I5/h0vQwYgwHa9m4EZks8IWLfjOTU3lc4gLTYtwCF44Kmc5iV5qCAWGN6qdMll5j3baguhL20
        arvF2YsINnYDrRL47Fj3WFyzXB3BHjaYQfja0o9YjeDR0s8FL7XtTZ4JKDbh/qUJlW8JioBiDjdSG
        tC0ABxeo3b7OWsy1FN/DSaW0mH7aIo0pfToPUQeWbluKqWCYPmO+DS2q3pqtt0eRXvy37e0iCArLQ
        AFhPqIKiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFDVs-0000xN-60; Sat, 13 Apr 2019 07:55:48 +0000
Date:   Sat, 13 Apr 2019 00:55:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 3/3] RISC-V: Access CSRs using CSR numbers
Message-ID: <20190413075548.GC30428@infradead.org>
References: <20190413073906.53676-1-anup.patel@wdc.com>
 <20190413073906.53676-4-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413073906.53676-4-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 07:39:44AM +0000, Anup Patel wrote:
> We should prefer accessing CSRs using their CSR numbers because:
> 1. It compiles fine with older toolchains.
> 2. We can use latest CSR names in #define macro names of CSR numbers
>    as-per RISC-V spec.
> 3. We can access newly added CSRs even if toolchain does not recognize
>    newly addes CSRs by name.

This looks mostly fine, but also please remove all the comments
regarding using sptbr instead of satp now that they are not true
anymore.
