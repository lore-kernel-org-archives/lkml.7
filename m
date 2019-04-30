Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE6C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FB72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556641855;
	bh=IVL0FG5N84AtR0xG/w2ryqFP70hlsxpOfDN0HKJUnhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qt2p+hcPcaHlFLvgLD0mEqS62r4S1nFTl3UoNQAhTa6FCN3UZkgMbcpNPAigIGpE6
	 eQPlbTYSUcOp0y6km0AyvYrXYUQwAmazWX4CFVzDeuUnu+MPhJKr48xM5jmF6VtohM
	 JAoPcgT3hTYjWcTPaZ+44WzuFhEt8DRFeyo+UCCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfD3Qay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:30:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41790 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfD3Qax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:30:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so11232648lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zirBQvpMX9FN+xMGuy+YB2uuBWDRMNHlzh9gJjRPgVE=;
        b=hs+MMq9iB+eslb+cGLIpGLGbIv6EJP2l9mo6ehrV020sNd1PwGxPBGOEt2lJlTs3aX
         j5lQOg6lmmOjeQDX5ZISw6NeAcc9gXvyDHGfdKNNARf9UJs1P4nx3ChCR2owg+Zh2w30
         nFun/lkPvWMpDLpdDrhOj9zXwOjyW/YZ8hGXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zirBQvpMX9FN+xMGuy+YB2uuBWDRMNHlzh9gJjRPgVE=;
        b=mtii655ngJhI1Gu0vQ34oSBubOWV9aY/za2LlhaQ5F67F0WTUIF8S5c0W+P8/qHEFS
         lwMhpUNgSWoXrwksOV4zTLZfnAZolrXa4q1f+yD3v0ashUJ5jEqNkPfuya/Nf/foVhQL
         jv74n6so2KlRds6D77BrDGCleZOpxgz6BoDDz1XfQm1HCALE2mDAGKaIlSOAGjB3ViS7
         CEVEGcYgWp+tM8Ewa1EXHp3C0YvNXHSRQfedGkS5ldspbM9CXHK7DqGxq+3LlHnmTQjq
         RoeY5wNUm/NSIWRD//EKqu0aG2/V1v1v3EddTC6GN0nFRgkf+DnGjTy6eO/QvMP7e2NS
         vy0g==
X-Gm-Message-State: APjAAAWRCPqWCNooXwuAvviFOvwvajQlzSTbNp2dHSmgslpd9NE0zezH
        O7/DpTFd47KEGP6pZwX13qixzGoeCt4=
X-Google-Smtp-Source: APXvYqy9pS/OUSVkQkGi09rUH79xuGpMTzbj0PsRZWGOar4I1InTRF46slpfOU/r5W5V5lXkPmVnjw==
X-Received: by 2002:a19:384d:: with SMTP id d13mr16591722lfj.38.1556641851534;
        Tue, 30 Apr 2019 09:30:51 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id b15sm4133838ljj.1.2019.04.30.09.30.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:30:51 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id t11so11222835lfl.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:30:51 -0700 (PDT)
X-Received: by 2002:ac2:4567:: with SMTP id k7mr36971631lfm.166.1556641462358;
 Tue, 30 Apr 2019 09:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com> <20190430123901.GD23020@redhat.com>
In-Reply-To: <20190430123901.GD23020@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 09:24:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit1f_eARfgHYBQwjU2ndd_75OuHQurXNmrEHuhjQViJA@mail.gmail.com>
Message-ID: <CAHk-=wit1f_eARfgHYBQwjU2ndd_75OuHQurXNmrEHuhjQViJA@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 5:39 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Yes, but I am wondering if man vfork should clarify what "child terminates"
> actually means. I mean, the child can do clone(CLONE_THREAD) + sys_exit(),
> this will wake the parent thread up before the child process exits or execs.

That falls solidly into the "give people rope" category.

If the vfork() child wants to mess with the parent, it has many easier
ways to do it than create more threads.

As mentioned, the real problem with vfork() tends to be that the child
unintentionally messes with the parent because it just gets the stack
sharing wrong. No need to add intention there.

> I see nothing wrong, but I was always curious whether it was designed this
> way on purpose or not.

Oh, it's definitely on purpose. Trying to do some nested usage count
would be horrendously complex, and even a trivial "don't allow any
other clone() calls if we already have a vfork completion pending" is
just unnecessary logic.

Because at least in *theory*, there's actually nothing horribly wrong
with allowing a thread to be created during the vfork(). I don't see
the _point_, but it's not conceptually something that couldn't work
(you'd need a separate thread stack etc, but that's normal clone()).

So no, there's no safety or bogus "you can't do that". If you want to
play games after vfork(), go wild.

                   Linus
