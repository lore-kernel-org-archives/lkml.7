Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA829C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE7F22459
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569529036;
	bh=mfNVnBwlsatz6LffX8lCPkx1EChz+zrZfI36b2TAWOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c0ru41GU52GtM+C9loeytTbws5iWHSE+7lNC1jSK9cDsE3LGCmxBuIZCg49t6B5y2
	 oZLI7oOaX43SspvFZji+MBxxOOpn57V93QZs0oqrtIQvvJk+hL7lAVZjmJLhVnxYIg
	 UTsgWpCZldEeKwjgTvgGvpbXraCUZwj+KN7KFf64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfIZURP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:17:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33224 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfIZURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:17:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so253093ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7RbCDRjRAvWcIi7QkdCjwk6XzzWsIsN9TecD9WwksU0=;
        b=aB5pA3SyZ5HaFLWIhKIPBd/X2uy1rvQJqJjWNTqTRvRCwfYAHVwoGVtpWvbJi2/gvM
         4lACq7gPi2ifoD1gBfDLo2nCP7EvRcJXd25QAJYSNV2Hv0abkMJ3RTdFJkKbYrWUIHZ0
         HfDtd6wvPm9AKCezZy9cGdX9Q1c6mc+eBmIyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7RbCDRjRAvWcIi7QkdCjwk6XzzWsIsN9TecD9WwksU0=;
        b=cuyXWIzDJ6Cj8s3Fm4V/nQtqoFVEbaNKEiiWyDZdM7ILSSb/IPrGUWnj6rvI2U2ilS
         80S7G7oX0VO/erYK4Iut+YmdIRovPySfAhItBjT0vmcILVD+aNTpGAUj3/i7kp49CEyr
         jx37LXQE0DN2FPryRQkq2EStgm8huBY3xFpk8SHRhaE50hv9tsWe5gP2sB/GDaAYuE8B
         6YgZpxhDfTvzEUk5RmBq4tQ4xbF9nLZTB8v/zgBoimMWZzXBE6EugOTKOaHoYh8LQp0z
         WNqcGe9WD1PhhKQI5WpdWckIYsskliNYbExHGXiXt+7sRYQICAEyARArRWpQzdWcLcJr
         b/ig==
X-Gm-Message-State: APjAAAWKWdUTJ05truzosSG6tSw+bU+wIElh6IaJNLt4qV7VOejM0XqK
        yj4gQ4+/b82bo6EVJQDY/6p2DWt8R/c=
X-Google-Smtp-Source: APXvYqzRw7t2nLWzI5pF9hKf1mG8CmSFY/oyR6FY9/pbWMrL1oYrGM6siw3WdeRT8E3LRs07Gh9X2A==
X-Received: by 2002:a2e:a313:: with SMTP id l19mr283726lje.205.1569529033207;
        Thu, 26 Sep 2019 13:17:13 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id x30sm39495ljd.39.2019.09.26.13.17.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 13:17:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id b20so227599ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:17:12 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr344627lji.52.1569529031736;
 Thu, 26 Sep 2019 13:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org> <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com> <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
In-Reply-To: <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Sep 2019 13:16:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
Message-ID: <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 1:09 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> That said, if people are OK with me modifying the assert in
> pud_trans_huge_lock() and make __walk_page_range non-static, it should
> probably be possible to make it work, yes.

I don't think you need to modify that assert at all.

That thing only exists when there's a "pud_entry" op in the walker,
and then you absolutely need to have that mmap_lock.

As far as I can tell, you fundamentally only ever work on a pte level
in your address space walker already and actually have a WARN_ON() on
the pud_huge thing, so no pud entry can possibly apply.

So no, the assert in pud_trans_huge_lock() does not seem to be a
reason not to just use the existing page table walkers.

And once you get rid of the walking, what is left? Just the "iterate
over the inode mappings" part. Which could just be done in
mm/pagewalk.c, and then you don't even need to remove the static.

So making it be just another walking in pagewalk.c would seem to be
the simplest model.

Call it "walk_page_mapping()". And talk extensively about how the
locking differs a lot from the usual "walk_page_vma()" things.

The then actual "apply" functions (what a horrid name) could be in the
users. They shouldn't be mixed in with the walking functions anyway.
They are callbacks, not walkers.

             Linus
