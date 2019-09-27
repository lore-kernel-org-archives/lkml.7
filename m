Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B672CC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8DC21841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GE8yIbd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfI0WVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:21:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0WVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZKFeHyvETC+38UTlXHyc0JEWdr9e5XA2y4WeMp+VK6k=; b=GE8yIbd6tVtE1/iLSYLHoIDj6
        kDyEgPrCoSDNeFV75qh4oh8xzxLXioF6zfm5FWlSaSIbNmBXCIoQv97mV7Qa6yC2ZiKixD0EAbXik
        /7UbL4EoqQZXS8uaF70jrdB3XEsehoQCRg6JmicnJNIgqF9TQ8v702qIobKHa9JpTNzrV7OCrVkW7
        134q7NfGHWJx54tXVZ8uC2+YkRaHxhn6Owt2OVPPqJSFx82aHs6HD6PgtSeZJF7XTNByakXCQn/TI
        +iAuNJPThjGOxgtyuPKloSY+MiV6hrWFn1qRyqOUWd7U2h693FLbmuOxDvsShojGnmi9Hipn0o3I0
        WWKm0r5qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDybs-0002ih-0Z; Fri, 27 Sep 2019 22:21:08 +0000
Date:   Fri, 27 Sep 2019 15:21:07 -0700
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
Subject: Re: [PATCH v2 3/3] RISC-V: Move SBI related macros under uapi.
Message-ID: <20190927222107.GC4700@infradead.org>
References: <20190927000915.31781-1-atish.patra@wdc.com>
 <20190927000915.31781-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927000915.31781-4-atish.patra@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:09:15PM -0700, Atish Patra wrote:
> All SBI related macros can be reused by KVM RISC-V and userspace tools
> such as kvmtool, qemu-kvm. SBI calls can also be emulated by userspace
> if required. Any future vendor extensions can leverage this to emulate
> the specific extension in userspace instead of kernel.

Just because userspace can use them that doesn't mean they are a
userspace API.  Please don't do this as this limits how we can ever
remove previously existing symbols.  Just copy over the current
version of the file into the other project of your choice instead
of creating and API we need to maintain.
