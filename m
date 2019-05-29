Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A4EC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0622081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cChtVJTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfE2IEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:04:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38838 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfE2IEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:04:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so1241626lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LIOku9W0w6jyilHULXZM0qJLovMNSsThL0PJAa4R6s=;
        b=cChtVJTAkdUeB569BzFxW+lkBv7RfvyARS1+90S3q0TPpHzTNLxCWGjgwut75/WYHZ
         CQ9XfGod9nJpU5BjcSlJyGmMzlSkH569SwBTcbB9Hg7jZTwZdfOfeeWP2oc2MJKZwMiW
         kYz9kLS/NVsgGustKQHks5T0k1EOf3OwfcwoMTZIn5LIJ2h3oDzvilSVIOJpzqUHD0Qh
         Io1B9qE1nYXUFSIBylfBsvLgZBYmIByUJzMPyFR56uHECQLCJrdIXEG5oXM+wrtyqdBn
         NwWeexMTd9waVGwrIeFxp/jE71lcpq9O9JeJ+tRcfj+6BXyU9vzfBWUuEJbO9nKdDTIX
         pmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LIOku9W0w6jyilHULXZM0qJLovMNSsThL0PJAa4R6s=;
        b=RtfTrOXqj4DUGc5xrXMwM1gfMHb2U+EYQ5zOMEC7wWiEbKWemX1ldsVa8lN0j3HVRZ
         Ukcg0bq+lu1U004GcDP7XbzRGlXkOnRx6/wur20+pGd0xJ+uleg9pjkFg4kQpHhddo2j
         GR2xUxvrQAL3Y/buN8HUfKf4hqGCilQTtEE0ghEhp01fN3w8h7Oay1nhM4ncxmlmEPUG
         9JbVpx2efa6a4/hpXeYcH+gOb4lSGtUImm4kU7g1uDd1L/fra4FS9/r9QBrmOmkdGFXQ
         ekeLG50atEGk0qSvHKfuqytpa3FNm/dtsIec4YFtAmv2b5VW1/T8E9hTa3zXWf+TfpLJ
         aXcA==
X-Gm-Message-State: APjAAAV3mK45kj5R2IB4XKuWLdjoNGa09VNSIp9kfTQA8ZQulb4TmJvd
        XG20xNG2aTQ1Ab/iu62iv1Kxz6CiiChwUxMf5Ajbixuijr0=
X-Google-Smtp-Source: APXvYqzGg3PfDli6WYmdX+mVXkhECaeIUHXaK/vTD7ZvztMnsVmqR0e2YR/cufgv/gQgmROlPOEQ02URCK8zPU2nObI=
X-Received: by 2002:ac2:4428:: with SMTP id w8mr3070736lfl.99.1559117093345;
 Wed, 29 May 2019 01:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190529025256.GB22325@shao2-debian> <20190529035613.GA6210@mit.edu>
In-Reply-To: <20190529035613.GA6210@mit.edu>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 29 May 2019 13:34:42 +0530
Message-ID: <CA+G9fYtVH0UF55Xins22sXCvcOLN+JGv-p2brj58BjzNGqdE2A@mail.gmail.com>
Subject: Re: [LKP] [ext4] 079f9927c7: ltp.mmap16.fail
To:     "Theodore Ts'o" <tytso@mit.edu>,
        kernel test robot <rong.a.chen@intel.com>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        ltp@lists.linux.it
Cc:     lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Wed, 29 May 2019 at 09:26, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, May 29, 2019 at 10:52:56AM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: 079f9927c7bfa026d963db1455197159ebe5b534 ("ext4: gracefully handle ext4_break_layouts() failure during truncate")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

I do have found this problem on linux next 20190528 on x86_64, i386,
arm64 and arm architectures.
But, this failure is not easy to reproduce.
so thought of sharing report with steps to reproduce and got delayed.

>
> Jan --- this is the old version of your patch, which I had dropped
> before sending a push request to Linus.  However, I forgot to reset
> the dev branch so it still had the old patch on it, and so it got
> picked up in linux-next.  Apologies for the confusion.
>
> I've reset the dev branch on ext4.git, and the new version of your
> patch will show up there shortly, as I start reviewing patches for the
> next merge window.

However, Thanks for looking into this problem.
I will keep monitoring this mmap16 failure and let you know when it
will get fixed.

- Naresh
