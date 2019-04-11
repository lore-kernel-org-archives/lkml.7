Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC5C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B6921841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PZ4M3IAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDKG7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:59:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKG7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GiQINlGJosPYmr/ByTYLOYbdKecbUBGNgpmQ/M2GHic=; b=PZ4M3IAEzu9842mg4q/Prsk2V
        5bDEEkANHKMffKlqD6SRe/6FirCvb1ff8xCnV4jmeLopjZl5wC3DbBW5rMmktqf+fWCTs+r5pYzLK
        NqAbw+SSfzX6gFZI3FoaMUCWRt0+vt7hmz/J4m5DUhU6kR5vR25lUGCiuoHkG4XfuB+ErUDNX4GI+
        yUe3DCxNB7tqzepU2B9Xd2467o/8ch7hNdI8zIfZyV0WcNHCLw/UUEWuGqtjgP2kWuNYQhNG5L7Ux
        bKduQ5nQjsgl3yhFz5h5uDSZNymSNqsU5fx3TLemtjar6iRmn2DoHTb6g88/Xst7H+HWyrXGvS6Xc
        P1BDguKwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hETfs-0001tA-Kl; Thu, 11 Apr 2019 06:59:04 +0000
Date:   Wed, 10 Apr 2019 23:59:04 -0700
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
Subject: Re: [PATCH v2 2/4] RISC-V: Fix of_get_cpu_node usage
Message-ID: <20190411065904.GC29422@infradead.org>
References: <20190410230443.15729-1-atish.patra@wdc.com>
 <20190410230443.15729-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410230443.15729-3-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:04:41PM -0700, Atish Patra wrote:
> of_get_cpu_node expects a logical cpu id not a hartid.

But only because you changed that with your patch 1, so it should
be folded into that.
