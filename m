Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07096C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D226C2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMXveiSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfLEABZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:01:25 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34728 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfLEABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:01:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so1718036qtz.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJE0pjdE5Zlehm0IQrIdzxUmlagRhXSz8Z6krXba16E=;
        b=dMXveiSdmysvHaaEGqoOeZVSx5EPJ9MpMwSPukSFjNxEoCMpSTZ/b7nW3a3ag+uVAQ
         WJqr3Mqy/7UmoytRqJv1NDqoRpsXix5p5K7lJ1cn9tolu5aMWzqO1bsczgCQX2yBZFio
         /owaBhc98Ur1YVsbX4paW48mWFyWzoO/p1IDD3DFqbUqcIKOR9ok2SpJjnxswQIwl5k8
         11AdS6biXWKXtMXYO02Qbn3EyfPdk9nh44b2fn9WJTrAx07Weld/jA/XnPX9fNhWsxFA
         gK7XXefTKOuYQuo1lCxJjtBIQQPuqF4K/u9J38SLRlccFneeuFHsEIkfmMtJTYKqh5tN
         yB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJE0pjdE5Zlehm0IQrIdzxUmlagRhXSz8Z6krXba16E=;
        b=Iw8nQJ+6ZXtaYa88Q9X8Kxch8pvYlQVVbaaU99eWjoHbKfDld+b1M1M0lJn19yVZGe
         By8+PXwwLtmCLIsQIABrwNuC3MBp8DPUFusCB3btVpMy9pKkVIYuEFwfDmLMKkH+QVCf
         mgEZr5eZ5Xq8UvTfh3RAsQF7MUf3mhmg2pgEmouzpe4JzfSJBxD0T0N76Ps99xut2JG3
         flxJ66PoMcQbOMWJFX9juVuhWtVzeT9SR7kD2lBkS8tU0u5aqnzf48sbduA4jUnn7xIT
         FAxC6u0NjVnqpnupUm4EdQKqElGO8EoJB6Do+bdgvIW/l2PeKg+m8LEpyeWtLZfwlKhd
         HZFQ==
X-Gm-Message-State: APjAAAXfGa9HUacjjP3ZWR8YYik2gAGBt2RIyTsFqMU7L/m3wn1iDIDO
        phHmb0khUNtrQ/PH1XoMRpFHNiZcZ/pFkF2J1QyP
X-Google-Smtp-Source: APXvYqyjERtSkkqd18jJn6NmH7zcnXxSu4imYlM1ke8pU9s0MVgE/EHmIGiKhuYy1w87RsrmzGQgcu4BTCkDWBb0gf0=
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr5209796qto.109.1575504084233;
 Wed, 04 Dec 2019 16:01:24 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com>
 <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
 <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com>
 <20191204003851.GF86484@mit.edu> <alpine.LRH.2.20.1912041531160.5511@dhcp-10-175-179-22.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.1912041531160.5511@dhcp-10-175-179-22.vpn.oracle.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 4 Dec 2019 16:00:48 -0800
Message-ID: <CAAXuY3qekjWBUTxzAjCs+87nVXpigvzqm7TpG7MtJagTSG-xtg@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I've also got a patch that I was hoping to send out soon
> that might help.  The idea is that each test suite would create
> a debugfs representation under /sys/kernel/debug/kunit;
> specifically:
>
> /sys/kernel/debug/kunit/results/<suite>
> /sys/kernel/debug/kunit/results/<suite>-tests
>
> ...where cat'ing the former shows the full set of results,
> and the latter is a directory within which we can display
> individual test results in test-case-specific files.
>
> This is all done by ensuring that when tests log information,
> they log to a per-test-case log buffer as well as to dmesg.
>
> If the above sounds useful, I'll try and polish up the patch
> for submission. Thanks!
What would be the best way for kunit_tool to:
1. Know that the tests have completed as QEMU will be just sitting
there with kernel complaining about the absence of init (or running
whatever we give it as init)?
2. Read the test results from debugfs under QEMU virtual machine while
the kernel is still there?
I think supplying an init script/binary that copies the
/sys/kernel/debug/kunit/results/* to a 9p shared dir set up by
kunit_tool would work but it would add a step of cross-compiling and
packaging a userspace binary.
