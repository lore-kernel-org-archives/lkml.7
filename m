Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF38320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfCFUPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:15:31 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40786 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfCFUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:15:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id h28so7610926qkk.7;
        Wed, 06 Mar 2019 12:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8vUM2dDzUO4JJB7vWL6CinrzSK68AXeVE5JXTfM1VM=;
        b=K46RDHkwmN9uiV7v80q9rAeDgJowc9NudZxeWOqJciAwNJSiAlHnQB6VHhMiqH2tXh
         SpSk/aHp3L0JJvBDqF8yFThrPODP1tmCreqHuGh21iuF1fqgbafjQzqAYBSc6j0PPMGy
         qV+h9uMFYW/BnVvOvMJdLGGJgE6kh/BjsgFI3or1ONyhNdvJfLrdwS5xUBAJnTFipVPl
         mHCkmhMj316d1EjIu6vy7Co/DRr1ibwjHHUbyEVrcM9zxdb6xXT+0MxUuZeXOIM00u8Y
         6EULMnIl4eUtUjF/25v2IZafH8FzQkFnu7auEK2BCXxengVOF/OSB34yI+ON/NPvawPF
         OhWQ==
X-Gm-Message-State: APjAAAWegHXL1cWg9dZGARoM7ZImNfbb4DWC49HG+SE2MgkaECSxAB8x
        yMbL9V0GOFNWdyyEfe6IpCJV7TbJeXM2qbREuSg=
X-Google-Smtp-Source: APXvYqy2nT6YuZJWhwfnNpI0VqjIbugoFDZZKmPYkg7ecq/5Ixqri+zGB2lME6JJF+zUpVHwN1/PRVBNUYAJoMkft4M=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr6862931qkf.107.1551903330048;
 Wed, 06 Mar 2019 12:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20190305132147.3739133-1-arnd@arndb.de> <20190305143453.GC8256@zn.tnic>
 <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com> <20190306175808.GA30016@agluck-desk>
In-Reply-To: <20190306175808.GA30016@agluck-desk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 21:15:13 +0100
Message-ID: <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 6:58 PM Luck, Tony <tony.luck@intel.com> wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>
> This seems cleaner than adding all the EXPORTs to skx_common.c
> I also tried a build with the 0x8A152468-config.gz that Arnd
> supplied.

It's still a bit fragile since you do something that kbuild doesn't
expect with having a file in both a module and built-in code
in some configurations. I'm fairly sure this version works today,
but it would break the next time that file gets changed to include
a reference to THIS_MODULE, or anything else that is different
between built-in and modular code.

Another alternative would be to mark all symbols in this file
'static' and then include skx_common.c from the other two files.
Of course that is also ugly and it increases the overall code size,
so I don't see a way to win this.

     Arnd
