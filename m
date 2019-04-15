Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43B1C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A5C2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rIATMSUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfDOQk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:40:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfDOQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4P7L99vwueUQIVVYUSitqk8lX9/oC9DZ894Z38CWA2Y=; b=rIATMSUF6mD9gDbhnNHtEyk4t7
        aChNvyyv6j/dgu2AodIuEJgZJ58EcWgOM5+FUUGbYAGOWanLlEdctoDoV5p2fcuuPJdI5CKriaqdd
        77PQPyNy8anOalA2XRzlYPvsWd4uKd9xc76NGvFuhQx3nnDfIf6MDzMG7ITHFTPBghGk++WpS5Mmm
        NnieVKIiDMBz/iyvuL1LXOsL4hykKJ8vqGHlBKQCv8xf611NzL6ExzdaX759abBblGerK2i4fsQJA
        c65DgDuiPf45IQ7tcTS/ikHD0URDP2pR1NeBnIeSxr4Njc8J9CU3fweKLrt1mg7dnypOCiNjeUuvi
        KpeVIvoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG4ec-0001az-Co; Mon, 15 Apr 2019 16:40:22 +0000
Date:   Mon, 15 Apr 2019 09:40:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: avoid atomic_inc in exit function
Message-ID: <20190415164022.GA32090@infradead.org>
References: <20190415155509.3565087-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415155509.3565087-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:55:00PM +0200, Arnd Bergmann wrote:
> This causes a link failure on ARM in certain configurations,
> when we reference each atomic operation from .alt.smp.init in
> order to patch out atomics on non-SMP systems:
> 
> `.exit.text' referenced in section `.alt.smp.init' of drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section `.exit.text' of drivers/char/ipmi/ipmi_msghandler.o
> 
> In this case, we can trivially replace the atomic_inc() with
> an atomic_set() that has the same effect and does not require
> a fixup.

I'd rather fіx the arm section management.  Using atomic in exit
routines is perfectly valid, and it would seem odd to forbid it.
