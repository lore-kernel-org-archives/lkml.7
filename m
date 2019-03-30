Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C2FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1A42173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553962629;
	bh=H0ZOScGhv1KsETWl8yN3Z7JgS+TuwyQirN2FsAePuTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z2xfr2DkSJKlWyn+WYlpjXsbmWYjXdO9fE64MvDmxyq4KvyOt2t7n96e3jd72leo/
	 z+BH3j2k6Dfkyqcd4+1G4JJWoUHNhgSk9qT6w7ZlvL0qtC8uvQOeeK34gYrAIow2q/
	 m7xTf4+7FaYNY4KxAaUHi3ayvy73HHEvBb8nTSWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfC3QRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:17:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39486 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbfC3QRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:17:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so4504537ljg.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9Q5EM7FJZ8qECdEOjmqySeDC40RA5f9xl6j61uK/Ow=;
        b=V9F2JHO1K3LzzF5pbpCBVQsUlNP1D6GHYIBZINelXujGiD+qUH/aUTcyMQhCYJPWF/
         Wp8H+ClPcE+PICvD0SloFHz2V5s0H76v6+baiKYupHHsb72tOb9V9lU/45Q/lee0rR2b
         krDqMGkzC6jUctn18Wxw7l+2TMRhTaU9eAOYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9Q5EM7FJZ8qECdEOjmqySeDC40RA5f9xl6j61uK/Ow=;
        b=cgZJDVSdjMLamsWnvY/SUhlpR09cMdspvjNKOmley3h6oTnhh+3nJZu+6QHNKJoKeD
         sRsc+jPYt3adnJLutMETRNZNY+/AGf1xdJA6ueZDASRXRkisn4FkoKZ09cV9xoyyjQIC
         qCD+YpHdl4r3Xrvcf1CKp2NjoDIEAr1HsuA7ky8SDTEansjqpWbueZMZqaB12cReHLUG
         z6HtCEK+CJsfaqfS/hUx44HDUR97hSbLlMsx7mEITFM3firZyxr6s9wwX0isg7lnOU7Z
         zFlx0PwgIlXFz7qK9VsFZlZLJGn+SvQZtIAqjrIQfBFapbxedeQiEiOMSEbvUYxLanX5
         R+bQ==
X-Gm-Message-State: APjAAAWCNayjjNeKpzVwySXaHWxeq5TgS3xzpYdS4pQwhmjjYNfqeOos
        CVSLp82yMR6qquDg+H6jODYFRFnT3rE=
X-Google-Smtp-Source: APXvYqytP/svqHgbMMap1zHmJde19RBQ4qL13Us9hymrV/IIs9+Q8ePO76PLoJGNdDuQm0GBLEHP4A==
X-Received: by 2002:a2e:9e47:: with SMTP id g7mr5811364ljk.48.1553962624852;
        Sat, 30 Mar 2019 09:17:04 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r27sm889496lfn.87.2019.03.30.09.17.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 09:17:02 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b7so3435946lfg.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:17:02 -0700 (PDT)
X-Received: by 2002:ac2:4354:: with SMTP id o20mr14930297lfl.62.1553962621816;
 Sat, 30 Mar 2019 09:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
In-Reply-To: <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Mar 2019 09:16:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
Message-ID: <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Daniel Colascione <dancol@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 9:11 AM Daniel Colascione <dancol@google.com> wrote:
>
> How do you propose that someone open the /proc/<pid>/status file in a
> race-free manner starting with the result of calling pidfd_open?

CXhrist.

If you want to open a /proc file, then open a /proc file. Don't use
pidfd_open().

Just open /proc/<pid>/

Then you can use openat() to open whatever sub-files you want.

You have two choices: either you use /proc, or you don't. Don't mix the two.

And no, we are *NOT* making pidfd_open() into some "let's expose /proc
even when it's not mounted" horror. Seriously. That's disgusting,
wrong, insecure and stupid.

                           Linus
