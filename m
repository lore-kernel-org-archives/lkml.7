Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA64420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddyaBuXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfCDKto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:49:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41898 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfCDKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:49:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25so3897397ljk.8;
        Mon, 04 Mar 2019 02:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sG432yYj+fXh4CV3/rA9GM8c4ecdVV/QZAXmBtg6vfA=;
        b=ddyaBuXhIyY+M+4buRavN1fdObCs2Ol04TtkHx3IZsJ5kmE/7GOnF0i4QuNwaxccCV
         0No2F07f9jGX8ErYMIaMHQwSrk27ygdHENT1+NHEBMG//xZvGrVHcw3xOGESMAok0YHW
         cl03foYBhZAluZADKwwcZltAQnyqjh7EAT8ziKWAkjlWwhW0XgAjFKyNihVMMwi3gscQ
         Cx5zvITkdjNgRUk6F5AGiwPAwZWgMn69Z+wa4UsRoulTkB2F5T4/g+MkxN8iyHS3uRtz
         j2Nifh3dfsTka9EXWnlFAseoVFXl45qjRUlRmPRBNcJprjab8Bh/TNNTgq4j6tZR/l6T
         IlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sG432yYj+fXh4CV3/rA9GM8c4ecdVV/QZAXmBtg6vfA=;
        b=Dye3ksFD/tFXexf75k40bHyragUOWydeRMQQIaoLWkC0H8FW/+t64fTHwiLaM8Q9yk
         ZBrv7AcgO2Ly52jCtif9QdsB8PzZo4LvhpMLfWkVrFahdhLu5uhdbKC5eri+iI1UHSp3
         e46kKfNG1qzrAcnx8ytxOCDJPkdMJ9j2xr7omc/ygdBDGDbnft1UDdN5CGAcsA+2EazB
         TQGCbF0Waf6C3um+7HHQyGySJ2FIciEqBHBJ9QzObfY98CK7MeGKuTEkSNgUaG1S6P8j
         1ccS0qkSIoSbrh+izTy/EkEbjyDcliUn7LrusELcVtsv/0wyWC25cHUhDwaD60/dQ4Za
         dWcg==
X-Gm-Message-State: APjAAAW71CzQ50GQnY8gM2V35JYyxkXODWynw6i4utqiKnZHxsnATiQj
        aImKUrDiVRQNcL+4KyB0w9vengMxMLZNFS17Crg=
X-Google-Smtp-Source: APXvYqxBRntn7UDJWJZcWZ53z9J/iW4X+tuUOMzU5b4HtgA59u0hIcapCXpdEhIOToQqUWMABL+xcmcRq3t072n+ayQ=
X-Received: by 2002:a2e:54f:: with SMTP id 76mr10386125ljf.20.1551696580783;
 Mon, 04 Mar 2019 02:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
 <87tvgr1fr4.fsf@concordia.ellerman.id.au> <CAFqt6zY0HV7E+_6_s5A3eG+jEj+4hgQnAgJQm-Pc1gyX4Vnbpg@mail.gmail.com>
In-Reply-To: <CAFqt6zY0HV7E+_6_s5A3eG+jEj+4hgQnAgJQm-Pc1gyX4Vnbpg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 4 Mar 2019 16:19:29 +0530
Message-ID: <CAFqt6zYqa6aCAcs51AdePtBSL58hMa1BSA87ZMLbwUJA=rWNLA@mail.gmail.com>
Subject: Re: [PATCH] tools: testing: selftests: Remove duplicate headers
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Bamvor Zhang <bamv2005@gmail.com>, shuah@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.ibm.com>, boqun.feng@gmail.com,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, sboyd@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:59 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 7:18 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Souptick Joarder <jrdr.linux@gmail.com> writes:
> > > Remove duplicate headers which are included twice.
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > ---
> > ...
> > >  tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
> >
> > I took this hunk via the powerpc tree.
>
> How about taking this entirely through a single tree ?
> or Shall I send these changes in different patches ?

If no comment, can we get this patch in queue for 5.1 ?

>
> >
> > > diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > index 167135b..af1b802 100644
> > > --- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > +++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > @@ -11,7 +11,6 @@
> > >  #include <sys/wait.h>
> > >  #include <unistd.h>
> > >  #include <setjmp.h>
> > > -#include <signal.h>
> > >
> > >  #include "ebb.h"
> >
> >
> > cheers
