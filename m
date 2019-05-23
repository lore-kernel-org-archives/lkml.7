Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB30C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCC92075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558630777;
	bh=a+jM9NxwioOUmaoMXh/+LE31drcBzCQsSsXpDBPG3wE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l7llKfykvKrZ3KPMMvvflDjZCsz2oahHqr5mRng5isMyt2qZjVWyCY/iRhHhrC2HP
	 9m5UXB0aNzHZzhB+QMtZ9jogZJmCbVfxKwj/dZYrVWJxkym3Wcy4uNCfnuaTbvD8oc
	 b/LKZCb6O82DHdCitb+h4FoVFAoyhvuVHQwgvmPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfEWQ7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:59:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41276 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfEWQ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:59:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id q16so6147835ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ks/LH2oyTEaijoOzEMOK4qT05od1mgbLgD6IvZvC3ac=;
        b=UrcFcbzEFPGggz1NPXakVDUiIg5mDqTO4045eBb7udfHenM+Veb+rBZ0tlbryVNdJc
         qa5A4P3tgF5XCLb7D69n65wDt2yEO3fr0UKE7SehnvIvMriAPEG9xpGYM5u8gpQLeOdX
         1vpQBx74HKkfDoRasFV6IFoGOt3sYNk7jzZac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ks/LH2oyTEaijoOzEMOK4qT05od1mgbLgD6IvZvC3ac=;
        b=NVtm6kZZv24dG/jWhH8SXxeDU2JFpBBWdVwcCdvQEF5T5UWns/JtYAHOfjx8wpbdw4
         +bpxxAc4Qfbc8MND/rUEIzJ/x5nuPe1EPHBOMx5PQZjBalsjNHFEYiIudcebiSyWeUat
         RAu425XX32jQVTkoPDQYyobs16uzydNxp5r3xRYXXJVO9Wx7yb6ycetjlT/EbCrMtOsG
         HiCYFg93d8UvNl7kSnJ8M3MM1l3GIu3znoqPPVEd515AhP6PyhO8352CYdyi9nEOwejl
         L52xYWTT8dJGrJO36NcARAbuCT8/c9xu6CRfcog/sACLUrBe1MutFqoeecuaCzL58ZdY
         cwfg==
X-Gm-Message-State: APjAAAXlY6oTYB0vDEj95laEyVMgrgefDFkI+UG8aXmz3MTyv7KWFU5O
        X//25wRghmvy2g3CE0dsrDWA4FD6sjk=
X-Google-Smtp-Source: APXvYqzHcQhpMIIpSkEbuI6qxkxSkCFXZSF3u50LSMdV41k+93FKW6dIHX2WuY38GN6HU6NHWgrNoA==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr3865040ljk.10.1558630307848;
        Thu, 23 May 2019 09:51:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id d195sm15396lfd.10.2019.05.23.09.51.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 09:51:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id n22so4896442lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:51:46 -0700 (PDT)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr41221787lfc.54.1558630305849;
 Thu, 23 May 2019 09:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190523100013.52a8d2a6@gandalf.local.home> <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
 <20190523112740.7167aba4@gandalf.local.home>
In-Reply-To: <20190523112740.7167aba4@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 May 2019 09:51:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFJqTOk0mSxJGeh38ZxDksgRaMrNV8hqTngiuokyJzew@mail.gmail.com>
Message-ID: <CAHk-=whFJqTOk0mSxJGeh38ZxDksgRaMrNV8hqTngiuokyJzew@mail.gmail.com>
Subject: Re: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 8:27 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I haven't yet tested this, but what about something like the following:

So that at least handles the constant case that the normal "roundup()"
case also handles.

At the same time, in the case you are talking about, I really do
suspect that we have a (non-constant) power of two, and that you
should have just used "round_up()" which works fine regardless of
size, and is always efficient.

On a slight tangent.. Maybe we should have something like this:

#define size_fn(x, prefix, ...) ({                      \
        typeof(x) __ret;                                \
        switch (sizeof(x)) {                            \
        case 1: __ret = prefix##8(__VA_ARGS__); break;  \
        case 2: __ret = prefix##16(__VA_ARGS__); break; \
        case 4: __ret = prefix##32(__VA_ARGS__); break; \
        case 8: __ret = prefix##64(__VA_ARGS__); break; \
        default: __ret = prefix##bad(__VA_ARGS__);      \
        } __ret; })

#define type_fn(x, prefix, ...) ({                              \
        typeof(x) __ret;                                        \
        if ((typeof(x))-1 > 1)                                  \
                __ret = size_fn(x, prefix##_u, __VA_ARGS__);    \
        else                                                    \
                __ret = size_fn(x, prefix##_s, __VA_ARGS__);    \
        __ret; })

which would allow typed integer functions like this. So you could do
something like

     #define round_up(x, y) size_fn(x, round_up_size, x, y)

and then you define functions for round_up_size8/16/32/64 (and you
have toi declare - but not define - round_up_sizebad()).

Of course, you probably want the usual "at least use 'int'" semantics,
in which case the "type" should be "(x)+0":

     #define round_up(x, y) size_fn((x)+0, round_up_size, x, y)

 and the 8-bit and 16-bit cases will never be used.

We have a lot of cases where we end up using "type overloading" by
size. The most explicit case is perhaps "get_user()" and "put_user()",
but this whole round_up thing is another example.

Maybe we never really care about "char" and "short", and always want
just the "int-vs-long-vs-longlong"? That would make the cases simpler
(32 and 64). And maybe we never care about sign. But we could try to
have some unified helper model like the above..

                  Linus
