Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CDC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DED022527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576178920;
	bh=mw6yUbytXpLJnaF1QjwaHchkWwnhvbA8I3y52Tw2Tkk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lQjak2XI1zsrE4BW+UySxy1+pWLb0NQTq3hddeijQjwCzLBrTrNVK5cH7zCBnDmge
	 BUQeWYjFSX0HUcW0adif77nyDqRAhmmYQn9tgnuAH8ZEefEzV3x8wQtdtVOl/VMR7W
	 WXOoN2gQzRN1qyroqarg6HcyOz+VOGKy3HG+/2rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfLLT2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730168AbfLLT2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:28:39 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F5A22527;
        Thu, 12 Dec 2019 19:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576178918;
        bh=mw6yUbytXpLJnaF1QjwaHchkWwnhvbA8I3y52Tw2Tkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LJ4yl5RDalD1iX2sPYWVNYhW1QG8yMGa4rOVnu/yoyZxHiQMmRhBr4LxVCdtCLmla
         A3GDqIHIq+4MZ9HBRYnVDc87v/oZwJ//PGE/JhPR1cK30cQvEB0ncvz8Fp5BEGGuCn
         WrPdijRMUurAw65q8RPOEbNPV8srq7NkNTCyvGMo=
Received: by mail-qk1-f179.google.com with SMTP id w127so2552608qkb.11;
        Thu, 12 Dec 2019 11:28:38 -0800 (PST)
X-Gm-Message-State: APjAAAWJ5giif7u8JXkPn5kPUdJF2Kch80gTM4HWUhGPvp1efspLsfN8
        yjt7hBmf0S+y+FLslQ40T8LLyvXOy6NyJ/avoQ==
X-Google-Smtp-Source: APXvYqztoQqhxovDfRnj0RgJBBwkCgrjSBwCGMpdQbdU+PvguSAyZhuMfnJ7zw6RsYWS9Nj1XfxvYqrg1mFnHjsx5vs=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr10000154qkd.223.1576178917566;
 Thu, 12 Dec 2019 11:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20191211232345.24810-1-robh@kernel.org> <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
 <20191212130539.loxpr2hbfcodh4gz@linutronix.de>
In-Reply-To: <20191212130539.loxpr2hbfcodh4gz@linutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Dec 2019 13:28:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgi+Rd1jiBiTcbuoiZUnpahdNfbAQNkbPH4LEM1Cs09A@mail.gmail.com>
Message-ID: <CAL_JsqJgi+Rd1jiBiTcbuoiZUnpahdNfbAQNkbPH4LEM1Cs09A@mail.gmail.com>
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 7:05 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-12-11 17:48:54 [-0600], Rob Herring wrote:
> > > -       if (phandle_cache) {
> > > -               if (phandle_cache[masked_handle] &&
> > > -                   handle == phandle_cache[masked_handle]->phandle)
> > > -                       np = phandle_cache[masked_handle];
> > > -               if (np && of_node_check_flag(np, OF_DETACHED)) {
> > > -                       WARN_ON(1); /* did not uncache np on node removal */
> > > -                       of_node_put(np);
> > > -                       phandle_cache[masked_handle] = NULL;
> > > -                       np = NULL;
> > > -               }
> > > +       if (phandle_cache[handle_hash] &&
> > > +           handle == phandle_cache[handle_hash]->phandle)
> > > +               np = phandle_cache[handle_hash];
> > > +       if (np && of_node_check_flag(np, OF_DETACHED)) {
> > > +               WARN_ON(1); /* did not uncache np on node removal */
> >
> > BTW, I don't think this check is even valid. If we failed to detach
> > and remove the node from the cache, then we could be accessing np
> > after freeing it.
>
> this is kmalloc()ed memory which is always valid. If the memory is
> already re-used then
>         handle == phandle_cache[handle_hash]->phandle
>
> will fail (the check, not the memory access itself).

There's a 1 in 2^32 chance it won't.

> If the check
> remains valid then you can hope for the OF_DETACHED flag to trigger the
> warning.

Keyword is hope.

To look at it another way. Do we need this check? It is in the "fast
path". There's a single location where we set OF_DETACHED and the
cache entry is removed at the same time. Also, if we do free the
node's memory, it also checks for OF_DETACHED. Previously, a free
wouldn't happen because we incremented the ref count on nodes in the
cache.

Rob
