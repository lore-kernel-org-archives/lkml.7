Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2517EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EB02133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gVXVPGWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfJGQKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:10:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PCyJU3ca+Mvj8pvXxRNRagxt2UUiR2tcaN+o+wNoM1I=; b=gVXVPGWWNjl+DQBYIVZaAPCX4
        gs4vwnNTSXsln1yaqRNfV+c9OpcyVzd0Io28aILYClbv/gBULKL7naX0icjbkeE/QIQpVzTJLBiG/
        sKkUeLl5CJlJl7ojDYqfh2PJGIELyJ+M6GcYvkRfT8cxwDK3MHkLF8ZTxSG6Ax0rcTgarVYeuIOFz
        43f/6B/6QmOk5CT7Xy1ISDgou+oTLGnWLdZWgSZ5TFz1yUW8A+y7t7Wr7i5ohmZibg0FL5ERLVLHD
        dFhk163tmtM4HlUWV7cYIY7eL8cTsGGGVFtqkaRQstWw4tFNxOXXWEXmtk+WL1U1/MR2e/E7BH1/N
        6xu4oNIxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHVb0-00079G-4w; Mon, 07 Oct 2019 16:10:50 +0000
Date:   Mon, 7 Oct 2019 09:10:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Subject: Re: [PATCH 4/4] riscv: remove the switch statement in do_trap_break()
Message-ID: <20191007161050.GA20596@infradead.org>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
 <1569199517-5884-5-git-send-email-vincent.chen@sifive.com>
 <20190927224711.GI4700@infradead.org>
 <alpine.DEB.2.21.9999.1910070906570.10936@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910070906570.10936@viisi.sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 09:08:23AM -0700, Paul Walmsley wrote:
>  		force_sig_fault(SIGTRAP, TRAP_BRKPT,
>  				(void __user *)(regs->sepc));

No nee for the extra braces, which also means it all fits onto a single
line.  You could have just copied what I pasted..
