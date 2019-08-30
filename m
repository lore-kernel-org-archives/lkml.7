Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9070C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885E823427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567181034;
	bh=/TsnS01NI9Faoc6jujUnnmfQXtA8X9ZnGBg/vjnb2Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sEEqUaYgL/gB4owG7muwPxpJEW7Zi19Hx4VO/acrHKWCbKByQaG7sQnOkQd9xItWV
	 3F8Ocvc0qKnL5j3hlRrvK2XI56l6WvpoWbSx5hHSnFL+DTYVnwFmivlwkcPk2Nf1CT
	 5i5WtRsErZBYZXBNiz3LIYI9jwV3G3F8x2hAXRiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfH3QDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:03:53 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36745 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3QDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:03:53 -0400
Received: by mail-lf1-f51.google.com with SMTP id r5so5763635lfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O41u0LaDz39ALIXuHv0yabeuXt1/muoAQJYzGxbd+Vw=;
        b=ZBVoFQCN6MNrzzwJZVX2J48A0/aHFZjrkKuYNUWHmt13AKALINVRdBhChzKcPkihYN
         p0xN9WEeK9Mwf77siewx9XgBUMz9FjYVFo5vi21h8mu+gD1wWAnbZvdj/M/wUq588kHc
         GAQtzS1mnKGtj/4wDGgauqjsqXpvQ5QaojCqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O41u0LaDz39ALIXuHv0yabeuXt1/muoAQJYzGxbd+Vw=;
        b=lL0DQKBGDGzfm+0UPOAVC6hQDroE1QeUoxRLZNUMUy6jCOXj6ean9eX4LtkkWYGpIo
         FhM6qwzNpAbwd4YvchVBezJsbiZZfdyTHZ9JWA7Rzxhiso0NBfaLD4Fv0bkwzLsBGi/d
         JbHS6oI/HEhF0l8ItBAxevd+teQnrMByTRT5EDQqT9hDffgirOqcOMfqBxQSJZcycuai
         zqVHdH++S9dz2yVYPUeENjdQY9Sru5mNwizB6q+WoFOwzvwQzTeZQhXY/PPaxgKD5Xy8
         9J3hNgzdo2XTf/Iy8fD5OUpOsP3HtVAbHLF3bIuVeXQjzRoMvJ0CWfzm4wro/OWciW6q
         qikQ==
X-Gm-Message-State: APjAAAWgLnw/dKFJn8iyKIDLurAg4+cgPoHg658Iv3y5WMX/pCtR+zBS
        ILNDaisIgeV372uKeJr2wNaYWHL9q5I=
X-Google-Smtp-Source: APXvYqymMtDzmI54ztd0KqntgI+YPDClaAgEb76JmTtyT/OKOKO5qRfF7HHCBKuQVtKh6+hBrxMOVw==
X-Received: by 2002:a19:c191:: with SMTP id r139mr9858584lff.23.1567181030497;
        Fri, 30 Aug 2019 09:03:50 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id z2sm983212lfh.97.2019.08.30.09.03.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:03:49 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id g9so5772670lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:03:49 -0700 (PDT)
X-Received: by 2002:ac2:4c9b:: with SMTP id d27mr9727934lfl.29.1567181029264;
 Fri, 30 Aug 2019 09:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <CAK8P3a1CONyt0AwBr2wQXZNo5+jpwAT8T3WfXe73=j799Jnv6A@mail.gmail.com>
 <20190829232439.w3whzmci2vqtq53s@treble> <CAK8P3a0ddxbGVj974XS+PM_mSJDu=aGfTGarjmqMCuLKn81mRg@mail.gmail.com>
 <20190830151422.o4pbvjyravrz2wre@treble>
In-Reply-To: <20190830151422.o4pbvjyravrz2wre@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 09:03:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcQBYjs-bX-v4CQUaT_bh_41EzEw4PmvSjBmAxGbr3OQ@mail.gmail.com>
Message-ID: <CAHk-=wgcQBYjs-bX-v4CQUaT_bh_41EzEw4PmvSjBmAxGbr3OQ@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:14 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> What about just adding a couple of WRITE_ONCE's to sas_ss_reset()?  That
> would probably be the least disruptive option.

I think that WRITE_ONCE() with a comment about why is a good idea.

The reason I dislike WRITE_ONCE() in general is not because it's
wrong, it's because people often use it mindlessly and the rationale
for it isn't clear.

But with a comment about why, that issue obviously goes away.

            Linus
