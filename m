Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A8C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E1D20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKSDOlnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfE0Niy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:38:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40850 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfE0Niy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:38:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id u11so14812724otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMFxRGlKUpvBvlbQG58xrVAgA23tAIXMetii0uOnwLo=;
        b=bKSDOlnNh1cedFkO7cgRQsvU+SSGTdbdaXYpVewl+/Qr5s/W5HZ2p5wW6xe3KU6Dzp
         za2OilPy0X4hy44OStoNDLirumw6BRgEWfvN7eTX6EcFekxvNjeyHo3toAls/KbqezUG
         fqX/moYkcTQhCJ3LZ3TgpxBoJY/MqcGKfOD9LpcvMbJZQ2pKcNbw8qSgEgBRVJ2l8RpI
         dPp+7S9+RrItjw3Ncld7Bru6Z5gs6prjOlX4rudOG3cEZx8XIfFfgzvPgpryIf77yuks
         PYg/QVt/TmD5+sTivN1hcl+ik2t7vropjLpWNF4qUwlRkSo+C4EhMqSxgGOm07en+dpQ
         qCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMFxRGlKUpvBvlbQG58xrVAgA23tAIXMetii0uOnwLo=;
        b=TrVvonYBSzbTkcPcEpyRF+pGWxsIVUPPhvJunkcIyPciG1BLlGWxxpC+FEuB2JHTwK
         uglC5v8wfxJ7Yi9HC69W0SLpVgbkgYUu+rvfTWVIiEKezUoZFKHGuYA0WkVP9rnsfDGB
         aelVLZlUV7gj5OIzfR1OIdXQ+aF270XUGXXMdf/vhvYtw/NqQCHPZYBA5oSwpcTeEb5E
         OSBTycBKjIV2v/2bwOzzIgJEt0f9y+hsOXTOh+/GfFdlecJg0Npz0th7VdfQV4+gx/yd
         DM+SjW7lL7oVejbxCfN/Kem/5MnfehzcYMZwgpUOqUaUH6ACRRvShz3Lz2Mtk5zOiQep
         7y1A==
X-Gm-Message-State: APjAAAVkcy4te9XSQB1l76mHwhg9a98TeE+AJObLI6pgfFesNdxP2TJR
        o71GUk4p1IP+3kuu9lpnFP76TVGLWiC3W9E0Rq6FvQ==
X-Google-Smtp-Source: APXvYqxoth4mkHbnO0TqcFaUQ9vqz3CUKV8OQ74qrszPxEyAAEGmVBkSK/g9hXXDRNCb6YoL30BzLj001zsiH9XVnNI=
X-Received: by 2002:a9d:148:: with SMTP id 66mr21992873otu.32.1558964332814;
 Mon, 27 May 2019 06:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190524201817.16509-1-jannh@google.com> <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
In-Reply-To: <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 May 2019 15:38:26 +0200
Message-ID: <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 11:43 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com> wrote:
> > load_flat_shared_library() is broken: It only calls load_flat_file() if
> > prepare_binprm() returns zero, but prepare_binprm() returns the number of
> > bytes read - so this only happens if the file is empty.
>
> ouch.
>
> > Instead, call into load_flat_file() if the number of bytes read is
> > non-negative. (Even if the number of bytes is zero - in that case,
> > load_flat_file() will see nullbytes and return a nice -ENOEXEC.)
> >
> > In addition, remove the code related to bprm creds and stop using
> > prepare_binprm() - this code is loading a library, not a main executable,
> > and it only actually uses the members "buf", "file" and "filename" of the
> > linux_binprm struct. Instead, call kernel_read() directly.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I only found the bug by looking at the code, I have not verified its
> > existence at runtime.
> > Also, this patch is compile-tested only.
> > It would be nice if someone who works with nommu Linux could have a
> > look at this patch.
>
> 287980e49ffc was three years ago!  Has it really been broken for all
> that time?  If so, it seems a good source of freed disk space...

Maybe... but I didn't want to rip it out without having one of the
maintainers confirm that this really isn't likely to be used anymore.
