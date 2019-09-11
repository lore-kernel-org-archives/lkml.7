Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB1ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED2E2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtFM/wNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfIKUaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 16:30:09 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:36471 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfIKUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:30:08 -0400
Received: by mail-vs1-f41.google.com with SMTP id v19so9520918vsv.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xR7hYe4cgaeRTX0oM2Y5DNYIJaqcoPBbVI2nTGUyj3I=;
        b=vtFM/wNP1cbgEAHfwr2tSf+02EhyZPlQI2hH6LIOAujE4b2dV5EHR8S/+jHn7mNh7A
         dRrbfqGWSphPeXOKuDHFAF8dSowLXFxxGC4FbANYtLHrM3nrSZyQ9oaRw41A+IdO0sj4
         1GAOBXo65OWgs2wVFbCoeMw+Yr371hSazFG6BZkeJuALvPJ1xKYzBUlq/rURdG4QGAn5
         VpjVi4GSiISma6lDJL/8xgI99P1xYQK9Y2lIfMB5ekxjPDcR8AXmp+X5hpzQCI25CfEV
         UYmYj407XQ1sV9i0WKofsgpXso5FGO6+l/h7TjL9t2k3GdcZM7+HsiugG/KPZnyQn0qg
         st1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xR7hYe4cgaeRTX0oM2Y5DNYIJaqcoPBbVI2nTGUyj3I=;
        b=tiIGR/LUvu29gFLsoWVfgoxT5/LZhXxTD8fX0zfkwsU1ZtDxHSq/R3rDwHHXmwN3BS
         eOVA4z5Ma7iJoU2efjUSJr1VA9Nd/N/lpA/SemXaATqhnEcx6bbrsdVUJAFuF41eTpWm
         2EdLeoImq0jDvGbnORqJn213c5RP+eONxuZGfaKHCA2hBWLfqq69dAoW64nQcDiCb/n8
         qanjj7dlgqYy6JaGl6UlSpUdFl+MF+JFEjS6+/t5gCamvVleUGOZQRaCW+6YrM22U3py
         izEW5qN7KCjNvX6Bve4TFgNLFLwvzih91NU8PprmcN/j0+TJ7naorrrKoIGgDCLLrI9n
         BdEQ==
X-Gm-Message-State: APjAAAUezHMFC/tgI/gxoJe7EJ6j7Q6Y9NYunTHgreG/SIdHxUbal/j4
        /480rP8wKnh2YAeGDphVslsXhvyPGjHhaGVy09paUQ==
X-Google-Smtp-Source: APXvYqyti/BEpWt9VUm8RNlb1/OJ26SyVNVAoBMuidSB+6SFTYNd400N8tvIRMKnHXXEojW0z2LCqaCiSvDhOTHTQ8U=
X-Received: by 2002:a67:6d06:: with SMTP id i6mr21648978vsc.5.1568233807241;
 Wed, 11 Sep 2019 13:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190909223236.157099-1-samitolvanen@google.com>
 <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com>
 <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com>
In-Reply-To: <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 11 Sep 2019 13:29:56 -0700
Message-ID: <CABCJKueLLs7nUFnQ-BHWE3cPJncWACy2tG196n01QPpShUwKEg@mail.gmail.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:43 AM Yonghong Song <yhs@fb.com> wrote:
> How about this:
>
>         if (!IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) && !prog->jited)
>                 goto out;
>
>         if (unlikely(hdr->magic != BPF_BINARY_HEADER_MAGIC ||
>             !arch_bpf_jit_check_func(prog))) {
>                 WARN(1, "attempt to jump to an invalid address");
>                 return 0;
>         }
> out:
>         return prog->bpf_func(ctx, prog->insnsi);

Sure, that does look cleaner. I'll use this in the next version. Thanks.

Sami
