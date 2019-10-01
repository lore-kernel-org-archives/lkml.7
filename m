Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2AEECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D9F21D80
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RpgTG9pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfJAKKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:10:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJAKKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XtyAdyybK9/2yq2Y9Xw+/1gjr0liZcE2qS9FErv9e5k=; b=RpgTG9pKdNnoQvVU0EB+7FThY
        nMlgbZbfh1O7eVWjPz0UXK6sWfzZ478AKB1BN2s6lGx8bSaXDv8rg9Q/PfaC8ehgnxeOF/9IuE+tX
        aegeCQAt/dlD9vezXu0jhbROMa/2HmK6bw/lmHPbGH/qy0Ij+T7SRYWgXneDlqGrK1lfS1A/qLvMX
        5t01yGzEy5NDxAJcJEWrjl3PzNoJvqNnGTf2HkEfY8RHGICh5YYs6Mz3woYRgZ/GIMpP1rYdCZmot
        EzGTj+HjtAV0jiBN+8Fgy+58K4zvVNBAtELCe2rw8j0o7rBx2g9VbhdTzW/4AOyIG3aPJx06QyVVC
        AuUBgYwiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFF6m-0007Pg-Fv; Tue, 01 Oct 2019 10:10:16 +0000
Date:   Tue, 1 Oct 2019 03:10:16 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>
Subject: Re: [v6 PATCH] RISC-V: Remove unsupported isa string info print
Message-ID: <20191001101016.GB23507@infradead.org>
References: <20191001002318.7515-1-atish.patra@wdc.com>
 <20191001070236.GA7622@infradead.org>
 <b0c39a9895698d74e2f44eb1f2faed46eee54bc3.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c39a9895698d74e2f44eb1f2faed46eee54bc3.camel@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 08:22:37AM +0000, Atish Patra wrote:
> riscv_of_processor_hartid() or seems to be a better candidate. We
> already check if "rv" is present in isa string or not. I will extend
> that to check for rv64i or rv32i. Is that okay ?

I'd rather lift the checks out of that into a function that is called
exactly once per hart on boot (and future cpu hotplug).
