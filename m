Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35113217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553963086;
	bh=0KrkSAPj2dJoP8Q9juXN8lezoq0fyyKC1IUMilzr+mc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fBdlODGGrrnu83iE9hqh0dliVooxTsc8Lc1F1YdQI+ByFyVkDxCZc3pqhAENixSuZ
	 4sgRuZUxZXAKdCrSM0HK1kjHgwX/yKMiS3evho56emMZhjveLWAAjetV+ux5G0W/HI
	 GJVXv9MfeGyBGZi4IimceQDoDs6tRk7AfPX0OedM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbfC3QYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:24:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46369 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbfC3QYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:24:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so4486640ljk.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dbf9YjHg9/21PLwzpfRAxu8vfMgIUFianSuRN5KFOGs=;
        b=eQoUyd2tmJM4OZzMMJJ3rYIZ6iM6IrqaVaXTXgJ5Kr6/EN9kDGymKsj6qpVNG7Qr3W
         KVCh11VP2ChmbmPhfkkp1CZHmr+lF05mlzfg9Jx0bcL3ZHyx06KmvYYApjRHt4QKa0xy
         IcuyAxIfgPkMVJFw+7JOx4Gob/AfD3glfZOzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dbf9YjHg9/21PLwzpfRAxu8vfMgIUFianSuRN5KFOGs=;
        b=PLkonJUIDdnVkKdhLGdexzupD0EW35oaOFYCpOmeuD41lNIFDJlBzlHb8uMuu1u1Sw
         vUaeiJWYBkjYzjIYt6snvbLUgOAWxObwvFebkUT6F/Vt9pwVFWJ66HfXKUp3ROLgR0gx
         ejTa6w/HOcf1FpnrJjiWgFd3hood1p+8Y1luf7vo+CCaI1+QYiiXNCE1BXD3riDQOdlb
         3cbj+AkbGpX/duWA/qAdCpT6PKfVzxRcYBk2jAPMjz5+4NiFAjf+R1lsQhskIGGpsLzH
         8HFZkvPdSTl7vbH1x/k0nJPK5y1SEo00i/n277jOQ8+ON3Aho5Y49X5NhNF/dZvqRGTy
         e7ng==
X-Gm-Message-State: APjAAAXMk+Prkdafl/ANixZAY/LkV5zlmTB1pSxt5an6XGzaY7ksK6SW
        eJR5+JwC+FNmc9PXLu5nq4iR+uLuXPQ=
X-Google-Smtp-Source: APXvYqyk461wHH3viX627DFQYq6MI3es+DNBWHuKf2PVUQtelm8UlA7tdPa1XohYlQsvwIg7H3GjAw==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr30048752ljj.63.1553963081569;
        Sat, 30 Mar 2019 09:24:41 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id s10sm882048lfc.20.2019.03.30.09.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 09:24:40 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m13so3451063lfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:24:39 -0700 (PDT)
X-Received: by 2002:ac2:4424:: with SMTP id w4mr27965950lfl.148.1553963079676;
 Sat, 30 Mar 2019 09:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
In-Reply-To: <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Mar 2019 09:24:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
Message-ID: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Andrew Lutomirski <luto@kernel.org>,
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 9:19 AM Christian Brauner <christian@brauner.io> wrote:
>
> From pure API perspective that's all I care about: independence of procfs.
> Once we have pidfd_open() we can cleanly signal threads etc.

But "independence from procfs" means that you damn well don't then do
"oh, now I have a pidfd, I want to turn it into a /proc fd and then
munge around there".

So I'm literally saying that it had better really *be* independent
from /proc. It is the standalone version, but it's most definitely
also the version that doesn't then give you secret access to /proc.

And it weorries me a lot that people are trying to play these kinds of
games. I'm just seeing some android patch that adds this horror and
then starts using it.

                      Linus
