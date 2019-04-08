Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4740CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20907217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDHMqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:46:53 -0400
Received: from verein.lst.de ([213.95.11.211]:42668 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfDHMqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:46:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 39C5A68B02; Mon,  8 Apr 2019 14:46:40 +0200 (CEST)
Date:   Mon, 8 Apr 2019 14:46:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jie Zhang <jie.zhang@analog.com>
Cc:     Mike Frysinger <vapier@gentoo.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: CONFIG_* symbols in UAPI headers?
Message-ID: <20190408124640.GA607@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just stumbled over the MAP_UNINITIALIZED defintion, initially
added by:

commit ea637639591def87a54cea811cbac796980cb30d
Author: Jie Zhang <jie.zhang@analog.com>
Date:   Mon Dec 14 18:00:02 2009 -0800

    nommu: fix malloc performance by adding uninitialized flag

The defintion depends on CONFIG_MMAP_ALLOW_UNINITIALIZED, which
will never be set by userspace.  How is this supposed to work?

Shoudn't we define the symbol unconditionally and just turn it
into a no-op in the implementation?


There are a few similar issues, like struct elf_prstatus having
a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.

