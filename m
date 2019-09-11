Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C40C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F2220838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLaITkTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfIKVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 17:07:52 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46336 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfIKVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 17:07:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id z14so14705282vsz.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 14:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XJHMobu+BW8e+V93RysuqAgvySnrHLkRIzv4bFfI7f4=;
        b=rLaITkTegfgDMi+pB/j2GYgfbd6BDMH+O8pwlAubC6Z5n5kBe90cnyi48On+jQNA9m
         baSrbYQ59tXUdZLYPMx3QGsc/mNPgpai5FUjX2j4kJNpm01e2LBSRiiMCVycweKWx29F
         n2QZ7KQZPwv5UqS+w6i5mDg7DGJmRcULePrDjgC+78lhrCqZq6dMTxvqH1oui/kEYQPM
         reYg7Ub6C0ts0aefaw+ybSvD4KteJ5fluoZHKnSzOCzb4HXsFcDAn8swltoqO4hMwSLN
         tq+MfJQ0P8ajLboT7nYDwDWBR7DkiGnrhlLPoxQHgCIkKf6YdD/uAoJTUpoR71KYDK1a
         IFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XJHMobu+BW8e+V93RysuqAgvySnrHLkRIzv4bFfI7f4=;
        b=YosD9GHXRULmkARZ2gxkY8pScPqhah+LZFysPIwA5ESSIlsXubdggz/1XmKBScpxN7
         8dPvJNsfHQe1yR14FtAiSsiquJcWy7am0GSLo818PNJlQsYH2HthAHpxu5gYL2+x+HKR
         Sk4/fEzud1VhPyboo/pCC4aY69U+KkpYIrlKaBELTrk8IiaMjicpAYWovWpL+wrnxGXq
         fE2PlsO8wzNS4Wg2nH7ahiYwQaHhKAnL78YqY5HsGQD8ZKJJWT/QxaxtWB8lxmcgDMQB
         jKWHtZkb4Ac2aCerfk7sO4gEvoT2O1TqqtnhLD1vDeBuYhW4dUZim2J+hLFJrfFxdOqt
         Zbqg==
X-Gm-Message-State: APjAAAUBcTm3fA/V+xEzoEhUZrU4FvYnZG90HEtueD0UidZ0jfL121oE
        kk9FbJ+/oSnFmXoxsm8j9EvwiKqSymFqQtUqUzQcbw==
X-Google-Smtp-Source: APXvYqzVFDguN8esHlbARMFIHd2F5AxzYzchx7PmiukG4R+VEAGjETrh4svN9zZQtYLaAcXSG2g3v9d0ZdhTkVGhPNc=
X-Received: by 2002:a67:6d06:: with SMTP id i6mr21756050vsc.5.1568236069615;
 Wed, 11 Sep 2019 14:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190909223236.157099-1-samitolvanen@google.com>
 <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com>
 <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com>
 <87impzt4pu.fsf@toke.dk>
In-Reply-To: <87impzt4pu.fsf@toke.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 11 Sep 2019 14:07:38 -0700
Message-ID: <CABCJKufCwjXQ6a4oLjywDmxY2apUZ1yop-5+qty82bfwV-QTAA@mail.gmail.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 5:09 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:
> > I ran the "xdp_rxq_info" sample with and without Sami's patch:
>
> Thanks for doing this!

Yes, thanks for testing this Bj=C3=B6rn!

> Or (1/22998700 - 1/23923874) * 10**9 =3D=3D 1.7 nanoseconds of overhead.
>
> I guess that is not *too* bad; but it's still chipping away at
> performance; anything we could do to lower the overhead?

The check is already rather minimal, but I could move this to a static
inline function to help ensure the compiler doesn't generate an
additional function call for this. I'm also fine with gating this
behind a separate config option, but I'm not sure if that's worth it.
Any thoughts?

Sami
