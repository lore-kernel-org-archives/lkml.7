Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D85EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DBB21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMiPkcct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbfDRQws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:52:48 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:55158 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:52:48 -0400
Received: by mail-it1-f180.google.com with SMTP id a190so4335527ite.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wt4ioWrxRp4SM6uty58Zpqheb4JhxE2L4iThCK/EJ8I=;
        b=EMiPkcctKgQemV/aH0/R7A5w+CBDuXdN62tSb7vHBCJkF5ZjVPXwOb8BjJkA3hGl+r
         CUfOUMNLWa5WNnahIgeU+U6js2wJtlKwiIK2L/T/gR4vBR2qZ8RxQMIjCNudbKOG9Z/p
         rvzqY051dPlIHymgCt8gWLxw8sIlhtCZe7xfEn8DVqI8c2hHSV+nzsItc8ZXkmUdQta3
         ZHFB6GkKa4FyTrP+Igl8pDSkx/k/4D0y79Akvccpm69k2kXkc9sOF6QOn4hlRWsRJYJg
         ET5SGiq87oN+hWGR/AtcA/AI4ukLvz49V5U298qaPP6FuCMR1MjYez+Rhd5OyRP2PC6y
         tAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wt4ioWrxRp4SM6uty58Zpqheb4JhxE2L4iThCK/EJ8I=;
        b=DkUoq68v3N5nBeZIWBoO+AQUjx4Qm4/Jn7DyrZ5MEj+heyITVYSmpyM1UxrGaFYVwR
         5aF7LUUgYjymfJIAOCO4OqBqT0gjm6IdT0xWzo6aBhoiYFmKHB7IYoHQ4VbGwTyAjkr5
         ouZ8MWXg+wzJQURs4CBF4G/ec6UJAixxqajuv5flgjD4kIHiwKyYkU7ipDWC1HX0yx4h
         l7rXaWa2MSKEdLf+usDboxj5I/qytFX97w3+KVHi1C2gzdz7tK+avnlv2iUB3l86J4gF
         SOkzfPeyJOhJ10aP8tB7r554HBH55rWs0O4Ghyj5A35gVOi3uc3k3/6STnMXAXFOGbxk
         /w4A==
X-Gm-Message-State: APjAAAUXkHSs4Dyv7ZdgeGK/ImKCO818YwUAYSxWN1Nz1byM2nQP7XIo
        gLKo+kq22KuamzHZiHwLfdu54rXHIpPaMlHMxQE=
X-Google-Smtp-Source: APXvYqzL36mj3MQawWHKIHEJykoyWYWFCT5TlpvqPbphg8Fq8vDdN7S2DnReLhou5x4VCZWhxV16FYZ1gI+NBde8y7g=
X-Received: by 2002:a02:c6d8:: with SMTP id r24mr16228929jan.93.1555606367238;
 Thu, 18 Apr 2019 09:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsM8gjvh8x9QyzbrbnSb-NmWpmmEUJnFiFv5MaPkcG=Ubg@mail.gmail.com>
 <CABXGCsMcS+H9jxEotmM3u8F28zhPobvT3+Hd_iWstFQN744v6Q@mail.gmail.com>
 <alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de> <CABXGCsNaw=mb0YF4Bkd5_CTwMfU=dNZ=RTV96dwO=UQy=n_gOQ@mail.gmail.com>
In-Reply-To: <CABXGCsNaw=mb0YF4Bkd5_CTwMfU=dNZ=RTV96dwO=UQy=n_gOQ@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 18 Apr 2019 21:52:36 +0500
Message-ID: <CABXGCsP414BbijQQ+NJkCV83zdCKcfCyR0NBwyor6z3T8CawDg@mail.gmail.com>
Subject: Re: [5.0.0 rc3 BUG] possible irq lock inversion dependency detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 at 01:07, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
>
> Thanks, with this patch problem was gone.
> We have time land it in 5.1?
>

I received automated email with follow content:

> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 1f50ddb4f418 x86/speculation: Handle HT correctly on AMD.
>
> The bot has tested the following trees: v5.0.7, v4.19.34, v4.14.111, v4.9=
.168, v4.4.178.
>
> v5.0.7: Build OK!
> v4.19.34: Build OK!
> v4.14.111: Build failed! Errors:
>     arch/x86/kernel/process.c:417:2: error: implicit declaration of funct=
ion =E2=80=98lockdep_assert_irqs_disabled=E2=80=99; did you mean =E2=80=98l=
ockdep_assert_cpus_held=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>
> v4.9.168: Failed to apply! Possible dependencies:
>     01daf56875ee ("x86/speculation: Reorganize speculation control MSRs u=
pdate")
>     26c4d75b2340 ("x86/speculation: Rename SSBD update functions")
>     5bfbe3ad5840 ("x86/speculation: Prepare for per task indirect branch =
speculation control")
>
> v4.4.178: Failed to apply! Possible dependencies:
>     01daf56875ee ("x86/speculation: Reorganize speculation control MSRs u=
pdate")
>     26c4d75b2340 ("x86/speculation: Rename SSBD update functions")
>     5bfbe3ad5840 ("x86/speculation: Prepare for per task indirect branch =
speculation control")
>     cc69b3498921 ("x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}=
")
>
>
> How should we proceed with this patch?

So I wonder is any further actions are required for merging patch to mainli=
ne?

--
Best Regards,
Mike Gavrilov.
