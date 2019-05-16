Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC7C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEFC20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm/ptDLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfEPSgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:36:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44226 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfEPSgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:36:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so3387900lfn.11;
        Thu, 16 May 2019 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+vfzW6eP2qMMPDF3Oo8GSsL6qZua9aEVyyeHZO1Mw8=;
        b=fm/ptDLwjlO59tFgKllZKSA0FayNW9Q+veAeUCykX2YQDQ9XZ4j4JdZ3fNignQj+QC
         t4IHzyz1daMp+WXIAX0EhQWWmn5J+nr6DKKxy8vBRkkirPIDehmDn8rbM+2IBBP5ovBu
         GhbEAJOwG2SdvWA//gHdpI4BZSHEbP8a1bXFwsLFGL5BXmYRJmmH9Roi5OPdMsJzbd3d
         jdGXab7V3VHiac5D3MAq1MGN7mTrMeiDnjkdvGFCPNqVNtJzPTzs0i4EU9sQvyr44Axf
         ph1qen3SPNRyMZ5oysZUPzH7ftbOicoV4JdMjaNh4vXuRB2cLzVNZ07a3n9zdz0p05af
         FcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+vfzW6eP2qMMPDF3Oo8GSsL6qZua9aEVyyeHZO1Mw8=;
        b=B0vGAQ/TxpcYKxpO/IXnwt0F3BrHvCYjGIo+fMUu9RWdMthRq+QTTbGSDyc0Tp3vb0
         iFYvySzZeNUHVQ81aNZVwWXi2bixIC2tnjGcPlErdgrZyNhl9OJrr3S+JsO8pkwTtPVa
         AhsiW9pBPSFgGYah2FYZvUVYiuitSEUnf0MCfGNXWBIxhaHQ/imU1qCmw2IHpynJ5y75
         jdgBWJS1olHVI5LTtev77Y9I8/QI3gjyeLam+siw6eAmu5x/y3E4CyB4EKoX5v4em6ql
         v+ylx0Fh6pBRKU5zJlq299Ouk5DXbmJMldfWzvRDXcs0dkdzE1pjMDIglsr9vjs7v5Lk
         U6jA==
X-Gm-Message-State: APjAAAVCNFLkbz4AV8qymv7eIw3qG9JPkWZgBk7BSxsipDR7jIw1QaKP
        S9t2PtYlAUOI5DNFaqbaJaP8zrWqMqyABzreA51S5g==
X-Google-Smtp-Source: APXvYqzOL2Ln7N6+03KL1lTz+KXMuislOZ8LsZ09CmjkM0dECOItTLmmhIeTwXzn11gbIlxPjN5U7UXUDSwQjsgnfzU=
X-Received: by 2002:a19:8:: with SMTP id 8mr24736850lfa.125.1558031796007;
 Thu, 16 May 2019 11:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190511025249.32678-1-skhan@linuxfoundation.org> <20190511043729.3o4enh35lrmne3kd@ast-mbp>
In-Reply-To: <20190511043729.3o4enh35lrmne3kd@ast-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 May 2019 11:36:24 -0700
Message-ID: <CAADnVQK2eyFdEULS6z-M1R77d-AKe5sACKCHxHShJFOqhqy0rw@mail.gmail.com>
Subject: Re: [PATCH] selftests: fix bpf build/test workflow regression when
 KBUILD_OUTPUT is set
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 9:37 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 10, 2019 at 08:52:49PM -0600, Shuah Khan wrote:
> > commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")
> > broke bpf build/test workflow. When KBUILD_OUTPUT is set, bpf objects end
> > up in KBUILD_OUTPUT build directory instead of in ../selftests/bpf.
> >
> > The following bpf workflow breaks when it can't find the test_verifier:
> >
> > cd tools/testing/selftests/bpf; make; ./test_verifier;
> >
> > Fix it to set OUTPUT only when it is undefined in lib.mk. It didn't need
> > to be set in the first place.
> >
> > Fixes: commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")
> >
> > Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>
> 'git am' couldn't apply this patch because "sha1 information is lacking",
> but the patch itself looks good.
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Thanks for the quick fix.

Ping! What is the status of the fix?
