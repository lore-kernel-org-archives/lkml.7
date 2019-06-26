Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71552C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3487C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDG9THSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfFZEkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:40:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34778 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfFZEkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:40:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so1228820otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1Tx6hW48tWiA/Izb/w3vicI3ly2WQB2siq+u/tEzxo=;
        b=gDG9THSojY0XQqfQlzWkYg3ux8Ratr6ecHKdE4kag2yxNI2HzUDTaPuex8a79ZTUHg
         KbA9skWcdhdIjp/WPLtaOARIGP18dHP8xYNj+LeaeAw0+hdgfj+hrIon7LR5t8zBmIv2
         dyLVCZZbYt5v3UbtDcMAAMa4spIXnnZ6n5CSpAb2/NnqQnyhXknkGsr1/6M34mPoS7t5
         XCRf1Vw/27pVy6ipVYnGRGeF4ww+dFdvvodRXMQdg3yQ2SwzvLC46/SLUyGs/o9UI1BA
         rpl4qyMaxB7YCc7eyeqjD7+z5l+pa/27DAXWoFMC0Ft8SfF2VyLTLW4wYawaMl/+LX9O
         wLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1Tx6hW48tWiA/Izb/w3vicI3ly2WQB2siq+u/tEzxo=;
        b=ACF8rutsY+mJQOcVo4X/l3K9v0dOkV08eXXJ6nHJVM9L00itc50ga1MxPJQ75pqVhp
         +7eIEPiMmmQ/peAgT+R4xeRjBsAaOLIUBywdHeOrvK/Uc4IN+rh/4dP/ddJuZ3o6Unzl
         QYjpbPWTSoU0uiy6gYe73zUD9RdBXJZayy2Zsfh5ceKtinqpk2I6+A8PfiA8eJZ90t+z
         M/rWif+NmMf/1xVmBfOwCmmTPoMUZnYUmBrPpiML/z5Y2YhUz4uYtxNjqWezl7Yf/r3C
         AiUu+CnViMEQtqtNEGlNbcgzHI56XH65mzmo/bLGDdJWrt7sNCQ8tlsvTdcqsChO4LEy
         TQLw==
X-Gm-Message-State: APjAAAVVQ1T3JAXPLNlZC9voPdTzzyLVAnyCRQPfbgBRttTIWsoQxsud
        72Uf0crF2E/ARJGGmLnacioGe4bTfgVK6E/hiTqhyf6/9Wg=
X-Google-Smtp-Source: APXvYqzAeMq8PT8el6Qv/4swP/UqCGHHNkDDdTwN72DbcsXy9JARTKrLF0dJV5+LzMd+dweoCQwIMd+RwVqd93dqSuM=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr1704290otn.327.1561524013040;
 Tue, 25 Jun 2019 21:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <1561479779-6660-1-git-send-email-dianzhangchen0@gmail.com> <alpine.DEB.2.21.1906251835370.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906251835370.32342@nanos.tec.linutronix.de>
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
Date:   Wed, 26 Jun 2019 12:40:01 +0800
Message-ID: <CAFbcbMBFS5h6asOpAma_Zq3T1TS31Pno1s9BkWDnYg0zk2ps0g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/tls: Fix possible spectre-v1 in do_get_thread_area()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 12:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 26 Jun 2019, Dianzhang Chen wrote:
>
> > The index to access the threads tls array is controlled by userspace
> > via syscall: sys_ptrace(), hence leading to a potential exploitation
> > of the Spectre variant 1 vulnerability.
> > The idx can be controlled from:
> >         ptrace -> arch_ptrace -> do_get_thread_area.
> >
> > Fix this by sanitizing idx before using it to index p->thread.tls_array.
>
> Just that I can't find a place which sanitizes the value....
>
> > +#include <linux/nospec.h>
>
> and nothing which uses anything from this header file.
>
> >  #include <linux/uaccess.h>
> >  #include <asm/desc.h>
> > @@ -220,6 +221,7 @@ int do_get_thread_area(struct task_struct *p, int idx,
> >                      struct user_desc __user *u_info)
> >  {
> >       struct user_desc info;
> > +     int index;
> >
> >       if (idx == -1 && get_user(idx, &u_info->entry_number))
> >               return -EFAULT;
> > @@ -227,8 +229,9 @@ int do_get_thread_area(struct task_struct *p, int idx,
> >       if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
> >               return -EINVAL;
> >
> > -     fill_user_desc(&info, idx,
> > -                    &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
> > +     index = idx - GDT_ENTRY_TLS_MIN;
> > +
> > +     fill_user_desc(&info, idx, &p->thread.tls_array[index]);
>
> So this is just a cosmetic change and the compiler will create probably
> exactly the same binary.
>
> Thanks,
>
>         tglx
>

sorry for being careless, my bad.
And thanks for suggestion, i'll fix that in next version.
