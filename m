Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76295C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDD520854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfCRJGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:06:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44231 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:06:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id w5so8705627qtb.11;
        Mon, 18 Mar 2019 02:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7Xoc2YtB6Oo5DU83WCFpk/cU4V9NzCsDrCcvzL8l8Y=;
        b=RliUiLN1+HoW+STcLFF8a5yD7X3ari0xMFqX9BZtOeZw0mx3jiYm8T0XbTLvKHW00s
         p8759F6dagvTAnXWQ57WFJ7p33jq6g51K2cu+dSbOyU4Ksd2rvXUG+A6x0ixsHLNPk0o
         vEMmnnY2+cykYTwy5JdV92/4VFKa34DS2vyoYtHgkZT3G6ItXeeGEKnD6QOB8sZCk3Uh
         MSWc1VFMDfg9ZToPbFaF+3xngCETdRe9XKBOQcBVqvY5uADAPKmjR7wtkBFSDVKHIz/t
         NgZifabiMlVx101pRYRhdhfQV0AjEcnbaGN9Jxb6QdhB9boLrq2rkqJKgLRxPF/M0mc6
         hcsQ==
X-Gm-Message-State: APjAAAUNks5vNKnyKIzm+az+GANnxoPlvAgstAkeN7zsGBKepx+p99pf
        djmSyOOsxIZvty4ZQSdYM9vajEXwJNXheXN9REE=
X-Google-Smtp-Source: APXvYqwN/N//cdPNb+NaeocPGglRpwoECZQGwuJBwCzgZi0DnT7HHyJ/S+M4POAwf5LLc6K3NBngjrwMLXejDN90t3k=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr12700658qth.319.1552899964522;
 Mon, 18 Mar 2019 02:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAS5-e6QcJqSg_c2NBS=11ZZ-KFWLqDZYxWTu0wPFHg=cQ@mail.gmail.com>
In-Reply-To: <CAK7LNAS5-e6QcJqSg_c2NBS=11ZZ-KFWLqDZYxWTu0wPFHg=cQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Mar 2019 10:05:47 +0100
Message-ID: <CAK8P3a2CAHmiPe41fFh0vUR51G86UYtxqPjMzFFxigh6mSP_JA@mail.gmail.com>
Subject: Re: Enabling -Wint-in-bool-context
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 9:46 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd,
>
> I saw several commits from you
> fixing -Wint-in-bool-context warnings.
> Thanks!
>
>
> I guess we are almost ready to remove
>
> KBUILD_CFLAGS   += $(call cc-disable-warning, int-in-bool-context)
>
>
> In there any concern about re-enabling
> this warning?
>
>
> When I asked 0-day bot to test it some days ago,
> I just got a report
> for drivers/net/ethernet/mellanox/mlxsw/.
>
> Perhaps, you may have better test coverage
> and have noticed more warnings, though.

I had this enabled in my randconfig testing last year, but not after
rebasing on linux-4.20. My plan was always to enable the warning
(and a few others) eventually, but this was part of my idea for
a larger-scale rework of how we handle warnings in the kernel,
and I never got around to implementing that.

I've turned it on manually again now, will let you know if something
comes up, but I expect that we can simply do it and fix any
warnings as they come up.

      Arnd
