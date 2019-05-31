Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD378C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601C12190E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mE2jYH5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfEaIRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:17:21 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59589 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfEaIRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:17:21 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b4311862
        for <linux-kernel@vger.kernel.org>;
        Fri, 31 May 2019 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=vV7g1HtOkLPHTvxQrsleWOReJbM=; b=mE2jYH
        5Srr0VaX5IhWi4RYsPM6UCGhdNhoAo2RdcwoxJwAGYmp1d4TDrwwZQW97/GrMK5L
        yZtHOh/EWBZ2nBt48z+VjP/gHhDQo8SHJKFFhVJf3UcN/1aeecFc46izrko1CrZa
        iR/ub5UJl+pAqPShngyZqHGofOLvnZ5jc3Mvw7M5xNpbJPRfNnAmg7BOfn03/gtU
        GwkzlaSR0ADHwSdHXZMG1whZZfWC7E3M44HTMVBsOezsJ1hTbc0niBlp5Ma/3tWX
        V+A4WicwjnfWzuaqJxgereyupFcNJimH7ABRJ3LZFxurM/aC7HlTNjsLi4UHx0DP
        D/SYbbUaKf2d5qcw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e2395b8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 31 May 2019 07:46:37 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id k24so3232529otn.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 01:17:18 -0700 (PDT)
X-Gm-Message-State: APjAAAVdVINkQ94i14EOs6dCnYMG01OQCRPI7nX/zG0GRZUliXtl7cmM
        qC5mNfXMSGiUbDwpZDTcAsC/QXv6Jh6r9uKdcvk=
X-Google-Smtp-Source: APXvYqzKlmFhru/pDXwRMaqmgR2Y/k1KGYrsdsEkXEeczEVUJb1npzo66YeAU86gOb81lEwqLHhnBbJYiLGfALQJ+6U=
X-Received: by 2002:a05:6830:1612:: with SMTP id g18mr845264otr.243.1559290638103;
 Fri, 31 May 2019 01:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190529182324.8140-1-Jason@zx2c4.com> <CAK7LNARFUaaJH+g3oGzwFyKnELum72nOzxnvUfMKYBaAoGVkug@mail.gmail.com>
In-Reply-To: <CAK7LNARFUaaJH+g3oGzwFyKnELum72nOzxnvUfMKYBaAoGVkug@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 31 May 2019 10:17:07 +0200
X-Gmail-Original-Message-ID: <CAHmME9rGAUW9hjjZ7ZqNvZvaOCGrVHs3JNhYyr6g2PhZgS3TQg@mail.gmail.com>
Message-ID: <CAHmME9rGAUW9hjjZ7ZqNvZvaOCGrVHs3JNhYyr6g2PhZgS3TQg@mail.gmail.com>
Subject: Re: [PATCH] arm: vdso: pass --be8 to linker if necessary
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Masahiro,

I'm not sure exactly. I did just notice another place --be8 is being added:

ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
LDFLAGS_vmlinux += --be8
KBUILD_LDFLAGS_MODULE   += --be8
endif

I suppose it's possible that this is kbuild related where one of those
isn't winding up in the right place. I did see that the commit that
this patch addresses uses "=" instead of the more usual ":=" or "+="
for whatever reason.

Jason
