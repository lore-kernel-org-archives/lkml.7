Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CADC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F3820685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xw05QP52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfDVNrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:47:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40296 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfDVNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:47:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so10346008ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 06:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CW0rqAbogseVL//is426DQ3OzikK37DSAbjjE1/dEMI=;
        b=Xw05QP52BbqnsOxbWieAgtEZrL2+76zcY8QKc4LP4V4DaQAlgs3boJlH+kenYZxabV
         BcQ0iVlDY1DUYgUyS5TdFEbm6A2f2v47y7RfEVtPh6ycvRi1bhNuz70znjTrAd0cf2Ha
         +JRUDYG0r/GINNe4ODhQdIb8z2VzFtpQj4+YQ5GAz5C7JOkH6yibC8xB+YT6ndMw06SX
         OT+XXKJcvnXXZJc3/vGftCY4H5NKKHJbYCow2dqaio7STTwX/0WxdJNCf64C6pUm3SoZ
         hyDO7lxwhd36q8502caspq0/Y6X9wSeF5mV3uN9pG3jM40ng27ylnvZL4WEC7D4DoO9S
         ZzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CW0rqAbogseVL//is426DQ3OzikK37DSAbjjE1/dEMI=;
        b=E9BOGK87Omna2DrJgQBXJ/+q5/UN8+itTaNyh5dL1dlmc9kM37XMqg1y2xm6l+4GM1
         Z9Mc4yUtm+ecFYFTeadBcAGQyCRpUBDuEFHPiVhJyq5QCF/8R4ObyyIeBLtBtKulW8V4
         Fhs3S/P+STgf5C7IL/n4L9uhf03NzNCuiQHTLOmkue/lTVkYF5nkxA13bd8nDnwx6pVL
         Tn9ANpp0sorV2og1vEvs9Jrn9guK4X3zwi79nyNLO6bLZmoI+iuFbFzTxVH+C0WO5yjM
         TvmvyZcsxvT2pvDrV7pE96tuwvvzQP4p1vxoW5pV9OamEEM8rH0OIl4ejcfrn36Y5Z+j
         PrFA==
X-Gm-Message-State: APjAAAX5/cUWe11rEVDtXXnwvMp1a4R1dIotT/YFhE/nxNDv8JGI1XLj
        SD9E+BewkhYUPbrzZnXPkiqrS7T+bWx+tET0UnI/SA==
X-Google-Smtp-Source: APXvYqzpwl67uXk3ShqkrN7zXEFynnAj2riG1gSP6jG+C+v379vseXLlZ4+kTbG13+nOpnNWc23JtgGl+t9LbQM12W8=
X-Received: by 2002:a2e:5bdb:: with SMTP id m88mr10350626lje.9.1555940825758;
 Mon, 22 Apr 2019 06:47:05 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 22 Apr 2019 19:16:54 +0530
Message-ID: <CA+G9fYvy8gcJO2hLZpwtTjD10Aw8G-eawLjOKi68dTfrmM2KAw@mail.gmail.com>
Subject: Beagle x15: perf test -v hangs on Linux 4.9 and 4.14
To:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-omap@vger.kernel.org
Cc:     lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf test -v hangs on beagle x15 device running Linux version stable
4.9 and 4.14 kernel. ( gcc version 7.3.0).

X15
----
Test breakpoint overflow signal handler: FAILED
Test breakpoint overflow sampling                        :
--- start ---
test child forked, pid 381
***Hangs Forever***

Debug log with strace output,

strace -f perf test -v
...
[pid   346] perf_event_open({type=PERF_TYPE_BREAKPOINT,
size=PERF_ATTR_SIZE_VER5, config=0, ...}, 0, -1, -1,
PERF_FLAG_FD_CLOEXEC) = 3
[pid   346] fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC) = 0
[pid   346] fcntl64(3, F_SETSIG, SIGIO) = 0
[pid   346] getpid()                    = 346
[pid   346] fcntl64(3, F_SETOWN, 346)   = 0
[pid   346] ioctl(3, PERF_EVENT_IOC_RESET, 0) = 0
[pid   346] ioctl(3, PERF_EVENT_IOC_ENABLE, 0) = 0
[pid   346] --- SIGIO {si_signo=SIGIO, si_code=POLL_IN, si_band=65} ---
[pid   346] rt_sigreturn({mask=[WINCH]}) = 0
...
popping up this log continuesly
....
[pid   346] --- SIGIO {si_signo=SIGIO, si_code=POLL_IN, si_band=65} ---
[pid   346] rt_sigreturn({mask=[WINCH]}) = 0"}

Ref:
Juno/x15: perf: Test breakpoint overflow sampling and test hangs
https://bugs.linaro.org/show_bug.cgi?id=4321
Full test log,
https://lkft.validation.linaro.org/scheduler/job/655038#L1794
Kernel Config,
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/am57xx-evm/lkft/linux-stable-rc-4.9/524/config

Best regards
Naresh Kamboju
