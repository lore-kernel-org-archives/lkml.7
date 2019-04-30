Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0951EC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF932075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBfXoY85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfD3VHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:07:20 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53002 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3VHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:07:19 -0400
Received: by mail-it1-f195.google.com with SMTP id x132so7110160itf.2;
        Tue, 30 Apr 2019 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRrtymnozdQGNFJfEx2JWMa9SRj+uzIojyqq/lvOudM=;
        b=mBfXoY855uNr+wxgPdg2vCAmqnVWcKkqVPw/STnI4CsBQVZkrtzNyGy6lIx06Ytbk9
         gHpvUc2llHhrMVnJEdvTYrhUzHJnw5MHOIV0ig55mSH+oipvUcKF2cqANBKl6zmncTXK
         WuU+8BwiFUU3JKiUs09IziR/E2m4k7oH/Ixq+JHEi26KCGx3SmITSWDiwEBxMAoi3mBU
         VOiM86DMf99u6g6uwwJJtuP9VFQgRqzh/SpEc0Upg9wqoi1ExLAQ4Av9oV1NCf6Q93Vy
         PSYIogmnzKn9BY6K3h0BlaoYzjajC5V7llQ3pabazWRZrjdb3KwTnty7hdyxh3zdE1q1
         QUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRrtymnozdQGNFJfEx2JWMa9SRj+uzIojyqq/lvOudM=;
        b=Sdn0BgogpoVerymYr6uwn2xYUUF09+gdwJleGW1oUs98zKG/Cl1sQXaRcKWVSvCsFr
         VNB+2eLvPLsoOnQgwQfAyDl394+V7sgIcM5PVSK6lv9hW6c6q7PqIXmQeyJnt4d5+GZ0
         efVo8XwPqmw+P4N80yUXrVFtmndPqD6zzpT1q92rA114/pueFSUMwsRWEbF6/7xGgZcR
         4eHOOD7YTjxPQsTwjGVraLsDLigVqlgqFlywjZAwkfXLkLSgVfzg23nH2d/nKrHZyzwq
         fuTddz57uTDqk6M0lRz29bSQrOgpzVBNa1zvU3t+mAUY73v+i2L8R/ZCgCJtofd15Vl1
         xZlg==
X-Gm-Message-State: APjAAAV13diBn95vxumdKJqVhaQlaz2+a01VYmwnfkPOVp2ErtePEI8g
        gCVc9qSlevx471h7pqi3lT36opkECXbZBmWf2ek=
X-Google-Smtp-Source: APXvYqyr8I7GartFvml6c63Sk0XE7PDA0bUalvU/Ko9MMjWCGefDyHA/wp9c+ZbAz74pwOLivyA4LjO3pm5VhBAEmQk=
X-Received: by 2002:a24:7347:: with SMTP id y68mr5512480itb.58.1556658438613;
 Tue, 30 Apr 2019 14:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr> <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr> <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
 <20190429210427.dmfemfft2t2gdwko@dcvr>
In-Reply-To: <20190429210427.dmfemfft2t2gdwko@dcvr>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 30 Apr 2019 14:07:07 -0700
Message-ID: <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
Subject: Re: Strange issues with epoll since 5.0
To:     Eric Wong <e@80x24.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Kilani <omar.kilani@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was also not able to reproduce this.
Arnd and I were talking about this today morning. Here is something
Arnd noticed:

If there was a signal after do_epoll_wait(), we never were not
entering the if (err = -EINTR) at all before. But, now we do.
We could try with the below patch:

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4a0e98d87fcc..5cfb800cf598 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2330,7 +2330,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
epoll_event __user *, events,

        error = do_epoll_wait(epfd, events, maxevents, timeout);

-       restore_user_sigmask(sigmask, &sigsaved);
+       restore_user_sigmask(sigmask, &sigsaved, error == -EITNR);

        return error;
 }

diff --git a/kernel/signal.c b/kernel/signal.c
index 3a9e41197d46..4a8f96f5c1c0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2849,7 +2849,7 @@ EXPORT_SYMBOL(set_compat_user_sigmask);
  * This is useful for syscalls such as ppoll, pselect, io_pgetevents and
  * epoll_pwait where a new sigmask is passed in from userland for the syscalls.
  */
-void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
+void restore_user_sigmask(const void __user *usigmask, sigset_t
*sigsaved, int sig_pending)
 {

        if (!usigmask)
@@ -2859,7 +2859,7 @@ void restore_user_sigmask(const void __user
*usigmask, sigset_t *sigsaved)
         * Restoring sigmask here can lead to delivering signals that the above
         * syscalls are intended to block because of the sigmask passed in.
         */
-       if (signal_pending(current)) {
+       if (sig_pending) {
                current->saved_sigmask = *sigsaved;
                set_restore_sigmask();


If this works that means we know what is busted.
I'm not sure what the hang in the userspace is about. Is it because
the syscall did not return an error or the particular signal was
blocked etc.

There are also a few timing differences also. But, can we try this first?

-Deepa
