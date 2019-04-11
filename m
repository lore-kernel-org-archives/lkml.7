Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F64BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE9B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555001471;
	bh=W8vmqTJJQ5bkw2ibphr0GbRKYsJCRSQrBCH2au6Oapc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k7gsoFrl0gUFgUDFfir2vU6IUMooW8QOhA6mXog0pAPh4HIT1me8RCcx1XqbY5JBy
	 wjllC2vF3V5vwZhmrPkWwLtcF3YJ6AlZAzYCoFCF5eBy1DjtbqXYY39F1SSC1DZURz
	 rVOwcXhWr/r0On3IOHtEOnbK6TduABMb/cQwjoJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfDKQvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:51:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38786 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:51:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so6162894ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/hx0NnsCoe25Udwmu9EvTCGmVL1NWLmRxa3s9qSNGE=;
        b=OULQRYO1z+YohekQGwp2/pmaJbeorta81jqJLvhROkmKxSDTRczQVcQgnSHRvKqbrZ
         sAbS3xz8hZ4p+yGnIOw/nKDHUFbdIyKX/gFvwfcew+OH+651b6Uo4eorhexO+mDQ4wY0
         mHVAD8o1bKZ5hm1ctB+zL12qiQL5NveFu0jEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/hx0NnsCoe25Udwmu9EvTCGmVL1NWLmRxa3s9qSNGE=;
        b=MPi5xwJSwLjpLoBVgV2YwaAT3v2b7nrgKB+hkDURLeU1cqZTEXF58NIX5sPX/ie6wZ
         TeYDuLlVyD1UgYGiCF4/CYU1c/3MWaoPrMST3/PGbaYjNPgWf+ZTEWZ79PkxKEzguW/F
         TLgou3hCSCPYbaEV6bbuW8rejc5uDhj3wyOIVBI0S9LJHV6Ch6Se1i+qIJLMMef9JxsE
         FkOVZkvUegn4L1ZxwkSbHlC7YItQw5Tx1cDG0M8rZ7l9gDNe2BW1klxt7AI4gzZNIeQS
         viRgMtm8Go9POn50MhgOFuBYjdk3nhKOq3F7Xzg9FRwrERGIGNSbsfp2f3Ah6l3PLGiz
         lOiw==
X-Gm-Message-State: APjAAAX8pwjwG/+Pfr/XA7cqlMKEpyazLDY/nazrDI1V3ihVWdEyP7xh
        qLYG9GhF9RZjve9LOEXHcAIcU3hSuyo=
X-Google-Smtp-Source: APXvYqw90ZxGvD68RbSL44uQsi5MP3dcIwTRbp0hrAKk/xKkxzUP4Inmn4oEXxb8LXKiK2Tgzf1uFw==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr4653805ljj.21.1555001465673;
        Thu, 11 Apr 2019 09:51:05 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r20sm7776741ljj.22.2019.04.11.09.51.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:51:04 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u17so5260164lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:51:04 -0700 (PDT)
X-Received: by 2002:ac2:546c:: with SMTP id e12mr16140942lfn.121.1555001463837;
 Thu, 11 Apr 2019 09:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190410234045.29846-1-christian@brauner.io>
In-Reply-To: <20190410234045.29846-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Apr 2019 09:50:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifyY+XGNW=ZC4MyTHD14w81F8JjQNH-GaGAm2RxZ_S8Q@mail.gmail.com>
Message-ID: <CAHk-=wifyY+XGNW=ZC4MyTHD14w81F8JjQNH-GaGAm2RxZ_S8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fork: add CLONE_PIDFD
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 4:43 PM Christian Brauner <christian@brauner.io> wrote:
>
> RFC-2:
> This alternative patchset uses anonymous file descriptors instead of
> file descriptors from /proc/<pid>.

I think I prefer this one. Your diffstat makes it look bigger, but
that's because you added the example code to use this to that rfc..

Plus making anon_inodes unconditional makes sense anyway.  They are
always selected in practice to begin with.

               Linus
