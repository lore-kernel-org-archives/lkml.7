Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B44BC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B74520815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEPPxz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:53:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40346 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:53:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id q197so2564427qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JQI/WU1c4eX4Bc95K/7Uz+e1kJGO+JQuZlvUeSbbPGc=;
        b=P1036jmKbqm/AJyk+/tVpMqLuyrp4uLjX7FVpjOsOuKkAwDkxuiRNznB0shzilRP7r
         D4us/1t2NSsJugSSGfpAVazsx0tO1gPQlLvUNq9UtY2lo7jUGgHBhVMWsQBwidBpEp3S
         WAFkNo/A3BybRjnOcfXcxHS1FV7cjrWeq+i6yP2hpAA51sfimpkHPtqHpWeGu/Fa7KDr
         EM+4CznuB6xOHXSYtfuPYlRXR+5Ms/Gemn0rgEFJEALizzcacYGuPW58t94XVkFo5SOM
         u1uI3A6/xrAyciOH+qgnyQuYEXvH6NIt6eprzAFyevTYRAljgbSfPQfp16Q4bFx8/xVQ
         E6xQ==
X-Gm-Message-State: APjAAAW/2+RoOAu7pluCrb0pCLw6lKE0DvFsdP91Gt6IfuE2n6J24Nbe
        fUFNkiOOzui25IeXPilv+SIR4vwo0fYSz3hOiNkUH7mNd6Q=
X-Google-Smtp-Source: APXvYqxGacujl3xkC+1CQj9ZgVTewrIKspT5Krb7d0/OwrCP8EKuEx+9fNaCY33lbb5MOJouXqule4hfYCGQTcBKDzk=
X-Received: by 2002:a05:620a:1085:: with SMTP id g5mr23133232qkk.182.1558022034360;
 Thu, 16 May 2019 08:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190516064304.24057-1-olof@lixom.net> <20190516064304.24057-2-olof@lixom.net>
 <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com>
In-Reply-To: <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 May 2019 17:53:37 +0200
Message-ID: <CAK8P3a27zgq3c_iWHVfypAc-hLag06Bs=Q2D7bn4i4nVfPQSyw@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        ARM SoC <arm@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 5:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 15, 2019 at 11:43 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > SoC updates, mostly refactorings and cleanups of old legacy platforms.
> > Major themes this release:
>
> Hmm. This brings in a new warning:
>
>   drivers/clocksource/timer-ixp4xx.c:78:20: warning:
> ‘ixp4xx_read_sched_clock’ defined but not used [-Wunused-function]
>
> because that drivers is enabled for build testing, but that function
> is only used under
>
>   #ifdef CONFIG_ARM
>         sched_clock_register(ixp4xx_read_sched_clock, 32, timer_freq);
>   #endif
>
> It's not clear why that #ifdef is there. This driver only builds
> non-ARM when COMPILE_TEST is enabled, and that #ifdef actually breaks
> that build test.
>
> I'm going to remove that #ifdef in my merge, because I do *not* want
> to see new warnings, and it doesn't seem to make any sense.
>
> Maybe that's the wrong resolution, please holler and let me know if
> you want something else.

As far as I can tell, that is the best fix, thanks for the cleanup!

      Arnd
