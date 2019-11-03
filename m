Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADADACA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 21:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFF1214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 21:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJVC1+hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfKCV5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 16:57:02 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36511 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfKCV5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 16:57:02 -0500
Received: by mail-il1-f193.google.com with SMTP id s75so13119584ilc.3;
        Sun, 03 Nov 2019 13:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DNkf4uxqo0YQIdE8Us9jbPgA9TmH/+Jl2gT1g76SXFs=;
        b=mJVC1+hx9OfnC/aY+y/U84n6SkDy4TVyo1BCEKWzcDune0oiuQM0zlLDAIkI/BnOza
         9XGq2pJZa0LG1LUwBU8ta16gM66VPLZAp2RT7e0X0tSMsw90DgYhLrpUktoHRLK1rMuo
         UWtGv+pftbJe8cItRQeG7zLZaXZg+GMbI6EXcp72tLTIaHy0zeClzp1DsgTLOJuyoVQz
         Lb553PjJ8M00rjujhWsQYn3Bp+4N60qMG2VFa+X7UnOeb/kUWAfQ5uDkZ9sJFMc8JfaD
         HmSIUNv/mc9XHllbBGlOo9IQBVsCgk/HcstSuRrkIpQmpbDDEfgrv5mXny3AQ7/0IMv8
         w7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DNkf4uxqo0YQIdE8Us9jbPgA9TmH/+Jl2gT1g76SXFs=;
        b=F7yJGkAx/A5X8/QcL21S2fLUNZdN0vR1wcOHTWMqbQ+vjk0EJL6/EaiOy1YZjWaVPs
         EcdThE0PNEBg5ISMtwkgU+o4y5v54HDRaTF8CVsxI4tIomR8mAGdseRndtQEy/kED9yg
         duIO4riy9vPFwo1ZsYotT07BqiQiDa2OKeRpcsm5OeuMcbbVDFlwdZl3w2OtlCh1pn3A
         7pHtJwBzdJOp/UmMrFj0Z7365WhgsBkjEKTObIzy/sf88YCWx6BBLpXXRuYwoe5+WlqA
         4vN+rlYG/NlBA3djTf9fMZXw3ryaGW3UgsEob4KG8hWBIgZ5d6r0Gd7W3G2I4xM1rSN1
         JbpA==
X-Gm-Message-State: APjAAAW3xvPhm5Qf8FaO/uEH0HFEn6cxK5YC4djVpMiuJDxdi0GBx1SY
        fEipuxTSon9f4BAG6Sg9blI2viiTDcAx79yUD7A=
X-Google-Smtp-Source: APXvYqxFEUs5q6rDDn+KpjfFYkGGkD9k/RLi+ABL/YNSDIkVQ0Ea79lSHULlCKlbzjrgHSUJ0Mo1HR8EfsI9vZX7Rrw=
X-Received: by 2002:a92:d7c6:: with SMTP id g6mr22955596ilq.298.1572818221558;
 Sun, 03 Nov 2019 13:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20190620062246.2665-1-e5ten.arch@gmail.com> <20191029210250.17007-1-e5ten.arch@gmail.com>
 <CBCA4048-A9C1-42E6-A821-1EE36AE8CDC7@zytor.com>
In-Reply-To: <CBCA4048-A9C1-42E6-A821-1EE36AE8CDC7@zytor.com>
From:   Ethan Sommer <e5ten.arch@gmail.com>
Date:   Sun, 3 Nov 2019 16:56:50 -0500
Message-ID: <CAMEGPioV_MTKO9DK6JT5355b7x0py-D_K467etDDnxWSYAbEig@mail.gmail.com>
Subject: Re: [PATCH v3] replace timeconst bc script with an sh script
To:     "H . Peter Anvin" <hpa@zytor.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please let me point out, again, that bc *is* part of the basic POSIX tool=
set, and the only tool in that toolset that allows for arbitrary-precision =
arithmetic. That being said, GNU as, which we also depends on, also contain=
s bigint arithmetic, so it might be possible to coax as into outputting ASC=
II output without manually implementing bigints manually.
>
> Another option would be to use a C program linked with gmp. Binutils requ=
ires gmp, so it doesn't inherently add dependencies, but running it though =
as would probably be easier at least for the LLVM guys.
>
> I also have written a small, portable C bigint library, but that is a lot=
 of code to add to the tree.
I don't know what the requirement is for the level of precision this
would need to support is, so I don't know if this meets them, but I made
a C program that doesn't use gmp, so while it probably doesn't
theoretically have the same level of precision as bc, it does match it
for output on anything up to 15000 (it doesn't stop matching
timeconst.bc above 15000 I just didn't test any higher). The program is
here: http://ix.io/20Ka
If this is considered precise enough to be an acceptable replacement
I will make a new patch to use it in place of timeconst.bc.
