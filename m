Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8495CC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499A6214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569367801;
	bh=HTCjVVJhKnM9wBAHuE/prZG572PTBWFfbQcTmzcLdjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rIynTqZO/g6DgrhlxlqDXzd6ouRisRfx4Pf1YvWZsJ3X/uyRsxDFO/GwwTkBHxl1F
	 n+vK+SSh6xoq+VAL4fQUNg5dxN8yRrzfeClRRv4WArkGBrbLm7GKCIx3hVW3U6+/HX
	 lTTjy05gRnoFwXdm/1yel1aREbFOuRsmu3YY+eRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442083AbfIXXaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388737AbfIXXaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:30:00 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708C02146E;
        Tue, 24 Sep 2019 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569367799;
        bh=HTCjVVJhKnM9wBAHuE/prZG572PTBWFfbQcTmzcLdjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=16LXSSqHPBhE8nfctAWoDqBAl2s7jVm71t/a834sCoynHJd6o6rAzkPluSKIOFsyx
         HTMHy/R69lobeUGGn2AZBvU6Z98Hyb7/KnwZyWcf+F0nPtKtCd5I52i2lkdellIUMP
         7q8paiXlVBSBie0NQdEg1xj07TU+dL0B/0C7wPO8=
Date:   Tue, 24 Sep 2019 16:29:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uaccess: Disallow > INT_MAX copy sizes
Message-Id: <20190924162959.25ccaac45dec9a8697e1ca27@linux-foundation.org>
In-Reply-To: <201909231607.B6A0736@keescook>
References: <201908251612.F9902D7A@keescook>
        <201909231607.B6A0736@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 16:08:54 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Sun, Aug 25, 2019 at 04:18:56PM -0700, Kees Cook wrote:
> > As we've done with VFS, string operations, etc, reject usercopy sizes
> > larger than INT_MAX, which would be nice to have for catching bugs
> > related to size calculation overflows[1].
> > 
> > This adds 10 bytes to x86_64 defconfig text and 1980 bytes to the data
> > section:
> > 
> >    text    data     bss     dec     hex filename
> > 19691167        5134320 1646664 26472151        193eed7 vmlinux.before
> > 19691177        5136300 1646664 26474141        193f69d vmlinux.after
> > 
> > [1] https://marc.info/?l=linux-s390&m=156631939010493&w=2
> > 
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> ping! Andrew, can you take this?

It's in my post 5.4-rc1 pile.
