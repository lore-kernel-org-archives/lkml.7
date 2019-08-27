Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE26EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96CD21883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566928022;
	bh=KW4wkBtQ7sC2bdNHxFcx8NN8mz4KA55BBudFAOlxo78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KbTSRlDNRo3jJ5uyI7UsZ64VXWVbGyBzkcp/R7Dlt9JbfWuJCnbCdba6LiTBwNYPD
	 M+TWB7cc3NIGtsYrumeb/5k8cyNhBKSY7fr1vFsuTLO7K7gpehTO8NpLhv4SWAqGSC
	 ZIEPR2wDAbDK/pflgZi6LyvfWn2SaBx/QKB5ISDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfH0RrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:47:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33921 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:47:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so90455ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csGO6rReLM1hU0UOFnxStmKvrFXOnJUlxRrEakaCEVU=;
        b=eKX3lG1dbvgvEwsRu7rFLd4KLUPNlxQFAnCHUYhdDzrDbj6nMS6Omjsg8ib8/HjdH1
         ZX28LSB+QxleZnpuQV1BCMVBdP+Q6Y9aSPZluIXHKfA/IssK2NQSEJrBeKEw/tzDUm4P
         Nt8C7KEQ/3KjKGA2KQsE75z8KnKWPwyo8eirs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csGO6rReLM1hU0UOFnxStmKvrFXOnJUlxRrEakaCEVU=;
        b=LgunFN5OO/T53mCuwSCaXGLcNPE7x6uF4OCZKBXpwUHoMTw6vHCLRQ4NOSLaSJXr3Z
         6lUaV/enJIDUvBR8EGmOb1IUU+Mo60IgecsIqO+FQxXF2Z/ZTz8kgFE3Db7dP1jq6Wx9
         p68ucAUrUySvLvzHslb7Ek/Of/UHW4VRbmV+4GX+kzsiKXbO7q/hdzfuUbjLkEYXvEjV
         HaO4qYMV71zu1ftUdlNTcIRBZNOqoFQvciQLy15NM11avh+5TY9tC4njUSdJ74hrKUGm
         C+v+SPAGp/K4wIFdSgPqFqbu0eTs7xb7fX7Cm21niX4aW8G0q9N8we9iSut6u0W5c/ld
         InnA==
X-Gm-Message-State: APjAAAX7LQM7RVlE605IUqv3jpIh4G5UEO/Dw4Kji6tLujX1hS0ChZSZ
        Ii0iPkdcNmKvLSDjFQfLVxaw6I7uSg0=
X-Google-Smtp-Source: APXvYqwKti8dFuPY/Y2Qbm5PwrY08EcSlonIebrTE9hUNpzFUw9+SDwxZ6ihFsnc9wHvHAVV4varvQ==
X-Received: by 2002:a2e:b174:: with SMTP id a20mr3294578ljm.108.1566928019028;
        Tue, 27 Aug 2019 10:46:59 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id e62sm2608591ljf.82.2019.08.27.10.46.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 10:46:58 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e27so58768ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 10:46:58 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr14483815lji.52.1566928017806;
 Tue, 27 Aug 2019 10:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic> <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic> <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
 <20190825194912.GF20639@zn.tnic> <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
 <20190825201723.GG20639@zn.tnic> <20190826125342.GC28610@zn.tnic>
 <CAHk-=wj_E58JskechbJyWwpzu5rwKFHEABr4dCZjS+JBvv67Uw@mail.gmail.com> <20190827173955.GI29752@zn.tnic>
In-Reply-To: <20190827173955.GI29752@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Aug 2019 10:46:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+w5+dicacZhtUG94r4ee5zEMM4FngC8dq1bB2X+V5Xg@mail.gmail.com>
Message-ID: <CAHk-=wj+w5+dicacZhtUG94r4ee5zEMM4FngC8dq1bB2X+V5Xg@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
To:     Borislav Petkov <bp@suse.de>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:40 AM Borislav Petkov <bp@suse.de> wrote:
>
> Do you want it this weekend, after some smoke testing on boxes or should
> I leave it a couple of weeks in tip until the merge window opens, and
> then queue it for 5.4 for longer exposure in linux-next?

No hurry, and I don't care deeply when this goes in. It looks safe and
harmless, so any time as far as I'm concerned - whatever is most
convenient for people.

This is more of a "let's protect against any future issues" than
anything critical right now.

And I suspect it just means that next time somebody screws up rdrand,
they'll screw it up to be a simple counter instead of just returning
all-ones, and we'll miss it anyway ;)

              Linus
