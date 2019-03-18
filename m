Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BDC20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiF99wgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfCRRJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:09:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40582 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRRJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:09:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so11816562pgo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yhMVf/CLsXX1hIyqYPcTSmZyWAXCDmBjuB8GqsfA+0=;
        b=uiF99wgTzOEOowvlYftVE2fPWmLFwKQ5QZvSDi5JPIEiHWJtsG/JiKzZ7t7EAVm3hw
         C6LQEEptUtjG2dYMkIev4T0WNh8J0S2jlBnk0tZz6mjnubVRtOdh3OEMAqrKFfxbczGL
         4oXckoFwyGS6HhlkyM2BNLlAXyTNsnmzEPa+dC+JsVEyHMnO0+Kfg8hhisNaSMKv7oYK
         gQpXd0NqAcQh28PUQ15c71kBdb+l4eEcJyd9dkwNcTgAsgpc+x5AfyeiyMDz9NZcGHTd
         YTtmpPILWSxhRMagDsvgmdF+8lDQd2W73hxguS7JtspdiJdvLJYANRoiBlD+NOhlf1MB
         UVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yhMVf/CLsXX1hIyqYPcTSmZyWAXCDmBjuB8GqsfA+0=;
        b=aOZgz54DVs0ElVPHb9hMeOKSWPsMaJTzvtgTwbZwZQLVG5xXKFi0iciAr3xdNsRG18
         wYzpJuZQx7DYOz9SYR5akFRNvV3Zvwy2MfbbM57f+fYnkyEm2NIg00hkvaCmYCBA3vQV
         r0ov+ogahesxkCSUyIUVF+doofqdumf6uKN9larqIk9P71zAEcGQ1u5+6C/JZx+kGzI6
         7bNDPG4O8is0XBudSZX6hW8+deSpuszKmtB7+G46zVlKe42mT4H9bKEf8NuBZMsN0Gc2
         3kpY5UWcrhk4fgXsGlTBlRC7VMobvC5iankGw8NzsXnQI244E3shAubavEf2RbE0wBip
         lAdw==
X-Gm-Message-State: APjAAAXlN8tg67VfgZwwTTTZVgCQGKHGZ/vhvXoG4QkT0x8U7iBvzAOR
        wQrrmVsrDr9AgHQ2DYc2p36A3Z/k+BlTOBqL0vmfmQ==
X-Google-Smtp-Source: APXvYqx39xFIflukjNJwdi8UQ2N4n8pFFN+fi5HMtHe5XOLa+kZzOYd0B4M8xY3bygpY240xCn1wW1px9P6qMrGCRGc=
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr20943580plx.13.1552928988458;
 Mon, 18 Mar 2019 10:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
 <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com> <20190315222906.GC112750@google.com>
In-Reply-To: <20190315222906.GC112750@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Mar 2019 10:09:37 -0700
Message-ID: <CAKwvOdkXobdu74Fo0fiS4xkikqZdKS=gWN61pVAFBbXRPoenRw@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 3:29 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> On Fri, Mar 15, 2019 at 02:31:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > Is there a config I can set to reproduce this, in order to help
> > test?
>
> I encountered it with a Chrome OS specific configuration, but a
> defconfig should do.

defconfig selects CONFIG_OPTIMIZE_FOR_PERFORMANCE=y.  I needed to
select CONFIG_CC_OPTIMIZE_FOR_SIZE=y to repro.  My CI is simply
running defconfigs, which is why I didn't catch this.

> Note that you probably need a development version
> of clang to reproduce this.

Yep.  Thanks for the patch.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
