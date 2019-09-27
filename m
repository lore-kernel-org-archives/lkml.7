Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56F0C388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C3421BE5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbqjZDu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfI0WTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:19:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0WTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3vhOmfdU3y6eLM058hdQ8gBFeloyzGlQE3QsONV3mF8=; b=kbqjZDu/WAoB3RJgwnRpj69wr
        5PyKLZhpAWePMsZKQvv8+ZyAbJBqq1PqtBIFzXeg6jn3Lt1urs47YKsBQHCDg66PQTb2G6i5iJJg7
        jtawQ6hWDHYC+RSTbGKsEST9an7uFQ5BEPWDj0xOsXm2JP4I7DXgegTBc8tTHxU9pxkx6bEWIYe/B
        KgU4i09JvimbuX364xkefRSXpdB9GXSjW9lz0Dr4B0RfjEkg7i9bOw1UFExDMu5F9DW4LjUQC4q+Q
        /MNgffNXKPvHex/TZ+yFXFkpNC0FW9jFlKUjxzIT5yZLqaNWNDg8Q2k/lsQnnSYoWyvknOmgp4/sN
        jx+PKBLKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDya1-0001HT-7d; Fri, 27 Sep 2019 22:19:13 +0000
Date:   Fri, 27 Sep 2019 15:19:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2 0/3] Add support for SBI v0.2
Message-ID: <20190927221913.GA4700@infradead.org>
References: <20190927000915.31781-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927000915.31781-1-atish.patra@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:09:12PM -0700, Atish Patra wrote:
> The Supervisor Binary Interface(SBI) specification[1] now defines a
> base extension that provides extendability to add future extensions
> while maintaining backward compatibility with previous versions.
> The new version is defined as 0.2 and older version is marked as 0.1.
> 
> This series adds support v0.2 and a unified calling convention
> implementation between 0.1 and 0.2. It also adds minimal SBI functions
> from 0.2 as well to keep the series lean. 

So before we do this game can be please make sure we have a clean 0.2
environment that never uses the legacy extensions as discussed before?
Without that all this work is rather futile.
