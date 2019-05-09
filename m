Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D353AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52F7217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557434900;
	bh=oxlVIqdW1xJXGhmjqKpiNLSLaYvxQIKY+fDw04WB6J0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aGn9TXJiD06qP/BP5z3tg/Rm36fBnkFBc4arttQ7aLX5M4HYcKy411eJ5iBFs7jbw
	 tMoagjpWLZ2oPV1qZkqB/Pc5lmkGDIBeuuOihEsEEPBlE5KUdDfERBCEwLldGh50gw
	 moZ9vjWhw1uNW1iwWrKRM1+YUyt/fQft8r3OFNZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEIUsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 16:48:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34471 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfEIUsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:48:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so2572538lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ujzrvNmPJ2OZ9Fy0FHiZkbFG2aSE886nyFWFqGQoMM=;
        b=fO6kGVJhaDxkC+qPOns61hP7GMjRnpzyqcJnS6HgMh9gEnza3SsxrFvbqW0bahAslo
         3u1vOi1w9PtOJNMb+Kau6RCEy1FnyOgyCyyyagPQmTXkoc/Ej4o+XoGRcbBFLgpEUIol
         TUHTDOTqS2qtNPTggnMo2J9hCaYw8vLpFxav8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ujzrvNmPJ2OZ9Fy0FHiZkbFG2aSE886nyFWFqGQoMM=;
        b=BPuLHfy4QrTKXRMlT/922e2ivWgwEaZrINuypHaWvfk5WreJb26U1A6P2eRVP9JMXF
         uVxx9zKV+hVCrOnW+2hPadht+XRU6q6cfUrv2xOUy7J2Dg5LAEhrzim1oEMWNTikzqpH
         cn6s3PcSn1AoUJlhAVSl2ge4k3cgrSonu6DgRz1NVYAzM2p5ZJx6twcc+IauxEajl6vQ
         JJ5G/4ab+OioY8SPA0lxmRyiLduaxr6fznAz2rKVne5puDC9KS7/LXAV83hxGE73ditd
         +qV2P7K3/F6vdJzTltkMfe7fFLGAiyIfCOX14fWVD6SVm1MMXK7zjvVuV6Sdmu2PKi0H
         8D5A==
X-Gm-Message-State: APjAAAXqNK4sOxZhD6YHQio0grF/vhFMvt+9fssE/BSksDzBW/5eZ9GB
        Nm6JK1YkUbV1ZIC13gY2m+ptELLsWNw=
X-Google-Smtp-Source: APXvYqxUGxyhAmiR82iZPH8tQrjl9QLXFMfLd+gObnKtfBra9LWWivxI4Wvn9RaaeFjrTKLEQTi+yA==
X-Received: by 2002:a19:f243:: with SMTP id d3mr3501067lfk.168.1557434892456;
        Thu, 09 May 2019 13:48:12 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id u26sm586388lje.56.2019.05.09.13.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:48:11 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y10so2558966lfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:48:11 -0700 (PDT)
X-Received: by 2002:ac2:5212:: with SMTP id a18mr3760884lfl.166.1557434890884;
 Thu, 09 May 2019 13:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190507175912.GA11709@kroah.com>
In-Reply-To: <20190507175912.GA11709@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 May 2019 13:47:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=Uscp=yO1p===JjH3x9NS-ez+wrk64Z0pw7EGfWvVTA@mail.gmail.com>
Message-ID: <CAHk-=wh=Uscp=yO1p===JjH3x9NS-ez+wrk64Z0pw7EGfWvVTA@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.2-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Ok, this may look irrelevant to people, but I actually notice this
because I do quick rebuilds *all* the time, so the 30s vs 41s
difference is actually something I reacted to and then tried to figure
out... ]

On Tue, May 7, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Joel Fernandes (Google) (2):
>       Provide in-kernel headers to make extending kernel easier

Joel and Masahiro,
 this commit does annoying things. It's a small thing, but it ends up
grating on my kernel rebuild times, so I hope somebody can take a look
at it..

Try building a kernel with no changes, and it shouldn't re-link.

HOWEVER.

If you re-make the config in between, the kernel/kheaders_data.tar.xz
is re-generated too. I think it checks timestamps despite having that
"CHK" phase that should verify just contents.

I think the kernel/config_data.gz rules do the same thing, judging by
the output.

I use "make allmodconfig" to re-generate the same kernel config, which
triggers this. The difference between "nothing changed" and "rerun
'make allmodconfig' and nothing _still_ should have changed" is quite
stark:

- nothing changed: rebuild in less than 30s

    [torvalds@i7 linux]$ time make -j32
      DESCEND  objtool
      CALL    scripts/atomic/check-atomics.sh
      CALL    scripts/checksyscalls.sh
      CHK     include/generated/compile.h
      CHK     kernel/kheaders_data.tar.xz
      Building modules, stage 2.
    Kernel: arch/x86/boot/bzImage is ready  (#9)
      MODPOST 7282 modules

    real        0m29.379s
    user        1m50.586s
    sys 0m41.047s

- do (the same) "make allmodconfig" in between, now rebuild time is
just over 41s:

    [torvalds@i7 linux]$ make allmodconfig

    [torvalds@i7 linux]$ time make -j32
    scripts/kconfig/conf  --syncconfig Kconfig
      DESCEND  objtool
      CALL    scripts/atomic/check-atomics.sh
      CALL    scripts/checksyscalls.sh
      CHK     include/generated/compile.h
      GZIP    kernel/config_data.gz
      CHK     kernel/kheaders_data.tar.xz
      CC [M]  kernel/configs.o
      GEN     kernel/kheaders_data.tar.xz
      CC [M]  kernel/kheaders.o
      Building modules, stage 2.
    Kernel: arch/x86/boot/bzImage is ready  (#9)
      MODPOST 7282 modules
      LD [M]  kernel/configs.ko
      LD [M]  kernel/kheaders.ko

    real        0m41.326s
    user        2m17.822s
    sys 0m54.561s

No, this isn't the end of the world, but if somebody sees a simple
solution to avoid that extra ten seconds, I'd appreciate it.

                  Linus
