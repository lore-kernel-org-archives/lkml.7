Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9E3C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB35207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCYP3ZkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfFDRCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:02:12 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:38439 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfFDRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:02:11 -0400
Received: by mail-lf1-f51.google.com with SMTP id b11so17010859lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXMpeJuEOdKOx/HQKDVkHmCBlz8jhse9a4h820958SA=;
        b=kCYP3ZkPc2TvMg2Wi6ykhEAq4aOHidw2VC3+oseBzc57ug/iY8JEtSMAXw6A6MUtF1
         S9yL/tH/xkUNlN3qJW4dF10MPEQnzpcwNq7tvbstlGF03df00RR1u0SOhWMo+8mu6Aro
         fwkZkPVtKFpCmx/STkQFd0upVUm2ETInWkqTgH+hEAGeH2C72eInDqu1Ky2MX/QdjMjF
         dsqpTezlmEfIEMQO3UtEtcObUWMcTUp4e3piA1yK6iYuemvPhS+Ge3PGBVDG0ecFXmb9
         c9JZwoRR02YUqGoN/2rOvmNEDw35p5/PZsL4p7Zo5PkE1hPFiUQsIlX3me9epNMjMa7d
         nmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXMpeJuEOdKOx/HQKDVkHmCBlz8jhse9a4h820958SA=;
        b=DecN7swQ6/zw870b/ZNhg079plA96koh2jIzc6agxWNYow4SPyJmBxkn4HwqWoHzsU
         AaVDHZ4XyoYe8afEaIlEj6aJl/OoOgaReA4hMRMg2G/+E40MvVxNFUL49ibt/QGQO/3q
         7MJmGhvpcnidiIyI7fU5YPfP7zzD+27pAX0jPy94trmAq6Me2ZVK5g40aCPgL+Bph6d1
         hOvFBLLopkd9xYHI5ZUO/YTvc8Ao5QzAI1xpSMM6+x4qEeNY8YWbIAvWyB5feSxBAcy8
         idHPhaw/2u30bap+ucKkGm32yJbyyTwDVXqPJ8b0QvZXlri7JVcqEANL2b+cxBkXDFym
         g6MA==
X-Gm-Message-State: APjAAAV6fAFSb8Dtj69UcBFI3LZRt6T1u10hCRcSErLFvjVtu5GPAg2i
        ButEZFbIYudHc+PAQOngeIvbGII2UAzYzF7YOIC6kA==
X-Google-Smtp-Source: APXvYqx3T5pRH32no890qB33wNihmq1VvYcMK9pbP5hOQJiKRjsEJv6pyoSP9K1gnMzp+pf+T7PWymXwtX8g7raiNnY=
X-Received: by 2002:a05:6512:30a:: with SMTP id t10mr1839716lfp.22.1559667729967;
 Tue, 04 Jun 2019 10:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <73fac64c-fe49-4738-49a4-0afe668eed94@canonical.com>
 <201905310740.522B3A7C1@keescook> <c80362bd-1dec-3e4f-c3e8-1c58d3a33070@canonical.com>
 <CANRnR9Q4AY1nyTebWgkVM-wUfZv7kKNLnsrchWPBH4HPbB-X6Q@mail.gmail.com> <201905311330.EA6B6E5F@keescook>
In-Reply-To: <201905311330.EA6B6E5F@keescook>
From:   Ke Wu <mikewu@google.com>
Date:   Tue, 4 Jun 2019 10:01:58 -0700
Message-ID: <CANRnR9R5mhMRMfTUkU5i_GhGwEiXmhhHBN2E6bo+N5KtBUVecQ@mail.gmail.com>
Subject: Re: security/loadpin: Allow to exclude specific file types
To:     Kees Cook <keescook@chromium.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent out a new patch according to your last suggestion. Please take
a look. Thanks!


On Fri, May 31, 2019 at 1:33 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 31, 2019 at 11:03:17AM -0700, Ke Wu wrote:
> > I think Coverity is correct. Note that it's the size of
> > kernel_read_file_str (rather than exclude_read_files) doesn't equal to
> > ignore_read_file_id.
> >
> > This is because READING_MAX_ID is also an element in
> > kernel_read_file_str, which makes the size of kernel_read_file_str to
> > be READING_MAX_ID+1. I will send a new patch to fix the issue. Thanks
> > for the  analysis!
>
> Ah! Yes, I see now. I was looking at the wrong things. It should be
> possible to just do:
>
> > > >> 209                for (j = 0; j < ARRAY_SIZE(kernel_read_file_str); j++) {
>
> for (j = 0; j < ARRAY_SIZE(ignore_read_file_id); j++)
>
> and add a
>
> BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) < ARRAY_SIZE(ignore_read_file_id))
>
> for future robustness checking.
>
> Thanks for looking at this more closely!
>
> -Kees
>
> > > >> 210                        if (strcmp(cur, kernel_read_file_str[j]) == 0) {
> > > >> 211                                pr_info("excluding: %s\n",
> > > >> 212                                        kernel_read_file_str[j]);
> > > >>
> > > >> CID 81977 (#1 of 1): Out-of-bounds write
> > > >> overrun-local: Overrunning array ignore_read_file_id of 8 4-byte
> > > >> elements at element index 8 (byte offset 35) using index j (which
> > > >> evaluates to 8).
> > > >>
> > > >> 213                                ignore_read_file_id[j] = 1;
> > > >>
> > > >> According to Coverity ignore_read_file_id is an array of 8 integers.
> > > >> However, ARRAY_SIZE(kernel_read_file_str) is 9, so we have an out of
> > > >> bounds write on ignore_read_file[j] when j is 8.
> > > >
> > > > What am I missing? This doesn't fail the build:
> > > >
> > > > +       BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
> > > > +                    ARRAY_SIZE(ignore_read_file_id));
> > > >
> > > > They have the same number of elements.
> > > >
> > >
> > > Yep, that's very true. I'll discuss this with Coverity as this seems
> > > like a weird false positive.
> > >
> > > Apologies for the noise.
> > >
> > > Colin
> >
> >
> >
> > --
> > Ke Wu | Software Engineer | mikewu@google.com | Google Inc.
>
> --
> Kees Cook



-- 
Ke Wu | Software Engineer | mikewu@google.com | Google Inc.
