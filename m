Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC1DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57742183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oVkon3wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfDXUrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:47:02 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42348 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfDXUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:47:01 -0400
Received: by mail-ua1-f66.google.com with SMTP id h4so6501785uaj.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGnnbGnoa1Ix9iDFS5f9uTubbVrTmmHzn9+oJ3ixh0c=;
        b=oVkon3wy+COciLYDZ4nDPAO2zQt5Oms9wubxc1BY5yKNnUX2itOfL6QmKXd1M5S2Xr
         ijcKmWCpwAodDcke4IUkB9T8iocXZX5fAG5ezjB51JJN6PnkxG1Wp2crzGt4gvghlMGW
         lUIXU7kX9iyPYXfyzisUjvTuJJ1GAHn4/lcbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGnnbGnoa1Ix9iDFS5f9uTubbVrTmmHzn9+oJ3ixh0c=;
        b=oGxIqSiE3+m+Phj7MerbqaNHs85NxeCNsRIVmKDmqnavA85wH+qfxi54h41NXH/zNa
         FX13ochwsAcHB+V7W8xtAiQy+bg9FoXs1FaW5+lgFXTx9VIjmazsEevjVAx1FnvtyNRW
         FYnW8wt5Cz6nuXX1arEE7BKaOqL9K0ixh96/02BJPF/MTfaoBHummsTQk8tb+Dld8u7c
         qHlevk4CIK3rpAkuyrvl7EivRxwnvcy9UD1KUnqtv71YCOZKXII0trO1nJ2R2oQhtQbY
         5+SCKwhxy5NM4nWT7bDGrLM4B1b8n0nCiTeTKUGKfxHWoK3+ZcSP6cSUtPqmoWj31hbX
         UZdg==
X-Gm-Message-State: APjAAAWT1S4SsfwQEdJSsU/716jDxMjSQ+d2A/2wX7KnLmPTpiJcuzAR
        Tl8EPDk7LMcLKCu64wX6XN2JiADthho=
X-Google-Smtp-Source: APXvYqzx3/pssG1Jm9EDkGKye0pAp0eMxEyCgRZsDBaUA7C2KwarMELtY2nEa1N6LjbLRM6vZCS5Bw==
X-Received: by 2002:ab0:7008:: with SMTP id k8mr17883077ual.40.1556138818714;
        Wed, 24 Apr 2019 13:46:58 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id z192sm10569699vkd.45.2019.04.24.13.46.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 13:46:57 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id x84so4357959vkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:46:57 -0700 (PDT)
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr18565549vkk.13.1556138816641;
 Wed, 24 Apr 2019 13:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190423194925.32151-1-keescook@chromium.org> <CAK7LNARuX8XfO=YRX9dYpipyBTCtMbQqLJfuk6iMLfLdZe1-KQ@mail.gmail.com>
In-Reply-To: <CAK7LNARuX8XfO=YRX9dYpipyBTCtMbQqLJfuk6iMLfLdZe1-KQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Apr 2019 13:46:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJfYBTt836K7-SNdwZcHf9RhXKxRj+xefn_hhogt2UEnA@mail.gmail.com>
Message-ID: <CAGXu5jJfYBTt836K7-SNdwZcHf9RhXKxRj+xefn_hhogt2UEnA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Refactor memory initialization hardening
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alexander Potapenko <glider@google.com>,
        James Morris <jmorris@namei.org>,
        Alexander Popov <alex.popov@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 9:07 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Apr 24, 2019 at 4:49 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > This refactors the stack memory initialization configs in order to
> > keep things together when adding Clang stack initialization, and in
> > preparation for future heap memory initialization configs.
> >
> > I intend to carry this in the gcc-plugins tree, but I'd really like
> > to get Acks from Masahiro (Kconfig changes, Makefile change), and
> > from James (adding the new Kconfig.hardening to security/Kconfig).
>
> If needed,
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Great; thanks! :)

-- 
Kees Cook
