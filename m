Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E34C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5456820818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 23:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557963132;
	bh=DdQxNOhT2rkARm+F4+I9o5A8l2BLuAeEqMtxCtDdsTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NRuPffovwNRh4IcH/tdZDIOwzBE4b7U4cqIy0eNZWUoHH/x+guK6jHTaJpm7LJUr6
	 ITx2qJkd2bPBkYHE04EIkoNxoKm4b4qEYXGXkVyNsl4j3iBYaOIViS/buPpHo8QlYo
	 DGur8fL7lesSqFQGOSDIvGtUlSVVCOudnleXtfc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEOXcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 19:32:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40606 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfEOXaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:30:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id d15so1340280ljc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rj8eiKEfKQp+r4kU9L07lOLZVjOy1p00iMYQoQzNM1g=;
        b=Jd4/tDKEvp+hE+t3buf26fXCZjFpIqo785n5ciqv6R11gys8cOxk924sG82V47MMTS
         KWGX4flrn9O1MphiePtZy6rBOY4DrEPz4wddSOpILtzncpeasMMd3u2vobOU5muw2mWm
         kFhZckpJrzaMMWO/ZPNRKFhPu4YsTQU3KZsKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rj8eiKEfKQp+r4kU9L07lOLZVjOy1p00iMYQoQzNM1g=;
        b=o4zqlku6LBEqk2tYBiOxs46TnJ//5YO7QOzhtW57G7pZu6ZKKkljL7/J8LclRoyDHI
         FKrEUKtGRy88YBIpV9XyQEtTcinX386CoiZCzY6db/7M243dhsH59j7qXqMu5Am8GnSK
         TxpvE+twiDhIWwkji4WaNG7T1shb4UsS67QGhYPtLk5dstQ43cTe54Zn7/SUBM+3ltUP
         wDzjDubC9dTFhITYy5w5GzlACQyCbFIH4pzIa9Z3JL0l/s3eONH6pod2zLQb/q60XMrm
         eQz9GgdQO+IwUyFKeig+qhiuGDKmomjcu8EmaYCtqHQxfL9CFreMGDdahPbcngOAt3fh
         AF2g==
X-Gm-Message-State: APjAAAV7nPR9z0IkIz/D89df3jtRtAs0kEPIk5yIltwsGE3F2MNp9Q+S
        GeyjNj1zzw7APE3IVxLafdEVECuilZw=
X-Google-Smtp-Source: APXvYqwQUE5IcUrTUezootSnL09xtH5PQ3Gih+UhJhtIA24/y+KGQYFnlBaEjd9N4JGJOXSvYGBOxA==
X-Received: by 2002:a2e:9142:: with SMTP id q2mr2574573ljg.18.1557963008240;
        Wed, 15 May 2019 16:30:08 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y7sm578688ljj.34.2019.05.15.16.30.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 16:30:07 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id u27so1085114lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:30:07 -0700 (PDT)
X-Received: by 2002:a19:4f54:: with SMTP id a20mr21404667lfk.136.1557963006849;
 Wed, 15 May 2019 16:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190515133614.31dcbbe0@oasis.local.home>
In-Reply-To: <20190515133614.31dcbbe0@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 May 2019 16:29:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com>
Message-ID: <CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:36 AM Steven Rostedt <rostedt@goodmis.org> wrote=
:
>
> The major changes in this tracing update includes:

This is not directly related to this pull request, but newer versions
of gcc hate your trace_iterator clearing trick.

This code:

                /* reset all but tr, trace, and overruns */
                memset(&iter.seq, 0,
                       sizeof(struct trace_iterator) -
                       offsetof(struct trace_iterator, seq));

not only has a completely misleading comment (it resets a lot more
than the comment states), but modern gcc looks at that code and says
"oh, you're passing it a pointer to 'iter.seq', but then clearing a
lot more than a 'trace_seq'":

  In function =E2=80=98memset=E2=80=99,
      inlined from =E2=80=98ftrace_dump=E2=80=99 at kernel/trace/trace.c:89=
14:3:
 /include/linux/string.h:344:9: warning: =E2=80=98__builtin_memset=E2=80=99=
 offset
[8505, 8560] from the object at =E2=80=98iter=E2=80=99 is out of the bounds=
 of
referenced subobject =E2=80=98seq=E2=80=99 with type =E2=80=98struct trace_=
seq=E2=80=99 at offset 4368
[-Warray-bounds]
    344 |  return __builtin_memset(p, c, size);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

It's a somewhat annoying warning because the code itself is
technically correct, but at the same time, I think the gcc warning is
reasonable. You *are* passing it a 'struct trace_seq' pointer, and
then you're clearing a whole lot more than that.

One option is to just rewrite it something like

        const unsigned int offset =3D offsetof(struct trace_iterator, seq);
        memset(offset+(void *)&iter, 0, sizeof(iter) - offset);

which should compile cleanly - because now you're doing the memset on
a part of the much bigger 'iter' structure, not on one member (and
overflowing that one member).

Another option might be to separate the zeroed part of the structure
into a sub-structure of its own, and then just use

        memset(&iter.sub, 0, sizeof(iter.sub));

but then you'd obviously have to change all the uses of the sub-fields..

                      Linus
