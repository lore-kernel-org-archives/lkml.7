Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B2DC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396AE22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564176428;
	bh=dZOExye+pM1E7BM9U+2z7J2HkixivdUeGqrmu6iwUbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hBWhSzoFBqDEXDOW2TMsfQQuB79T8pcVZA0M5GE3bUMbXrVWKQTPsGI0tYnpuESRS
	 KLAL5B42o6R2/RHwmnTnP0Ym7Y8dBqr+r54qzssRD2ayYrEVZjzjXS5bd9fQUuVLJL
	 1pEErQHasOUoYjPbjGb3lhD2KIKAPZsb1wL+xfG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfGZV1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:27:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37979 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfGZV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:27:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so52785514ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oROXchk0tmmHnZtV89FllJVdTECuKw3BPgQ6Hf6Vl4s=;
        b=MSe+CuDQ+yUvx2OlxKcOIA/4YcSwxquGlKWAqjpBzvL1fy4OqUlDjjZFYp7icsODS2
         3sY0GZ7+dxI7JKNycv2ZU9exAXYyPCPFqLn0O+9Bo2iriXFT42vwZfct15Ds7bGRc2k5
         SXbYZmFVEC1KOPKJWAM4ltcZCJpZAK2Jaz6fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oROXchk0tmmHnZtV89FllJVdTECuKw3BPgQ6Hf6Vl4s=;
        b=N7D4N99cUp8Y8CCI6AuSPIH5tfA2XZ2CYidWMZNpZbVjJGvTqtiF+gFmipSGUcNRWE
         sdjn5oLqpBgZ/V86gFHnKaXwgJ9eETP3gXhsH9xrhljGSBnzprQg4KteBRjDBa56s6CT
         3TGQtbqV/HkBIdIw/AnfBZb5/mOtUEArC8l6rwu3eeLwF50psbCQ0fzTGjm4sgmG+KbW
         wQZrjjKtePFN/OqYPtn6lyXyyew/dlCU2Zeavpr5J2frL1r0k7axAueJjfhgEs9S47WN
         r6ceaGcr4iSDB+xg4m/CoQ9rPiKBzsQsjvA9CR4B4XIrrVi2xHFLjkPKdW0hQhlnoZje
         zyxA==
X-Gm-Message-State: APjAAAWEsKDQNYEmGVh6G9bMRjvFnryDFns33lBZON0uX4cmeETz+JGB
        qJIoJdmnWshrV9OOCPnEKyuKfkst768=
X-Google-Smtp-Source: APXvYqxoZnXsN8G27cj0ddAvIA7klqRLvTu6SkjpY6E5MKHoT1453GR1W9c67jcTYbz3zZyrLb7e/Q==
X-Received: by 2002:a2e:88d3:: with SMTP id a19mr3670746ljk.32.1564176423657;
        Fri, 26 Jul 2019 14:27:03 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id x18sm8742434lfe.42.2019.07.26.14.27.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 14:27:02 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id x25so52856822ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 14:27:02 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr22933090lji.84.1564176421990;
 Fri, 26 Jul 2019 14:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190726093934.13557-1-christian@brauner.io> <20190726093934.13557-2-christian@brauner.io>
In-Reply-To: <20190726093934.13557-2-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Jul 2019 14:26:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibXtQ9pjB9ctpy5jWJK93DL19Lj09Et6cYEQE+h7tPpg@mail.gmail.com>
Message-ID: <CAHk-=wibXtQ9pjB9ctpy5jWJK93DL19Lj09Et6cYEQE+h7tPpg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pidfd: add P_PIDFD to waitid()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 2:41 AM Christian Brauner <christian@brauner.io> wrote:
>
> -       if (type < PIDTYPE_MAX)
> +       if (type < PIDTYPE_MAX && !pid)
>                 pid = find_get_pid(upid);

So now we have four cases in the switch statement, and two of them do
*not* want that "find_get_pid()" call.

Honestly, let's just move that whole thing into the switch statement
for the two cases that do want it. Particulartly since I think the
"upid == 0" case for P_PGID will prefer it that way anyway.

Let's not check 'type' in two different places in two completely
different ways.

Ok?

             Linus
