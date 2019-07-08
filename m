Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04303C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E1420861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404991AbfGHUYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:24:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42885 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGHUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:24:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so12199652qkm.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnrita1b0MkM7AyNkc/2C7SSvEndD1B5RxD62T0Ue1c=;
        b=GRs8HCqScxd6y/khQCbsFwg8NN2n+h4vqwpj1IDtjjzAi+2CEZUH7eitWnGDiGcWuP
         fh6zfl04mO+bbkThkEhW7J8ekKQin2iEcpwpg+hRhuxJamsK0ig/onrwiEd0gL1d3WDn
         ThYZH4lAiNH4752P3D7TwC5WsgHrj4K80ZL+z6zqOaMcQ6OiBsq9Ybo0CdBr3JMA2Ozm
         YmQxHUjyx2O6BZbFbdHbQ3usLaIQlDx2rap4sb3YfY4METLslMiVZtJcXfU7+xVrznlm
         mxFl+KkSuYKd0MHiKRBiDz45hzxDbOVqgiuXP7uXurR83G8hULrPskLqv025YBl3rQHn
         BrWA==
X-Gm-Message-State: APjAAAV9aMqYTsQTnpXBXRueJDKTBBXFvvt+4IHG0U7HLBgXjb+95QL9
        qGa1Neg9a3ZXw5SXXszSm4y+ASvJAzV6HuNCNeY=
X-Google-Smtp-Source: APXvYqzp2meV/E+aj2azg0GgBkXPsp7U2/Lbp+hd+FV4m9ZLBmCI5eKAOPpe0FiTi+Kmeqqq3XmNzw77aVbgQtu74k4=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr15270829qkm.3.1562617472727;
 Mon, 08 Jul 2019 13:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190704055217.45860-1-natechancellor@gmail.com> <20190704055217.45860-2-natechancellor@gmail.com>
In-Reply-To: <20190704055217.45860-2-natechancellor@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Jul 2019 22:24:14 +0200
Message-ID: <CAK8P3a1thzkjD5V39QcVWb1fQe62g6PLChMKuwodyu_rbWhgBw@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu/mes10.1: Fix header guard
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
>  In file included from drivers/gpu/drm/amd/amdgpu/nv.c:53:
>  drivers/gpu/drm/amd/amdgpu/../amdgpu/mes_v10_1.h:24:9: warning:
>  '__MES_V10_1_H__' is used as a header guard here, followed by #define of
>  a different macro [-Wheader-guard]
>  #ifndef __MES_V10_1_H__
>          ^~~~~~~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../amdgpu/mes_v10_1.h:25:9: note:
>  '__MES_v10_1_H__' is defined here; did you mean '__MES_V10_1_H__'?
>  #define __MES_v10_1_H__
>          ^~~~~~~~~~~~~~~
>          __MES_V10_1_H__
>  1 warning generated.
>
> Capitalize the V.
>
> Fixes: 886f82aa7a1d ("drm/amdgpu/mes10.1: add ip block mes10.1 (v2)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/582
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I ran into the same one now, and saw your version before sending an
identical patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>
