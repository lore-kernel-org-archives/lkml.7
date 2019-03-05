Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD40C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7B520645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551809052;
	bh=/e1FWiCwVpNa00uGp3EbK+9wwgBnzB9f36LM/haavOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NmQh5ocYP6pG2OaOVnXlN6dZchrnVVWh89eDc0fufm+7dt6hFvzUf2cR9O2xkFusl
	 H6PVUrvKNKp2z7Yl5Mlu88RGlq7vW/tpGUYwNY2Ju1Cm5C2xf3UuuS7p6oKEetqAQQ
	 we2TtpbTHwbIaFiW2WkoqcqcgJ3/TcEqPrvJ59o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfCESEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:04:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45723 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfCESEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:04:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id d24so8400413ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 10:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgVrRSJyivwjBkz7OzuCK9JYX2LpyV5wEUswZ9wQbf4=;
        b=Spxd+IMH+o0dtSiNYLKNnd2MPe7tEJvbDpTvKk5jm4s39TZbfJ3mFG6tAOXAgUOfC1
         qdLT7E8UKNADWl2e9+sp3NcJu0iyHiG4jR9KQtPIiVk7sU5m+W63HHZbsKway2VS53v1
         wIwSlH4sPyFi8plJDGJ7yPgKnrmMtAbXcN6dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgVrRSJyivwjBkz7OzuCK9JYX2LpyV5wEUswZ9wQbf4=;
        b=PsJFIa4jejr1Pjb26COjZ/snBEVZ0VAR1fmT6HgV7mfPrgMAGK2Xfp/IGza9YOoQ6O
         HEWrmJ1CaXOWBWjRdyWI/1NKhzVXC4U0oyumrJHCvlEY7Nw+ajjRT+Hh6U9o3KfKLG03
         cq0L61c6SJuwFjJYfb8Mgv/Wrz47rpq6dpXWanzGCOaeQAFPkH0QaJzg+Svxe9XMFZjJ
         RB2uSGmMwfoHWkqD7Atr6DXO0dolWFDenBapSAu52H6lhGHPMI5UDuoFwafsK+YaDdEz
         MDnrMs41Oee/2HYPNPAsjWhYDTHYBzfzLiFh+/r5iRy7fEhiDMHlEI6zKJScSiZDx74X
         gIag==
X-Gm-Message-State: APjAAAVKlUk0rbBOmwuTZv+VYE5lJbCpHaT3lSHV2n1Pg6+2/+XwNMgD
        YeiTaXCZvgg2Q8ZoZHtZ8tQUaxe9Gn8=
X-Google-Smtp-Source: APXvYqw4rGUqqEbX1lsP3AnP1X2rJqvACUv150mwRUB4ltRvwB/imZVsj41vRdbw6DxkAfvMMcSn/Q==
X-Received: by 2002:a2e:964b:: with SMTP id z11mr13207585ljh.138.1551809048355;
        Tue, 05 Mar 2019 10:04:08 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u18sm2236059lfd.15.2019.03.05.10.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 10:04:08 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id z196so6853925lff.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 10:04:07 -0800 (PST)
X-Received: by 2002:ac2:5088:: with SMTP id f8mr1455651lfm.11.1551808724311;
 Tue, 05 Mar 2019 09:58:44 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com> <20190305173134.GE8256@zn.tnic>
In-Reply-To: <20190305173134.GE8256@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Mar 2019 09:58:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
Message-ID: <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 9:31 AM Borislav Petkov <bp@alien8.de> wrote:
>
> So how do you wanna handle this?
>
> I guess the easiest would be if you apply your patch directly now and
> add the a.out phase-out strategy we're going for in its commit message
> so that people are aware of what we're doing.

Yup, I'll just do that. I'll fix up my patch to be more complete (ie
the a.out-core.h removal Jann pointed out).

I'll talk about removing a.out support entirely in the commit message.
I'd be ok for that to be a total removal, but maybe there are some
architectures that still have that as a "main" format?

Or I could just apply your patch after removing the core-dumping. Comments?

               Linus
