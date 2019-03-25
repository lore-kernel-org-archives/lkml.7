Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE209C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E6E20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCpxCAs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfCYQ6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:58:53 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42591 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:58:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id f15so5803977vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIoA/MPV58v057b0x/ZPZgd6N3XeCcI0L69t5nexKXc=;
        b=sCpxCAs919IMpJz4103LqUd6mJ4Lu9SEDPn9eMNLNfOYoNsu9oNJf4pLjjYb3yuEce
         PsS7l3bi/+C8lXqGoaUPwsryFr+53KUEm9PcJBs95uVOpcSfgPdn2WbCVjel4PBH0Gne
         KpIsTCILA9xM6nScFDuTSu0L4Cu3KJn+xgX49j4jpOd3fR3RzRoG6gfcvyV+bWp1qodF
         ZNsvPSrHYi4AHHJ8P/Wc9YuTRBLx1tMnLxELgj+rq7KjYmchAxZ0HdXjsgb0YJuJWuvp
         1+aB/FQVmWEy5heBH3va92LU8kSZyRgq0zVmke+EXGYY0YkVWJHbN5eSHTtnf3bN+xdx
         J1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIoA/MPV58v057b0x/ZPZgd6N3XeCcI0L69t5nexKXc=;
        b=oHSnImp96ZicW0otooDMrpR00y1J6b5l7BiTqzyLRSE5QYKc+Ewk2kDXZ5xv3irvT1
         HY2Yq3ULYMTE84exgxAR/bFCNOFL27npkjhvETvaNJt0yBGcKduJUJT/GYA81HctZ5H+
         bD6CdlRhsxkpRwHndvzkWisKvt5dNvZR865kdUjrsT3KN9r1hrUhuEzqbP6uH86rtWaO
         O0q771/wmtRQqG6JHU/vMDI5zFtQafEx/fibMFq1kbp+33IJT4sSk7wldiAP5OB8R64e
         3ljNZw7tlXaXYPrs17J6UJTyADyxBv49WNO0ZQKjmHvvbSbIPoom0es3PAxYpffn0tUc
         tCpA==
X-Gm-Message-State: APjAAAX6aiG9GZigIdKwot+425dBv6P3XjIzYjCMW/p13jpdua635kLU
        l++icfXL030kWS325PwVNOneq5xI1s4XM9bw1JTrOA==
X-Google-Smtp-Source: APXvYqxe4wsGaJWhBHFzCpF9h9hpU8T1B7OZ0D8ttUJHosW4qYBM+Z3b46Sk/v71Ku5Raha5qW+ntkoGM8OWBdCCWsc=
X-Received: by 2002:a67:fa8c:: with SMTP id f12mr12923430vsq.171.1553533131233;
 Mon, 25 Mar 2019 09:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <18683.1553532974@warthog.procyon.org.uk>
In-Reply-To: <18683.1553532974@warthog.procyon.org.uk>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 25 Mar 2019 09:58:38 -0700
Message-ID: <CAKOZuev9TccQekrJjt50AhKA5cYskMmmKR3WF+Rm7G1xmbiV_w@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, khlebnikov@yandex-team.ru,
        Andy Lutomirski <luto@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 9:56 AM David Howells <dhowells@redhat.com> wrote:
> Daniel Colascione <dancol@google.com> wrote:
>
> > System calls are cheap.
>
> Only to a point.  x86_64 will have an issue when we hit syscall 512.  We're
> currently at 427.

IIRC, a while ago, someone proposed restarting system call numbering
above (again, IIRC) 1024 for both 32- and 64-bit varieties to
establish a clean slate and sidestep this problem.
