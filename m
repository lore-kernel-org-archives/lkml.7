Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CCEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA281207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552251435;
	bh=/fEN5sjshP6ff6jac0rg2K1r1hwrVDXmAxFe33hWHcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A4yKGgS1pqLoqslRseJFYvVBtzdo6v1vNBW2sIK7np2aynP5JA0RywjId8J11DYyE
	 Ju0Q/vspBOyKegO7O4V6T+Xyr6qHbvrIw7sdHpDLE26FgTmOcVBpeTUtTqHVcUvYmX
	 q+ckxSwLN2LC0cJJCgHJ3KEnUCnNuAimZmyK/yJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCJU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 16:57:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34524 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 16:57:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id l5so2273426lje.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qHiR6gPXeg10SwEpHN0+CjKSur/FxoCWo3IdUEkd6SY=;
        b=gKbdElyUQV2x8LhYF620kTTfMWnRH7XYSVm+RqCb9PYvmTwQdrlYqia9lJNkeru0Fg
         WdewtiTLhB67DO/iYk0Y1EOqPS1Is2n+l/e8YZSBPawDLEFDV/g7hfuYDW7skX/oxNYK
         2GiC6sV6KWFUCB2yk88j1beg7QeTckF5w487I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qHiR6gPXeg10SwEpHN0+CjKSur/FxoCWo3IdUEkd6SY=;
        b=XHtH2qNdFasXt0/rZ3InRQf3Yb0jNUC0kWGDxsrFo5SAhCyyX/o0RjV+UVPDx0DV9+
         H99kd0rLFoM8woKAwsRF0e3bw1XuNK4wN9SxKDtAnK1+RAurIsLwUXmT4E3GPXFyc6Xb
         5pawQKDAHho3HWQltJgtoKLAbemS8LOG4qoa5cTIm0yhF3zOXANvVXNb6qvX59B6k2IA
         +bFTJqjfv5EUo1O1cb1sXgyO81pBFWwzK8eEbj4iqe2zv7ntZCzthVGNWGfDC/ncnm9j
         AdYWSrVUbf0h3jm6jAXFNH4u5wueoNfy9B4Ci4dtzpwEg1KWnwiAjv9+qaJpYMZQf4WI
         luog==
X-Gm-Message-State: APjAAAWAmYJEbH0sq7n8LmZNJ+at/2fuLU4S/EPYC2dRxrntxa5GkLdA
        hkq55ZNe7k1M3y5xk1ReDVufWB2u43I=
X-Google-Smtp-Source: APXvYqyJB7wOUThofx+AgN5sKpoNqLtTxirR8CFrwuNr5TbYHE15l6DiKNR8ZqrBrDwjrHsqnCOyxA==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr14543028ljg.94.1552251430885;
        Sun, 10 Mar 2019 13:57:10 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a26sm883083lfl.45.2019.03.10.13.57.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 13:57:09 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id k136so1899202lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:57:09 -0700 (PDT)
X-Received: by 2002:ac2:5088:: with SMTP id f8mr15437434lfm.11.1552251429063;
 Sun, 10 Mar 2019 13:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.2888459223557668046.tglx@nanos.tec.linutronix.de>
In-Reply-To: <155221755097.13878.2888459223557668046.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Mar 2019 13:56:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_krg9B2B0i7+mV4rRCdowiNw3bOC9rssaZTVFQvKMxQ@mail.gmail.com>
Message-ID: <CAHk-=wi_krg9B2B0i7+mV4rRCdowiNw3bOC9rssaZTVFQvKMxQ@mail.gmail.com>
Subject: Re: [GIT pull] scheduler updates for 5.1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 4:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A small set of fixes for the scheduler:

What? No.

This is completely broken, and even warns loudly about it.

  kernel/sched/cpufreq_schedutil.c: In function =E2=80=98sugov_iowait_boost=
=E2=80=99:
  ./include/linux/kernel.h:827:29: warning: comparison of distinct
pointer types lacks a cast
  kernel/sched/cpufreq_schedutil.c:346:26: note: in expansion of macro =E2=
=80=98min=E2=80=99
     sg_cpu->iowait_boost =3D min(sg_cpu->iowait_boost << 1,
SCHED_CAPACITY_SCALE);
                            ^~~

because 'SCHED_CAPACITY_SCALE' is of type 'long' and 'iowait_boost' is
'unsigned int'.

Why are you sending me code that hasn't even been compiled, and call it a "=
fix"?

                   Linus
