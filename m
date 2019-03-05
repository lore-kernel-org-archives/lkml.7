Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5609FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FFB20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otcOw1+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfCEN41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:56:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36726 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfCEN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:56:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so5767557pfa.3;
        Tue, 05 Mar 2019 05:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyHJxLOBQ4frqWL9g0iXwMnceGr6NZV0LB0uzcou9Y8=;
        b=otcOw1+HvDRlikBukTO9Q9esahSEQVjhMASu5si5MB7WtOksfmaPHTEQrfxjrTlt/z
         WrlFPkeryJ4WyHCIt7/4pxR98cuq/tqN4I9DNHRt/15+7b5caC2YM9jpV4qzpedHK5KV
         TVLg8WOEoALzGa4VuXrEMtLV4mBTk6yD4/QOWD8XIgrxg9K3vbxfpFd042ZzIvtW2g98
         uiatLKxVv6a0WhGZ70VNFY/FDvoVE0aKHq/4UggYfNVarthtEhmO7g6vEQrcF+wkQiL8
         1RbxB7kQNjBjMftZj5sz0FBvY5yzq4GV/XuCtFWI38bDJxswDL3PpVrfabtNpjeW5jaI
         5t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyHJxLOBQ4frqWL9g0iXwMnceGr6NZV0LB0uzcou9Y8=;
        b=e5dmgJBan5DDZhNn2e5ZOSQA9PfGJ0dlNI5ek8r+X1/E21yZxntM8HawkZV/LvC3rZ
         q3XNIhPOySaSiqFMBPfflkgYxjzgTHtk0PYvzM6NyCzFEqm7oJm4qr6cED+TeqxuDEXB
         Xbw+ZOaOoRRr81UomCdp0sXvss/eGHa3jJ1UcJ7wiHTH6kINfVT3nLE8EaCli8fmVs0p
         O9fXJA2UUvIRT/ELyVHI70PYn/BpO4RnFIB90hji8agmVpLieudF94P34Bmwzs+ok/Q+
         elV9k3uIKTWE+vBFl4Ebp63WcX/25r0LG5f7LUrH8rGZ7pbg3QJCsuOvYNQ8WAQfyOD7
         gOqg==
X-Gm-Message-State: APjAAAV61AaO0nJx4uxkRlSo6Cf64Fx9kyd2ivQKs42L6Nh1ZLsRE6ii
        HLs4gzR0PwjpasDULYWurN63YeSWJi5t9JacV9c=
X-Google-Smtp-Source: APXvYqy11wVC+NllZaRyAEkAHCP0N4I/P63coZlpUaIX7CeZZUoPFeXMW43h5g4lt4IPMAl/irKRU0lZiy+MmlWJeuI=
X-Received: by 2002:a17:902:728d:: with SMTP id d13mr1377687pll.12.1551794186365;
 Tue, 05 Mar 2019 05:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20190304201930.1622839-1-arnd@arndb.de> <20190304201930.1622839-2-arnd@arndb.de>
 <a94c3c6a-481e-96a5-74e1-8c3299c74129@metux.net> <CAK8P3a0vdhCTNTF-K0mXjRWkPvv0qr3nf_52=8n6zTa7p3ELLw@mail.gmail.com>
 <54a7d035-155f-c47b-1db1-acb851b3aec6@metux.net>
In-Reply-To: <54a7d035-155f-c47b-1db1-acb851b3aec6@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Mar 2019 15:56:15 +0200
Message-ID: <CAHp75Vcd0eNCBtxb1huMBGFF9JXmropHv2YA1eh-yK3iMFfuFQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: apuv2: fix input dependencies
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linus Walleij <linusw@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 3:50 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 05.03.19 09:23, Arnd Bergmann wrote:

> > 1. try to use 'depends on' if you can
>
> Well, this has the unpleasant side effect that we often have to enable
> a lot of things, just to even see the individual driver. For people who
> just wanna configure a kernel for their board, this is a bit nasty.
>
> But, okay, I'm going to do this w/ my own tool - I've written a small
> tool that allows easy kernel reconfiguration on a higher level: you
> can just pick some board templates and enable high level features like
> eth, gpu, etc - it automatically creates a .config for you. I'm going
> announce it on lkml soon.

Darren gave a talk about merging kernel configs to get something like
you want to.
This tool is quite long already lying around. merge_config.sh in your
kernel source tree.

-- 
With Best Regards,
Andy Shevchenko
