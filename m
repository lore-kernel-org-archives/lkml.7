Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83796C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7982133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565972475;
	bh=8myK0rkU+u5deIKHv3iH6Zo9cygplJ0PFV9qwhxdPUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VkcdPyUlvrvFyP+2xaFN3Tj2R17kEN+sB9/qoYOGYDEtUv89DeB2ELYNkfzaCyRTf
	 J5IBC4ziFswA2uZUpsEskl9O6E5wYGUYAzUSgW7FUS1z7ebhcfqsnywfMpCwXWe3um
	 YD1o4PY/JsLIVzoyrPp99NnawF4wLPqOg4NfexFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfHPQVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:21:14 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:34441 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfHPQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:21:14 -0400
Received: by mail-lj1-f180.google.com with SMTP id x18so5840645ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ymHwSq4wTpjRhSkNkSGTSSHl5As6L3PV3bdJQptYy1o=;
        b=fgp4v8P6AxU+KKUY1EDc5rYVP1G7Mk7BIPRI7oZVb9n5xTGtQUQwxxYGrbtt4g5Gu3
         D4qg2XzBD6zjFtV9FiMyLGBsnngoRe1p7cJuCZFYZmtZ0f0vQtQMdktkSt0/8nrR0Aoz
         iLR92sZEp4yc9Ff9XsWy9gGBabbw281EZw/wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ymHwSq4wTpjRhSkNkSGTSSHl5As6L3PV3bdJQptYy1o=;
        b=OybmTdqftF2eA52E7uPk95nLIhVD85NerDXI9kERm8Z3YxfltB7r2SwU4DwJzfAlrK
         QedQSzqQ15986J9iM9ynL6k3NgISsOpSNDRe/CIw+yrWyex0gkrprud569xEo37FOkWI
         inZeXWkz96c+U8CQu8zFxUgIeozhEROMXlJ6yNni8Vo0Q9Cz8bFH3A2tTOi5FYg3BKF3
         wrkfCoGcPVHnsGhX3kMUsf06G+74KCEAxZUZCSR/rnVyMKffTWRpWO9hGhNLTZu9Us89
         8TLQ3dnzMd3Ga+Ow/u3krxDjsO1CoRHFMvZfaJlE6q0JH6ulXCOZsuDoy0m37g3ikDtX
         QYjA==
X-Gm-Message-State: APjAAAXgl4A5E/is7GcH3+ZcW8xhfgYFGcYucPSzMakHdP9PiUl2+pXs
        JcJhA5GijhKEYlfG4Ul72Fogk7ls7ls=
X-Google-Smtp-Source: APXvYqyELHetkxTKiX/nI6sPruFWcO310tbi62GXXRSEAVxIHkrqqBIKbwla4vsePr3WgtyH8a+1sQ==
X-Received: by 2002:a2e:9cc6:: with SMTP id g6mr6208754ljj.22.1565972472100;
        Fri, 16 Aug 2019 09:21:12 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r76sm1024710ljb.13.2019.08.16.09.21.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 09:21:09 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id z17so5845241ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 09:21:08 -0700 (PDT)
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr6088169lja.180.1565972468547;
 Fri, 16 Aug 2019 09:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190808154240.9384-1-hch@lst.de> <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
 <20190816062751.GA16169@infradead.org> <20190816115735.GB5412@mellanox.com> <20190816123258.GA22140@lst.de>
In-Reply-To: <20190816123258.GA22140@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Aug 2019 09:20:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOB5wLWxHe8UDHnBB1DWrZaZ62ZPXnD0KiE8hYoWokNA@mail.gmail.com>
Message-ID: <CAHk-=wiOB5wLWxHe8UDHnBB1DWrZaZ62ZPXnD0KiE8hYoWokNA@mail.gmail.com>
Subject: Re: cleanup the walk_page_range interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 5:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I see two new walk_page_range user in linux-next related to MADV_COLD
> support (which probably really should use walk_range_vma), and then
> there is the series from Steven, which hasn't been merged yet.

It does sound like this might as well just be handled in linux-next,
and there's no big advantage in me pulling the walker cleanups early.

Honestly, even if it ends up being handled as a conflict resolution
issue (rather than some shared branch), it probably simply isn't all
that painful. We have those kinds of semantic conflicts all the time,
it doesn't worry me too much.

So I'm not worried about new _users_ of the page walker concurrently
with the page walker interface itself being cleaned up. Those kinds of
conflicts end up being "just make sure to update the new users to the
new interface when they get pulled". Happens all the time.

I'd be more worried about two different branches wanting to change the
internal implementation of the page walker itself, and the actual
*code* itself getting conflicts (as opposed to the interface vs users
kind of conflicts). Those kinds of conflicts can be messy. But it
sounds like Thomas Hellstr=C3=B6m's changes aren't that kind of thing.

I'm still willing to do the early merge if it turns out to be hugely
helpful, but from the discussion so far it does sound like "just merge
during 5.4 merge window" is perfectly fine.

               Linus
