Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1E420872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="lR7IiVPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfDACNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:13:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43844 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfDACNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:13:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so3725309pfd.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CxXB4SWfc6S3NBwSbbwXW5l/4r4k5EPDkipFxiKya6c=;
        b=lR7IiVPBqeZIboLIDb6wST1HkE5i0AHVGX5X3AxyBf/JR4nAKUOcNtSxJKiGHwUKwI
         UYbnSesKhpHZxWtHpBpoNBxyMHtKom3qvKSFKKOMlmNbpOx0V7KMVMWNXESo+4G1ocM8
         S+Vp2F0Rv71KLGzD48YfXv5eUejz7TTULI19hlBjVbmfZ/cpP3AL5czn3R57h+881uwD
         DzAAhaMCZNMdztkafjlQXH8MtrRakn9hwxxzCkZaZF2lmlN0TSqonA8pOeSvK+S0KYNq
         sgQmGdr73b+Yi46HQXxVqBqKoVrQ498sLtVeKILmT94CRMHfHnjEMwYwyqsdhqaqqOo7
         HKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CxXB4SWfc6S3NBwSbbwXW5l/4r4k5EPDkipFxiKya6c=;
        b=U8LO8EotBGBAGtsElcIvHq8BxQJipX4WYyGAW/2Ho8MMiqAXcYennD1etdRcW8+qph
         L8d+HY4QI5rcQp2KSc4Fk29/MfSzJMdT5Q+lfBamz3hIi+TDNLXEMZjJFjjiXs9h+/cf
         30qhpyXmJ525L4w3cQYXwuFHhIERGrr2wyrBGf9h1GTEmrzYBOx3iv7pn5YXUOIjb+FX
         VimWkH8Xw89U3FeS3RKjMrSKVsi4z274q1TcUUCet4YJdHw3TGj/YwK9ktwqGrHuEmJN
         IVX2XxJxslwpsvC/Ryeokgu4QCXBrzClmBowBleEN+TICKpCKyDreafpOf5GjrWNrP53
         eFBg==
X-Gm-Message-State: APjAAAXTsUoSxk6crr4pTpmBKK8EM5AMkPqZd63S8tMwfGkuZ7Ad5A2C
        P5SREnlo+KeAm6xZOEBa2MasQw==
X-Google-Smtp-Source: APXvYqyBBV6lzEH6IBctB0Rojet327Vp8csFQGhlrYOzlqrrokEz3TqSc0x34ZwnXM4olCNWGluMsA==
X-Received: by 2002:a63:3190:: with SMTP id x138mr51205623pgx.273.1554084821322;
        Sun, 31 Mar 2019 19:13:41 -0700 (PDT)
Received: from ?IPv6:2600:100e:b13e:a3af:389b:29a:6d03:f8bf? ([2600:100e:b13e:a3af:389b:29a:6d03:f8bf])
        by smtp.gmail.com with ESMTPSA id 75sm14804796pfr.55.2019.03.31.19.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 19:13:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
Date:   Sun, 31 Mar 2019 20:13:38 -0600
Cc:     Christian Brauner <christian@brauner.io>,
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com> <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com> <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com> <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com> <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com> <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com> <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 31, 2019, at 3:17 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Sun, Mar 31, 2019 at 2:10 PM Christian Brauner <christian@brauner.io> w=
rote:
>>=20
>> I don't think that we want or can make them equivalent since that would
>> mean we depend on procfs.
>=20
> Sure we can.
>=20
> If /proc is enabled, then you always do that dance YOU ALREADY WROTE
> THE CODE FOR to do the stupid ioctl.
>=20
> And if /procfs isn't enabled, then you don't do that.
>=20
> Ta-daa. Done. No stupid ioctl, and now /proc and pidfd_open() return
> the same damn thing.
>=20
> And guess what? If /proc isn't enabled, then obviously pidfd_open()
> gives you the /proc-less thing, but at least there is no crazy "two
> different file descriptors for the same thing" situation, because then
> the /proc one doesn't exist.
>=20

I wish we could do this, and, in a clean design, it would be a no-brainer.  B=
ut /proc has too much baggage.  Just to mention two such things, there=E2=80=
=99s =E2=80=9Cnet=E2=80=9D and =E2=80=9C../sys=E2=80=9D.  This crud is why w=
e have all kinds of crazy rules that prevent programs in sandboxes from maki=
ng a new mounts and mounting /proc in it.  If we make it possible to clone a=
 new process and this access /proc without having /proc mounted, we=E2=80=99=
ll open up a big can of worms.

Maybe we could have a sanitized view of /proc and make a pidfd be a director=
y fd pointing at that.=
