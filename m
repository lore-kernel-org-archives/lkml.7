Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE2C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DB721783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vb5V5wS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfJBV1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:27:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46929 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbfJBV1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:27:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so262126pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ff5/X8LijthYfBkRMosRh8V5DWdVMBmSJpWGhDefc4M=;
        b=Vb5V5wS0B2+OZP1hBBvp/X0BN8J2HU5kfLxwxgDecAUheVPlHvun2OYXtJRwp3FY64
         B/rNa+xoUubebYIt9wU6UtQvz74/wh9aaLvwc1qLfrA4CcdAcvlG/WnwhXR6tVf3o9Pq
         6+kyVsT0p3gDAYf45MjahfyuIfSGJTw8yfHpocnjbuDtgx5ctlNxMGLoYG0NXQm/HPkH
         bgEL6k2l8Alsn0ErHQURhPrnycDhI7j24owjoOxuvFkricWBTQuucujCDaRWvcogBUiu
         J1w4QRQDUslmdgTvSO+cKA2COYYX84VW86bw6Ncpr4pIp3Fyn+urmRyNQX4v3S1OSWf4
         QmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ff5/X8LijthYfBkRMosRh8V5DWdVMBmSJpWGhDefc4M=;
        b=YEmbLOKnKC4s7u/F9E9JmBGXh4gcq+zSRciVZFA6Lq6ZNTBygj9WlrhpN66EKc46O2
         hxEDv9TdC1g+x+8IQDAHV3fFSNEf9UOyl252lh3lrY3r8zfkz8R67yaPI0gPNTWGNqyr
         z0MM5x07YtCXx4NtS+oiewqbNWQ6Evj2uzGMejU8BHtKhCf+HNRUFLsOzvKcOKql3kBS
         jvg9nwxHTnVTLvvCzJ6BAbYD7Fo4/qKFAnga6BWHjT9LEkG5XSOwObBPtFM+yz1p4EC3
         ecN2O9XsZHqoUuOv624S0pSvC16uqqCQ8gznUg8y/3gbDSmnykTQhWvFm2bkvNIi+Ze9
         QGrw==
X-Gm-Message-State: APjAAAVRRjP4G29GoqaBDlmWNflLlE9GkK6/kwjw3a5CKKqiXVTduHYP
        Tvrg4/PWa9B0YxwjIb3utwePkyTxdDVGzO8tVVXJZw==
X-Google-Smtp-Source: APXvYqxNdOGB2WGWCnghLz9uwjolnJyOa8vlr+WnUyO0zmr1/ot3q/S+YF1u1IXNHz8osGDRHnZWrd80t7vHOCyQN88=
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr77517pja.73.1570051668780;
 Wed, 02 Oct 2019 14:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CAKwvOdmjM80XP7VH83iLn=8mz6W1+SbXST2FChEnH0LSRRm4pA@mail.gmail.com> <CADnq5_MyUp9OkqM+MUHZ8BpLEe5afBpAqOwQxDwAWgvVvqbpoQ@mail.gmail.com>
In-Reply-To: <CADnq5_MyUp9OkqM+MUHZ8BpLEe5afBpAqOwQxDwAWgvVvqbpoQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Oct 2019 14:27:37 -0700
Message-ID: <CAKwvOd=+VeD4xchCAyKeBtTD8+qwS6BTVgM=4ZDY1kBQJq3wMQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:24 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 2, 2019 at 5:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Alex, do you know why the AMDGPU driver uses a different stack
> > alignment (16B) than the rest of the x86 kernel?  (see
> > arch/x86/Makefile which uses 8B stack alignment).
>
> Not sure.  Maybe Harry can comment.  I think it was added for the
> floating point stuff.  Not sure if it's strictly required or not.

Can you find out for me please who knows more about this and setup a
chat with all of us? (I don't want to deride this patch's review
thread, so let's start a new thread once we know more) We're facing
some interesting runtime issues when built with Clang.

-- 
Thanks,
~Nick Desaulniers
