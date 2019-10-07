Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE3BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E89120835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570478696;
	bh=/NQfyEbJqsZLbScfLTDqisYqi6KGJKeTtUYUHVeNRgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hOvzYSCvVBKxkqAgVWaks3VKE7785TS27DDTnxBeuklEycI2bGq9j8/KoFGw6B8M5
	 Jlnrt1HruPU5XKllaIe5J8wKF6oEoDxJ0wtD+6LVABUwjsPZA6rcKl9kmLBHpQ2xpy
	 LhJFfSdDb+z74/nbm2wy9Uxs0DFKM1LW1HEbv9oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJGUEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:04:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36078 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:04:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so15074051ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GePA4mA7sQIEG3MZZwlVQLPV66eifOkmE3PgU1n0qK0=;
        b=OzoZMg8bsThH/7YIIYERa+GnGEoGVQOmOpZZdz6Wwt94Bq5dPr5CAjoh6XGWzyvJ5e
         50FMWPp8sPelV93ADS+wQ5tvxWRniBO0qj+eWq+cQy18boRXEd0PKM1UgyHKVhaZQarY
         zh5t4iLJHEVqOHZA4vr+iys3VqD6HhTC6RMqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GePA4mA7sQIEG3MZZwlVQLPV66eifOkmE3PgU1n0qK0=;
        b=UJat8b7sVYJ4rdWye2JagAQ8Q5789Ni1Z2CbTfm0BmjIW7UCxvfI8GrfoWjJHI+jUf
         QxKlKcctynlASp0PxnQgG5P+oIyXWPUUsdYQyHhwil7jCuFH+YKIMx2nmX54XhTYdktn
         C7AAY2IhKWszWFbHiGkhFZHvTRF7SGGMHOnqbxDARSrjXjl3bNuo6etPd0yPlls5ZLAn
         6RGFJYvZ8K3LZVAl9PtxBRXqkhFhYX4YsiUKtsQZQ/Lboo/N4hA8fXEGhS4mESMV6PKi
         gvBYkJEBAg+qmylGxS3Edd4IIBEeWqht9IceJx0tt3VMolR8Ks7Kj7KWAKGj7vY3P1S/
         2eCQ==
X-Gm-Message-State: APjAAAVOf3HydAlM/uESE0zQPQ3gDx4OTH2gEl1oymujLn37m1hXcb0L
        5gq6U1v0Na1MGtFie6iyRKYu4TiAc9w=
X-Google-Smtp-Source: APXvYqy0iNqPk3jt9JJkGG+A+J2jahmHDcE8hniesPzo6TZxeyIW+icIqxBehE43AIrhnMCPubqCSg==
X-Received: by 2002:a2e:7c09:: with SMTP id x9mr20487542ljc.87.1570478692418;
        Mon, 07 Oct 2019 13:04:52 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id z14sm3313066ljz.10.2019.10.07.13.04.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:04:51 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id t8so10133005lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:04:51 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr17645967lfh.29.1570478690784;
 Mon, 07 Oct 2019 13:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <CA+8MBb+VKk0aQZaJ+tMbFV7+s37HrQ6pzy4sHDAA3yqS-3nVwA@mail.gmail.com>
 <CAHk-=wi3P2NvBNocyNFTAb-G08P0ASVihMVKmiw__oNU4V2M5g@mail.gmail.com> <CA+8MBb+Vubsx3Qyav25tgUgiGbs1XmEwoaCXTM=8jk4m2CxRbw@mail.gmail.com>
In-Reply-To: <CA+8MBb+Vubsx3Qyav25tgUgiGbs1XmEwoaCXTM=8jk4m2CxRbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 13:04:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFQNxO+JgA808pCMO333N5PkxrwU4kCntiPxqZKuxgQA@mail.gmail.com>
Message-ID: <CAHk-=wjFQNxO+JgA808pCMO333N5PkxrwU4kCntiPxqZKuxgQA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:49 PM Tony Luck <tony.luck@gmail.com> wrote:
>
> If PSR.ac is set, we trap. If it isn't set, then model specific
> (though all implementations will
> trap for an unaligned access that crosses a 4K boundary).

Ok. At that point, setting AC unconditionally is the better model just
to get test coverage for "it will trap occasionally anyway".

Odd "almost-but-not-quite x86" both in naming and in behavior (AC was
a no-op in kernel-mode until SMAP).

> Your patch does make all the messages go away.
>
> Tested-by: Tony Luck <tony.luck@intel.com>

Ok, I'll commit it, and we'll see what Al can come up with that might
be a bigger cleanup.

             Linus
