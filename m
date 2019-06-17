Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D7AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C984920863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560797349;
	bh=XN0sZTHFc86E5Er7PLQumYX68GNl/0viJ7UPgKDUIJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jEqoXinkLXkszFzDanTW2ZA3eqJ/m5Tr6pYAHJOpqRpSpy6Tj/IuaVGjzpwrTE49L
	 pXjE2Rk05NXjHY9eRRTzlpartHnenS1t6JMQBmrUCWZfe8shDDpth0r8FP+xLl7QdK
	 jUutCMRPD6QaTYZIgdls1bWU13r1xR65/cbtShC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfFQStI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:49:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32933 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:49:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so10378118ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nOSaXiJzVDj5IM4aW+0gcUHxkkLPWAqm3lSgcsh3l8M=;
        b=MvA2SRX/VcHcJ/x8ZeKMF1KFFgxP8vUPLAhIurER9lCvX2VZXMWPDioh1w1srq6rzn
         Zwoo9Xfyqg0l9Ax5Wz+NR2tDOku7ZmEn5fLqn1riZVzXmnUdqe43mDIsx1k087Au98Il
         q7u7RVM4b0VfVPtmQV1Q1W6OJiHBfodkWBImc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nOSaXiJzVDj5IM4aW+0gcUHxkkLPWAqm3lSgcsh3l8M=;
        b=DQljl4P5uwp//PMeXQrueTzPl0D8/ZqETGq2Rc8GATxEyYRuUGXalMh0AOs0rDg7ME
         Div69PyE9yW2UNBBVHAnG5STw40uUoSHv8c4Bt2c4WhKI2JDuDFnTlf9nwu5wducnv/2
         uAaERzTTyDUzmKh7/pOWg0STIsh6i781Nc+0qWQ8cUhcnKtfWCtPWzeNRxdfFwAsJFqP
         J7LdKdL2hn9vkHHti0hRBrh3ijDGeNPXOLBFSJrx1nt8qvthiVSUuVLPBg1fdRyzkGyT
         6i7ZXCFcPF2G+Ba2qNIifyrFg6Ez1rAyeVuBk4KGno9pqeHmTJJUJ9qXC82wj8V5N3r3
         mAhA==
X-Gm-Message-State: APjAAAWUKjXdQLkQIMaCiMvHYLBf0G9mPZQxqjT0LdCL2d3B2k+kC8vu
        QrmACrsgEJqQV9mR57dO4R+5/sR/DJs=
X-Google-Smtp-Source: APXvYqx+rPJ/ooH9Jua/XV91myjQeXnpN5N8fHCqvlRgAEC7Q5u+npDYhAFvnIRXPgAyHY7V+6aYaw==
X-Received: by 2002:a2e:a318:: with SMTP id l24mr48472968lje.36.1560797345231;
        Mon, 17 Jun 2019 11:49:05 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b9sm2220752ljj.92.2019.06.17.11.49.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:49:04 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id d11so7328544lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:49:03 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr6889528lfm.134.1560797343688;
 Mon, 17 Jun 2019 11:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com> <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
 <87k1dkdr9c.fsf@oldenburg2.str.redhat.com> <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
 <87a7egdqgr.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87a7egdqgr.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:48:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjF6ek4v04w2O3CuOaauDERfdyduW+h=u9uN5ja1ObLzQ@mail.gmail.com>
Message-ID: <CAHk-=wjF6ek4v04w2O3CuOaauDERfdyduW+h=u9uN5ja1ObLzQ@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:19 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > Unlike the "val[]" thing, I don't think anybody is supposed to access
> > those fields directly.
>
> Well, glibc already calls it __val =E2=80=A6

Hmm. If user space already doesn't see the "val[]" array anyway, I
guess we could just do that in the kernel too.

Looking at the glibc headers I have for fds_bits, glibc seems to do
*both* fds_bits[] and __fds_bits[] depending on __USE_XOPEN or not.

Anyway, that all implies to me that we might as well just go the truly
mindless way, and just do the double underscores and not bother with
renaming any files.

I thought people actually might care about the "val[]" name because I
find that in documentation, but since apparently it's already not
visible to user space anyway, that can't be true.

I guess that makes the original patch acceptable, and we should just
do the same thing to fds_bits..

                     Linus
