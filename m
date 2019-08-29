Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5541C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A182189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6B8eP/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfH2UYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:24:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34128 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2UYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:24:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id z21so3576438lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cp2CEJFUGq3Gfe61jQRohcv6CnZbgkL+vG7MtbVJPWc=;
        b=A6B8eP/RWOFYzyBxLMyF9/VxvdG9VuYOAlq/QbtPOMBt1mmTqy5FQPPCliho0ie4Xs
         jEZtNt/UTzI8vdEdUAgA27mnZD0+m/INxjTgd+fe+xmRW+rISGzulmDqmFlt2bxUNZwS
         6C5Hiw/WIHSPpTvDjVVB9i/h05/mIShRJZJKF0v9PZ0xtfn+gnHaEdu03oScek2v0eRv
         jATfILMDly1Pz1M8Hbt5KeSj7c7Gc4sv7N/ggzqaxbSubuoeIYWM3wnkzNlJKPZvGEeY
         2U8QVuSkchS/c1T1LDV/03mU5G6jMzE31UK2cqNnho1iWPwZvWi7nKmD/A3Gw+CRtydK
         bf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cp2CEJFUGq3Gfe61jQRohcv6CnZbgkL+vG7MtbVJPWc=;
        b=XGo76pIFSR2GPG1bo8Or6x1cwGfrCm+ckRp6NTbui9DGgaN4bpANYwxICQjjzVk3IS
         cS8oVxv5MCDY94g8i0VWae+yUSS+rQNemiSSuE5SbT2Cp+WGo5WwvvlLRQ0hgs0rvfye
         nubA6k8j4oo4S8YomLs2H3uplCRB3nwFW/4u9gJ3gtxuqfXCwcW+yMhOSSq08fAnmQ7z
         1vumTIsWbik7dzOE0bmw5LYTIpaW1syujTrnvktiHPG2wDmanatmch/u0jsZ0F0R9SJc
         94o7CBLoMxZKBCCRHj6n/Ggp0OFmaItw8yzbykTPqHCOgv6ARx4ESIAgfVsHIqd30TKU
         wBrA==
X-Gm-Message-State: APjAAAXlgtAOjtT45s6EqGKRCGjmnFRWHH2QzHjMaY2qPcFBV/NS/hxW
        QbpvPnQnpDeWTIwhM663o2+urELyk1spdLFYjLg=
X-Google-Smtp-Source: APXvYqyEoQrhucnIu6r/BMRAF13gUTZglw7SSLMV15bDa0AqvFZI/eY52vFmGGmWjbrQiDsqbHDYG/p3N5lAc80iVYw=
X-Received: by 2002:ac2:52b8:: with SMTP id r24mr2764334lfm.131.1567110282255;
 Thu, 29 Aug 2019 13:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 29 Aug 2019 22:24:31 +0200
Message-ID: <CANiq72niUcQv-TFn=_0Ui7nEM9ESKNC7n6GPQs2AKXVsg6ZV=A@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] treewide: prefer __section from compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        David Miller <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:55 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Changes V2 -> V3:
> * s/__attribute__((__section/__attribute__((__section__ in commit
>   messages as per Joe.

I have uploaded to -next v3 so that we get some feedback tomorrow
rather than waiting for Monday.

I added a few changes, please take a look at the commits:

  https://github.com/ojeda/linux/commits/compiler-attributes

and let me know if you agree (look for the [...] text before my
signature). Specially this one since it is the one I re-added the
unused attribute as __maybe_unused:

  https://github.com/ojeda/linux/commit/a103a32ac6a2c8bbb8fb217af92c9f6bd08e138c

Cheers,
Miguel
