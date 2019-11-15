Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFBDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58BD20732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+L1dD7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKOSjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:39:45 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41010 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:39:45 -0500
Received: by mail-ua1-f66.google.com with SMTP id o9so3302987uat.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bV2myfTUpz0CRJJzgk898nsegVBK706DjRFlK59PguM=;
        b=m+L1dD7DHAoqoFPkWS4f+BNnvPYPE9XHcSqCYVyMx0c+a1MWv5B2TY/7T8BOZaL1s5
         +vIAKqP3eSwDZBkR4whM1COVoYPLhTboSVtYVavsvQHhcE3BCGy6WMEFEC2fDWVd70HE
         OFhXVx+1nd2oVHFa8C8xsrP9VnVxvO7aylKw54njPk1dKNiijEDK7NV7wqfjKMFg7PSP
         wnHOBwfkZawEWSViQKsQGbRBc0CbbEtPJXGQfd1l6MWgTGTqXZs914IDyyTM0R82ejR9
         KLdZ0Id83YIX04xikE1J6N90jB2iz9ac5sHcI4A8QECIGGeB+xAcz7dLqsMLxn4rNsEZ
         K6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV2myfTUpz0CRJJzgk898nsegVBK706DjRFlK59PguM=;
        b=KaDZ9OeaFbwNhVAnX8rfEJvCC+Haz1ESRYjl5XZEMNI9QV40E1kbZO6V2Vfec2lo+n
         EHkL5ZevSeCD+eHRD2DnjQHWfA2loTZq+GB9W2wI1WJQQy+T2JYXiSLaqJVfd6m8JUfR
         4hpmhWgt9hIGvsR2rKTgZV/ESx+f+bG0wRnP5QMDLlysHbBKi3FJnh1KBkcjjqcS6bF1
         NXzp70mdv7WWO16Ncb7zulLqOpP+8yGqthu6j6nrScqh4c628IKutbtHEWGh2SGJgZmm
         UaSrXpvdyFCCENeC4ZofaZWje1xpD1rPqIDsgKu9Hr8yt5lK6LVi+ad7fGHZkjcP6Yts
         8qCw==
X-Gm-Message-State: APjAAAWk4Avrt5PIoFwe4FyvVTaQotqFF9aTdl1KgZGdpuj+TQsL8mhm
        pUW8jflXFJADEelINkKa5FDWB9bf3ly3+QsnU5A=
X-Google-Smtp-Source: APXvYqz/+B5/7vOeF44jPGMtbH299xhEPCR27z4T3xxKJV5F6OEavJ0VioPYov6QfZkmxnjSucv5N4F/ROowt8aFNmI=
X-Received: by 2002:a9f:3c2c:: with SMTP id u44mr10152334uah.2.1573843183656;
 Fri, 15 Nov 2019 10:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20191114142707.1608679-1-areber@redhat.com> <20191114142707.1608679-2-areber@redhat.com>
 <20191114183421.GA171963@gmail.com> <20191115151420.GC20767@dcbz.redhat.com>
In-Reply-To: <20191115151420.GC20767@dcbz.redhat.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 15 Nov 2019 10:39:32 -0800
Message-ID: <CANaxB-wWfXmFaFD7GuXe6GaOnEQhTCS-7cPa24L00dxux5YtOQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] selftests: add tests for clone3() with *set_tid
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 7:14 AM Adrian Reber <areber@redhat.com> wrote:
>
> On Thu, Nov 14, 2019 at 10:34:21AM -0800, Andrei Vagin wrote:
>
> > > +   snprintf(proc_path, sizeof(proc_path), "/proc/%d/status", pid);
> > > +   f = fopen(proc_path, "r");
> > > +   if (f == NULL)
> > > +           ksft_exit_fail_msg(
> > > +                   "%s - Could not open %s\n",
> > > +                   strerror(errno), proc_path);
>
> If the child does not exist anymore, the test will fail here and exit.
>
> Besides this while() I tried to address all your comments in v11. Any
> further comments on the test?

No, I don't have any other comments.

Thanks,
Andrei
