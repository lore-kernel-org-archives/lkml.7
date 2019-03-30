Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60520C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227672184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="M0NtndlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfC3QTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:19:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42691 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbfC3QTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:19:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id x61so4546661edc.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=ernJGglIMT4+VghNiZOzqrUEB85/gc2EJjQrVTUa6Ug=;
        b=M0NtndlDoTUOJViHHBJbfpgMzMvYz5SEH0W6ZXovwpdV0L+TO3vgAJWxxFr6E9+wTh
         D2fCDASHQFVeyPnEKhcu2umRxOiAJ4RlU9HbHMjerwLIbq+xkUd0UNvta2dxn2n7GrHa
         YthXtZfCS2gWlzCN6CiJs1V+ylGXgCQofGZNyg323N0BmPkpgHb0Sb/Xd5CNENtQlQAq
         Cz8tfmxA83hycB2B9bLZ+urPGstPD0NioznekJFbrVKhvJLOpGFr1cxKyzfFIMuWt+6d
         jmb3YCuxpcQBpTnDarOU4yqj074CtSQ5AxVm+K3fqL90JZ9vIpFjdHldmYCQBKNGwe+8
         CyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=ernJGglIMT4+VghNiZOzqrUEB85/gc2EJjQrVTUa6Ug=;
        b=PAinNB0Eulc+a4zbObWEh75/1BD57SuRSpl0OF8xF9kcTShGfpoK5gv3mACbn4sbUo
         clqz1l+qecTkUgIaA7qdPXwM00t7PL8mmpGHdT/OyZWyc7a/Q/NgfX7lfF41r8keCaID
         cP+uBW8Ppji1IvM+7dEwpyB8+qLGCJd2imtCjXEFhNkypgPN4OFlpMU/zfZXIUQb0y9D
         EA5AnAsCeMFO/mPrBkXQLxm3aehxm3R9Qe4nl/ZAslfTj/1epcfW3lt4Y6xuZ5xo5Z84
         E557fnA+eqqQhpmcd4voVsF8+SuX+B5KEQatob4+8H81wbbpYIL0/DwzqsnrRNBpGPA4
         1bbg==
X-Gm-Message-State: APjAAAXuRdT5XYP3U0cs0/ys7DMiF7zhOTby+uTDbEqgatxT+P4wzl8h
        FZ3GHXjzrVgL8qsls/NpQOeipg==
X-Google-Smtp-Source: APXvYqyX/nwunVfbVClNk8z7HdetZwIknjz59k0jQ/A/XOzEZh7T0hl0/bufWzzq8fEyCnfa5BtDXA==
X-Received: by 2002:a50:8561:: with SMTP id 88mr21150275edr.101.1553962778713;
        Sat, 30 Mar 2019 09:19:38 -0700 (PDT)
Received: from [10.38.1.125] (x59cc8b7d.dyn.telefonica.de. [89.204.139.125])
        by smtp.gmail.com with ESMTPSA id n3sm916383ejc.32.2019.03.30.09.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 09:19:38 -0700 (PDT)
Date:   Sat, 30 Mar 2019 17:19:32 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jann Horn <jannh@google.com>, Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>, serge@hallyn.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>, dancol@google.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 30, 2019 5:09:10 PM GMT+01:00, Linus Torvalds <torvalds@linux-foun=
dation=2Eorg> wrote:
>On Fri, Mar 29, 2019 at 8:54 AM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> /* Introduction */
>> This adds the pidfd_open() syscall=2E
>> pidfd_open() allows to retrieve file descriptors for a given pid=2E
>This
>> includes both file descriptors for processes and file descriptors for
>> threads=2E
>
>I'm ok with the pidfd_open() call to just get a pidfd, but that

From=20pure API perspective that's all I care about: independence of procfs=
=2E
Once we have pidfd_open() we can cleanly signal threads etc=2E

>"pidfd_to_profs()" needs to go away=2E
>
>If you want to open the /proc/<pid>/status file, then just do that=2E
>This whole "do one and convert to the other" needs to die=2E No, no, no=
=2E
>
>                   Linus

