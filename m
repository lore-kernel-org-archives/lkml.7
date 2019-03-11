Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA32EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9CA2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552331430;
	bh=EVWbQ0FLYyrCJYZDNZlHxygXu4O2tBnBySx/wI6Yciw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OrsXjL1u3wAfmsbGahUcnFYp8mICvrcvOOm+z0cYzmghPSNm5vflr9NqGxBaB9rdZ
	 pegIY95jNx+TUy4975S0ENswSMYGxVgKRdnJtDR7GiD+VGUz2dzgie0ZkyG3GEqEyM
	 7cdSp1iqctoT9cAUId5SQW5JMXubmM3Y4CjLK0DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfCKTK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:10:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44104 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfCKTK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:10:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id u9so113639lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aPksBs5gmVWSAtQBhdxf/7+kKKa60fGxFB1/+DhE2AQ=;
        b=Kc1ld9FxqH/Ed0XvvvnE0Y0vZYjRwQfgjTvHHYtdBVU5MHvQpzZAW/DccGNCX6kSqo
         JJdbKDRrnnf8ajFkkLwnL36D4j1fdUwRVX7xwxUzn93jAaYjIY3YWFk+PCMvgHQaADgA
         Jk25ujdwaDWfDowZGtVB2nypw19/ibH2N2vi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aPksBs5gmVWSAtQBhdxf/7+kKKa60fGxFB1/+DhE2AQ=;
        b=EaNJqzvqUAtaIppaJpZLeGF7am47AWA+T4skqADMgMc7p/VScpJAQVYyZ4ECq+1eKJ
         RAtI6AH6wps8HRpaa84NH4/EzN62TQLeQ+sLzvGno7Fyn03OptF5U7jcMGDry6KiqO+Q
         I2Kc8Z1l66rrBYAoFtBD3tb2d6GbnVU6DjGEBukCqqRhrE1LFy5QyG8Qo7ZFoTttxqDr
         d7WwcuCWl3gBMUXQcI6CmcdJdsDO805qJO9FumhzVrlcbxn+b5ZRH4yQnI2v7KPra4pM
         ZGGC/SdvZJXA0Dd9oYwdI9hkIlo2F2XfOfdhPV1w89y7fz/Mv+Tzy/n3H4PMBKvrwQ8B
         xJog==
X-Gm-Message-State: APjAAAU2OJhMHK4DCrdMx+1Nbn+OMeoQ4jS38WOOZ+i+hNCyeAH3tfM4
        VFy0/FiawXuQfCF6DszZWmxNw9LjQrY=
X-Google-Smtp-Source: APXvYqynymsgedtCV4S0Dkfhz7sBnrFFWd8EgOipnyEXbPbGzhGC1oxG6IfyQMGrFybZNW8VXwR7GA==
X-Received: by 2002:ac2:55ab:: with SMTP id y11mr7218459lfg.55.1552331424104;
        Mon, 11 Mar 2019 12:10:24 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z88sm1060207ljb.10.2019.03.11.12.10.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 12:10:23 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u9so113593lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:10:23 -0700 (PDT)
X-Received: by 2002:ac2:548f:: with SMTP id t15mr3783375lfk.166.1552331014305;
 Mon, 11 Mar 2019 12:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
 <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
 <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com>
 <yw1xa7i14btw.fsf@mansr.com> <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
 <yw1x5zsp473a.fsf@mansr.com>
In-Reply-To: <yw1x5zsp473a.fsf@mansr.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 12:03:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU7xacTqDfm-x29-meyJWNd_X95K0T8FQMcDgy-yo3Qw@mail.gmail.com>
Message-ID: <CAHk-=wiU7xacTqDfm-x29-meyJWNd_X95K0T8FQMcDgy-yo3Qw@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Matt Turner <mattst88@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
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
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 11:08 AM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> w=
rote:
>
> The latest version I have is 5.1, and that uses ECOFF.

ECOFF _is_ a.out as far as Linux is concerned.

So Linux basically treats ECOFF as "regular a.out with just some
header extensions".

We don't have any specific support for ECOFF.

I _think_. Again, it's been years and years.

               Linus
