Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F754C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F008D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKLxGDSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfDOTjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:39:17 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36935 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfDOTjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:39:14 -0400
Received: by mail-vk1-f195.google.com with SMTP id o187so3912090vkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMB1Xiarl5PcZSg9vVu/GRE6BQorb4XVsU8O0cUqVsU=;
        b=BKLxGDSl5+TsetRL/bEUshtZAOrv8PcHg3pn8gD/QXNHMWbfZXrRZrAVjR5M3KMyUN
         ed7fBPkMlMSdDsobZX6+U5/4BBlbC0XUSQp5YC1PzTkBtaQtK+fVP9p38yPLv0hTzU/A
         cKOlswBu/5wIJy9MaFrRr/xwcNt8TyJeS5GSNBgC1l9oWttuOZ7N4IF/g4/VGkeXSxl+
         bnCprrdU2ra8shjwHOuZikXLJkJAtvwc7O4qvjJMFBIxJE7m+vPKjYwPMufXcsJad01S
         lUjyEtRAD7ivCLIEnGP0beOCRuq1cD+8+pN7lJImhZF5LpEyKeGvEtM6qDSav/QiZpku
         mkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMB1Xiarl5PcZSg9vVu/GRE6BQorb4XVsU8O0cUqVsU=;
        b=omJEWItfDOWI3eEzj8DUW8smYaBL2Yb3x7ndqvzFJae9+SUC6D9QIbOuvVXegNrRGv
         lIt7IprtRh6A93u1kRPJB1PGqErNeuxyai3rweqYtNQBu11x3AsTChr1B1zjeTaPaqj9
         WeQsqASrP1G7ODC7rY2TQnmjDaVj+HaI5dMO4VF5IaCyNbOP1byYFWSOntyUUJPmKeEF
         JpMJ0hiXAYvREnqP2JpzZVULA+/MIFbJwhRxEHJqjvRqnopwpL5Bd+Pl+QOi04w6K8Wt
         HTuGSM9O1nlI6pS8lvL/HoEsdG2JRtwDjXEcxKMT6PwAhE6RsI0B7AU0YZ71gRJ1UGtA
         1lxg==
X-Gm-Message-State: APjAAAU0VvuHMvpSnokzzVFeN9TCSWn9LiXeDauXlsCC8++yTg55DimH
        KXcoxqTMeEUHsrY9QyZC+lW7fXXVC1ig9d5ba3JzYw==
X-Google-Smtp-Source: APXvYqxIHLE9Vu1BgI3Syp9WYP4zTP3QDmhMxZxttvlPEb14/xcTjCe42CYsYpYLEhVixlm+gO8l/Baz2YwJx6c3WdA=
X-Received: by 2002:a1f:8c94:: with SMTP id o142mr40823622vkd.61.1555357153147;
 Mon, 15 Apr 2019 12:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <20190414201436.19502-3-christian@brauner.io>
 <20190415105209.GA22204@redhat.com> <20190415114204.ydczeuwmi74wfsuv@brauner.io>
 <20190415132416.GB22204@redhat.com> <CAGLj2rHpZ92txk2=yf7dtHFcic2H0bGB0=FzEo7w2rNpC2zxDA@mail.gmail.com>
In-Reply-To: <CAGLj2rHpZ92txk2=yf7dtHFcic2H0bGB0=FzEo7w2rNpC2zxDA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 15 Apr 2019 12:39:01 -0700
Message-ID: <CAKOZuetPpE6-HrV0uV=fWosOnQkaq5eSQHyiARS6LUensuWBbg@mail.gmail.com>
Subject: Re: [PATCH 2/4] clone: add CLONE_PIDFD
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:15 AM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> > Why else do we want pidfd?
>
> Apart from what others have already pointed out, there are two other
> things I am looking forward to:

Everything that Christian, Joel, and Jonathan have said is right.

If I can wax philosophical for a bit (as I've been accused to doing
:-)), there's a lot of value in consistency itself, a "more than the
sum of its parts" effect that arises from modeling all kernel-resource
handles as file descriptors. You get lifecycle consistency, API
consistency (e.g., dup, close), introspection consistency (via
/proc/pid/fd and friends), wait consistency, IPC consistency, and tons
of other benefits from using a file descriptor. The alternatives tend
to be very ugly: one of SysV IPC's* biggest mistakes, for example, was
having users manage its resources via non-file-descriptor kernel
handles. The process is, I think, the last major class of kernel
resource that users can't manipulate via file descriptor. Even if
using pidfds didn't provide strong immediate and direct benefits, it'd
*still* be worth moving to a file descriptor resource handle model for
the sake of making the system interface regular and uniform.

* Does anyone know *why* the SysV people didn't use FDs? The
consistency argument I'm making was just as relevant then as it is
now.
