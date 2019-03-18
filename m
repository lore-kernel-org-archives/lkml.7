Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353C72133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIgE4Gyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCRTLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:11:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47007 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfCRTLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:11:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id x188so1783828oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoDVYGN3p0uUP69FKJYNO6I1tI51AT9N5qPr8sxvnZE=;
        b=mIgE4GybGcQbN4cBEJLSUN2zTD9SvJz1Nw5WHwNPHkIm4rGvF5/NYm/hlC4zOmykdg
         jAbKZus00QVw6XUA4pC3pr6fPPhJxgJDOw885lw5InVIKANXDtXzcqOiX5TuX0BFJmdt
         MCCApZGl6pwCdxIsqDZZeVHfSM8ztihxFm67lpsZcwbxlUPo9lXg1lLFk515wusrS+UA
         qQZHH/+YEEfkp8VgQLLDTZWGMOSvZ/LyhANFdL4a93AvOAr465xDi/DaStgRUT+Pia6K
         e1CrJDI1jBTmE7/PcA/ty55DXW1pc3s7Hx2zd4CNySdk0Ro4dgw8u3RtLhXz3QC0NWV/
         /viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoDVYGN3p0uUP69FKJYNO6I1tI51AT9N5qPr8sxvnZE=;
        b=mVCDKIBjV4zcBY2HceJuJ/QmrMku8t3DPyJIZGtHwXWUoLjfrs3dZ4Nb2ysiaiG+uz
         v9hbfldoWTlN6trg3dTcWyor1g9fiFf+ePSCWAdZfC6t71qfgTm3EQ7CsIMFQAKBipeK
         m6IhahkXwhzYuAbvVg2VkgIfabW2cY/oDQDv50iYh52gTx5gXH/7f5kKg0hymxdR9qyR
         h7AZau80GLbzC2UYyTYeZb7c3/LuYYin/MxvCDxliOJhCgozST01iC8y0rvQ+NkQixWM
         C9CKzTL4XqoqnfBdxH6F7zmvAKUlLvygAm9dlNRZwpc+sYKktGCur1QJrtMCTYNwBUym
         kpRQ==
X-Gm-Message-State: APjAAAVacuTvSMbg0ljqwEjkoDt8Yaod6Qi4Uf/ktaPo6zy0K+rk9nSA
        4BMqdKntZS+FvYHsvqw4Nt3B0chPvAMy0Qph9TKmVCKGCLA=
X-Google-Smtp-Source: APXvYqzQrXRHbrQwpdgk21uyj6j1k03CtWNZaAR1n6hnsnFk48dNYyTcfBIh4gu2LRtvNea4jButnGBFv6R/TisWq0U=
X-Received: by 2002:aca:550c:: with SMTP id j12mr313915oib.52.1552936295646;
 Mon, 18 Mar 2019 12:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190301160856.129678-1-joel@joelfernandes.org>
 <CAMuHMdU77UyUs-LvRx-NN_k0Y7MZXQkBdgL2i83veCkvdzeeqA@mail.gmail.com>
 <20190307150343.GB258852@google.com> <20190307152303.GA9819@kroah.com> <20190318185742.109dee5c@alans-desktop>
In-Reply-To: <20190318185742.109dee5c@alans-desktop>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 18 Mar 2019 12:11:23 -0700
Message-ID: <CAKOZueu1ArNH3W4MfgTmWM39gvaKcYUsYUVGpQm5pZLUi-eGNA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?open_list=3AKERNEL_SELFTEST_FRAMEWORK_=3Clinux=2Dkselftest=40vger=2Eke?=
         =?UTF-8?Q?rnel=2Eorg=3E=2C_linux=2Dtrace=2Ddevel=40vger=2Ekernel=2Eorg=2C_Manoj_Rao_=3Clin?=
         =?UTF-8?Q?ux=40manojrajarao=2Ecom=3E=2C_Masahiro_Yamada_=3Cyamada=2Emasahiro=40socio?=
         =?UTF-8?Q?next=2Ecom=3E=2C_Masami_Hiramatsu_=3Cmhiramat=40kernel=2Eorg=3E=2C_qais=2Eyous?=
         =?UTF-8?Q?ef=40arm=2Ecom=2C_Randy_Dunlap_=3Crdunlap=40infradead=2Eorg=3E=2C_Steven_Ros?=
         =?UTF-8?Q?tedt_=3Crostedt=40goodmis=2Eorg=3E=2C_Shuah_Khan_=3Cshuah=40kernel=2Eorg=3E=2C?= 
        <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:58 AM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> > I think the compressed tarball is much simpler/easier overall.  If
> > someone really wants the filesystem, they just uncompress it into a
> > tmpfs mount.  It's much less moving kernel code to worry about.
>
> There is an even simpler approach. The people who want this for whatever
> strange reason are Android folks. Android lives on flash, so all they have
> to do is put the headers in a flash file system that is updated with the
> kernel and mount it wherever they like. Simple matter of a bit of
> devicetree no ?

Did you read the rest of the thread? We talked a lot about the
problems with filesystem-based approaches. It's not just "Android
folks" who want BPF-based tools to Just Work, and it's not "strange"
to want that --- what's strange is this reflexive opposition to a
pragmatic feature (one that nobody has to use) that will make a lot of
system analysis cases Just Work. There's nothing wrong with having the
kernel describe itself, and there's no reason to push tons of
error-prone metadata tracking to userspace when the kernel can just
talk about itself in a guaranteed-correct manner. Every argument
against this work is also an argument against /proc/config.gz.
Completely unsurprisingly, /proc/config.gz is in practice super
useful.
