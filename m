Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD227C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3342087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fet+F70j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfCYLia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:38:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfCYLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zs5p2ts4J/0GsjEh6VhRCFHQy9NtUAnxa/xKagLT3tk=; b=Fet+F70j51j30cv9zKCvvxSA5
        EW0eXEAMT0k4zyaNxippXm/8z4kknlP/qTcne+eeRXMtyyltX1jUmMTupLOo6WagQ9c3nghWYtd9k
        fk7zrxGwiPbhvMZCey4Q2DoVLO/rBDKWjw2J2wKfjNxgJx5+GKaDbMbHgJNtXDcRQTgYVZvti974t
        JS1DPNXU7ktf19qz9hqFvuRfIoHhNn2o2jhoe54tF4sMUMEq4K6JdM1e8HGXUv7E2qn9hGwcVsYkF
        SIXUcCwB5xgx33XoBid2qBiDu2E/NP/F6SyQPYL2X/zM3YTmU5YkJ1hys6nO5CKpKyb/peGQ7so1x
        xymA9etBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8Nvv-0000RO-Mh; Mon, 25 Mar 2019 11:38:27 +0000
Date:   Mon, 25 Mar 2019 04:38:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 2/4] RISC-V: Fix memory reservation in setup_bootmem()
Message-ID: <20190325113827.GB27843@infradead.org>
References: <20190325092234.5451-1-anup.patel@wdc.com>
 <20190325092234.5451-3-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325092234.5451-3-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:23:09AM +0000, Anup Patel wrote:
> Currently, the setup_bootmem() reserves memory from RAM start to the
> kernel end. This prevents us from exploring ways to use the RAM below
> (or before) the kernel start hence this patch updates setup_bootmem()
> to only reserve memory from the kernel start to the kernel end.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Shouldn't this be a Suggested-by?
