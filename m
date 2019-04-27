Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C2C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 02:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B477D206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 02:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="us0znVW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfD0CP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 22:15:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46820 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfD0CP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 22:15:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id k18so3680957lfj.13;
        Fri, 26 Apr 2019 19:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5STeCG4aRVdHVTO/L7BJz/8etDEMrfGWk7jZsnXo3WE=;
        b=us0znVW/TNtHr3ZFeFHTXc1qRhFGq/7Pf8bVZ8tcngMfaVcazmH6k+ZM2GPczZgRF+
         Q2YE/UV+bRWRsnttw1kcFA3vTn7dlDve7BwlFI0sBp7Gmw2BMKGjdmasrDVl6R6lB15q
         iBcmiOinPdfg6qoIsdaVigBeB/pRGWk7qvnOjcb8oeV5a6nBp1sUDu9uuJm8r6/tig4a
         NzeXlcePLRSjZXvHHgtYcnW5eh2FRJom9hZODAFMEeMbEFEDbDmpyyILBumCCYAFXDs3
         qGmpuSmK+Z8gXbhlhwHc0KJlcf+mEpxIU1F/Gj5AB+qio/1/g2n4yHAixyv21lts0fBM
         FTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5STeCG4aRVdHVTO/L7BJz/8etDEMrfGWk7jZsnXo3WE=;
        b=s41iOcEOjEza2bKTu+aLiYkZcH2/hvRjmJiKSz4H0/V7FbUFE+CGNWN1NyiAuZ76SV
         EcjBn6fat92cAJxLVgIvTsPkOIrrgOcxeDbpANSF/mQ+EA4EPK0+DWhODVTePjF7Pw+6
         /5yTHa8P9moXP1u/MyaIOYAAzeYqK2WSky1xOg22e7PHjfeg9rVTETXABPtNKkpT8ble
         qLWeFBAAQU1fB4qx5t8nxuqMDc6P96UKfI6u0Hw4dktzbRaue0zaqrct0vYLv0WpkaWm
         MW5j6UPizfe5glogM76XTqFt09XS4eMY5rlZKw2XvoHMNTZPxFWes2RU0c2c0Mu+t9gG
         4/0A==
X-Gm-Message-State: APjAAAUDQ0L7l+mkRP7IJlLJZqJusJ9rq6jujyi5A6TJrb+U9aH/dH/0
        kUkGzBf+Tm/LDxHOlWjep23NoNbCPBUf+6UDV5k=
X-Google-Smtp-Source: APXvYqwnl4MtaxJCm3KVKR5hqFLEVtfUckAb8Gi9qRpBx2fE15oEqfYMb3o4CDplc9R269UHo281RD0lnBSJEVC8/i8=
X-Received: by 2002:ac2:4109:: with SMTP id b9mr9285094lfi.90.1556331325560;
 Fri, 26 Apr 2019 19:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190426184951.21812-1-mmullins@fb.com>
In-Reply-To: <20190426184951.21812-1-mmullins@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 26 Apr 2019 19:15:14 -0700
Message-ID: <CAADnVQJuxuLC8uzSz1UWDQa3txc+aRdw4OkUmdBOjdezkUhd+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/5] writable contexts for bpf raw tracepoints
To:     Matt Mullins <mmullins@fb.com>
Cc:     Andrew Hall <hall@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:50 AM Matt Mullins <mmullins@fb.com> wrote:
>
> This adds an opt-in interface for tracepoints to expose a writable context to
> BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE programs that are attached, while
> supporting read-only access from existing BPF_PROG_TYPE_RAW_TRACEPOINT
> programs, as well as from non-BPF-based tracepoints.
>
> The initial motivation is to support tracing that can be observed from the
> remote end of an NBD socket, e.g. by adding flags to the struct nbd_request
> header.  Earlier attempts included adding an NBD-specific tracepoint fd, but in
> code review, I was recommended to implement it more generically -- as a result,
> this patchset is far simpler than my initial try.
>
> v4->v5:
>   * rebased onto bpf-next/master and fixed merge conflicts
>   * "tools: sync bpf.h" also syncs comments that have previously changed
>     in bpf-next

Applied. Thanks!
