Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E68CC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC2F2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyJ/rizP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfDYSls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:41:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44372 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfDYSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:41:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id l7so855748oil.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcxdzp5rfcZaAhi7zsbzX1v7vbGmzyJu023Nr18WuYg=;
        b=fyJ/rizPP3EwhDxQOiwAQZWVKUx0ZV8//ebph0sK2g0cyJTPYLHpKOTrWazOJEpN3M
         IbtXZeE5ayfvHr6mgWvVg3LhrYFXIphrD1FKEAMISvSSfoRbNDMEE5d0DtbQM/EdXTqh
         +RkqGql9L75zjnOT1MMN9FoQiWln9IZqvDJGIbF+2Ox8Iqnl3aNwuou6llrnKKGt7Kq8
         sFLO0Jl1HnR27h8b1lyCd5naInuQ07u7JGbYwvlDbDhSiOzVnSEMd8OASszhED2/q724
         Y8HfzraVmvncKjLqvMw2bBxPxG60UHzh4XOFwktYyrl6gEibGixrHzFtz19y8J85Q96w
         91Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcxdzp5rfcZaAhi7zsbzX1v7vbGmzyJu023Nr18WuYg=;
        b=B0ASPSVB3w30dcLlDBMoeuYq8r2VGLeNQuiErWF/0bW8Tb3ExO/aR+u5yD6HGJf585
         zuvyGw1j3d3l7acFGx/NkvHhjG0whE2OZXPDP4lILMD+jfD3PhpdcAnEOQQXXMF4PNe2
         bJedHQuxsb5MV6KehCPmZXMcANZdz7Pf6xKA6Okk7oGNw0p9yy+G7gWfD8wAMebVfnNa
         mQA7VDu4F7DLqi1OV2KZh/AwJ1VOlVZbLs6S9EmMuRlR2hoEHnlFgzMivL/G8CKEsy52
         69+CZ4wZ2XV9PU8TFtsQOcphLRyFeM5Uo1ovvaJ0GMCVcBDjNbfRS46bghPLEQnybFQw
         VeuA==
X-Gm-Message-State: APjAAAW8zW8sxW12bmNCy216IXGDz0SjF+bB5V+uDo6WQ+YUJNiDft9y
        n3+2uk/u17e+PuguicQF43j+plOu6DoBwLczQ01bJA==
X-Google-Smtp-Source: APXvYqzD2NSDIIHhHXjMgET0U2HDFJ0JWoq23dTNuhnPgg9Emv5j+rmKH84ZZMBJibS59glACitCJJo7rlUIVsM1Np0=
X-Received: by 2002:aca:dcd7:: with SMTP id t206mr4457535oig.68.1556217707324;
 Thu, 25 Apr 2019 11:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190425161416.26600-1-dima@arista.com> <20190425161416.26600-13-dima@arista.com>
In-Reply-To: <20190425161416.26600-13-dima@arista.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Apr 2019 20:41:19 +0200
Message-ID: <CAG48ez1NSNWx1vixsHrxkqyafEu1i=qC4dQwBLXc+gLnBM2Y0Q@mail.gmail.com>
Subject: Re: [PATCHv3 12/27] x86/vdso: Restrict splitting VVAR VMA
To:     Dmitry Safonov <dima@arista.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 6:17 PM Dmitry Safonov <dima@arista.com> wrote:
> Although, time namespace can work with VVAR VMA split, it seems worth
> to forbid splitting VVAR resulting in stricter ABI and reducing amount
> of corner-cases to consider while working further on VDSO.
[...]
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index babc4e7a519c..ff9875a4d53b 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
[...]
> +static int vvar_mremap(const struct vm_special_mapping *sm,
> +               struct vm_area_struct *new_vma)
> +{
> +       unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
> +       const struct vdso_image *image = current->mm->context.vdso_image;

Using current->mm in here is a bit awkward. So far the ->mremap
handler can only be invoked for `current`, but still, maybe
new_vma->vm_mm would be better here?

> +       if (new_size != -image->sym_vvar_start)
> +               return -EINVAL;
> +
> +       return 0;
> +}
[...]
