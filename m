Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0892C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5962133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554134899;
	bh=4mUBPSvFW43cZvn4hu1jhHu1mmod6UfLuzf+HJTOWoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MA11Hp65yMkDmZNOFV10jOZ8cZJq+pnQAxIo3RxsLemEZ1Uf3UvEJQqvtAsJinIep
	 ihw0zTTaYuCBqpX/I5GVQG3G2FMPNlR8afd7Rr3/pHoNglZ8bjv5r2pe/dmSlKEuF7
	 PXptHBcBHT6yRqVDx65H1xWzqsYG5MUl25q+ZW+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfDAQIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:08:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38061 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfDAQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so8707866ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zX6pW+dmmCXMEz4jCv0a4w3jGqqO84SK/D3MDTDCm0=;
        b=MY6OYHwH/K9pFTSK+Hc6dMo3sYWaw5y4092j+7NxrZKSktB0Oq4qHjylDxqIpcNsZE
         vkrHIMPlIhCVYnn6kn7Ba5j7ru7eDu2I5IeR71OkYEZ4hWg7DtspqAGlIsm9nF99BPph
         Uh/OZMGeyTZkmrke+z/G/mSg01N+vKgcqyjCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zX6pW+dmmCXMEz4jCv0a4w3jGqqO84SK/D3MDTDCm0=;
        b=jspQt8W2HqHZjH3pOnXrgaySa4T0q9Hyxf1vkBKXxnnDBpfUFjuzJPfdUA1bk8HVHa
         SKChPch03zS50oP/EyYHg792usu9puhISprZxtrCYYtPzKL6YQzXaQGHeE6Qtw1FlS1E
         s7aLMjk0bouUi8cf2rvD9ML0utR4i7cBN9NCCY3TWS1fAAbBeAd4IbzPJeDCuV6t1gI3
         ajbz2bU/mFIHRsdqKEOF1blzlT8p6CzRwr77j26k2VzQf0rgSGD+oq2le3SOJyYj/pqe
         L/q8pZeJMn3FYtaJYfKUUFVRav0PWbT97i0NTJqVezrGb3YaM4nqC3Z1oM34eXCGTaw6
         3w/A==
X-Gm-Message-State: APjAAAXqFNQmtl1XhH8HUFKxi2WRQ1JYWpUlVLdteCGCE3NA9o++ICyX
        sZAklZ5YwhSkQTmb5HR1GvcqLooK1Oo=
X-Google-Smtp-Source: APXvYqw2H/oCN/oDyD8b/ZP7EX5KL95T9sVr+O+2TMZqnsAQAgMCF2DnbGezy6HoNpSX6GnqOvkczg==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr561819ljj.51.1554134895557;
        Mon, 01 Apr 2019 09:08:15 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f25sm1461606lfk.69.2019.04.01.09.08.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:08:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id l7so8695400ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:08:15 -0700 (PDT)
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr33165967lji.127.1554134506239;
 Mon, 01 Apr 2019 09:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com> <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
In-Reply-To: <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Apr 2019 09:01:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
Message-ID: <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Daniel Colascione <dancol@google.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 8:55 AM Daniel Colascione <dancol@google.com> wrote:
>
>
> > I wonder if we really want a fill procfs2, or maybe we could just make
> > the pidfd readable (yes, it's a directory file descriptor, but we
> > could allow reading).
>
> What would read(2) read?

We could make it read anything, but it would have to be something
people agree is sufficient (and not so expensive to create that rare
users of that data would find the overhead excessive).

Eg we could make it return the same thing that /proc/<pid>/status
reads right now.

But it sounds like you need pretty much all of /proc/<pid>/xyz:

> We do a lot of process state inspection and manipulation, including
> reading and writing the oom killer adjustment score, reading smaps,
> and the occasional cgroup manipulation. More generally, I'd also like
> to be able to write a race-free pkill(1)

I suspect most of what pkill wants is indeed in that 'status' file,
but other things aren't.

               Linus
