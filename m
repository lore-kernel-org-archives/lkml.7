Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC02C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D67222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UyRUiqxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfJCATz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:19:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35027 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJCATz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:19:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so644959wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=otXrdRXRXX4CQWq3GYXb5YP6U6iBo7U72/9DY4vWCe8=;
        b=UyRUiqxpxePfHhLvHWalEtfH7bXcfip6Jpuw1CuN4CME/z2VjKvnYoiACUL8njpxWx
         NrFj3wRuC+4G387TGIaHSpAOPY+RzGZ4sS0j/azLBk/U985whs44i6Y3Q8GidUtPoAtr
         gPg9sFSMc6bNH86zfYj2HsjOVmJbhRxv5A2Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=otXrdRXRXX4CQWq3GYXb5YP6U6iBo7U72/9DY4vWCe8=;
        b=s+3iz4pE7yYnKUE/FPO0+VMqC9Ytn+MPQfC218B20eek9gJ7nYOZuEFbDGTEiQpmYh
         DZYJiD59uWCNj3lhRPWltNlj1hmS8ntPnf1J5lXSpIG0D29k7e/nK2jQmV5MrcJDUFvn
         TPey2Vxzr9CRYgfm5aO5KTnsE+PDgwiY+Ozu8s5s5DxBlccD2xt7ROGwaERz2AzrvRKu
         1Cvt9TOVWo98ckQcFt4DFpXXcjgYIMtiW9B5fGkvrlNucyXWIYFN9+nZ3sb2hlNIdt0L
         RO4CBo6K3QeNvp00HkKfV9i8kU7MDwj273+vOxGou+gb4o0/dmfLlqV/b+80nb2QPAQ0
         P67g==
X-Gm-Message-State: APjAAAV75jxE8+0wi50vHng3QYu1xjILe+KNA1xkdi+RqlSNIcmeLOhk
        N2irOxaks4E5/6q5G+roBwaqnil/hwf+1VeKXJpy1Q==
X-Google-Smtp-Source: APXvYqxalUowEr9ft2/u7jrMhV84UjQI79UjdzbXbSZaI9zycwf1BjEeLazp7AlXXo82ElFFmqdBxB6sMQbjZwxUAj0=
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr4781220wmu.139.1570061993266;
 Wed, 02 Oct 2019 17:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191001113307.27796-1-bjorn.topel@gmail.com> <20191001113307.27796-3-bjorn.topel@gmail.com>
 <CAPhsuW627h-Sf8uCpaE4eyu+wpkOPK+6eXkOhwMBnvFVVDQdKQ@mail.gmail.com>
In-Reply-To: <CAPhsuW627h-Sf8uCpaE4eyu+wpkOPK+6eXkOhwMBnvFVVDQdKQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Oct 2019 02:19:42 +0200
Message-ID: <CACYkzJ6R4bY2B61fC-EYGn0f-osPOVrZEJsatWyJRFn9_1JN2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] samples/bpf: fix build by setting HAVE_ATTR_TEST to zero
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        adrian.hunter@intel.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: KP Singh <kpsingh@google.com>

I can confirm that samples/bpf are building for me now (x86_64,
clang-8) after applying this series and:

 * https://lore.kernel.org/bpf/CAPhsuW5c9v0OnU4g+eYkPjBCuNMjC_69pFhzr=3DnTf=
DMAy4bK6w@mail.gmail.com
 * https://lore.kernel.org/bpf/20191002191652.11432-1-kpsingh@chromium.org/

on the current bpf-next/master.


- KP

On Wed, Oct 2, 2019 at 11:00 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Tue, Oct 1, 2019 at 4:36 AM Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.c=
om> wrote:
> >
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> >
> > To remove that test_attr__{enabled/open} are used by perf-sys.h, we
> > set HAVE_ATTR_TEST to zero.
> >
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>
