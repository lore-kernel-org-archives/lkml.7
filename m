Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89BFC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05FA217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ye5VPeIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEIWrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:47:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34348 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfEIWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:47:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so2083225pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZRf/O+AYO1pjasRFrKqOyps3I4eNGFPQS8KhShdX90=;
        b=Ye5VPeIClHIvOa3yb/Txa2nZfvUQR7hyXGf8jlN8r7iBdWzaJtSWZksEgYFQpdW+le
         CqqejGHpFq3qNoZ6SId2I8t2xH38UIuS4VQ0klh21WPl8hWhSZnaIBHQpZQdxggBGLJb
         zkdOrKjnmeaLHbdYu1LbpWW+AHV9M7rizlsQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZRf/O+AYO1pjasRFrKqOyps3I4eNGFPQS8KhShdX90=;
        b=gKE9AvBtRKLsfB69DYMy+82cGQ39yS2Jn2acntoN8RwgcfecV5oJXPHpnhsDI6iPE7
         2GngBeQ7JhiX7E+ktAci6Bze6FXcJavQMz4OqSG5NRUZ6aV+rOCLGNnpXGkEjWT5kWas
         OKmiHhgdAfyWT4cOOf0IzxAc4+Zm2dQlFTw707P2ggh2n6xSy6lZjTnXW01bc9HXC8+8
         omj+ugMqG2AtHuBkZ9DC9dlaHocEqqENqD0DEspJogeOL3tztyW0ZkV+OnerCw1wbDRg
         Nh00WWQl8hOSIv5XGyC3GILiRUwGacQPS593ISUuTMFdCaA8WDgsZhGL2gVo2pKfmbVN
         s2/g==
X-Gm-Message-State: APjAAAVe/Pde/LPj9WTPawZBxapQxRfAML8osu6ZTiZr02YP3yMNNBFQ
        8b/3X8Q2vh0Vjjj03wQXzksJOA==
X-Google-Smtp-Source: APXvYqwO0Rpd3ouiehbTSdDrhChC3UhFFIDoCyfVb2yZJbYtD/jBLOeJxKNQDgTgWjLrHtJmKc4WbA==
X-Received: by 2002:a65:43c8:: with SMTP id n8mr8758516pgp.365.1557442066517;
        Thu, 09 May 2019 15:47:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h6sm8950991pfk.188.2019.05.09.15.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 15:47:45 -0700 (PDT)
Date:   Thu, 9 May 2019 18:47:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        atish patra <atishp04@gmail.com>, bpf@vger.kernel.org,
        Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        duyuchao <yuchao.du@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3] kheaders: Move from proc to sysfs
Message-ID: <20190509224743.GA29215@google.com>
References: <20190506013456.86061-1-joel@joelfernandes.org>
 <CAK7LNAQesyT-vspoGKdgRqycZfhtJm5Upx2T6ij-yB5i4Nx5nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQesyT-vspoGKdgRqycZfhtJm5Upx2T6ij-yB5i4Nx5nw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 12:43:34PM +0900, Masahiro Yamada wrote:
> On Mon, May 6, 2019 at 10:37 AM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > The kheaders archive consisting of the kernel headers used for compiling
> > bpf programs is in /proc. However there is concern that moving it here
> > will make it permanent. Let us move it to /sys/kernel as discussed [1].
> >
> > [1] https://lore.kernel.org/patchwork/patch/1067310/#1265969
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > This patch applies on top of the previous patch that was applied to the
> > driver tree:
> > https://lore.kernel.org/patchwork/patch/1067310/
> >
> > v2->v3: Fixed sysfs file mode nit (Greg).
> > v1->v2: Fixed some kconfig nits.
> >
> >  init/Kconfig                                | 16 ++++-----
> >  kernel/Makefile                             |  4 +--
> >  kernel/{gen_ikh_data.sh => gen_kheaders.sh} |  2 +-
> >  kernel/kheaders.c                           | 40 +++++++++------------
> >  4 files changed, 26 insertions(+), 36 deletions(-)
> >  rename kernel/{gen_ikh_data.sh => gen_kheaders.sh} (98%)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 26a364a95b57..c3661991b089 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -579,15 +579,13 @@ config IKCONFIG_PROC
> >           This option enables access to the kernel configuration file
> >           through /proc/config.gz.
> >
> > -config IKHEADERS_PROC
> > -       tristate "Enable kernel header artifacts through /proc/kheaders.tar.xz"
> > -       depends on PROC_FS
> > -       help
> > -         This option enables access to the kernel header and other artifacts that
> > -         are generated during the build process. These can be used to build eBPF
> > -         tracing programs, or similar programs.  If you build the headers as a
> > -         module, a module called kheaders.ko is built which can be loaded on-demand
> > -         to get access to the headers.
> > +config IKHEADERS
> > +       tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"
> 
> 
> I suggested "depends on SYSFS" twice, both in v1 and v2.
> 
> https://lore.kernel.org/patchwork/patch/1069806/#1266147
> https://lore.kernel.org/patchwork/patch/1070005/#1266279

Sorry about missing that. I have made a note of this, and can address it in a
later patch. There is a more pressing issue with allmodconfig regression
times so I will look into that first. Also a vacation is taking up some of my
time.

Needless to say I will get to it soon and the point has been duly noted!

thanks,

 - Joel
