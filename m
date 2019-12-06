Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BTC_ID,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73176C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4117D20659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L67Udo4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFNcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:32:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36676 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfLFNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:32:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so2685687pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 05:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2S08e87qyOClIb15ji+5kVBV12PJ10Rg7yCvmuY9seI=;
        b=L67Udo4kJZKk80cfaTAth0CgKYP/DsxHicSKHyNruf6i0ke+J/XqppX60g+cun9oq+
         rU/KAZ8Vz2gnPIK0EecvN4/PgsuGXj2aZy8D9+I0AlhNnAKRRQfim9LG1cW1/j6X6wgu
         DaOoDtVEjztCMMS3YDEMmhA5F7rTQRPMvvYVTM0f84Z0NAzd+AyuofKkyrBojGf2v+Ui
         yd+UmL61srEGYH3zMaExIUzkvqRsJMuEYN/nmFRbo91eZxwz5AGpCitV+1ZGm7hGWCLH
         NGyP9Au3P/xw+DkJAFZEiQVTLt+3Vgr90XMwdtcmH/wS+POClIxXnd2Xf9X3QvBM7SbU
         iJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2S08e87qyOClIb15ji+5kVBV12PJ10Rg7yCvmuY9seI=;
        b=UZkn60G2w1j1ejss2cCGjujhwns1XqL6YSmC2ir+t76zz4Bee4MrVTNSJ5GUKX4czN
         79ZDAVPGECwF0esFgw9nexTFY7eGV/gf8EZTjsFTMuYY+13weee6JmicxIZTuNyVTd0Z
         xIRZggKI27OpkqCLcZeb5fK4xRBkhfpq2srSZtxbpKA8fcweFUq9uS57Uao9qmdtj5ex
         CsYO5poJpmVUVA9yaTkAl8/mH8/vw4opBrLPgfjkBfCgSFIUv1CrckwuxvxLo2rbd5uJ
         nzBNG9eyC7XxYwMsPLZ5QrGBWd2mNFdxKpCUTz+lou73rQs9oSKAEV8gXMu6jLC/uMHz
         Jqaw==
X-Gm-Message-State: APjAAAWFO61vI0xQMY5a4xBJcdMDEz3761Xbc0WCNuNvxcMrtUFGZRXy
        ReK3xWlzeVt9AkrCcoBOld/5kZ4fU4c5zp+TVIiKzw==
X-Google-Smtp-Source: APXvYqzGLszCKnNXCjDC648w2B2pW9Ym7h1x0WCYSF56kB12Pba7M4Ri36jHDVLBNr2t8h97l/8SAfP70geO0kxFXho=
X-Received: by 2002:a65:678f:: with SMTP id e15mr3508678pgr.130.1575639125248;
 Fri, 06 Dec 2019 05:32:05 -0800 (PST)
MIME-Version: 1.0
References: <46cee2a09d53921057cd4b87d1ed3796a2ab15bb.1575637022.git.andreyknvl@google.com>
 <CANpmjNPb988whEFQW+msYpdco=_=CXwG1mj+apy7U7ARJ3s0CQ@mail.gmail.com>
In-Reply-To: <CANpmjNPb988whEFQW+msYpdco=_=CXwG1mj+apy7U7ARJ3s0CQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 6 Dec 2019 14:31:53 +0100
Message-ID: <CAAeHK+w749YgJDXi-YnYn_K=OPLPGKNgEU47p6iEjb-BsXtCUQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix struct layout for kcov_remote_arg
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 2:14 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 6 Dec 2019 at 14:05, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Make the layout of kcov_remote_arg the same for 32-bit and 64-bit code.
> > This makes it more convenient to write userspace apps that can be compiled
> > into 32-bit or 64-bit binaries and still work with the same 64-bit kernel.
> > Also use proper __u32 types in uapi headers instead of unsigned ints.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >
> > Hi Andrew,
> >
> > We've noticed failures on 32 bit syzbot instances when the kcov patches
> > got merged into mainline. The reason is that the layout of kcov_remote_arg
> > depends on the alignment rules, which are different for 32/64 bit code.
> > We can deal with this issue in syzkaller [1], but I think it would be
> > cleander to get this fixed in the kernel.
> >
> > I hope this patch is acceptable, since the change has just been merged and
> > is not included into a release kernel version. The patch breaks the newly
> > introduced kcov API for 32 bit apps.
> >
> > Sorry for not testing it with 32 bit code earlier.
> >
> > Thanks!
> >
> > [1] https://github.com/google/syzkaller/commit/ba97c611a36b7729d489ebca5f97183c2ba7a90a
> >
> >  Documentation/dev-tools/kcov.rst |  7 ++++---
> >  include/uapi/linux/kcov.h        | 11 ++++++-----
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> > index 36890b026e77..744df2bae1ed 100644
> > --- a/Documentation/dev-tools/kcov.rst
> > +++ b/Documentation/dev-tools/kcov.rst
> > @@ -251,9 +251,10 @@ selectively from different subsystems.
> >  .. code-block:: c
> >
> >      struct kcov_remote_arg {
> > -       unsigned        trace_mode;
> > -       unsigned        area_size;
> > -       unsigned        num_handles;
> > +       uint32_t        trace_mode;
> > +       uint32_t        area_size;
> > +       uint32_t        num_handles;
> > +       uint32_t        reserved;
> >         uint64_t        common_handle;
> >         uint64_t        handles[0];
> >      };
> > diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> > index 409d3ad1e6e2..53267f9f1665 100644
> > --- a/include/uapi/linux/kcov.h
> > +++ b/include/uapi/linux/kcov.h
> > @@ -9,11 +9,12 @@
> >   * and the comment before kcov_remote_start() for usage details.
> >   */
> >  struct kcov_remote_arg {
> > -       unsigned int    trace_mode;     /* KCOV_TRACE_PC or KCOV_TRACE_CMP */
> > -       unsigned int    area_size;      /* Length of coverage buffer in words */
> > -       unsigned int    num_handles;    /* Size of handles array */
> > -       __u64           common_handle;
> > -       __u64           handles[0];
> > +       __u32   trace_mode;     /* KCOV_TRACE_PC or KCOV_TRACE_CMP */
> > +       __u32   area_size;      /* Length of coverage buffer in words */
> > +       __u32   num_handles;    /* Size of handles array */
> > +       __u32   reserved;
>
> The kernel provides __aligned_u64 for this purpose (32/64 bit uapi
> compatibility).

Oh yes, this is much better, sent v2, thank you!

> Is adding an explicit 'reserved' better here? If so,
> it'd be good to document.
