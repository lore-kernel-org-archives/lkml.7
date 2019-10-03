Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D801CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5E021A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xh8EMbKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfJCKBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:01:22 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33152 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbfJCKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:01:19 -0400
Received: by mail-vs1-f65.google.com with SMTP id p13so1305877vso.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7o/eWbmZMF7tghY7GsYEgJqo9ZWWmUzNSO/fUncz0A=;
        b=Xh8EMbKY8aUMNCtd9DUk/0wH/Cr5O1kZc86NxICkCkr8/5PS8F6GlN+2xs/2vC4dRt
         ty6r0pI4DfdkBIGyf6NOHIOalxh4X7molyh8nDuemr2wIlG1iOjJph8u57o+djetShsw
         Kj/3UVZnZ5QOlYHJk7wQjcBrHqwGWCCqfUUK9DFrPxWL8a8F6nyvKqxbesZcVtcYsLm5
         NScs9MRfxVTUalFccr+KrbLArk0aUbbHEsoVQVQGSZOSXn5SIYwZikl3ey2zRAru/kfq
         o9Mb1VVopEMb9ew/nbeSwZnf6LsozSC7GavxSyBodf7NtSsDCx29YO3o8vkfL/P8gVU7
         /Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7o/eWbmZMF7tghY7GsYEgJqo9ZWWmUzNSO/fUncz0A=;
        b=JyDDqivK585elUixx/IT/l3iCdA2bzAyUSxIn3YzEx2TLCuXiLbKurduGHniIfJ5Mz
         9h5c4gvwPyO2anbA2q1frouF6t9RrjFo9tafP/0JZN2QZ5tFXZhifs3sw+l+g0hcQ193
         7WSqrHaB/EXhG4RuVWp3cwAFYND4LKJ1XmGCpW/E6Bt9vThb3VSX8RlgibQmTV2GrMCR
         meBtFzEoRNssaWrmQAU4F9Lystem5NNAyw0u0X+vOE6inTcKY7ZmfX7ZW2XeFBoZREqQ
         1bSYfaVRUry+zdlljpMYSoM7HLIV2ox0c1kyM2oVMaJ2vz5cFV9T9H+B53/GkxNQvv5Y
         d3IA==
X-Gm-Message-State: APjAAAX/GM+IVmf+gSrdd0lwr4tVGae6GdqMI1zsHImIJG3SsovUa1Fd
        RktAd5Y+K0V0fHqDE4NtmegPKGAYLJVqE2TIr0saKQ==
X-Google-Smtp-Source: APXvYqxL07NmXssn+CMHMD5w5w42iHOG7BGWk291TkCuQfaiwZmMl3OFL+eI+fxDOQEw+ydwytxswi6ADkBUqx8K79Q=
X-Received: by 2002:a67:fc42:: with SMTP id p2mr4559906vsq.34.1570096878598;
 Thu, 03 Oct 2019 03:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com> <1567669089-88693-5-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1567669089-88693-5-git-send-email-zhouyanjie@zoho.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:00:42 +0200
Message-ID: <CAPDyKFo0aR2fhCd8qCNAf7hoXSjV+9vG1BqB6vEM=B9Vpmpovg@mail.gmail.com>
Subject: Re: [PATCH 4/4] MMC: Ingenic: Add support for JZ4760 and support for LPM.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, syq@debian.org,
        jiaxun.yang@flygoat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 at 09:40, Zhou Yanjie <zhouyanjie@zoho.com> wrote:
>
> 1.add support for probing mmc driver on the JZ4760 Soc from Ingenic.
> 2.add support for Low Power Mode of Ingenic's MMC/SD Controller.

Normally we try to make "one" change per patch, unless there are some
good reasons not to.

In this case, it seems like you should rather split this patch into
two separate pieces. Can you please do that?

Additionally, please change the prefix for the commit message header
to start with "mmc: jz4740:"

[...]

Kind regards
Uffe
