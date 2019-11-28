Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013F821774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="GjdCm5Rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfK1VNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:13:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41865 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1VNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:13:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id l26so3239968pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:date:message-id:subject
         :in-reply-to:references:to:cc;
        bh=FyqTLTv2j4L1gEekoNfzFQVXdnYoPeHw5/qT6TKVOR4=;
        b=GjdCm5RqYEaOwTue8OcdWss1DQlbJTa1gCdFU0KRLokox7XApAh7YFks8mJvKlzdFf
         o4U4oUZjCCRjNIoiXWZ9kszfM9O4azNctAJKN/sR77q5bHsDZ/h0BGnH/UHtf5WOPtTJ
         ETgeBQdkzkrRrIH+DKKApqyyJF3D2yldDRY1Y0Md2vw1QMm+Vq9cmsG72EyFZOJdJZbb
         goAUlF4Yz+mGebcDGydlOl/m+drh4o5xNDJolJ00yKL59gCapwA78uPdoVusRnzM5Pa4
         WjtyYzvPERs2s3y3O0+X1D+Kwv8gUXRzmwvYmO7rYB4wqe0YktZodSVaL/QCetxZPGQN
         2XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :message-id:subject:in-reply-to:references:to:cc;
        bh=FyqTLTv2j4L1gEekoNfzFQVXdnYoPeHw5/qT6TKVOR4=;
        b=pJcYLJz89rcSm2tg2c6EVj2HQgNnStGxjXd2HRJ/nklgmSga/szJQiPhmpl0ru48GD
         TgOx8Vb+OigaTbOC8KsNFfY9XQ5muawGx5M7/OLP2mJ6CouoLTo243lNUMs18GfvJLfs
         OztzM83NzDZPtvioW8JiPPvuKEQr5GwdLOLgIWgktj41Rshkjg1jgG+qTbn5LRDb/qOJ
         jOT4skCoSpJOMC4IGioGPCA/S83ducghuuoA3si9qfgt7HXJzHsS3WraY/OGgDzOTDxL
         pK5UUhVhB8kch3DXOpsOPomEEYKrFQXX00W37veTeSN46sYc0sxXW7JkKxqB7CwJbSyW
         NcXQ==
X-Gm-Message-State: APjAAAU0/YIQKXTYs+7uWIGAyhF4sdGjFElGtktub2qUpUxxOLscUjqe
        pcj+TEJA8cNZryPv4TMdA1I2qPPLXzWtJw==
X-Google-Smtp-Source: APXvYqyQXKwKZYZt5WpPBWKYyBJsXm8ODa0WyI2Np6oOWdJvGl0ideImKLMK3dXdphfxEcSbkfMwmQ==
X-Received: by 2002:a63:4a1a:: with SMTP id x26mr12206916pga.298.1574975617595;
        Thu, 28 Nov 2019 13:13:37 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:ac85:b26c:253e:8928? ([2601:646:c200:1ef2:ac85:b26c:253e:8928])
        by smtp.gmail.com with ESMTPSA id h5sm11814341pjc.9.2019.11.28.13.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 13:13:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Date:   Thu, 28 Nov 2019 13:13:34 -0800
Message-Id: <EB7AF2AE-6CA3-4395-AA37-BF92EE308A42@amacapital.net>
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix get_nr_restart_syscall()
In-Reply-To: <CAHk-=whA1h-7MKGdzyViwJR4_rqYKMP91FwuObWneBZE0yH81A@mail.gmail.com>
References: <CAHk-=whA1h-7MKGdzyViwJR4_rqYKMP91FwuObWneBZE0yH81A@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> On Nov 28, 2019, at 11:25 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>>=20
>> =EF=BB=BFOn Thu, Nov 28, 2019 at 7:36 AM Oleg Nesterov <oleg@redhat.com> w=
rote:
>> You misunderstood my question, I do not see a good place for the code
>> above. So I am going to uglify */signal.[ch] files.
>=20
> Ahh, ok, I thought that was kind of understood.
>=20
>> --- a/arch/x86/include/asm/signal.h
>> +++ b/arch/x86/include/asm/signal.h
>> @@ -5,6 +5,10 @@
>> #ifndef __ASSEMBLY__
>> #include <linux/linkage.h>
>> +struct restart_block;
>> +extern void arch_set_restart_data(struct restart_block *);
>> +#define arch_set_restart_data  arch_set_restart_data
>=20
> I'd just replace this with
>=20
>  /* We need to save TS_COMPAT at the time of the call */
>  #define arch_set_restart_data(blk) (blk)->arch_data =3D
> current_thread_info()->status
>=20
> or something like that.

I think this doesn=E2=80=99t work for x32. Let=E2=80=99s either save the res=
ult of syscall_get_arch() or just actually calculate and save the restart_sy=
scall nr here.

Before we commit to this, Kees, do you think we can manage to just renumber r=
estart_syscall()?  That=E2=80=99s a much better solution if we can pull it o=
ff.

>=20
>              Linus
