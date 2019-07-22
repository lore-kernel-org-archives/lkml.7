Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7554C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807AA2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wamzhstl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfGVPk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:40:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37027 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGVPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:40:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so14852914wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=IblV1eSdD9A1yoa0yRZtwaxbgDnglVW4LyJYr5t+VuA=;
        b=Wamzhstl7EUeofLBKyeLwGnqzRZ7TvwFQIloQWCe/PoIjczEgqSP2CJBABLEsapW6H
         cos00a/M7EqJWfbUejF6efPpC/dStb4dt/SxmW1WwunOP9obT81TQU8+FdMn2VKZTNUc
         j2A3EqcFNWdXk4ktz7SNxoDAnU/6a4tG6i/gnpcC6waz7Fsl/y2Se7bLblbbNGsNcw+h
         sV/yKXOkZo/wIFSX7Fw64GbwjJo0MGQcQ/u61AL1HnpmDvqr+Rm63lNss5QkNKisvPCf
         4Xr9sQH+eKZTs4hd2UKrwc0QSD8SKOnbP9aoOXy3LhfrPQV6J3NyfIyYN9QdAoaU1DJD
         LR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=IblV1eSdD9A1yoa0yRZtwaxbgDnglVW4LyJYr5t+VuA=;
        b=UFgGtTIywcZ75V1m/S3NTZbTfTEt0rO63DUAtnD4I/134sloJe4KuYFw29neL2CtIp
         45bFt2vemZoKwQNpkQQaa1QXAKkIDzq96qubgl7ffHH9yNuEgiw/yyC1jyvoQy1N644m
         BS+oqvjJiAvJi/WIqswVNzFcvJBklG8+fuxSXE6CPS06iXrmbEtZHDrb1jUhSvOk4pCw
         2mTD9l6dOOKjBL/2K8PFRVmkbNcs+UTAeuF8maFZpN0gVYISZCgvVpdJrkGBuJpHq4LN
         DBhBqYz+FgjE/0iw2v0/UfOpHTKzz3MJLhPOUDSlxh64sT8TUSmSw8y2lKNGj7V38smM
         XQFQ==
X-Gm-Message-State: APjAAAW5wXtXkW3EH/LSfKn2kmM0X8xUULfSvJlv6HGWxgqyRoQRgH8T
        ozB3pu8NB0d4APSF5wLjvXi1J+IHP3AziWWjiMk=
X-Google-Smtp-Source: APXvYqzDRwQUp64/GbIyFgEq4eROYjDEz3ywrOLm9+d8RDgZNzODGeTNaiy30i/L3MSPmODwFLvhFTohsOy50SN9MME=
X-Received: by 2002:a5d:498f:: with SMTP id r15mr71037233wrq.353.1563810025346;
 Mon, 22 Jul 2019 08:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <CA+icZUW5jNJY3L5EcxrtOttwpbdAWQ7=U_bZaLHcTogOdNuTcQ@mail.gmail.com> <CA+icZUUtNibYGbHEt+cqsu6cuKYF7=MobvPQ9mkXU1pJZhFw9w@mail.gmail.com>
In-Reply-To: <CA+icZUUtNibYGbHEt+cqsu6cuKYF7=MobvPQ9mkXU1pJZhFw9w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 22 Jul 2019 17:40:13 +0200
Message-ID: <CA+icZUVbYL9RkcVqU=Z0HJgn0U=hYStr30rQDaZ_rcBr27Cv6Q@mail.gmail.com>
Subject: Re: x86 - clang / objtool status
To:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 3:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> > First of all I find out that it is possible to download and apply the
> > series (here: v2) from patchwork (see [1]).
> > I highly appreciate to have this in Josh's Git [2].
> >
>
> There it is.
>
> - sed@ -
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-many-fixes-v2

next-20190722 has them.

Parallely, I opened an CBL issue #617
"drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
.altinstr_replacement+0x86: redundant UACCESS disable"

I hope Josh can look at this.

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/617
