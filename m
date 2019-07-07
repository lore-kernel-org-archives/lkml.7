Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BC9C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 06:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A1A20838
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 06:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfGGGL2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 02:11:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46280 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGGGL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 02:11:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so12957978ote.13;
        Sat, 06 Jul 2019 23:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f6HeUv7mgbudCRRHNCvrlDER38PZ1qsXydjAfY6uFKg=;
        b=VMsJdpf9Hs/nuiUIGYzGYchCxqn6Ushx8COuzxtqoiaR4tDfLuQz4o4O++PpWu79N5
         4PyV6jJETMm6yCe7XBb4F3gaU7Pbj6GWTHV+FkHRHwV1B1AJH26U9GSzdhIXbdkYHCzv
         okImtTgOQ3PdUNqkrBRjVMDZKs2qE7LbadBVIBvqJwr6RtPQwJ6rMT8p8OavA0x0EL90
         rwXXu/JHFog4A5PTrMivcHT1pFTQDtchWGRqOWq6Nz0x26/Oc758SFWC3uulYIbEgHPY
         Bce16vhiCyFlgFJa2CoSB3CKy6sjecTNCEtWZi5Auf80gnQi0owxJ+l7UtBPBe4aaFiX
         BrjA==
X-Gm-Message-State: APjAAAVrIxR1Yeoeho8f6BH7it+2THg/xnC/R2NdRG/YQEyt/UF2aCwD
        8ZofCOfX6JuigfxvUZ+BaoCu8jR8m/RqbRLt9J8=
X-Google-Smtp-Source: APXvYqyfz3K7cMkwQa+wCD0qVQ1rIHzd1aLEjJKDdzPn/cuToS6HWchCIr5HLPlrS5Q/FriT0IRxCAyZvIlLkj2Cn4o=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr9591073otq.224.1562479886956;
 Sat, 06 Jul 2019 23:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190605053006.14332-1-yamada.masahiro@socionext.com>
 <20190706203745.af0bf9bd5dd46e94fa5e1ff9@linux-foundation.org> <CAK7LNARCjucs=0BD=00SD8Ljh+a0GtCUNHF4En=eSM1+VG0-4g@mail.gmail.com>
In-Reply-To: <CAK7LNARCjucs=0BD=00SD8Ljh+a0GtCUNHF4En=eSM1+VG0-4g@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Date:   Sun, 7 Jul 2019 15:11:15 +0900
Message-ID: <CAKFNMonV+Bsyc6HGP3qSXjrKnQMjhUmQjajt1Dwp0ng7qJaVYA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: do not use unexported cpu_to_le32()/le32_to_cpu()
 in uapi header
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yamada-san,

I'm sorry for not being able to follow.

Could you tell me how did you find the build error?
Still I cannot reproduce the error in my environment.

Or, if it's right that we should not use
cpu_to_le{16,32,64}/le{16,32,64}_to_cpu() in UAPI  header files,
I will acknowledge the change and modify nilfs utilities to comply
with the guideline.

Thanks,
Ryusuke Konishi

2019年7月7日(日) 13:31 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> Hi Andrew,
>
> On Sun, Jul 7, 2019 at 12:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> >
> > Seems fairly serious.  I'm thinking this needs a cc:stable?
>
>
> Ah, yes.
>
>
> Cc: linux-stable <stable@vger.kernel.org> # 4.9
> Fixes: e63e88bc53ba ("nilfs2: move ioctl interface and disk layout to
> uapi separately")
>
>
> Thanks.
>
> --
> Best Regards
> Masahiro Yamada
