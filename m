Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B1FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225CC20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554133322;
	bh=3wdvxTrKJEKmmgmad+Ok4SeOTJFTxUx6I1kJ3xAEGAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s2QOZ4KaFJYysDeRw1caBx3PBx+jrkPREA7uDS4D0mBhixek6B9dzSDjL9zAs/kfY
	 cyi32Mh3jLHJn0MCrC+qaQGteaOFVn+T8pDDabZZfue1W9OjpQPMnLp2R9czPamvgW
	 CDpIYQcB6m5B6W7BRT6ILARTYMeKo575XgMzIhyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDAPmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:42:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38225 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:42:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id a6so6661150lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOW3gcj0uVZsBKtJ1kk1jNQorwoq58Na1xgkJ5fJwr8=;
        b=IKLQM78LYMrHE2ryWjCD67ieOLyLRl+qQ7SoWH5RCDaqGhanzR41HN+G8WzqWJoUw9
         HTmyXMlnZcS4boxznsdRMFAq9WlqeDDKFQEnijI+ivyPrYsDX5Rin2yywSDcbZdMhyX1
         /4nTwk+H1MX5GSuIsUoyL4+a2a16nQTbUZXBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOW3gcj0uVZsBKtJ1kk1jNQorwoq58Na1xgkJ5fJwr8=;
        b=fManrTyldvtovwYlrmVr1UGSZWC8wmZI7olyR+vdaY79q4s8j9zy2tXFPp/jjmoqq2
         U0lvZCI7qij7K40ZD3Du88VhY+EcQkKY589fTf1bVdwheAvSzrVxD7YzKvhbYbIIdKiX
         r0f5C9JYh79eIikAqL+lXRMD3m5W7UWnUczUJ/HN4mfpFaAP8RukXILmX+TPDRGgkoEh
         QKZLvG85Sk9msYfhLuJgd76b1/zqmqssh8KsSiQ7vzljeBmNlgg4J3jxCrHkTrQ+SUKR
         rTWNIcJN9aAMqIFzh3IYu2TCZALO+s8paGfyTJGn0sYyYTjBJv7M/26+LZ2rZUNu5kwr
         dBaw==
X-Gm-Message-State: APjAAAWkVwqpHBxcoFQIRs08fK/M5X42CkY0ESGb+z3pyeRrmomO3SEM
        NqXGhaQ9ju+u2VMjfxb0eFniROz7b/Q=
X-Google-Smtp-Source: APXvYqwTVx8oTSyttacDHOvo/QpRwiBHgLht0te5hb320D/QB57uQoyyOaBzPfKwXG5iIqLHqkMaMw==
X-Received: by 2002:a19:c314:: with SMTP id t20mr33097723lff.114.1554133318441;
        Mon, 01 Apr 2019 08:41:58 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 7sm2419510lju.27.2019.04.01.08.41.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 08:41:58 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id a6so6661100lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 08:41:58 -0700 (PDT)
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr132573lfm.14.1554133002233;
 Mon, 01 Apr 2019 08:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
In-Reply-To: <20190401114059.7gdsvcqyoz2o5bbz@yavin>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Apr 2019 08:36:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
Message-ID: <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
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

On Mon, Apr 1, 2019 at 4:41 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> Eric pitched a procfs2 which would *just* be the PIDs some time ago (in
> an attempt to make it possible one day to mount /proc inside a container
> without adding a bunch of masked paths), though it was just an idea and
> I don't know if he ever had a patch for it.

I wonder if we really want a fill procfs2, or maybe we could just make
the pidfd readable (yes, it's a directory file descriptor, but we
could allow reading).

What are the *actual* use cases for opening /proc files through it? If
it's really just for a small subset that android wants to do this
(getting basic process state like "running" etc), rather than anything
else, then we could skip the whole /proc linking entirely and go the
other way instead (ie open_pidfd() would get that limited IO model,
and we could make the /proc directory node get the same limited IO
model).

                  Linus
