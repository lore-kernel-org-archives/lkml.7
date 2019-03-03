Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E502C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3F62075B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZicyOYPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCCQMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:12:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40253 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCCQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:12:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so2726699qta.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Scldm7asFmkFv3RFdwemKhngiSVl7tHyiBYeIj/ElUA=;
        b=ZicyOYPebOfcqWDlSm9bqi6Jv6gGnYB6GWPwpVakCgxS3XiA8fNZoD3ac2FyigjepJ
         xtd5plynsXkzIFYV0CWK6LGo0rv/K5k+b5fkR2QOOvQ8SRmYbnjkdStIt1KxuiS71Zh8
         14s7gAIJf9rbgpH1Pq1D6aJWBB5VjHoNn1oKY3es5TYPdEMBtb2vLCpXmthjYDtAzDqG
         r+ziXl0Dj/DloABoXZmP9CZ5lyI/Fpmi/6xJhcGjlleI4AZB5Ph6LoAGYLJL+WBG0rga
         6pKhY9re9rP6kcW9zwwwXeBNWFTx/gY46EGFRhs+cj4mQc+L9nAgjmJNYfnj8qop23eH
         xptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Scldm7asFmkFv3RFdwemKhngiSVl7tHyiBYeIj/ElUA=;
        b=EAXXAy+noHY3c0HyuGDMSbmubsXflM3HmchsIx42dvrntzN9h9hwXcLij6x5lckwul
         KxzJDY+6vB2D9HXY0G5kom/9KTb5al0nlrHmkwgOnJ8vfqceWgX3WU6YH2wZq7SIiOx9
         OAGLYphXD5u9j75gwzh+IZnWiLA5+fR+Y/AWd+vH8o4iMUBCx5Cb9gnUEbNW85UUm4Kd
         0ZE+E8WhF5gcHnx1M76Pq9NjnlM9Z1apNCdHq9lI237FO88AlI01MqQNgA4mHaNAmJyo
         rLgs72GZ2+WKeWzzIZqnZZLjPEFd4YRn5b0oJNjiK5NPf/Yl4MRVA+bffOEdsJJ4Cdvd
         6u0Q==
X-Gm-Message-State: APjAAAV15MrMWhRXxl7FJCk2mvpuLKbYnoUtEcEMPU4JPGntPts3qu2n
        +glN/Bpg5xTJhScoT/m25x4vmhqKcURbAvuba40J0Q==
X-Google-Smtp-Source: APXvYqzEae83UdXzlFdX830+tuKK2j/CkNUvJ0+roUvZTP2BO2j0eUq6ccK1V5OdVKdgCzRbjUAuIl5ZQHSIWWdTEPI=
X-Received: by 2002:a0c:bd97:: with SMTP id n23mr11452843qvg.58.1551629529955;
 Sun, 03 Mar 2019 08:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20190301160856.129678-1-joel@joelfernandes.org> <201903030526.3AuYFiuN%fengguang.wu@intel.com>
In-Reply-To: <201903030526.3AuYFiuN%fengguang.wu@intel.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Sun, 3 Mar 2019 08:11:59 -0800
Message-ID: <CAJWu+op541tQ_TBJs-kOyRRBYDWiN0Znpb=cUQFxuLg-SmjO_g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     kbuild test robot <lkp@intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This report is for an older version of the patch so ignore it. The
issue is already resolved.

On Sat, Mar 2, 2019 at 2:00 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Joel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.0-rc8]
> [cannot apply to next-20190301]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes-Google/Provide-in-kernel-headers-for-making-it-easy-to-extend-the-kernel/20190303-014850
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=sh
>
> All errors (new ones prefixed by >>):
>
> >> find: 'arch/sh/kernel/module.lds': No such file or directory
> >> find: 'arch/sh/kernel/module.lds': No such file or directory
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
