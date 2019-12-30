Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9042AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665172071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577691312;
	bh=m8eVohNyKttmgU5ay7SHm+slg90RHhjhhS7LlHAagHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wd3op81a3Ceu3lE3mnxY6VWuGajjyvywTHv8p/UXsnwja2v+RhPz90IGA46llMdTZ
	 vXGsK44D7HoT86ABOfp9n0dPFctzAHGvfdLK3CoJoid+l/BgEguGkWbq31NpLctJmp
	 qdlsrbOVLMSJ3ux8WVUKqFLFA8bKYQ2jvXJctiTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfL3HfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 02:35:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45367 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfL3HfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 02:35:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so32434840ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 23:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8VcqoghW5rOvSMJZ0IRIDoHi0nnnASGxtcLP9nLAOE=;
        b=dcr/plKaY7CZ9pAbFtoIBm1kJ5332NaIez2y+adUYFlSYClNPYMFXaLR/4ZeaHThae
         0NCLKYZWzj0ZhsWf2e47n3ViMgFwTwrkmZNIbW13YNQIezqPgp+Z6vCLkGnc5OMABuVx
         VOl557q4dUt0XZZxaC0scsChHGK80Gm1/Peb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8VcqoghW5rOvSMJZ0IRIDoHi0nnnASGxtcLP9nLAOE=;
        b=nGyPFnBifwTI8adHq4iiAIPE5iQJDGOgIkDKhxDwZkVzo61PYpFZ8kLLtM8AP7XAOf
         5c6GSonIxxwVmQOyZ7y10HQUdGwNVb6XTWg3yJetPNjFAwkIPQnECeknz5LKTLw460IJ
         z8qhyAUZFeOt08mrG8nvHA7pa+J1dUHESLs8iqj+uB74DWBDXRCuLWXHK8/4N3hPor59
         EFzAhhmhUS7ckmWBYiSY1XQ6OHo/BVX8dBh4H1kx8Gx3zqeaBETAeXW8vmE6mdTysK4t
         FJuPcLBJF1PX7/IoEX8O8ckTci4yy5eBfPQbuoJLlxZvgTigEf8VDkOpDAlSaKAdIDy6
         jcBQ==
X-Gm-Message-State: APjAAAUFQmM3A7NPOPaE3i/4/hNCurFmp0AzUOq8I5c8Z3cPMoUB4FAB
        6K2N2gwPJuG/P+xia5yYBvuMSxj9pzQ=
X-Google-Smtp-Source: APXvYqyC0R/Z+bnB/mNTl8Rf5HTFgmeOCV92i+Zyaelw0OS/je8XUNA96IgNTVQmqD/MF9ZUlKHkPw==
X-Received: by 2002:a05:651c:20a:: with SMTP id y10mr37657656ljn.216.1577691306457;
        Sun, 29 Dec 2019 23:35:06 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id g15sm15074411ljn.32.2019.12.29.23.35.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 23:35:05 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id j1so25079383lja.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 23:35:05 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr37380088ljj.148.1577691304745;
 Sun, 29 Dec 2019 23:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20191230052036.8765-1-cyphar@cyphar.com> <20191230052036.8765-2-cyphar@cyphar.com>
In-Reply-To: <20191230052036.8765-2-cyphar@cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Dec 2019 23:34:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHPCQsMeK5bFOJQnrGPfVDXTAFQK4VsBZPj5u=ZgS-QA@mail.gmail.com>
Message-ID: <CAHk-=wjHPCQsMeK5bFOJQnrGPfVDXTAFQK4VsBZPj5u=ZgS-QA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] mount: universally disallow mounting over symlinks
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 9:21 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> +       if (d_is_symlink(mp->m_dentry) ||
> +           d_is_symlink(mnt->mnt.mnt_root))
> +               return -EINVAL;

So I don't hate this kind of check in general - overmounting a symlink
sounds odd, but at the same time I get the feeling that the real issue
is that something went wrong earlier.

Yeah, the mount target kind of _is_ a path, but at the same time, we
most definitely want to have the permission to really open the
directory in question, don't we, and I don't see that we should accept
a O_PATH file descriptor.

I feel like the only valid use of "O_PATH" files is to then use them
as the base for an openat() and friends (ie fchmodat/execveat() etc).

But maybe I'm completely wrong, and people really do want O_PATH
handling exactly for mounting too. It does sound a bit odd. By
definition, mounting wants permissions to the mount-point, so what's
the point of using O_PATH?

So instead of saying "don't overmount symlinks", I would feel like
it's the mount system call that should use a proper file descriptor
that isn't FMODE_PATH.

Is it really the symlink that is the issue? Because if it's the
symlink that is the issue then I feel like O_NOFOLLOW should have
triggered it, but your other email seems to say that you really need
O_PATH | O_SYMLINK.

So I'm not sayng that this patch is wrong, but it really smells a bit
like it's papering over the more fundamental issue.

For example, is the problem that when you do a proper

  fd = open("somepath", O_PATH);

in one process, and then another thread does

   fd = open("/proc/<pid>/fd/<opathfd>", O_RDWR);

then we get confused and do bad things on that *second* open? Because
now the second open doesn't have O_PATH, and doesn't ghet marked
FMODE_PATH, but the underlying file descriptor is one of those limited
"is really only useful for openat() and friends".

I dunno. I haven't thought through the whole thing. But the oopses you
quote seem like we're really doing something wrong, and it really does
feel like your patch in no way _fixes_ the wrong thing we're doing,
it's just hiding the symptoms.

               Linus
