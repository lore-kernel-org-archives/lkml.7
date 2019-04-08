Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C882147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="tGMBSHPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDHNRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:17:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39524 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:17:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so15280495qte.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQ1SL9x4bZEYJy4r8vMymO8S+vKZHanfiXAqd5yNVlg=;
        b=tGMBSHPMKldELijf7ebfUlxeeTeLrmGlAS+GT3x9k22hlFNOefudwLsOJx77cQ2zsU
         XC11xSxJvWxx/g+DvPTqp/8G4WASzymHnVaKllfPqqBmWkVewDkjRg7EUAwQ4BwMEnek
         C1qXrzW/ZIiP6VHcqJYgvhz1eim3v/0aGSLlNPyaN70cNdNdVJVZNAJnvr4nF06KISIM
         ScDscYVVw3QXzS7iMbLH7H38VkMo9hrotMWyQ0B16321feot7yXACtuM/YU6ounkokuP
         g5OGfx0I6eoOMS4dx9aOxSKDB1VWlkwNFdd3gzGRv3+7OkgRtm4tC1OHjeNCcPWX/Iql
         rfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQ1SL9x4bZEYJy4r8vMymO8S+vKZHanfiXAqd5yNVlg=;
        b=kJb9wmpoMuwaCsC7FWBCJuPLH7egLWdZMtsX3yw3kH5p/PNqJOy7rUS7v+Jtz5I3Ai
         hsY5MHOYgbvKzltCDMVpWHEqMY11LZ0Hi7K20fOXsz2o10ssWgcJMpVaQs7G7siZTSxv
         /bSSt3CEvISMQLU492fXfNBsnwNKa9uBc+gHcSbN1iuoe/txnSm5KJaMfnOS66mkdFyu
         l7XdNelD4XFZFHqphNiMwnWAJFuNj8b6yqLck0TGk21ihDutxqwbU9XGWq3V+ro5vAFP
         s0sjUupn+g/owBhVdxL+PXCNJwuYpa52yGgc83ssVQOoGuEZzluGEmUvRWrGG4SRbRxq
         ZitA==
X-Gm-Message-State: APjAAAXwrXy6WJZtzpeqV4QCnBxVO6O814T26iWTcs08oBhWcTiGNy5m
        w2BUb9a4VudTpxyChgVrfwQjWw==
X-Google-Smtp-Source: APXvYqzU6+z7q49B2XOUsT4HgLpoMZS9GA5y3qCYOAPVfjWmMVH1tX1HnUyjNK8X3E6L7g4zrk5qEw==
X-Received: by 2002:a0c:b78f:: with SMTP id l15mr23189216qve.160.1554729457052;
        Mon, 08 Apr 2019 06:17:37 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n70sm19984226qkn.5.2019.04.08.06.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 06:17:36 -0700 (PDT)
Message-ID: <1554729454.26196.44.camel@lca.pw>
Subject: Re: [PATCH] slab: fix a crash by reading /proc/slab_allocators
From:   Qian Cai <cai@lca.pw>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Tejun Heo <tj@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Apr 2019 09:17:34 -0400
In-Reply-To: <CAHk-=wgr5ZYM3b4Sn9AwnJkiDNeHcW6qLY1Aha3VGT3pPih+WQ@mail.gmail.com>
References: <20190406225901.35465-1-cai@lca.pw>
         <CAHk-=wgr5ZYM3b4Sn9AwnJkiDNeHcW6qLY1Aha3VGT3pPih+WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-04-07 at 19:35 -1000, Linus Torvalds wrote:
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
> last two years. At some point a "this can't have worked if  anybody
> ever tried to use it" situation means that the code should likely be
> excised.
> 
> Qian, how did you end up noticing and debugging this?

There are some nice texts for CONFIG_SLAB Kconfig written in 2007,

"The regular slab allocator that is established and known to work well in all
environments."

"tricked" me into enabling it in a debug kernel for running testing where LTP
proc01 test case (read all files in procfs) would usually trigger the crash
(Sometimes, "cat /proc/slab_allocators" would just end up printing nothing).

Normally, all those debug kernels would use CONFIG_KASAN which would set
CONFIG_DEBUG_SLAB=n. However, there is no KASAN for powerpc yet, so it selects
CONFIG_DEBUG_SLAB=y there, and then the testing found the issue.
