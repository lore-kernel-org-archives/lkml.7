Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FD9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D90520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAshJijk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfCFSCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:02:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44742 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCFSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:02:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id u9so5493728lfe.11;
        Wed, 06 Mar 2019 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NlTnV1RuRzxavxPyEzKIvYJ+VeCVW6++rTPCnXKsCM=;
        b=HAshJijk36tRtXm9Ks//VLNIk4cZ58Xyu44Tm5mtYSIBKnp3XuHPmADtVTi+4RG7Lz
         xGf3IR/MilgzzDGOrNX47XZPqTEySRmSPXLBnuYUruL1wxI5I3MW9G6vftLoYpjTK7zL
         0qxSG315vCeacS0c2PMRDGuZSNGxO6jmsA7BCxaePYLMpUNYqUW9gFXOFa61b5+zDmTo
         rTJ2Z/n/O+r5Rc3OJhaV5qOXywZ+jBdvH4pmvPmPPnPAwunH/FY+EEaObkv95H3bigBB
         iYMJ5Ein2UO6Jl53VFdw6QKXJp2Onb2LzFGG6U0b3doDvPDPD2eZHu9o+fN/MEsGQH/m
         yP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NlTnV1RuRzxavxPyEzKIvYJ+VeCVW6++rTPCnXKsCM=;
        b=U6ln2MDIJigHMg8Byq0oWUIkOaAccmgrXCsK+dulEC/ntr6u1XYrCmqjF8+eDKKf31
         VTsMUsIvoQQ3efpLU9cZmsOH1cdvoKzL44kQK6+0WN+NnROopa0NrYFews9NOInhZzy7
         g2DqOCW6W9Pp6Hh43dIfaF6N/mhDmAMRqSEdxXNViMFeG0bAJZFRaXXE8VruUHA4cS96
         pb4Io7uPkO7WChI2lyc4cuXe9H6bOsn77zMJBPAkgK3BVreLj6bFL+HarMNS71e56kAb
         /DoEZmJm/9dxKne/zw2j8a80efslrpY9LRma06BuAIEaek8CXYfg9JzGkAdsE9yboxN/
         OZHw==
X-Gm-Message-State: APjAAAUewixdpbLcVcXVqPQioUOyAvj+Xn5Q3wLv+9pSLw8Va4vmd165
        T81fW75BayhsxghyTyc2L/V7i6B9G6p7UlWJtbY=
X-Google-Smtp-Source: APXvYqyES9Mlgsy3geuwbdoVhE5fLT2b9NOat0SfHRhOEn8gfrTNRFwrNYBWJ0BtwzSo1L8lrjQhc3hEhcNyxmQwAWU=
X-Received: by 2002:a19:a417:: with SMTP id q23mr4872719lfc.27.1551895338862;
 Wed, 06 Mar 2019 10:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
 <87tvgr1fr4.fsf@concordia.ellerman.id.au> <CAFqt6zY0HV7E+_6_s5A3eG+jEj+4hgQnAgJQm-Pc1gyX4Vnbpg@mail.gmail.com>
 <CAFqt6zYqa6aCAcs51AdePtBSL58hMa1BSA87ZMLbwUJA=rWNLA@mail.gmail.com>
In-Reply-To: <CAFqt6zYqa6aCAcs51AdePtBSL58hMa1BSA87ZMLbwUJA=rWNLA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 6 Mar 2019 23:36:38 +0530
Message-ID: <CAFqt6zZcoe1fZF__h=zdKaWC7MHt4nVELCV07RspWjntHA94hg@mail.gmail.com>
Subject: Re: [PATCH] tools: testing: selftests: Remove duplicate headers
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Bamvor Zhang <bamv2005@gmail.com>, shuah <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, sboyd@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-gpio@vger.kernel.org,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:19 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 10:59 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Tue, Feb 26, 2019 at 7:18 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >
> > > Souptick Joarder <jrdr.linux@gmail.com> writes:
> > > > Remove duplicate headers which are included twice.
> > > >
> > > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > ---
> > > ...
> > > >  tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
> > >
> > > I took this hunk via the powerpc tree.
> >
> > How about taking this entirely through a single tree ?
> > or Shall I send these changes in different patches ?
>
> If no comment, can we get this patch in queue for 5.1 ?

I will drop this patch as we have submitted these changes in
different patches. ( Except the one picked by Michael).

>
> >
> > >
> > > > diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > > index 167135b..af1b802 100644
> > > > --- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > > +++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > > @@ -11,7 +11,6 @@
> > > >  #include <sys/wait.h>
> > > >  #include <unistd.h>
> > > >  #include <setjmp.h>
> > > > -#include <signal.h>
> > > >
> > > >  #include "ebb.h"
> > >
> > >
> > > cheers
