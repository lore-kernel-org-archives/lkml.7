Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0452148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="GvgiXh2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfDHPPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:15:14 -0400
Received: from a9-37.smtp-out.amazonses.com ([54.240.9.37]:46396 "EHLO
        a9-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728479AbfDHPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554736511;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=lNudCzZ4w2s8/H8+lpBX7L/o8a8N/r9Gfx4wno1thXs=;
        b=GvgiXh2jwzAKEcSIvSEHZ7wXwO53kEXUrIQ32sBEP9JQ5xZuwvt2G2bVkMYkRab/
        s8KivUTDhpY3S/pzO5O2k7tEkQI0ZyRGpdsqWx71a9wJfL775CkbpHGn71j6vP8XsjD
        q7weJEid6EUbqwZjDvHiR2VVskTLBYw+21QKoko0=
Date:   Mon, 8 Apr 2019 15:15:11 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        penberg@kernel.org, David Rientjes <rientjes@google.com>,
        iamjoonsoo.kim@lge.com, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab: fix a crash by reading /proc/slab_allocators
In-Reply-To: <CAHk-=wgr5ZYM3b4Sn9AwnJkiDNeHcW6qLY1Aha3VGT3pPih+WQ@mail.gmail.com>
Message-ID: <01000169fd847a25-5933cc1e-a520-416a-b634-84b3e7ce9960-000000@email.amazonses.com>
References: <20190406225901.35465-1-cai@lca.pw> <CAHk-=wgr5ZYM3b4Sn9AwnJkiDNeHcW6qLY1Aha3VGT3pPih+WQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.08-54.240.9.37
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2019, Linus Torvalds wrote:

> On Sat, Apr 6, 2019 at 12:59 PM Qian Cai <cai@lca.pw> wrote:
> >
> > The commit 510ded33e075 ("slab: implement slab_root_caches list")
> > changes the name of the list node within "struct kmem_cache" from
> > "list" to "root_caches_node", but leaks_show() still use the "list"
> > which causes a crash when reading /proc/slab_allocators.
>
> The patch does seem to be correct, and I have applied it.
>
> However, it does strike me that apparently this wasn't caught for two
> years. Which makes me wonder whether we should (once again) discuss
> just removing SLAB entirely, or at least removing the
> /proc/slab_allocators file. Apparently it has never been used in the
> last two years. At some point a "this can't have worked if  anybody
> ever tried to use it" situation means that the code should likely be
> excised.

This is only occurring with specially build kernels so that memory leaks
can be investigated. The same is done with other tools (kasan and friends)
today I guess and also the SLUB debugging tools are much more user
friendly. So this means that some esoteric debugging feature of SLAB was
broken.

