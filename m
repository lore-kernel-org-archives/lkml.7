Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91020C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E4920896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="VSoL4p01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfDAQQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:16:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43247 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfDAQQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:16:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id m10so4722402plt.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=l9oqIRAU2UPrMiXtPjkYTdSg/WVLOxnn2O41sRz69XE=;
        b=VSoL4p017CZ6RMrEZA3phIoOPqFD4TL520E8rkIUQWnXNsmkQw6BKkSjYGb99BMvLV
         ocpsTKbW/t8XeRQap3NNGljZ5KUexaPcRi5eNbeK7PZgMhswl/iO1or/siU2dfL8Ds5m
         b5fhAyAYue7EfiSITyzF0tgu/U7lIzTGCbg7N/ke5D6Aem5MPFk2xHiu4C311eJn72Zl
         6rill0AgPrRE2QPBe0lqX05msxcqBe2Fy9dBFlmH5n3zK1tQ6c0KLl9SK2/+sOAsaRVD
         mIB85KxjAWJpqNBJV77UkdUZmS+iiObkmdleeLMn91H8KE7tU5J6aMhj0lQeim8ofMU6
         g4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=l9oqIRAU2UPrMiXtPjkYTdSg/WVLOxnn2O41sRz69XE=;
        b=WrVgVIOh/6Nyv329mNhTTgEs9qb8bUBHI2W3GSBYUTAu623Rw53n25OFhV1vSk1PcC
         fZ5fKFQPrj+Ffj0pL6zS3uKexEGq8/yvWXino0YVbSsm7pjW1KfL/tvH71WlJquL09Na
         7w4mhqdQVkAv+2W3ol4kBh4hrba3Yzd3TQU515DtmIFPKetLlwHkvXC1+lMGQkvmxKi+
         yikLBDBtTSfQBZBiDsJ6UsKmHpP7N7m2NNwJOVTWltNqe6mCRUFKPFT5ZIscfz0lAZF0
         Pdr6zB4XTfrFG5tvLgfp/84lBGl+4wqiJoCS1M3jpN9rP/y5mFk+8WQMdkebZ7LbDqmu
         449w==
X-Gm-Message-State: APjAAAVvxpAWJk7lR/q041cidu7K/bzoAY573kdFUu8iZlab9f7TGqwz
        fQp1oYlc30i3goorlDyR9UbhlQ==
X-Google-Smtp-Source: APXvYqw1iOgVQMzhpwGDN37bxql8NP+0pt/VdsuTQg7m3v07lVuAcE9q2Qr6QrAQeuXwR8BQlaL+LQ==
X-Received: by 2002:a17:902:a704:: with SMTP id w4mr7290502plq.51.1554135400122;
        Mon, 01 Apr 2019 09:16:40 -0700 (PDT)
Received: from ?IPv6:2600:100e:b13e:a3af:389b:29a:6d03:f8bf? ([2600:100e:b13e:a3af:389b:29a:6d03:f8bf])
        by smtp.gmail.com with ESMTPSA id s16sm15502667pgo.69.2019.04.01.09.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:16:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Date:   Mon, 1 Apr 2019 10:10:01 -0600
Message-Id: <190D1581-ADD6-4E8B-93A3-5F3C6B1D8154@amacapital.net>
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com> <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com> <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com> <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com> <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com> <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com> <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin> <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (16D57)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 1, 2019, at 9:36 AM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
>> On Mon, Apr 1, 2019 at 4:41 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>>=20
>> Eric pitched a procfs2 which would *just* be the PIDs some time ago (in
>> an attempt to make it possible one day to mount /proc inside a container
>> without adding a bunch of masked paths), though it was just an idea and
>> I don't know if he ever had a patch for it.
>=20
> I wonder if we really want a fill procfs2, or maybe we could just make
> the pidfd readable (yes, it's a directory file descriptor, but we
> could allow reading).


There were patches to make procfs mount options work sensibly, and I think t=
hey got merged. So we could probably avoid a whole procfs2 by instead having=
 it be procfs plus a special (maybe purely internal) mount option to restric=
t it.
