Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD580C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA1420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUnYOXoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfCDRc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:32:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33280 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:32:56 -0500
Received: by mail-ua1-f67.google.com with SMTP id q17so5145941uam.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkY60ZGZ5GzXTCVZGdJfnj3QrSrvwyXRT+DLIil7TAk=;
        b=bUnYOXoX7yvX06rwCT958g5coU4Gk/jNsnhGFwysxWJBmuZb0WHLukHskO+5D+KeaS
         rOKnMZ8bIfbA6U7sJemi2xb3lh+108PIyZVtD2uvJU/0qp6vEnGPIabEVNakbqLkltW1
         DFLclqm5WP2Aj5s7nmyDU1uGmTVPD3FbRL5Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkY60ZGZ5GzXTCVZGdJfnj3QrSrvwyXRT+DLIil7TAk=;
        b=K7NHVl2+zy89Y+kHpLfd6V034fBsygXi2dgJ4InwMGq9jeJ9ml4O5bPL8zhBnddKUu
         4NETgBix5raKkdUkplFh2RC9+OiR3TlK+W6zKSWjaF3e2qqAGtqO1rtGKJC4+F/pk+a7
         GPBZLT1Krtjr4q6N1XQXUvL3VZITrDEcT5208l7H//hD8evdwfDwz8BrMfB/LfWKX24q
         Rb/emRxK+pzGrdVnzsQ5UlWExGjEWvr4tU6+AiarmHIaJx81TMQldfbC1SseRO+ZdSTV
         5WD8bTmMnM3t9Juc86MSV+s4jVxsObpuae8swmqXVPsAQdwGrC/Qa8c5JLeUeLDkpMEp
         6PPw==
X-Gm-Message-State: APjAAAVttxWWDUp9qLpTx2nzrjcCx1BWZWhCI4Yra4RtCgB6U/ZAnn4e
        IfM9CLZS7Y+PflMNLAQYedAIlEGb9TU=
X-Google-Smtp-Source: APXvYqzE0tdZEzEopRlVz5Tkh7UpGtwOKWOe1b7H2JKHVKWu/d3YscDSUMHvj6QNDDbIOUlzNmS3uQ==
X-Received: by 2002:a67:ef83:: with SMTP id r3mr10046157vsp.101.1551720774872;
        Mon, 04 Mar 2019 09:32:54 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id j131sm2064737vkf.20.2019.03.04.09.32.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 09:32:53 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a42so5137515uad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:32:53 -0800 (PST)
X-Received: by 2002:a67:89c9:: with SMTP id l192mr9968756vsd.188.1551720773428;
 Mon, 04 Mar 2019 09:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20190212180441.15340-1-keescook@chromium.org> <20190212180441.15340-2-keescook@chromium.org>
 <CAK8P3a2xC3OVckPnweSjor3AH5LpSzichKxAjkAcgXDtCf0QmQ@mail.gmail.com>
 <CAKv+Gu_+GZ8Ut0nN+za+V48Eo6O27P_go3Dk1rDe1Wederad1Q@mail.gmail.com>
 <CAGXu5jLwEh-_v_aVm35hSqbX3QzdFOy_AwEa4mmKM8JmWtiKGA@mail.gmail.com> <CAK8P3a3r-VV=xwuUgC5kMoNsOymjzSoZ4h-ks_p7AzNDfPa4oA@mail.gmail.com>
In-Reply-To: <CAK8P3a3r-VV=xwuUgC5kMoNsOymjzSoZ4h-ks_p7AzNDfPa4oA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 4 Mar 2019 09:32:41 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+zZdgeBg6kkh-oC4qfJAgaOm04Lpni4HkkGKNRZ6BU9A@mail.gmail.com>
Message-ID: <CAGXu5j+zZdgeBg6kkh-oC4qfJAgaOm04Lpni4HkkGKNRZ6BU9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] gcc-plugins: structleak: Generalize to all variable types
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 2:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 2, 2019 at 4:43 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sat, Mar 2, 2019 at 1:05 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Thu, 28 Feb 2019 at 21:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > I get similar results with asan-stack=1 but without your plugin, only
> > > > the combination of the two has the explosive stack size growth.
> >
> > I can look more closely, but I'm not sure it's entirely worth it:
> > these two may not make sense to build at the same time. (e.g. the
> > use-after-scope config was disallowed to work with this plugin.)
>
> Well, I still want to make sure all 'randconfig' builds complete without
> warnings, and without having to turn off the otherwise useful
> stack overflow warnings.
>
> One thing I noticed is that your patch removes the 'depends on
> !COMPILE_TEST' check for GCC_PLUGIN_STRUCTLEAK_BYREF_ALL,
> so if we add that back in, it would at least take care of the
> allmodconfig and randconfig cases.

Okay, I'll add this back in the next few days.

-- 
Kees Cook
