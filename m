Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCE3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C331E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmjoIghn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDJWeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:34:31 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33294 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJWea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:34:30 -0400
Received: by mail-vs1-f67.google.com with SMTP id a190so2360336vsd.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/d+/Smh+ztTKnhe7lRqmlhlKS4kJ9d0Yz1XzvP1SVsI=;
        b=lmjoIghnhFGVRmeW7FlGNwb+HYAG+0AXZxYzMM1eWAwIUi32/pVnH8w3L/tAoULcbR
         OTOo7y9qzxhwrWmLexdTslLY0L/NaAhLwae4S/sD/o6FJGVgR28RKAOHfgWorVCcJtFV
         60Z7Daj1NnQdcjpzkqhB4Sv2pENweuYx6muCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/d+/Smh+ztTKnhe7lRqmlhlKS4kJ9d0Yz1XzvP1SVsI=;
        b=WdchU5PHCQFk9CBRxyz2eMueOHE6pTOkJIvupRwMIP6rRQm962IQtrXj+ARqyxb1VN
         VdPysV4lCQ2XotzthLYjMBpanQ11Gi5Iu0QO5R5METKAdfyKFbrX+AR3wyc15Akox1pp
         WO8Zw7lJrRZlOI6Zumpf28pmFqBqzm8xN3tcFfjRhyGV55QItlGOtN7FSyDsf8yOPEu2
         iyCRcd1LBnOO15VzhH5UVLPsusCExOwa7OzcrhAJDefLJ1pyb05mqwNTx7N10Sn339hy
         d1h89qkEg+LdnVeqIFvLyqcr+kKU6sv0bNpGJTKpaCE7lda6oqC0gz/R4beAbIw1GD+R
         lOvQ==
X-Gm-Message-State: APjAAAUpY1yKZjDZM4MVR3dTIUJIZkHJrfF+fihxUD3NL/d9h6g2FYOb
        WHTWlvhzWbrACZM7q0F0FJ4dpX2M1+Q=
X-Google-Smtp-Source: APXvYqx1wgvv8IYc4ReITG/pnA6Z22RYlV+9R9FRLF5zlJyZJQVun8pJw6WQQMdgapBpMRONke25KQ==
X-Received: by 2002:a67:d38f:: with SMTP id b15mr25636195vsj.154.1554935669220;
        Wed, 10 Apr 2019 15:34:29 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id d134sm16743006vkf.6.2019.04.10.15.34.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:34:28 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id v7so1342812uak.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:34:28 -0700 (PDT)
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr24036899uam.85.1554935667664;
 Wed, 10 Apr 2019 15:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-3-mcroce@redhat.com>
 <CAGXu5jKc2q3gnBrJ5JowDvOC_tSR5o9iKuF+JVKMJYWAPOZANQ@mail.gmail.com>
 <CAGnkfhwZEqX03H7PqsSTa=GVwZXX127hQO5YHzJasAEYtpLMZw@mail.gmail.com>
 <CAGXu5j+0sAc2fHTuYwYTLoHPDbnfxYuAEJ+tRfgc2Z5DDqp9Jg@mail.gmail.com> <CAGnkfhxPZJXmnPJ+k8nGPCBNeDBM_=rN+kEea-Uyq0zfCt0MXg@mail.gmail.com>
In-Reply-To: <CAGnkfhxPZJXmnPJ+k8nGPCBNeDBM_=rN+kEea-Uyq0zfCt0MXg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 15:34:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKf8ezMOxMn3P8DW+0GQrdkmno8_qxgQtxBD98cP3MRKA@mail.gmail.com>
Message-ID: <CAGXu5jKf8ezMOxMn3P8DW+0GQrdkmno8_qxgQtxBD98cP3MRKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
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

On Wed, Apr 10, 2019 at 3:30 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Wed, Apr 10, 2019 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Apr 10, 2019 at 12:24 PM Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > On Wed, Apr 10, 2019 at 8:46 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Mon, Apr 8, 2019 at 3:09 PM Matteo Croce <mcroce@redhat.com> wrote:
> > > > >
> > > > > Use the shared variables for range check, instead of declaring a local one
> > > > > in every source file.
> > > >
> > > > I was expecting this to be a tree-wide change for all the cases found
> > > > by patch 1's "git grep".
> > > >
> > >
> > > Hi Kees,
> > >
> > > I have already the whole patch ready, but I was frightened by the
> > > output of get_maintainer.pl, so I decided to split the patch into
> > > small pieces and send the first one.
> >
> > Heh, sounds fine. Normally the big tree-wide changes go via Linus just
> > before cutting rc1 (or rc2). This is "only" 31 source files, though,
> > so maybe akpm wants to take these instead? Andrew, how do you feel
> > about that?
> >
>
> FYI, this are the stats from my local repo, just to let you the size
> of a series with all the changes in it:
>
> $ git --no-pager log --stat --oneline linus/master
>  2 files changed, 4 insertions(+), 9 deletions(-)
>  2 files changed, 7 insertions(+), 14 deletions(-)
>  6 files changed, 15 insertions(+), 30 deletions(-)
>  1 file changed, 16 insertions(+), 19 deletions(-)
>  1 file changed, 3 insertions(+), 5 deletions(-)
>  3 files changed, 15 insertions(+), 20 deletions(-)
>  12 files changed, 93 insertions(+), 116 deletions(-)
>  3 files changed, 98 insertions(+), 104 deletions(-)
>  2 files changed, 9 insertions(+)

Tiny! :) Seriously, though, I think this should be fine to take
directly to Linus after patch 1 lands, or see if akpm wants to carry
it directly.

-- 
Kees Cook
