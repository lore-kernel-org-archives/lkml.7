Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD87C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1C72084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zv1DFYiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfCZHyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:54:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51156 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbfCZHyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:54:38 -0400
Received: by mail-it1-f193.google.com with SMTP id m137so18091096ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8m6PYsN0vGrh77HZZMlNOYDAucKTnmDJdz7+D7pXffc=;
        b=zv1DFYiSQBbxOwb6lVFhUMDVIwd7rTAp3mTxLGEMegX7p69aWkWv7uKVHV1zV4X7WO
         3ZyNiWd/RYIDOwuuroz61Q6OPx7MipWkGopdKPdS+KbXHHv25F7OfCU+Bcl8++4KPXtM
         BiNC83usV+OXzXQxuUBZnGg6gHSHVBnltHFzHk8HWgWDxS0CPh+7GzVXEt54YJup5nVe
         lU4yA9PupRmEfLuMxj6rEho/PgaeNwakxObgsfsfoiuKHZa2v85x737FjbZGu0eoKI+P
         +1mKFzb6VWM9K2uFibv9+cSnWj+eUqUFWAATJ+G0mH+L+m8jy1vZzQzxb5PvZPpFgtJZ
         iclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m6PYsN0vGrh77HZZMlNOYDAucKTnmDJdz7+D7pXffc=;
        b=WBc0GOqvnJjjZp5b9tZyqQY1EfuNcNdpr4jjG0VJTqpHK0gVSkNpLAOnm5UvBauLYI
         d8ythgLZfzKFJxb+CbcJpzPZ+QXopmPCGwhAQbkq+UAIPE26Mtmq1V3hdByYl7FpdSeS
         h3P+zJ0Chyg7x0LI4DpTCPVhN2g1CS8esis45EboelUonYmDpSzO+1GXDRpIND8hnnu8
         8hCBkjF36iSIqsYXxomHlDjqLcaMwfWkWtpsPM9tkfTRN4pf545eh+GApysE3etZ6WuN
         1QkrMuemWGb3I59AbQLC3w8OCJ0QAj4UeIGZ6taBsDUXY6fZPTijvfFOI9zK+ucK76WS
         lNYg==
X-Gm-Message-State: APjAAAWf3eJ4N5nROlupJ15cM3pCjZPO9cwllZCpRh1SAzTcAQ2VvXd5
        sNTNwXk07e3+E4ra7UWT/+DZD64nqtAhFrjwKVByCg==
X-Google-Smtp-Source: APXvYqxHUkkMiiWIA/lchq6orplAKNai6FRkQMZN69Ltu/wpCCRgMTGFmCJ8CmZQjKfvSwQ4IrYzSgsS/V5q50Fx1cY=
X-Received: by 2002:a05:660c:7d1:: with SMTP id e17mr15898705itl.158.1553586877157;
 Tue, 26 Mar 2019 00:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <1549943095-10956-1-git-send-email-yamada.masahiro@socionext.com>
 <CAKv+Gu8yLY+c6jNmHYkvP3n=xiojF7dcKBHmeGibUW2FUrEczA@mail.gmail.com>
 <CAK7LNASoyeFW=j9R=M2vaoLK_Gms1Z6hA_yKLyVSY=g5ALUi8A@mail.gmail.com>
 <CAKv+Gu8k63Fj2aPbQPLLvBXvJrdcu5NrODXuZKkb2n21AUM70Q@mail.gmail.com>
 <CAK7LNARd6R31QyGn4MZdDeTfUVGhF7bOx+5ZyuY-c7kZ6fETsA@mail.gmail.com> <CAK7LNASGFinR5EALd-2V-jezC+H5f+tw24NBBtfsUfxLBirwRw@mail.gmail.com>
In-Reply-To: <CAK7LNASGFinR5EALd-2V-jezC+H5f+tw24NBBtfsUfxLBirwRw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 26 Mar 2019 08:54:25 +0100
Message-ID: <CAKv+Gu_i=cWfzf2fLchY-M1wWYh-wz4AMyDJBsT4Emg=4XqPcA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor cmd_stubcopy
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alistair Strachan <astrachan@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 at 07:06, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Ard,
>
>
>
> On Sat, Feb 16, 2019 at 11:07 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Sat, Feb 16, 2019 at 12:38 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Fri, 15 Feb 2019 at 06:49, Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > On Tue, Feb 12, 2019 at 4:26 PM Ard Biesheuvel
> > > > <ard.biesheuvel@linaro.org> wrote:
> > > > >
> > > > > On Tue, 12 Feb 2019 at 04:45, Masahiro Yamada
> > > > > <yamada.masahiro@socionext.com> wrote:
> > > > > >
> > > > > > It took me a while to understand what is going on in the nested
> > > > > > if-blocks.
> > > > > >
> > > > > > Simplify it by removing unneeded code.
> > > > > >
> > > > > >   - if_changed automatically adds 'set -e', so any failure in the
> > > > > >     series of commands makes it immediately fail as a whole.
> > > > > >     So, the outer if block is entirely redundant.
> > > > > >
> > > > > >   - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
> > > > > >     target"), GNU Make automatically deletes the target on any failure
> > > > > >     in its recipe. The explicit 'rm -f $@' is redundant.
> > > > > >
> > > > > >   - surrounding commands with ( ) will spawn a subshell to execute them
> > > > > >     in it, but it is rarely useful to do so.
> > > > > >
> > > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > >
> > > > > Assuming that it still works as expected:
> > > > >
> > > > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > >
> > > > > You can test this by adding a statically initialized global function
> > > > > pointer to any of the libstub source files that get built for ARM.
> > > > >
> > > > > Thanks!
> > > >
> > > >
> > > > I tried that, and it failed as expected.
> > > >
> > >
> > > Great, thanks for double checking.
> > >
> > > Are you taking this directly, or do you want me to take it via the EFI
> > > tree? Either is fine with me
> > >
> > >
> >
> > Could you apply it to your EFI tree?
> > Thanks.
>
>
>
> Will you pick it up?
>

Yes, it's on my list for v5.2
