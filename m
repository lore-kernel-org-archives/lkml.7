Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C861C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23F9208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="Xf8yOiJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfFUW1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 18:27:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35578 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFUW1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:27:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so4287162pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=12Gmw5zKib47jcBiDKW7HN4evhmenszIUvUtcBNVr/w=;
        b=Xf8yOiJSLOSDq8hWrSlqpVXhoLaAmtIuYSuhh/74sBbU3do17BqBGp8WItUeF/yGen
         7QyMyUUFMICKWkLKDOjqV9xQzIl8ml5EglhEaZ5q7B7ht6KlF5augdWsLTNIeapnDgwo
         tsiSht9gHfvxnPm6uEpfxtFooUB4B5AVXpaJNLwYWGHj9n0asq1s+48vQT5N11RUCUam
         xkooi/XOAN4ALTzwT5nU+13PdxyRVZOvq/9+uocblGa/k3frtWsRIz8BBt1wcobxNprH
         qQd1iUwf1V6UKbv2VDNdJ/VX+PsCET2klo7Q7Prr2VV0Le1jdGqcfBRVx5BEQbhf/2Ua
         VkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=12Gmw5zKib47jcBiDKW7HN4evhmenszIUvUtcBNVr/w=;
        b=K40pmg99OG4jL8EFlqZjAPr5H+4llKJCEIIXoa8nWnSCVb+1AMsQUJD2Nih3ceQUec
         7fVIHAf2wjnnZsw3JT+1/+E5nuVQ/o9fpOFjpiFuNFG5+0pWPhSXfs8lzGUBYi98Zfwy
         wQXGB7Ov3tseWFhcPoMCu+B9slT0si9Rdkh60gJYT+9l/GAQ+f0PU0XV7oEGW92hsqrK
         kvlp6SOhJRxapmRSebQbvXHEeq98uuCHgHuDfrUEyqf7t6OpmgRVuJkE4311g9qojDwS
         CTexhXCSa9jUdI/HvvSZxJIkRmfh/WVDyLV2LGu4WhZrMvCCbf/M9a7cCmgBM8D/XLHn
         NUAw==
X-Gm-Message-State: APjAAAVSVURKuP0jATqWF8sXj3RWW9ZiXcmxVSTVOARBrJq8QTn538GD
        FbB4OK5fdl/ujQHOvUZrBrKh6Q==
X-Google-Smtp-Source: APXvYqyaiXsnJomCA0jaG6+PiyM9/ArBlY8whr81Mb/Rcx7aNr8Hgjb7UwlTl2XzXFsDehOifOqB8w==
X-Received: by 2002:a17:90a:9b8a:: with SMTP id g10mr9335809pjp.66.1561156067118;
        Fri, 21 Jun 2019 15:27:47 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id m2sm3241108pgq.48.2019.06.21.15.27.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:27:46 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:27:45 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        bpf <bpf@vger.kernel.org>, lkp@01.org
Subject: Re: [selftests/bpf] 69d96519db:
 kernel_selftests.bpf.test_socket_cookie.fail
Message-ID: <20190621222745.GH1383@mini-arch>
References: <20190621084040.GU7221@shao2-debian>
 <20190621161039.GF1383@mini-arch>
 <CAEf4Bzaajc27=YyMaOa8UFRz=xE7y6E+qLbPBPbvLADO2peXQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzaajc27=YyMaOa8UFRz=xE7y6E+qLbPBPbvLADO2peXQg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21, Andrii Nakryiko wrote:
> )
> 
> On Fri, Jun 21, 2019 at 9:11 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 06/21, kernel test robot wrote:
> > > FYI, we noticed the following commit (built with gcc-7):
> > >
> > > commit: 69d96519dbf0bfa1868dc8597d4b9b2cdeb009d7 ("selftests/bpf: convert socket_cookie test to sk storage")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > >
> > > in testcase: kernel_selftests
> > > with following parameters:
> > >
> > >       group: kselftests-00
> > >
> > > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > >
> > >
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > >
> > > # selftests: bpf: test_socket_cookie
> > > # libbpf: failed to create map (name: 'socket_cookies'): Invalid
> > > # argument
> > Another case of old clang trying to create a map that depends on BTF?
> > Should we maybe switch those BTF checks in the kernel to return
> > EOPNOTSUPP to make it easy to diagnose?
> 
> For older compilers that don't generate DATASEC/VAR, you'll see a clear message:
> 
> libbpf: DATASEC '.maps' not found.
> 
> So this must be something else. I just confirmed with clang version
> 7.0.20180201 that for ./test_socket_cookie that's the first line
> that's emitted on failure.
Thanks for checking, I also took a look at the attached kernel_selftests.xz,
here is what it has:
2019-06-21 11:58:35 ln -sf /usr/bin/clang-6.0 /usr/bin/clang
2019-06-21 11:58:35 ln -sf /usr/bin/llc-6.0 /usr/bin/llc
...
# BTF libbpf test[1] (test_btf_haskv.o): SKIP. No ELF .BTF found
# BTF libbpf test[2] (test_btf_nokv.o): SKIP. No ELF .BTF found
...
# Test case #0 (btf_dump_test_case_syntax): test_btf_dump_case:71:FAIL
# failed to load test BTF: -2
# Test case #1 (btf_dump_test_case_ordering): test_btf_dump_case:71:FAIL
# failed to load test BTF: -2
...

And so on. So there is clearly an old clang that doesn't emit any
BTF. And I also don't see your recent abd29c931459 before 69d96519dbf0 in
linux-next, that's why it doesn't complain about missing/corrupt BTF.

We need to convince lkp people to upgrade clang, otherwise, I suppose,
we'll get more of these reportings after your recent df0b77925982 :-(

> > > # libbpf: failed to load object './socket_cookie_prog.o'
> > > # (test_socket_cookie.c:149: errno: Invalid argument) Failed to load
> > > # ./socket_cookie_prog.o
> > > # FAILED
> > > not ok 15 selftests: bpf: test_socket_cookie
> > >
> > >
> > >
> > >
> > > To reproduce:
> > >
> > >         # build kernel
> > >       cd linux
> > >       cp config-5.2.0-rc2-00598-g69d9651 .config
> > >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
> > >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
> > >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
> > >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
> > >       make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
> > >
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> > >
> > >
> > >
> > > Thanks,
> > > Rong Chen
> > >
> >
> 
> <mega snip>
