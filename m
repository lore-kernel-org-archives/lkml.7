Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0206C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B7920859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Etd7t68x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbfFJPCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:02:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40539 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfFJPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:02:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so859246wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwmVmh7jPztWy0GKEZAfyi5TFykIAsZvgNG89Rfbe68=;
        b=Etd7t68xizBkpcZqSEMOmT0qrNwSLIudbv4IWKJ031r71BYQHQW6GeZWqtnrRNkBZL
         GGSEUKkBMrK2JbSv1ypdS0uQSs1noO9Wpm5ttLet+CLfEVtWpciTFTcZ/+SdCc67u3hi
         p6GYFZ/nRGVtcfl/ebubZVit/0qIbmPGcWIp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwmVmh7jPztWy0GKEZAfyi5TFykIAsZvgNG89Rfbe68=;
        b=CDYEUxuwOiX9GNdR9gDwQZz7PFbk7CEdS9AbBg+Qlmub5uMOLSfuRFOKcLXJ9J++T8
         /AXaf4tL9DcvOmFTgp0BmMxIbe3X1mExIyLmaszIgZ7cvMHPRjCOgS4tQ+8XMOh5Dvnu
         246Q4br0Xm3OVqOCNNXWr5qT19DKWUXMX5NR4K21bPCiDZUZYIlf/SWGRHDZCXClU9bx
         pHW3177jW2CAG8DGqVfLiAc8BFeRqAryHZ6OUnFlIgm9lLzbnwc68O1bK8HBbFk6zD+d
         RllqxjXQHHoCvVF6lfgSJ2C/MiHDUS27Pi3P4+z4tw05fxJ1vRKvt+UsTbk8SkzqSpaa
         z11g==
X-Gm-Message-State: APjAAAXsKNUzlbt+OZPmnRqG2T1ukPEpGjPl/M/F8WBk+qN38qnatUfi
        /XHEQk1QXllBa0/uxu3AeU4lUhdzgd6rlwFUu1PQww==
X-Google-Smtp-Source: APXvYqyUnswYvTUuGMMtOK9bu7oqC784gfSHEX0M9FO0bt97fGjX8Vj4FWw5jHQNwREhJM0zSozaNqEaFpxhzAu80zA=
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr14196914wmj.176.1560178927858;
 Mon, 10 Jun 2019 08:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190517085126.GA3249@kroah.com> <CANiq72muyjE3XPjmtQgJpGaqWR=YBi6KVNT3qe-EMXP7x+q_rQ@mail.gmail.com>
 <20190517152200.GI8945@kernel.org> <CABWYdi2Xsp4AUhV1GwphTd4-nN2zCZMmg5y7WheNc67KrdVBfw@mail.gmail.com>
 <4FE2D490-F379-4CAE-9784-9BF81B7FE258@kernel.org> <CABWYdi2XXPYuavF0p=JOEY999M4z3_rk-8xsi3N=do=d7k09ig@mail.gmail.com>
 <20190610074510.GA24746@kroah.com> <CALrw=nEp=hUUaKtuU3Q1c_zKO3zYC3uP_s_Dyz_zhkxW7K+4mQ@mail.gmail.com>
 <20190610142145.GC5937@kroah.com> <CANiq72kxyKV1z+dGmMtuq=gUWOYS=Y0EsNFqLKoFXWx6+n=J1g@mail.gmail.com>
 <20190610144858.GA1481@kroah.com>
In-Reply-To: <20190610144858.GA1481@kroah.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Mon, 10 Jun 2019 16:01:56 +0100
Message-ID: <CALrw=nEFtg47p0WZrDVWGcRZDqgA-x_ADXe5-TA92hB6W8zYtQ@mail.gmail.com>
Subject: Re: Linux 4.19 and GCC 9
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 3:49 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> >
> > I typically compile a bare-bones GCC for those things, it is quite quick.
>
> Pointers to how to do that is appreciated.  It's been years since I had
> to build gcc "from scratch".

This is how we do it, but we use it for some other projects as well,
so need ligcc and c++ support. I suspect for kernel-only there may be
a more lightweight approach (for example, by dropping c++):

Env: Debian Stretch (we run in a simple official docker container with
build-essential and make installed) - but probably should work on any
distro
Assuming the sources are extracted into $(BUILDDIR)/gcc-$(VERSION)

cd $(BUILDDIR)/gcc-$(VERSION)
./contrib/download_prerequisites
cd ..
mkdir gcc-build
cd gcc-build
../gcc-$(VERSION)/configure --enable-languages=c,c++
--build=x86_64-linux-gnu --disable-multilib
make -j<something>
sudo make install (or install into alternative dir and point Linux
build system there)

Regards,
Ignat
