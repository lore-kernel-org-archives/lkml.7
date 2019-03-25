Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578DD206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTA1MZBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfCYVPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:15:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36865 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfCYVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:15:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so12167213qtn.4;
        Mon, 25 Mar 2019 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOB0oYz+728BPsAdJuQbmMh9f8lOi7seLXMKgApZGOA=;
        b=uTA1MZBZV/6qeT6HsBg92eQPdJKcDv3y0w9z66V9rzVK1pLf4LWmkiMlithQIcXI0N
         vYrO/LTnv0kUF3Y46qRGxjWvs6WL0cSrOepUmJTgSBJB4uW331jPMUTEpq1w15mLVqnt
         oRJFpgkLTw1LY0PlluWYvhmUg8/BNEzp8vHqXThq4bBuiJQSy0kLHX//yXPu0d7oS8tK
         7UVS3QzcSyAmoAmarySC7cdt47fX1W9nZLn7lIw6KElDb4ONQ6qlomhHU1JEW13l4G3U
         KJgpJBQy+2XL822S5sZcDOD4T2wgv7yYWCFdiIs1e0J42qflI+Amm/Jwj/3qKDZhd5Ti
         NAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOB0oYz+728BPsAdJuQbmMh9f8lOi7seLXMKgApZGOA=;
        b=QfEz3d+PEv1zV6YEneqhfNLS72WwKPrnIUBal7mqWyMb97npv21XGGliTFUSlMaNsV
         Q74KF87FAHcpG6Trk1Y5jan5FCQynQn84S2gIrXH03A4bGosgqqmMTyOOsYYkm1rPENY
         3BccOw5qRyra+X1/j9ZtLaqI9euD9mfSptLg9mYlMQE+jF1Bb3/iExYV+UEUPXmyoNDZ
         o7v+O2oTQNdqi02n1gIE6g9ELvP96ocdeROeBP7I80rd2ePnT2h/7kk13/oddb5dABTg
         VwTXAhoynR8v993GuS25+kCZQSUOSlZnuPH2bv3lVWndAHBKJYXsbI/HSTWTKBiJeLFt
         kdgw==
X-Gm-Message-State: APjAAAXB/vSu7DEwqKpXOdCl2/HtCimOcgceJ0IBkBoGv4+QLf4y/Pp2
        44MSYd8SmGj9s3It4a8weJE3SnXjiH4jIP48WjI=
X-Google-Smtp-Source: APXvYqyebtow0S7IxBB4rXyTBOK9XAZjGNyVN09aAtNvLMl5gw8i7E3Su6gvAdCsMoEfNuG3zXdXW1+WoHfJPnhJThA=
X-Received: by 2002:a0c:8445:: with SMTP id l63mr22492411qva.187.1553548508460;
 Mon, 25 Mar 2019 14:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
 <CAGLj2rE1f4x36KFUjFLiFq8tF1RUmFuCSRTg_tCQ9W2G6LtizA@mail.gmail.com>
 <CAKOZuetCFgu0B53+mGmQ3+539MPT_tiu-PACx2ATvihHrrmUKg@mail.gmail.com>
 <CAGLj2rHETs+FjkOVP6PJ_EiePP7FKiDwxaWyjwg1gMZPYpU1fQ@mail.gmail.com>
 <CAKOZueuYMKdkt8BoSj1+p7=mpe2PA8r7xT5QiF6q3cTK+6HsAA@mail.gmail.com>
 <CAG48ez1ZVKgwfQDYT1k4pB4-8Y8Ywv12dabh5KFFxtKmT-e7Cw@mail.gmail.com> <CAGLj2rE7k-p=ZniyV6bDm-VbhAdzSSwxYcVV=X_Rsky5nixGvw@mail.gmail.com>
In-Reply-To: <CAGLj2rE7k-p=ZniyV6bDm-VbhAdzSSwxYcVV=X_Rsky5nixGvw@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 25 Mar 2019 21:14:54 +0000
Message-ID: <CAGLj2rGMHfNkRKmb1+BFTuJb+wpXg09so-52Hsb0tMiQ0beMfA@mail.gmail.com>
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

Also,  extending this further, instead of new ioctl flags over to
translate a tidfd one might introduce later for thread targetted
signals (which would still be a pidfd in the struct pid terms, but
with a bit set in its reference to target the selected TID in
particular), you could resolve this neatly to the proc entry of the
task itself, which would be subject to restrictions similar to a
regular open call, minus all the races involved.

This also means you can get rid of having to support the /proc/<PID>
dir fd in pidfd_send_signal, because there is no incentive to, any
longer. The kernel now has just one pidfd object, well scoped in its
purpose, and this "feature" is tied to procfs itself, disabling which
takes away the feature as well.

Otherwise, the ioctl will be conditionally available and/or work only
when procfs is present, and you'd tie procfs to pidfds eternally as
ABI.
