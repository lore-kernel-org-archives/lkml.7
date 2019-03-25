Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0359C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725E720879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqAfRbtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfCYUkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:40:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43203 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:40:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id c20so6240414qkc.10;
        Mon, 25 Mar 2019 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0S9UBo47qnHQkA9sh2xkZDDuLosvzAPjXi5dEKWR/m0=;
        b=oqAfRbttoIh9ewBzJoVSaRRh91YFpKRp/gpXYKFzJ+uertayRE0qEZi35k3qHM5yPL
         I9Af6yeuddibNShp4zLGWh/CFvovcH5P/NKy6Fk/uYJXuxrMtvxg4bhILQvIjqNU0cl+
         xGzJS7v3mbXjww98zY1eP7ONB69IOx+gOb2R1CFHAqhXl2liI+LlKHiG3jeXaZmOMFCe
         1mCbfAn9I/y2sr+S7s2LTd5kIR91/7odROmX9vKppPx+6VuI7y08W4GLItNZwxq/lvZy
         BkqF2L5x15ktVj8cVHutAwBR5XzUjR7cu2CQ0ZMBTBPVg5R7FWEmLQyBkvU3bPSPPKsM
         Ip4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0S9UBo47qnHQkA9sh2xkZDDuLosvzAPjXi5dEKWR/m0=;
        b=jRVgzCTgy25VJp8g3rUzg8/GE7R4VD1YFIDggPIq/ESDrxDfY9GuzvuDHica8w59Hy
         d71KQ0cS6bbv5zRFmxBDnArlupvtTQcji7Iw6x3euazVh0NB6OItRwsjZl/4S/1V0gXJ
         YfXop/KDrWGG6/rDoz2GopadAl2ALCmFSdKg9B8yvj1w9sOKM5iMl3fyRxAcozfeCuMt
         /7jP+9W1gx7XZ/eUFb3T1WBQBN/klQIuEOxh6HKqyS90tujaL59FZGQGbVGd3pP5k9w4
         jndUzWdMQxJU0O2pTlL6X8XTmm2Xy/+a6dvXbzlGXuSDLgthU42jiZ7pBmZLclpui5se
         UxkQ==
X-Gm-Message-State: APjAAAX+2Tc7ireVdWMYpnPigahQAQQVlcb335ClquQR5HIHqd/nHYJw
        T5z50vfP3EJB31Y+wjuD5Eegpp+Cm54pd0npn4I=
X-Google-Smtp-Source: APXvYqzBEUQt1Q6CtJ4QK3o2+QiHyJFyp0Msn4JMHWBafZYKpRxMDKI+k4p8MFQ4e3jcKI4sKutYdxVB/7Of9nQO0dw=
X-Received: by 2002:ae9:eb4e:: with SMTP id b75mr21478681qkg.121.1553546434892;
 Mon, 25 Mar 2019 13:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
 <CAGLj2rE1f4x36KFUjFLiFq8tF1RUmFuCSRTg_tCQ9W2G6LtizA@mail.gmail.com>
 <CAKOZuetCFgu0B53+mGmQ3+539MPT_tiu-PACx2ATvihHrrmUKg@mail.gmail.com>
 <CAGLj2rHETs+FjkOVP6PJ_EiePP7FKiDwxaWyjwg1gMZPYpU1fQ@mail.gmail.com>
 <CAKOZueuYMKdkt8BoSj1+p7=mpe2PA8r7xT5QiF6q3cTK+6HsAA@mail.gmail.com> <CAG48ez1ZVKgwfQDYT1k4pB4-8Y8Ywv12dabh5KFFxtKmT-e7Cw@mail.gmail.com>
In-Reply-To: <CAG48ez1ZVKgwfQDYT1k4pB4-8Y8Ywv12dabh5KFFxtKmT-e7Cw@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 25 Mar 2019 20:40:19 +0000
Message-ID: <CAGLj2rE7k-p=ZniyV6bDm-VbhAdzSSwxYcVV=X_Rsky5nixGvw@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Jann Horn <jannh@google.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
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
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 8:34 PM Jann Horn <jannh@google.com> wrote:
>
>  [...SNIP...]
>
> Please don't do that. /proc/$pid/fd refers to the set of file
> descriptors the process has open, and semantically doesn't have much
> to do with the identity of the process. If you want to have a procfs
> directory entry for getting a pidfd, please add a new entry. (Although
> I don't see the point in adding a new procfs entry for this when you
> could instead have an ioctl or syscall operating on the procfs
> directory fd.)

There is no new entry. What I was saying (and I should have been
clearer) is that the existing entry for the fd when open'd with
O_DIRECTORY makes the kernel resolve the symlink to /proc/<PID> of the
process it maps to, so it would become:

  int dirfd = open("/proc/self/fd/3", O_DIRECTORY|O_CLOEXEC);

This also means you cannot cross the filesystem boundry, the said
process needs to have a visible entry (which would mean hidepid= and
gid= based access controls are honored), and you can only open the
dirfd of a process in the current ns (as the PID will not map to an
existent process if the pidfd maps to a process not in the same or
children pid ns, in fdinfo it lists -1 in the pid field (we might not
even need fdinfo anymore)).
