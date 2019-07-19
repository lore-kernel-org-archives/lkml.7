Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F5C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D7C2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGSGBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:01:02 -0400
Received: from verein.lst.de ([213.95.11.211]:37200 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSGBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:01:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F96268BFE; Fri, 19 Jul 2019 08:00:55 +0200 (CEST)
Date:   Fri, 19 Jul 2019 08:00:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Miller <davem@davemloft.net>
Cc:     ldv@altlinux.org, hch@lst.de, khalid.aziz@oracle.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        matorola@gmail.com, sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-ID: <20190719060053.GA18491@lst.de>
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de> <20190717215956.GA30369@altlinux.org> <20190718.141405.1070121094691581998.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718.141405.1070121094691581998.davem@davemloft.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 02:14:05PM -0700, David Miller wrote:
> From: "Dmitry V. Levin" <ldv@altlinux.org>
> Date: Thu, 18 Jul 2019 00:59:56 +0300
> 
> > So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> > (thanks to Anatoly for bisecting) and introduced a regression: 
> > futex.test from the strace test suite now causes an Oops on sparc64
> > in futex syscall.
> > 
> > Here is a heavily stripped down reproducer:
> 
> Does not reproduce for me on a T4-2 machine.
> 
> So this problem might depend on the type of system you are on,
> I suspect it's one of those "pre-Niagara vs. Niagara and later"
> situations because that's the dividing line between two set of
> wildly different TLB and cache management methods.
> 
> What kind of machine are you on?

FYI, I'm pretty sure I tested this on Guenthers build test qemu
setup in the end, which further speaks for the different machines
issue.
