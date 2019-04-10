Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6859C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB20C217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDJWyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:54:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39978 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDJWyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:54:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so3622131ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1kulX08FnhDExeBUTFmsnZsTokQNhe6Ewv9wKtFlwk=;
        b=YlrCh7DgZG5GY5pSOdRXrMbzEAy8+MCN/DteXVec0EZpCCUQc3oLmmA/PvcgKeCz6i
         16PEKDjFTEg+i4Fmk0IFRPFFuYHQmNqxboYqisBRZhjhTXRMtuhURLvQYMPYnY6hUZX0
         uuM8eBsZWz1l9z3z3C3Ic72R8wbD9hqQHxPEuRyc7zQb1KUcO1Cc/sMkC8oVKlGkdO/D
         ReGLwz3pG6HQUQNPwKwN4g/2YE10ThM5qe9TmVzPSqNl1QkhdK+EFGvOA8ktwoklQyzt
         qGxEngjkMTDeWyUZdUzv3uTUiSKwACVS21cRbC3hKaEpQLdLfzQc4LVxaAGkAKM9QjqE
         GZaQ==
X-Gm-Message-State: APjAAAVMsNMQvsyLqrJemGRF78zHM4qFw3LrTbBjtbzrXtBTJvc9C2wC
        lmOSUdj0wUrtI9g/ayRS6OvSh14NZscDzaeY6tzHlh6R
X-Google-Smtp-Source: APXvYqwrQPkMhypQdrPjOZKlgadFrcbYn/kjGdcIN4tdhLujVUUlOc8jFOca9TCtatuZjIBBTbTAqT8LWHse3F8+iT4=
X-Received: by 2002:a2e:9649:: with SMTP id z9mr7735709ljh.92.1554936891736;
 Wed, 10 Apr 2019 15:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-3-mcroce@redhat.com>
 <CAGXu5jKc2q3gnBrJ5JowDvOC_tSR5o9iKuF+JVKMJYWAPOZANQ@mail.gmail.com>
 <CAGnkfhwZEqX03H7PqsSTa=GVwZXX127hQO5YHzJasAEYtpLMZw@mail.gmail.com>
 <CAGXu5j+0sAc2fHTuYwYTLoHPDbnfxYuAEJ+tRfgc2Z5DDqp9Jg@mail.gmail.com>
 <CAGnkfhxPZJXmnPJ+k8nGPCBNeDBM_=rN+kEea-Uyq0zfCt0MXg@mail.gmail.com> <CAGXu5jKf8ezMOxMn3P8DW+0GQrdkmno8_qxgQtxBD98cP3MRKA@mail.gmail.com>
In-Reply-To: <CAGXu5jKf8ezMOxMn3P8DW+0GQrdkmno8_qxgQtxBD98cP3MRKA@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 11 Apr 2019 00:54:15 +0200
Message-ID: <CAGnkfhyeUdN+H4g9Lx4X2ae9k3crLrZQjQYZVjNE4ZyM8ziY9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:34 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 3:30 PM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > FYI, this are the stats from my local repo, just to let you the size
> > of a series with all the changes in it:
> >
> > $ git --no-pager log --stat --oneline linus/master
> >  2 files changed, 4 insertions(+), 9 deletions(-)
> >  2 files changed, 7 insertions(+), 14 deletions(-)
> >  6 files changed, 15 insertions(+), 30 deletions(-)
> >  1 file changed, 16 insertions(+), 19 deletions(-)
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >  3 files changed, 15 insertions(+), 20 deletions(-)
> >  12 files changed, 93 insertions(+), 116 deletions(-)
> >  3 files changed, 98 insertions(+), 104 deletions(-)
> >  2 files changed, 9 insertions(+)
>
> Tiny! :) Seriously, though, I think this should be fine to take
> directly to Linus after patch 1 lands, or see if akpm wants to carry
> it directly.
>
> --
> Kees Cook

Nice. Still as an 8 patches series, or squashed into a bigger one?


--
Matteo Croce
per aspera ad upstream
