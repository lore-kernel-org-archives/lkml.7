Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3A4C742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4AB208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PTaFWFa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfGLBXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 21:23:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46805 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfGLBXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:23:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so7668385ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NuXct5FW62NllFLkWHXtF54PXpuTDXCY6/8Ws75hAk=;
        b=PTaFWFa9tsIcZKGH46sqa/kg0BqnZ09unrqjmMlbQrVI4BYj8E+xBy4K4ZDP4027CV
         GOPy9CKjNtES2ZAgyq964LkeWqrrxHFUISbSTAXkwMQ5J92Kxk5amAw1WuicOlDER9y/
         4exC+/nG5OMJbTivCpXXf2y8w/kgK+BV9Nv40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NuXct5FW62NllFLkWHXtF54PXpuTDXCY6/8Ws75hAk=;
        b=rhX9NxEtJj7e4LvvG4qZ5d5n4hNiDk9z0jd4IzjCBe1ZQnilDNoxd0JJbMnl9u/9Uf
         x5McHBUbVAj2hG72V+iRX/OA28ZE0lx8lanvv4uf5WgWABEziWiHXb2kredOkC1TAfvI
         kSP5RFYsFjBb/Q21NGJAElQqgGOUmwGRLhlFjV9wYd6w3lO8s3IOl8XZSY0JYmM9Fiuk
         FmOf5AmRIqUzdadrUyIyb1B6vQKs1R4+oSd/Y7+wBh5cOpM/9uaFzfDjAnRvkT2+RxU2
         LBjp6vTnJpdbu/yr6rHWO5iSYyv8LtAObblu/ozP5d8yd634GKq4GC9x2YgqjAdxMlcc
         hIjQ==
X-Gm-Message-State: APjAAAXhaU6SgkdsPTHzGcMfK17oxgIay9XNyL+Qd9ptmdFvPfqTt0Ua
        hThkyY+S7jSubdEznVj1qef8MACkKls=
X-Google-Smtp-Source: APXvYqz1FoL29kfvwRV8qo4l3hYmb/5MdIush6dwqY6tdrUGfCUgaoD9wgM4uR+b2iSqlIfVFYFqRg==
X-Received: by 2002:a2e:898b:: with SMTP id c11mr4349911lji.241.1562894611553;
        Thu, 11 Jul 2019 18:23:31 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y4sm911531lfc.56.2019.07.11.18.23.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 18:23:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id p197so5324949lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 18:23:30 -0700 (PDT)
X-Received: by 2002:a19:6a01:: with SMTP id u1mr3285742lfu.141.1562894610575;
 Thu, 11 Jul 2019 18:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190712010556.248319-1-briannorris@chromium.org> <CAK7LNARGNVfxexE616cQDs1fK7SzToKwHxO_T69+RShL6QVTCQ@mail.gmail.com>
In-Reply-To: <CAK7LNARGNVfxexE616cQDs1fK7SzToKwHxO_T69+RShL6QVTCQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 11 Jul 2019 18:23:19 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNGqYkBjMsjcRKAit+0cd0n7dwxKhezyYCXSh_HjucvQw@mail.gmail.com>
Message-ID: <CA+ASDXNGqYkBjMsjcRKAit+0cd0n7dwxKhezyYCXSh_HjucvQw@mail.gmail.com>
Subject: Re: [RFC PATCH] bug: always show source-tree-relative paths in WARN()/BUG()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 6:14 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> BTW, did you see this?
>
> commit a73619a845d5625079cc1b3b820f44c899618388
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Fri Mar 30 13:15:26 2018 +0900
>
>     kbuild: use -fmacro-prefix-map to make __FILE__ a relative path

Oh, wow, no I did not. If my reading is correct, that's GCC only? I've
been using various combinations of newer (5.2) and older (4.14.y --
didn't have that patch) kernels, older GCC (doesn't have that feature
AFAICT), and newer Clang (doesn't appear to have that feature). So I'm
not totally sure if I ever actually tried a combo that *could* make
use of that. But I may give it another shot.

In the event that this is GCC-specific...I don't suppose I could
convince anybody to expend any effort (e.g., taking a patch like mine)
to solve it for the non-GCC world?

Thanks for the tip,
Brian
