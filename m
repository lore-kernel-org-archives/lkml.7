Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090ABC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DF921852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LVjyjijH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfGXRwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:52:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44495 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGXRwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:52:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so21592600pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=LTjRTgv0sSmtdgDvRAyQuDy9Soq0qaA8z85xb1R02ko=;
        b=LVjyjijHQHfKDB6TTxxNkMKbqO6LZ3oZ9xr6a+Lk5e9HTmzvFnjYdxJpij+ZfGWRwO
         Zw2lmgqEgTRRQotlMWUsu3n2j2Vq3MVfj+Ghb4xfgNigDe4VfBSvM+699iujfFLG4hfQ
         1Bz2Uqco9uS3hLa+qE7rWLO8OSXOsa8pfHZFvlD5+Z6+S47ULGO+utVcPZLVMc0Khg5A
         B3Vvp3vvJnhGHCPrH7wPWhgWtdjZpMRSsK9KG5AsOEbsr63+Ra2ww8viC308puOrXrC8
         ft8fq94RETHXmbkgAvaWy5REviRNtrsFGY3WStZNOi8HuaUP+RZnWui5qA1QdSKayO+j
         tbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=LTjRTgv0sSmtdgDvRAyQuDy9Soq0qaA8z85xb1R02ko=;
        b=IsHSwG9Mf+7v5CI8PHIyk1kOZqjLWy37LNvpQOFRU1P1i7VVIPnspsBlaiKy/o4OfZ
         VyiTnwF52i/p7SwqdQlkIAPbitBop9gPrvUyGMOBTHat9HkSZDgz5yr5Ltlpmdbg85ol
         hEa+6z+8jcmt0xXpVsrHopnIFj4sxnpYw3QwTYRtFlKnRzCDo78kwKrBCXVMW9r40BEy
         ZpqOQaIb6ecYgVR1fXrT03H+g7kchidoc7acmGGNOqpOkXoPm6zCgV0K3F0cuXWhOxPm
         eQKU6h2xmV/m6xk0bp9vSvK1vcuoLOBlTnWQ6TjNy/tGTZNfhidsxkWS1ouEn6r+Nn5H
         6YjA==
X-Gm-Message-State: APjAAAXM6oRC0m3TEgfnEd7INS6sBvsZViwAO5nnNfcIEVvP24d1A/9H
        5wXp+fkHq9WXuXFX8Rjw9UI=
X-Google-Smtp-Source: APXvYqx7+JaUSwr8oNVFzhmI++HcH6nim4+KpKUYTgfT7PR5Hc6bp0HuElxuSpi3e2JwPJevG2BIaQ==
X-Received: by 2002:a17:90a:6546:: with SMTP id f6mr42634439pjs.11.1563990736774;
        Wed, 24 Jul 2019 10:52:16 -0700 (PDT)
Received: from [25.171.251.59] ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id g2sm78654497pfq.88.2019.07.24.10.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:52:16 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:52:08 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <95CD0533-576F-4B3A-8E80-D3D89967EE2C@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-3-christian@brauner.io> <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com> <95CD0533-576F-4B3A-8E80-D3D89967EE2C@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
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
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <D9BD06E2-576A-4627-8047-0AA86B6CCDA9@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 24, 2019 7:50:49 PM GMT+02:00, Christian Brauner <christian@brauner=
=2Eio> wrote:
>On July 24, 2019 7:45:38 PM GMT+02:00, Linus Torvalds
><torvalds@linux-foundation=2Eorg> wrote:
>>On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner
>><christian@brauner=2Eio> wrote:
>>>
>>> This adds the pidfd_wait() syscall=2E
>>
>>I despise this patch=2E
>>
>>Why can't this just be a new P_PIDFD flag, and then use
>>"waitid(P_PIDFD, pidfd, =2E=2E=2E);"
>>
>>Yes, yes, yes, I realize that "pidfd" is of type "int", and waitid()
>>takes an argument of type pid_t, but it's the same type in the end,
>>and it does seem like the whole *point* of "waitid()" is that
>>"idtype_t idtype" which tells you what kind of ID you're passing it=2E
>>
>>               Linus
>
>Well in that case we could add P_PIDFD=2E
>But then I would like to _only_ enable it for waitid()=2E How's that
>sound?
>
>Christian

Ah, sorry, just saw that that's what you suggested=2E

Christian
