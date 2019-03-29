Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85838C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D97F2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtZs5auA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfC2Orx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:47:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45127 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfC2Orw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:47:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so2212239otk.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNYwpRYQXU4tZl+O5H6FV8HPDpdmLrtP+ED1YZNs5NI=;
        b=EtZs5auAjSnRLjhSzLIZU267GAAoJhM1tWmGSCKbJAjPfpkYY/R4s2xS/LsKxhgGPc
         jzF1wXISuqmPnOSNiI7X0OwPmBD7eotj0wy2cVRHsNTSoRlsCxAqfF8H63eja5ugdWuE
         62z5FppLeiuCHBovzWxUHvsUVdlPgFN2ERVrcyuFOmmc/z2C14DX+dKOuEjwgKcC2cOS
         hV+EOD8atJC9wzs5IXT39GpcNvI4gNDNifmOJTfI7+5ep24iuwr8Zys0mJO6dfAiJb1L
         XRVn+SuX6E0aLVRgFteABdsGV8M2Ai391UpQ+kr74z6KteI/EeTGll62k6jrn8mY1b9t
         YtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNYwpRYQXU4tZl+O5H6FV8HPDpdmLrtP+ED1YZNs5NI=;
        b=QXiMJflp85jOTEuUYQ2/5GxxLP/UJz4mRPPlWKrapKP4fzqGjeuptiSWwce+MIxeOx
         M7pizvx+PaMUy7HgbQOJbTVyFIZJXPx7Wi2gnokqcYRPZRGPy/Yi2LoRRXklj+4LNjkq
         q5yaNI0+vBOk5HsifwSu3iVpUlADujQbszZE85hrJu7x8kThd3vcK2UGmlc+OU8xveEg
         sIdfv4cmykO7iGqBv35XxGUhxMPd/PZBSJrdYnFpALv70dBmIDQoEuCpSHsogIg5v1Rb
         QiSt8cSV5kLsP5x3BWYKmVZ2Sj1tjM34tmBmUuvIWjDzvBiecS6IMW4QE4fwoceXCOk3
         arsA==
X-Gm-Message-State: APjAAAVQjFefEruNyxT0IdZwQGNpCG6J37GgaS2o/3e+Fir/IieJjFiR
        glpKiYhZoo8Vm4kfV30F1ry401AyiqC/6bJDLeOpTA==
X-Google-Smtp-Source: APXvYqzsKfs/73yhKS0dS0pbmc2NNrBWXkTEvZHxPplG2+ErdoZCbVMMfE6ONV6AW9rkp034HOYCqQsUQOfUBBpoYBE=
X-Received: by 2002:a9d:694c:: with SMTP id p12mr33992119oto.242.1553870870937;
 Fri, 29 Mar 2019 07:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230939.15711-1-jannh@google.com> <20190329135708.GF21152@zn.tnic>
In-Reply-To: <20190329135708.GF21152@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 15:47:24 +0100
Message-ID: <CAG48ez2pcQCuGh+5yx8YixsgvrjVH2eTy1ShAnjLq8_91ncGvg@mail.gmail.com>
Subject: Re: [PATCH] x86: define LOADED_MM_SWITCHING with pointer-sized number
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 2:57 PM Borislav Petkov <bp@alien8.de> wrote:
>
> > Subject: Re: [PATCH] x86: define LOADED_MM_SWITCHING with pointer-sized number
>
> For the future:
>
> The tip tree preferred format for patch subject prefixes is
> 'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
> 'genirq/core:'. Please do not use file names or complete file paths as
> prefix. 'git log path/to/file' should give you a reasonable hint in most
> cases.
>
> The condensed patch description in the subject line should start with a
> uppercase letter and should be written in imperative tone.
>
> I've fixed it up now.

Ah, thanks. I'll write that down somewhere...
