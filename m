Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F7C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6978D2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+4eu468"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfGOFBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:01:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42382 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfGOFBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:01:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so533926wrr.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zClYUESx/MsQcEd1cORCbj1wx6ChnJ08xGnoixTBG4M=;
        b=O+4eu468O92Ej6QlWQTaCib4VIYrkwjVD7Y1HH9NwGzST8fCK40tLSKTUTvCXHuCHj
         YdcFqqdVhvRqOkZeQ83DZ+cUsYDK2ouBY95Wo0UX4Xgfcs8qkJdb26FQkz5Vf3cvCLC6
         yknVem4N5Ovuu24GbuHfEACeCKxEuen/ivC0gJilTiuavgQGmMigpR9rLeopnPS2uZxS
         JWKMc1dxmWHZoBCC8VCUmpVY6stCXCN4vGK5b58hW0ja5SBDMSBE4J65xrmK/KfmQovx
         B8gjdhunSn2RkgxOa7umoUx29BJ3LBXyvZIK8cgXdeyL3TDxAJu99Z8OsV/NCeIu4NH/
         aBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zClYUESx/MsQcEd1cORCbj1wx6ChnJ08xGnoixTBG4M=;
        b=aMotoes0rJzOxTLIp5TEMe9MUsPwq1V5Se4d1F4skNPpmJzSFJ3rGpuzMGsc2W3Rcc
         4V8pMPfLRLWCNJ5zSi0nXiHghb6FZq6JSSlv0wJB4Bh/8gHQqzl9JmA3fPlBDOqZO5RQ
         c+3vTogwO1acPftJJm1FwL9Z7YaJ93Qkt9I/H0Kswi6PJaKNtcCShAg3N9aWU7Ucsgoj
         4dHEPN4jj3GsDUPJgAd/k60Wp8FDAv4jTmm7FmYjC90wSECe29c4Gmi/83J3DEhYrgDR
         6aCDxkk4HfMnDIUbFgvtFQ4BiNi9YsFyttszGQQKuGNhczb7KL2ighBlz+ReZxewq29n
         ulFA==
X-Gm-Message-State: APjAAAUzHc3V+h9uJwuRcQJgAqrpiyoCpFQhksKlON6B9OLlVobRfw4J
        massIpMjFFgKBXjS5Wya6SFf9eSK7yqAVi3xX4/vu1qFa0c=
X-Google-Smtp-Source: APXvYqwpTD9VczFqXHNPH40b6SfiMcCS12JLdDpEREZ620R3W4ViaDf/0ThJX0CraVkz2GAxtDlLwp3H8uF9um9cw/w=
X-Received: by 2002:adf:9d8b:: with SMTP id p11mr24877525wre.226.1563166891032;
 Sun, 14 Jul 2019 22:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190712064850.GC20848@shao2-debian>
In-Reply-To: <20190712064850.GC20848@shao2-debian>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Sun, 14 Jul 2019 22:01:12 -0700
Message-ID: <CAF2d9jheTrhh2e_PBqWOTy6gy-vVVZMyj3_dM1hkV1NP+-7r6Q@mail.gmail.com>
Subject: Re: [blackhole_dev] 509e56b37c: kernel_selftests.net.test_blackhole_dev.sh.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 11:48 PM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 509e56b37cc32c9b5fc2be585c25d1e60d6a1d73 ("blackhole_dev: add a selftest")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
>
> in testcase: kernel_selftests
> with following parameters:
>
>         group: kselftests-02
>
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> # selftests: net: test_blackhole_dev.sh
> # test_blackhole_dev: [FAIL]
> not ok 13 selftests: net: test_blackhole_dev.sh
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.2.0-rc6-01701-g509e56b37cc32c .config
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
unfortunately, I could not get this to work as my qemu instance just
hangs. Will spend some more time on this later.
However, If you have identified config related issue, please state
that so that it would be helpful to fix it faster.

thanks,
--mahesh..
>
>
> Thanks,
> Rong Chen
>
