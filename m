Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F9C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FD8208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIvKXK7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfFUTGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:06:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34424 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFUTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:06:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so5256565qkt.1;
        Fri, 21 Jun 2019 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jabc8ETAM1tQvMfNwKY1jPA89l8aJAfxYNUpiE3MoE=;
        b=ZIvKXK7NiPWeFdhSQgGe4TXu21NsATnkOG6MAI+0GP6gUGQQ1B43qTMbmUPBpFg1iM
         8+P1XO8y2mIHUT+XKosHjiVJWm967yPC3isLKtVGsPcaYUwl5pa8T5UKif7CQo2+lFNA
         1lYGrr/Va7xBneCcIN9PT8ECGxc+W7VdNFVpHR37k6qlgFUtfZUOaMWhRbiHerp35PyW
         iYdi8rzrHWpwAjCfAgyBWSKvg6sbBOp1pJrmyUJKrT4ImPXVEe/21BrnC0WPggFSyyCH
         4ilJq4Q/8q6fIvvKSfOGrvI1CRmgpxQnWUX2jKZ2AmGP8E83crMx171jna1tH3ojo52Q
         CrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jabc8ETAM1tQvMfNwKY1jPA89l8aJAfxYNUpiE3MoE=;
        b=CDCcHu6VdyCTx7bPEdv3NdHhNvIYufdNc8InZz7etY+KXM/qRyg/GFdZL4VlsV5ZuW
         K21NkrIrJlkOAAbZ00n0Yw9+cciWy670GKDqkU1yJ6VdqfPoHRTLCpWa7xbL80+cF4Jg
         w653otrs2Hsut6tQ487EsfjHnVwCWLDcIOBEjDPekD6Xl/hZ38o8cLqP+hclvtKaz8bk
         MXv4esh0mwz+iFP0GKi1QUFQjNFNvR61Db1R/DdxMqmP/q2ojWWEZkCvcFaj0h0kg/3C
         hLV759FGSo8NYJNN4gU4Ky80JzExmSvRjJOVSl1AwzZUk7d7/ONfWrtFscptQ/aCaS6O
         CHkA==
X-Gm-Message-State: APjAAAUesxvt4aVVvI9RXmp1hyMSkNEfQ0/K7IN3j6n18dn1TzUX6Ms2
        qcbIXg9JfijvMAgu5+J76/o8+pvniKWlX2lLmYc=
X-Google-Smtp-Source: APXvYqxLZ8NKPxXhyyvt6UfjUaA7Z4LFeaGPCgUm8czG7YLC7JNrwybRkSuLO1g/RaEE8Lb26Bw7YXNCrIe03/ByHKw=
X-Received: by 2002:ae9:d803:: with SMTP id u3mr7089513qkf.437.1561143981730;
 Fri, 21 Jun 2019 12:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190621084040.GU7221@shao2-debian> <20190621161039.GF1383@mini-arch>
In-Reply-To: <20190621161039.GF1383@mini-arch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Jun 2019 12:06:10 -0700
Message-ID: <CAEf4Bzaajc27=YyMaOa8UFRz=xE7y6E+qLbPBPbvLADO2peXQg@mail.gmail.com>
Subject: Re: [selftests/bpf] 69d96519db: kernel_selftests.bpf.test_socket_cookie.fail
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        bpf <bpf@vger.kernel.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

)

On Fri, Jun 21, 2019 at 9:11 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 06/21, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: 69d96519dbf0bfa1868dc8597d4b9b2cdeb009d7 ("selftests/bpf: convert socket_cookie test to sk storage")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > in testcase: kernel_selftests
> > with following parameters:
> >
> >       group: kselftests-00
> >
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> >
> > # selftests: bpf: test_socket_cookie
> > # libbpf: failed to create map (name: 'socket_cookies'): Invalid
> > # argument
> Another case of old clang trying to create a map that depends on BTF?
> Should we maybe switch those BTF checks in the kernel to return
> EOPNOTSUPP to make it easy to diagnose?

For older compilers that don't generate DATASEC/VAR, you'll see a clear message:

libbpf: DATASEC '.maps' not found.

So this must be something else. I just confirmed with clang version
7.0.20180201 that for ./test_socket_cookie that's the first line
that's emitted on failure.

>
> > # libbpf: failed to load object './socket_cookie_prog.o'
> > # (test_socket_cookie.c:149: errno: Invalid argument) Failed to load
> > # ./socket_cookie_prog.o
> > # FAILED
> > not ok 15 selftests: bpf: test_socket_cookie
> >
> >
> >
> >
> > To reproduce:
> >
> >         # build kernel
> >       cd linux
> >       cp config-5.2.0-rc2-00598-g69d9651 .config
> >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
> >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
> >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
> >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
> >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
> >
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> >
> >
> >
> > Thanks,
> > Rong Chen
> >
>

<mega snip>
