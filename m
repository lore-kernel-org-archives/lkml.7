Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB57C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24632073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1ZDHCEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfLBR1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:27:50 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40812 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLBR1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:27:49 -0500
Received: by mail-pj1-f66.google.com with SMTP id s35so7879pjb.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orVQek45hbQSbuzOUHFucR+P4QAfww5RSJYpTiz6kMk=;
        b=E1ZDHCEdlSiRs2pgt0MJ9z0hc0NMboqKJ6DAxfZKh3xlL0N+t0EaKMJXUj/mUCzz2g
         GmK9qcWj11B1Z7c5zJmuLKI0cJjAFsuqBcW0d3RxcM1PJm1JRwfZEyUxJ+mmVjGyKEwh
         pQvQ+fC84S/SL0QYkOX8HPS1JX4qDJoT+pkeGWwg0fDrfS1LHqyBMFb/OCo1Qxld1CXD
         EJbeWQdrJqyq69KCpU4HwRBqXoT9roo3uRe0I2/zbVSGMZvjRRps3nrBqOJSWOQBRzqM
         dan9oMXAEn29Kbgea+qTVrDcOl0olI/gJ5STJYPmDwjsonGIt5S1RrZrGEj5kgnkUjVs
         0CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orVQek45hbQSbuzOUHFucR+P4QAfww5RSJYpTiz6kMk=;
        b=EmFPP5xqOlIR8sl4cBfxHMspIcn+mjFpvCAkjbjRYYN1u4H1xPCVEQTJ5Gn267xusC
         T1hgVeyRIGz9pu4K5+Z3qpj8tx883QzJr6iQ4/+3v9eSMFe+OwU+cU2e1jMWKql3mLEa
         QLnS5gSz8arK0G4Ptf4rpnAiogGV8joydYVNxqlK4VZJUVE8LcALPr1R1v3tMKFIXLAp
         i4M+v0eRyQ8foIa8n7f6bFttmWFnDtP9WdUdHw4jVdZfL3VREiCNBJ3fYTGrtgPQZixI
         t01zaobv6EIpIinsq9xS0XCizXMVlTDSrgzk0IE17wURrub31zWlVzXZ0fVaNSgoOX3S
         AOKA==
X-Gm-Message-State: APjAAAVxubXT/WPVcc/TjU9M2UzQREYL4Jd2v7HYGxJfvCjAQKyFD09D
        p/qpSddAqGGWCCDapfeE18Qh71LhEt02sKXUtqdhwQ==
X-Google-Smtp-Source: APXvYqzaTKvhv+BQ331cpJ2A58psUjQ8mIb0ogedjAL9QEa7CqlVb1qtoPwOztva/oBIQC9ZAversWAN2WW/C5IN2g4=
X-Received: by 2002:a17:90a:1505:: with SMTP id l5mr122297pja.73.1575307666825;
 Mon, 02 Dec 2019 09:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20191128033959.87715-1-pihsun@chromium.org> <d02f4eef9aa674cb36c1d90069a13e7bd02b7e40.camel@perches.com>
 <CANdKZ0eYSdPC2y5QxN1B7FshewXumrETQohbXrnvbovXMkSe9Q@mail.gmail.com>
In-Reply-To: <CANdKZ0eYSdPC2y5QxN1B7FshewXumrETQohbXrnvbovXMkSe9Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Dec 2019 09:27:35 -0800
Message-ID: <CAKwvOd=g36hxdU-pspCf78JhLTtxTk2dvStR3SQLhTPeCrELVQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] wireless: Use offsetof instead of custom macro.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Joe Perches <joe@perches.com>, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 8:05 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> On Thu, Nov 28, 2019 at 11:54 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Thu, 2019-11-28 at 11:39 +0800, Pi-Hsun Shih wrote:
> > > Use offsetof to calculate offset of a field to take advantage of
> > > compiler built-in version when possible, and avoid UBSAN warning when
> > > compiling with Clang:
> > []
> > > diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
> > []
> > > @@ -1090,8 +1090,7 @@ struct iw_event {
> > >  /* iw_point events are special. First, the payload (extra data) come at
> > >   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
> > >   * we omit the pointer, so start at an offset. */
> > > -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> > > -                       (char *) NULL)
> > > +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
> > >  #define IW_EV_POINT_LEN      (IW_EV_LCP_LEN + sizeof(struct iw_point) - \
> > >                        IW_EV_POINT_OFF)
> >
> > This is uapi.  Is offsetof guaranteed to be available?
>
> offsetof is already used in other uapi headers
> (include/uapi/linux/fuse.h FUSE_NAME_OFFSET).
>
> Also offsetof is also defined back in C89 standard (in stddef.h), so
> it should be widely available and should be fine to use here?
> (Should I add a #ifndef __KERNEL__ #include <stddef.h> to the file?)

Yes, please, otherwise userspace could have a
-Wimplicit-function-definition warning from including this header,
since it would look like a function call to a previously undeclared
function.

Actually, it looks like include/uapi/linux/posix_types.h includes it
unconditionally, and many other headers under include/uapi/ include
include/uapi/linux/posix_types.h (unconditionally).  So it may be ok
to just include stddef.h unconditionally, but please do so in addition
to the current diff you have.

-- 
Thanks,
~Nick Desaulniers
