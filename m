Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FD1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF2521841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OOhQZevJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDKG6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:58:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKG6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=993uO4zGCVdKb6icRldb2NUjy7/3iNlkThDi2dmCT38=; b=OOhQZevJHJ+ZEk4XXQXIwH421
        zpnIH/77Q40NEJ6N7mW24gojoRNupyHQXinT1/mzEOikZydis7W01EnFwgMwZsd5MoLMXfE62el5x
        Wz+b1l4UddW/UZTSkGaR5lJPFabdzBp3iyfhb7N9YawTlUpb+WjReG+me/SmxnvkB3H48hhIj75zp
        PzPyymlfnzGLOrWUJfhHkjgmfQdYp6qLjFkDWT9ks9/CUDVKaSdkIRBbOVe3CYsie2Jv36K/ltMr2
        66q3BsgflxkPIj5eIZ6zb81lPX+GS9mi2YV1Z6CYjaAOvPHQzI8w+qcknCIlJAC3yvN4haRRJbkPw
        W2XKC84CQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hETez-0001di-AU; Thu, 11 Apr 2019 06:58:09 +0000
Date:   Wed, 10 Apr 2019 23:58:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 1/4] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
Message-ID: <20190411065809.GB29422@infradead.org>
References: <20190410230443.15729-1-atish.patra@wdc.com>
 <20190410230443.15729-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410230443.15729-2-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:04:40PM -0700, Atish Patra wrote:
> OF/DT core has a hook for architecture specific logical cpuid to hartid
> mapping. By implementing this, we can pass the logical cpu id to cpu
> node parsing functions.

But that also means we must pass it that way.  So as-is this would
break existing setups, wouldn't it?
