Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0109FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0972222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3LI0a1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfIZR3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:29:55 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:36207 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfIZR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:29:54 -0400
Received: by mail-lj1-f169.google.com with SMTP id v24so3043812ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VFcFYcWwpHL0Oho9HxeoU1oGj1fgSa1sn99Foc5xkas=;
        b=f3LI0a1rOC9G6H//RKCxQuCNO3ym+yCzFJBKUs4LHy/3NHU5iJ4Gw/otd7ByI/DIzH
         k9ZwUlZ9s1PRq6uVFrxC7fu7fkbk+lQJLzZ3uZ9Z1MnU5tqAVDQSPgTiyJ9L1PzTAAyI
         I3qspHGkUpzhMw81L1rmuVpT54jIWdyIjVWNscdw2qlpD9fx11WJF35iRq5AP8Teeea3
         5SZcG7GM+8OwxMd25K5Y57bbITdGWCdcbJW3NtHyhaz3hHdXOXJZBjNOxnIGh+QmFb+p
         UU3U61d6bROnqbirNbH8XVwCZoKMoaSqAyQsiL00o5xdKWj38BhtCJTIO1CSRxRPfRnF
         k4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VFcFYcWwpHL0Oho9HxeoU1oGj1fgSa1sn99Foc5xkas=;
        b=p0h2B2A4psPo2xpkbquwzThlwDFxCp3JWJRHtzmLUEY46xdvGCPSbOLv2w8JScMpFr
         GV9vPPayPerbEhTLL1wmDVn4IIrZqV83bLvR5B3Y3hnD/avoIpSF585xHXksaWybo75i
         DoGs5OtbL2qXbm2Gg4p0ia/RaJiCzk7hjbnxYSTXRE4GOSpZEngDbKsgpTZ4wnKqsIDm
         sJXhTfz/lkX8ftpRC8Fd1BCgnPN6C3b1ePA8PInc1V9w9ORpEof9E21wpRJcpKEu2ePx
         67a/6w9jIzPVya91oCBAoriFF4aa40QeGNsPwqRwEHm7qq3AOcD5bYfqI2f8WzkdijWf
         pbWA==
X-Gm-Message-State: APjAAAWci3YfWroTbMijtKwPxj1iErRfYa8i9apJJ8UUYNrngDmxQ6Cs
        ISQXQWZkwEvm3EZaNrIV4xSJ9yAXzWGGiqlGNBEXHw==
X-Google-Smtp-Source: APXvYqxCfkoodIYkCFn1sFSEjjcZZiio6Uoe3BORK8KOACz9tWMOiafi0paC+PE4FqC1HNVbkYaiak/fzpb1FlSp/Q4=
X-Received: by 2002:a2e:a178:: with SMTP id u24mr3351803ljl.149.1569518992751;
 Thu, 26 Sep 2019 10:29:52 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 26 Sep 2019 22:59:41 +0530
Message-ID: <CA+G9fYu0hkS+NdwX38DNTygV1A7eebvjZvWvFUTfL=f3_4m=Dw@mail.gmail.com>
Subject: perf build failed on linux -next on i386 build
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf build failed on linux -next on i386 build

build error:
perf-in.o: In function `libunwind__x86_reg_id':
tools/perf/util/libunwind/../../arch/x86/util/unwind-libunwind.c:109:
undefined reference to `pr_err'
tools/perf/util/libunwind/../../arch/x86/util/unwind-libunwind.c:109:
undefined reference to `pr_err'

- Naresh
