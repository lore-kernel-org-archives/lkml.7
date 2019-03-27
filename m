Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E20C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45BE2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC83CVMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfC0URj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:17:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33387 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfC0URZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:17:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so20510135qtb.0;
        Wed, 27 Mar 2019 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLuA54w/8+kA9HFjVMb2IYadZJa1EC8H9/XOYotrFiM=;
        b=hC83CVMhbgqDRKAFkNSGM7c5eMJ5tAjXdnNMBpuSd+rH/dNzAtmhfOqbr5IPCpvKne
         Nl4IpZzeLQaJTG1tk2CwBRpZfPzwj2OiuCudmU6YN9PtwyaW6o5iAn/wDsWNT6ZcoO7c
         6L2L15/S6hRNBZvE9z7jh3MqluPTLK2MZosMUI9emI1joeX7JdYCjH3ylmfmw/Y+0y+F
         T1tXHf98WjjcP+l453DCKGFDKGdVMgKSWKmbVYIjaivbvQ/Qz3a0iyKUPfyjHSngH1/t
         XxBAjVJ7JhTrkho/0YYvAdFGG0v5l2gwmotafBtm3UUYDtW5vAg+Tt1A9cjZNB1aV4rs
         GKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLuA54w/8+kA9HFjVMb2IYadZJa1EC8H9/XOYotrFiM=;
        b=HlQFT8g8bXyfGrfMiEXYJBzxr7+yO0gF6TYq2uQvcwlQvHjlxj9hpSrD9pMCDDvQfO
         W3Ot7/swbqI4r6IaKWB/fuBRcImzM0OIywHJjrWuMybbDwedfALNlRPKYsrTTdk0+C/O
         aAVTPxG4zBgGBZ2ALDl1n4W+P/dL5v+lZVCIRE39AvXoq5tulkmB2zgZVKeOkcvAp5cH
         sMaqJ8YJ6B3gJtKSgD1FGyh5C8Q3Tf8QcGn+SQzTaU0feyBDtSlrCeXjusDzOVDmCboG
         7oxbmZWA0ooA4A+rQ9cr6UDWCIqJBhqs+sPW4FzsmkGY/Fp5zOQAiTO8qw2pPp9AVzXN
         q/0Q==
X-Gm-Message-State: APjAAAUzsCxdokUPcnY7Ng3Zx4rO4S6+2a7RlTQsfCeq21mpPKuXBKXE
        gb68XDfN7bVBXkh/vjtuP0KSAcw8QJb/8rt5Ik8=
X-Google-Smtp-Source: APXvYqzGEhnq5nOzoTlf9Cq/DikojHlRWI0ZN1KQvL8WglOWxIWz82aLuxyLHP8sJ8fVtkE/ZBJAAed2X9ShqLqTqVw=
X-Received: by 2002:ac8:3042:: with SMTP id g2mr32419237qte.1.1553717844543;
 Wed, 27 Mar 2019 13:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
In-Reply-To: <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Wed, 27 Mar 2019 20:17:14 +0000
Message-ID: <CAGLj2rFDvUiTpZcPdp_QgU11+KDZe0O8LcTRhRA_vBRJqJ81-g@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 7:38 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
>  ...
> ... the process cannot get it out
> of thin air on its own (and you already mentioned it has nothing to do
> with security). What I do worry about is one can use NS_GET_PARENT

disregard this, it works as it should.

> ioctl to get the parent pidns if the owning userns is the same, and
> just passing that gives me back a pidfd for the task. **So, you might
> want to add the constraint that the PID is actually reachable by the
> current task as well, apart from being reachable in the passed in
> namespace.**
>
> Lastly, I also see no need of /proc/<PID> dir fd to pidfd conversion,
> I would even recommend getting rid of that, so we only have one type
> of pidfd, the anon inode one. What is the usecase behind that? It
> would only be needed if you did not have a way to be able to metadata
> access through a pidfd, which would be the case only prior to this
> patch.
>
> I think this would simplify a lot of things, and ioctl_ns(2) is
> probably already the place to do comparison operations and query
> operations on hierarichal namespaces, just adding the relative PID bit
> will make it gain feature parity with translate_pid.
