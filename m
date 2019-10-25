Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE2D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Y1QJCZEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439385AbfJYLfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:35:43 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43123 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfJYLfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:35:43 -0400
Received: by mail-il1-f194.google.com with SMTP id t5so1520548ilh.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1b1sJRR8uGtQj2FhrTPypk+/a4UxvaBsPLPDsEX5mJs=;
        b=Y1QJCZEWt34OZkweqTGCRXSrS9a3ROOBaXAODcX3a38kZtOAkVMLjl1g/Ux91+Y6mP
         mQk1OwZzJWlAdaZiLPpVIw4uwG2GfWWhpbYgHhSesuRUohORK0Mum2dax/vGVBtc2IlY
         bp5ke93WyeTZBvQRKvZRf/X5EMNps0PxvFmoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1b1sJRR8uGtQj2FhrTPypk+/a4UxvaBsPLPDsEX5mJs=;
        b=fB3rlGJzZwpXOd3zNuHLBEnCIIroSqDgg0XZPeedQtSyg0IYBJ+koJXLFIR4hRpJ18
         NNOKwEyAH9Ya5dovAKKKJxUBpkSNquSdQ+bIQxRFm+bZGr1qgS/meTqNx5N4EMDfQNrq
         yMO5hCXRmY5plJvEos21+Y7txyAkS8Dk4ysTh0tLo7sA5IRTdzxdsRUUX5TNHUe9bQQ0
         762kgb0ugWFRCrlub3q0wbRrEhjBkOP4zI/oacN11QgOFwy/RS6ZeMqrR5IIsmFtujK1
         sKIHZmpVI1Qr52LxXYJAAQi0hiCXJ0yxvFygNYKLfRQ/d3JMYx0ppKDVxmJ1RS54F4sF
         Ujtg==
X-Gm-Message-State: APjAAAV5ZXtf0RLAEkLDBx9fmXTDHMY6qMiJRGmdw7jhsD2huVpwq4eP
        76jzynMjoxoQJmOmEOxFFW++mDhZz7EHxNnVtM1ckwSyceI=
X-Google-Smtp-Source: APXvYqxcGpnrVgHOfwUkSRzKsKbaYPJTX2ifjXfnD38ngz8j9EFntIjY8HvgftcIOjcxV9UB9XkiUwlH49BuRJYuNLM=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr3426726iln.285.1572003331734;
 Fri, 25 Oct 2019 04:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191025112917.22518-1-mszeredi@redhat.com>
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 25 Oct 2019 13:35:20 +0200
Message-ID: <CAJfpegv1SA7b45_2g-GFYrc7ZsOmcQ2qv602n=85L4RknkOvKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] allow unprivileged overlay mounts
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 1:30 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Hi Eric,
>
> Can you please have a look at this patchset?
>
> The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
> whether I'm correct in stating that this isn't going to introduce any
> holes, or not...

Forgot the git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#ovl-unpriv

Thanks,
Miklos
