Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E716ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54150218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqoIt1h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfJIQNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:13:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35832 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731426AbfJIQNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:13:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id p30so1720393pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c47qbrSLLIGvUFt5MXsNztJFq0VL1S5Chm3p/SDAdyg=;
        b=EqoIt1h2PDX7vbfae8AJX5+I4HC6Gk8kl3tB8yyytrR6muGw6bUAKdUrwRTTRciyOc
         5JAaJBNXH0afOQ/y1srk/nOrZYMA7SitU4EXessmNx2E2LvYGeN5YWB9E1g9VpvBi5Qg
         Heu2lsW9dReZSr+18lwS2AVry3IK5pN0cUYumY1zY7mwqxYHr9UgK7xjUBNnKH5tuCwV
         7ot7Xfz95MR9DgD80amwXFTtohgg8bfdfCs3VC5YQFZ+sMkYFrLY6gFNgJLG1fb5FbW2
         UR9kDDOg4Wlk7pTEMQYVbCJsPEoDiif+FVUVbUremIRYyZUBKrqtcDbjwYrHgj3CVNU1
         yRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c47qbrSLLIGvUFt5MXsNztJFq0VL1S5Chm3p/SDAdyg=;
        b=jERYsn1OEJnxgz5NhmsUrLfy/WiIFroZk2RaSfXo4DaZk78dUhIRNLeJ5tsF7ij1o9
         Ph6ge/VDTD50MamnV+4ayl/LlaSKGZv2r7AVrDhZNmKN4r1VzVzG+D9LxBAUDoKS0ewt
         5L+liY/kQdSlHrYO0jWoQrhqC1ab5JbHIVSh7tzKryIii0LXW8wxYsfAtUxG17ed5+iN
         pbHdqxGj71omfsjA9v6q5EjwEo1C5JVgvGq6EFC9xcc2OA3KWq7Skbra7IUfWEML4+x8
         TGniRBxwE292veHBtemg3H7LdiZlcZgw6F5s6cuIgYIWnUVEiZ9x6kyVGVtPcbZtYZSE
         9wIQ==
X-Gm-Message-State: APjAAAXOPrPwW/g94PT8qsWX6vR5guUr+7o1JGqrBp7cSek5uXcD6D/q
        2l4Ae81rLm753ezjxZ4PQHY0MpjG0En+tP5aPG1qGhi4
X-Google-Smtp-Source: APXvYqxLyT5YvYlsd+Ut7uCgK3TewVURguI1L+P+j6SbeZGD2B+eX5eQBTsw0b/K/ahpodvnAwT/Veh1PiFi/Ial8Sw=
X-Received: by 2002:a63:5a03:: with SMTP id o3mr5108717pgb.381.1570637609432;
 Wed, 09 Oct 2019 09:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de> <20191009110943.7ff3a08a@gandalf.local.home>
In-Reply-To: <20191009110943.7ff3a08a@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Oct 2019 09:13:17 -0700
Message-ID: <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 8:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 9 Oct 2019 14:14:28 +0200
> Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 9 Oct 2019 13:53:59 +0200
> >
> > Several functions return values with which useful data processing
> > should be performed. These values must not be ignored then.
> > Thus use the annotation =E2=80=9C__must_check=E2=80=9D in the shown fun=
ction declarations.
> >
> > Add also corresponding parameter names for adjusted functions.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >
>
> I'm curious. How many warnings showed up when you applied this patch?

I got zero for x86_64 and arm64 defconfig builds of linux-next with
this applied.  Hopefully that's not an argument against the more
liberal application of it?  I view __must_check as a good thing, and
encourage its application, unless someone can show that a certain
function would be useful to call without it.
--=20
Thanks,
~Nick Desaulniers
