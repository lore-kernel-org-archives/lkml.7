Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C91C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAD32075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxLsjAv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfEUIMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:12:36 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55149 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfEUIMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:12:35 -0400
Received: by mail-it1-f193.google.com with SMTP id h20so939466itk.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZKPhTsvfWLkzc9aYgb8rcUuPXo0Z18vJAH7SFmmWPE=;
        b=XxLsjAv5ZECYsuolBCX9u3iWon8vTuxGxM7q0oJxytZPyXdtCSZNluG+TDJ/dVl6tX
         aLExyAWJMA2XAOuGTL6z0Gs8QrNDvmn/UdF/34afrNMn5Vx/C16E6HQ4l2V+h5NJ7SVQ
         1O348oJrsNv4gE0YxWpNXJ10q65lUewQMbepVQy1LlVakaIXeQ+RZsDeIog7mMlaOEa9
         ANp2hRe3DrJ22pgqLu79/VzQpxFeHBeP3N7pk6fIyeV/wKympn80MCpSiAgQgZR3TSL/
         93VbQBcWKgWtK0nnbihaYmZHpRNbauSSZRSfMMqfMp1CHwQOz3MeS4Y4TVIu/6CP17rA
         U6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZKPhTsvfWLkzc9aYgb8rcUuPXo0Z18vJAH7SFmmWPE=;
        b=dgaHvYQ8Ax30qDF5nqDBTltJckz3noI5hwpl8f+3NIOXnqH9r8hovvsT7tFifIJzEA
         e0YTfvqHqbvO5BBVVuFhQ+oD9KNGcgayU3uU28OXhlAwAryMsRwpcr5ibQPhHzYCH2VS
         s4vo3CLDZQl+TBl0h9AXJrESrI3IU9HCXrX7AQ+Bs3t7Dr8vN2B9EQ461bh31Nnxyinm
         78i65ji8yhQKUuRc92fv6W8FCazsgNcEUekyMsDszsODDxiz30PjjVJalnq22owFrqaA
         5XOCZcbxmp/VcO3ja7fntScfvjgx8Px5+rdGVUL1HL5g/5uA3arn7ARH6cGAsxWdf2hM
         VPUw==
X-Gm-Message-State: APjAAAWZV02C26H2SsXh8+D+NB8qrAhAhbVtGeyLU9FXYGkkQNmlpo81
        d9v7iy922PBFqmFL/CNc8b+kw0xYT/rITecVygs=
X-Google-Smtp-Source: APXvYqzvIbTU7wBLO1RLHkGeWCvU6XJM+Iq+OZnl0PyI9FTajlSmyN6UUvOJKmC/wOxJhCNsRusIWyi7gGqwL4pDQ3I=
X-Received: by 2002:a02:c807:: with SMTP id p7mr53472481jao.38.1558426354698;
 Tue, 21 May 2019 01:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <a2fc0be9-22a7-cc0e-bdce-0a5ec7d31251@linuxfoundation.org>
In-Reply-To: <a2fc0be9-22a7-cc0e-bdce-0a5ec7d31251@linuxfoundation.org>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Tue, 21 May 2019 11:11:58 +0300
Message-ID: <CAJ1xhMVS=zJwitOACZ9CmxUo2-T1=6M7=wWF=ngL0=jg6eZdYw@mail.gmail.com>
Subject: Re: Linux 5.2-rc1 - module name conflict
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 4:01 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi all,
>
> I am seeing the following warning on Linux 5.2-rc1
>
> warning: same basename if the following are built as modules:
>    drivers/regulator/88pm800.ko
>    drivers/mfd/88pm800.ko
>
> My config has:
>
> CONFIG_MFD_88PM800=m
>
> CONFIG_REGULATOR_88PM800=m
>
> I don't recall seeing this warning before.

Commit 3a48a91901c516a46a3406ea576798538a8d94d2 introduced a new,
script scripts/modules-check.sh, that issued the warning in question.
See https://lkml.org/lkml/2019/5/17/419.

>
> Anyway just to let you know that there is a conflict in module naming.
>
> thanks,
> -- Shuah
