Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF99220449
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V16evrs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfCKTOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:14:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33224 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKTOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:14:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id t5so100198vsp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYX3tmmfu4P9tolV7mUI+g8kr2+ulGgimiqaD3uLT2U=;
        b=V16evrs69yR4ZUrAktghgK0S93/aP5QkWJ4vrlriWv+pNytp6Lq5zH+wqG3GLmR8+j
         G2elGKPq5lVyCCRnLLlrpLhcJvlrm8215sWiP4pmyvK6Tb0Bn128+2Mst/dTYDVxzs7U
         P1JYlQRcyvLxuraAEdRkm/Iz7XLOJh9eU78IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYX3tmmfu4P9tolV7mUI+g8kr2+ulGgimiqaD3uLT2U=;
        b=rj8ESWh21drZJ6HdEZZR6/kMhOV1VmmnTWNr9GTVYAXNZrylRIxcqgRIIXSTCsJwly
         i858jaokFJV1FDHtvFHyx9Kb18FolVG9cD/oADPlr6TtCT+kSZIQ78/tZqVQdAU/kTM8
         EcA9lceHSSV4+NCsdRZCabLz25FB9H6nZY/QDBmajKN+XmZHVNL+T4cb8MBD89lH+1lQ
         qF/1dQzlER14ibXuK0SyHiXXUr0Qyww3sDv/NFsWvqiavljTdqAipypr0hC+LRpgly/C
         jt6FxZhxLV4hrOy5uDQ1Ch61IP/9tSucAHjCStg/o5Sf/Vrs7QLR7ZcUNNe021UUMVN4
         jFoA==
X-Gm-Message-State: APjAAAUS1+Li63BTfVQLwWtqs0jLewTmfzzOGQ/sVqfAbUtKLayCLxqf
        ZT4mZGICbN5HsKtRsaedtjPw8Zv/AbU=
X-Google-Smtp-Source: APXvYqzQ0qzg131jNCen5FOSdHaG533yS3+mnN2TOCeatvFCBceN3CQmy+9t1YKdawHQBa2he46C4Q==
X-Received: by 2002:a67:e907:: with SMTP id c7mr18990342vso.221.1552331688157;
        Mon, 11 Mar 2019 12:14:48 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a9sm1867339vka.51.2019.03.11.12.14.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 12:14:47 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 17so59322vkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:14:46 -0700 (PDT)
X-Received: by 2002:a1f:58d:: with SMTP id 135mr17663607vkf.4.1552331686513;
 Mon, 11 Mar 2019 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
 <alpine.DEB.2.21.1903111516190.1691@nanos.tec.linutronix.de>
 <CAHk-=whUyG3+Zwb74LSOPGtTBvK9N6DG4f=Y5Yv9Xzcy-qY0Qw@mail.gmail.com>
 <CAGXu5j+NB16S2gAz9TOW6izZykuOXqRoP0nDkTqgn02OJ2ht5Q@mail.gmail.com> <CAHk-=wh6=X2TauxJzEBkLwcq5wcV3zM53FLDiVjD4LiBRcD9Qg@mail.gmail.com>
In-Reply-To: <CAHk-=wh6=X2TauxJzEBkLwcq5wcV3zM53FLDiVjD4LiBRcD9Qg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Mar 2019 12:14:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJLnsQm20A87-1+vH4kXwE1APjNqv=6qx32gCYk7SaW_g@mail.gmail.com>
Message-ID: <CAGXu5jJLnsQm20A87-1+vH4kXwE1APjNqv=6qx32gCYk7SaW_g@mail.gmail.com>
Subject: Re: [GIT pull] x86/asm for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Yes, that would fix things too, although I suspect you'll find that it
> gets hairy for hotplug CPU's (including suspend/resume), because new
> CPU's keep booting "forever".

In my testing, hotplug wasn't a problem because we'd already finished
cpu feature detection (which is why the SMEP/SMAP/UMIP bits couldn't
just be hard-coded). I had chosen to wait until after feature
detection was finished, etc.

> So what might be workable is to make 'cr4_init_shadow()' itself just
> do something like
>
>         this_cpu_write(cpu_tlbstate.cr4, __read_cr4() | cr4_pin);
>
> but I did *not* check whether there might be some other random
> accesses to %cr4 in various legacy paths..

The protection needs to be around the actual "mov %rdi, %cr4" that
native_write_cr4() exposes, so the "or" can't really be placed
earlier. Anyway, I'll examine some options. Thomas also suggested
looking at static keys, etc. I'll play around with it.

--
Kees Cook
