Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0B5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C143322CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJX6UTWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfH2P7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:59:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43841 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2P7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:59:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so3357950qkd.10;
        Thu, 29 Aug 2019 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vEGQNkK00oay2WNf1scuzD5dCz2zaDXZdVVYkLCPU8=;
        b=nJX6UTWWOz4O/nJJw1g67xvjXbYSzxeukliI0SSWNXKuqcs+mikp7hla1sdqB2i0L5
         IixcwimUb7Mc0K+ea09h9BTp0RxyZjZ1dEJaXhxBZr1D/Atj+wdT496U7FuiDs4xdkNM
         Ux+fZZpQLjaPn5b9lV0cEseU1tP5V/Px/Mx2RXPV1jK6444JK+HPLMl24fELDSGIIrSa
         8szCu/WuD6RUOTt0gJTWbDyIY6gwxJUyoFWskdi6A5Yif8IIMzG78PXvDiTASKm6w0oo
         WAZIROyVJPQ4JA1kg0iWigC6BlIrA35L8+FG+XU27/hPUFpDQmEgK2y+djLvcg7ksCrP
         5gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vEGQNkK00oay2WNf1scuzD5dCz2zaDXZdVVYkLCPU8=;
        b=lmQ9z55KMtGMBUXqvNIfVq7HKH9Nx0XuEP/MhLhUHQGLpH8S62/nloejJXd4/8nXau
         6qSC9sVml6J3CzwudrEa75zAMs4Xt76AXvlijKzAPj3pf5CDaWsSWhcz1fxJopNWXHM5
         hz3ctFSnz7IAVf6f3Atig9gD7MKhB+7a6LRSdOZ5ineM/OWGKckDYj2AjYcuyUgm1UpF
         nXqDLEuIRj+78av7vhgHBsE6tFXtR/pCZs8SQJt+fbWINkxhesG2VRGNNHb6O0ncI4JH
         E4bcMnQSBbDy+MhfhVeTNuA9cJwnXtJPQJ/G6CjWcXxV3M1aYzCiixYcpgmCMw4UG+aQ
         8zWg==
X-Gm-Message-State: APjAAAXnJgnRNE9bMs0bACjJABGcFKAkQgM3gsc2sn/2yY87jnJqpEgn
        SjSAmIElIXoF6dIsrXgjI3EnaR0UxJbSQOUbjtA=
X-Google-Smtp-Source: APXvYqxnfPdkhPWkBv4vKcxMIJY9EXkMbf5eiIhjSD9+q4dX8rj6Ep2ATMFnuG257clW7uB5xLinHhcbyMInhMyoLYc=
X-Received: by 2002:a05:620a:126c:: with SMTP id b12mr10701992qkl.177.1567094360524;
 Thu, 29 Aug 2019 08:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190829000130.7845-1-standby24x7@gmail.com> <20190828171505.105c2cf7@cakuba.netronome.com>
In-Reply-To: <20190828171505.105c2cf7@cakuba.netronome.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 29 Aug 2019 08:59:09 -0700
Message-ID: <CAPhsuW5OhFmcs=4LTzzjnH39f7i5Ks94o_OBbbZ_v+YHnXtaQA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix a typo in test_offload.py
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Masanari Iida <standby24x7@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 5:15 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Thu, 29 Aug 2019 09:01:30 +0900, Masanari Iida wrote:
> > This patch fix a spelling typo in test_offload.py
> >
> > Signed-off-by: Masanari Iida <standby24x7@gmail.com>
>
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Acked-by: Song Liu <songliubraving@fb.com>
