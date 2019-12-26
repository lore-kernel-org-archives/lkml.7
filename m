Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB93DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D9D2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLZWuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:50:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51618 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZWuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:50:07 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ikbvG-0000uN-8v; Thu, 26 Dec 2019 22:48:02 +0000
Date:   Thu, 26 Dec 2019 22:48:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dwmw2@infradead.org, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: jffs2: fix possible sleep-in-atomic-context bugs
Message-ID: <20191226224802.GR4203@ZenIV.linux.org.uk>
References: <20191217135143.12875-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217135143.12875-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:51:43PM +0800, Jia-Ju Bai wrote:
> The filesystem may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
> 
> fs/jffs2/malloc.c, 188: 
> 	kmem_cache_alloc(GFP_KERNEL) in jffs2_alloc_refblock
> fs/jffs2/malloc.c, 221: 
> 	jffs2_alloc_refblock in jffs2_prealloc_raw_node_refs

... gets called only if jeb->last_node is NULL.  I've no idea
whether it is possible on those call chains and analysis is
certainly needed before applying that kind of patches.

It might very well be real, and certainly worth asking jffs2
folks to look into.  But this kind of "defensive" fixes
is no good without understanding of the situation in the
code being (hopefully) fixed.

It's a good catch; even if there is a reason why we never
hit the blocking allocation in there, that reason should be
spelled out in the code.  It isn't, and that can easily
grow into a bug even if it hasn't done so already.
