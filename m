Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6B9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F74E20672
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AiurrKxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNQSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:18:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40115 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:18:25 -0500
Received: by mail-il1-f195.google.com with SMTP id d83so5834256ilk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/6eJjoqatlkHX327WsvzFKy6FL3fKgPjPYcZivid0o=;
        b=AiurrKxewNIgEi3Qc6AI4HYquUZOxMUDDDEB4z7QR5Qc3jretuIDN/CPqLL/KNil0+
         uG62v8LYmfkf3YQQ+ZypHZUpDwShD0oQL4dCmML/1uNfP7DOAg/9G85ZtXxpPcKJ24y0
         fmQVgK/gitIAxmcJYMo0YJjFbj5qdty2SABIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/6eJjoqatlkHX327WsvzFKy6FL3fKgPjPYcZivid0o=;
        b=TJlYEJlFiDcvC6VLmfcjMVdnkUgo4dQHbKJBqaU0w5ofIrAsGr2q4U/+qQRxthvRzX
         EJlkDPCZd81Y/AzeEZ63hFzoLlGZxAlncxLPXtQxQEkWA3+wfiLKLHt1yV/uyCHa3d9/
         6MW2cEMzVF64V1g8JJRvxJOF7w/WY6TRu4bx4QyjGM/qoC/D/YLUA3gD/bR3TY7rbe8r
         +N0FK0caYyDxN6SFmt7wqyNoquJGXE9rDlvv2sLlAbXOVF5LqOQ37A+IKjl14ypfmnjf
         lMktydLmTHGA205XxyAzlPQ9+IHuDMm5SLpmYykwoQtMjJR/tv6jOF+sE7SSbLaw5v9A
         kytA==
X-Gm-Message-State: APjAAAUq0LUgKPpzytw1AERAmY9lYbI8MyzYlKP9QEgn/tT2STGpRceq
        iW9wkLGspqwsR4e+3OS1s3yn94y71U0=
X-Google-Smtp-Source: APXvYqx4NoqmvQS7Ds7hsXbTrQUnMutlxWpI9la/XO3Bp55Tt/K1/j9Qf/elsf8I1Mvu1U0OYS4oyg==
X-Received: by 2002:a92:d64d:: with SMTP id x13mr10478258ilp.54.1573748303861;
        Thu, 14 Nov 2019 08:18:23 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id x1sm584746ioh.59.2019.11.14.08.18.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 08:18:23 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id i13so7435531ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:18:23 -0800 (PST)
X-Received: by 2002:a02:a813:: with SMTP id f19mr8010531jaj.12.1573747874146;
 Thu, 14 Nov 2019 08:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20191109191644.191766-1-dianders@chromium.org>
 <20191109111623.1.I30a0cac4d9880040c8d41495bd9a567fe3e24989@changeid> <20191114105125.t3jma3ghwj2wtv6w@holly.lan>
In-Reply-To: <20191114105125.t3jma3ghwj2wtv6w@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Nov 2019 08:10:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xkxm-eTXmU9s+Bu+biLmjkioVqmHZEBVguZ85cCQywog@mail.gmail.com>
Message-ID: <CAD=FV=Xkxm-eTXmU9s+Bu+biLmjkioVqmHZEBVguZ85cCQywog@mail.gmail.com>
Subject: Re: [PATCH 1/5] MIPS: kdb: Remove old workaround for backtracing on
 other CPUs
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        qiaochong <qiaochong@loongson.cn>,
        kgdb-bugreport@lists.sourceforge.net,
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        James Hogan <jhogan@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 14, 2019 at 2:51 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Sat, Nov 09, 2019 at 11:16:40AM -0800, Douglas Anderson wrote:
> > As of commit 2277b492582d ("kdb: Fix stack crawling on 'running' CPUs
> > that aren't the master") we no longer need any special case for doing
> > stack dumps on CPUs that are not the kdb master.  Let's remove.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I have no way to test this personally, so hopefully someone who uses
> > kdb/kgdb on MIPS can.
>
> I took this as a hint to add mips support to kgdbtest ;-)
>
> Support is added and working well. Unfortunately lack of familiarity
> with mips means I have not yet figured out which mips defconfig gives
> us working SMP (and what the corresponding qemu invocation should be).

Nice!


> I think that means I still can't (quite) exercise this code fully.
> The most appropriate test is bta on an SMP system, right?

Yeah, or at least "btc".


> > Ideally this patch should be Acked by MIPS folks and then land through
> > the kdb/kgdb tree since the next patch in the series, ("kdb:
> > kdb_current_regs should be private") depends on it.
>
> An Acked-by from a MIPS maintainer would be very welcome. Perhaps
> with a bit of extra work on the above I might be able to provide
> a Tested-by:.
>
> I didn't see anything that particularly bothered me in the patches but
> given we're already at -rc7 I'm inclined to target this patchset for 5.6
> rather than 5.5.

That's fine.  This is all just cleanup stuff so targeting 5.6 is fine.

-Doug
