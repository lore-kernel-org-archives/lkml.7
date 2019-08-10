Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E239C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFB4208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfHJHRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:17:06 -0400
Received: from verein.lst.de ([213.95.11.211]:60937 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfHJHRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:17:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1765068B02; Sat, 10 Aug 2019 09:17:02 +0200 (CEST)
Date:   Sat, 10 Aug 2019 09:17:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Christoph Hellwig <hch@lst.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-ID: <20190810071701.GA23686@lst.de>
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de> <20190717215956.GA30369@altlinux.org> <CADxRZqy61-JOYSv3xtdeW_wTDqKovqDg2G+a-=LH3w=mrf2zUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqy61-JOYSv3xtdeW_wTDqKovqDg2G+a-=LH3w=mrf2zUQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't really a way to use an arch-specific get_user_pages_fast
in mainline, you'd need to revert the whole series.  As a relatively
quick workaround you can just remove the

        select HAVE_FAST_GUP if SPARC64

line from arch/sparc/Kconfig
