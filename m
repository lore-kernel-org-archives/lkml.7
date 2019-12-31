Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA48C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B13205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ggmSDcZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfLaQPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 11:15:19 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:50099 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfLaQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 11:15:17 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f1f61f70;
        Tue, 31 Dec 2019 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=qZ75m75jiMdCxmO5RuvyLHTUs4s=; b=ggmSDc
        ZghhAKD5MPcComWrYuXxe/ImGeldlsadQRCPM+XdxjbrdJowbwEyR7NvwEXdVSho
        1i5cbh4IP3GY80m5L6LxAnkyTI+SWrp3NNFUdxQSEbePZT3+YYEe8RVPc6+6v5qU
        N4Lkv0juaP6VNyHwN+FHHP1WVGyySQRW9982uGF7EC/x2CyvyVgObxH6GEUZciG4
        mtnONj39tbB4TeLkx/52/4o4pbNWyQHPEtq0Om2cpYjt/j3uXSYCLKDlKfxeU4VM
        xYDmCQdhTw+KqoDHfzg1kKwvywziQ6qBLW0BlKJBdXeN4+k/s+KdyL2bFwaHdQPB
        zzc9MOYx8ThWyegg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b8998574 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 31 Dec 2019 15:16:58 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id l9so9251609oii.5;
        Tue, 31 Dec 2019 08:15:14 -0800 (PST)
X-Gm-Message-State: APjAAAUC0ywHX1n3Ev0fkmgzmkqf6Vn5cjmyc1qiNWqepUhOjJuGvyah
        euUmnRLQfZ6NjvqkJeN/ljtGQyNK96Fht5pZ8hc=
X-Google-Smtp-Source: APXvYqxWzzYIOl/3YyB9RhQ/dGKhx+mdJGdFSMbVVNrMBh1WdjNkSxwhFlWZgjv59E8BiNTSX/TzjU/w4ZwSx0Po9Ic=
X-Received: by 2002:aca:815:: with SMTP id 21mr954698oii.52.1577808913011;
 Tue, 31 Dec 2019 08:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20191223130834.GA102399@zx2c4.com> <20191224135404.389039-1-Jason@zx2c4.com>
 <CAK8P3a1fVFDkHe=gLy55rHxwfZ8YKcUSYvnhSoMbcAgWy6Nm9w@mail.gmail.com>
 <CAHmME9o07dQV_MmWmtBFCKp=sdsO-scC6-UbXNi=dpU6umCoPg@mail.gmail.com>
 <CAK8P3a0sWObusG3xO_JE9CXCyNfFN0p6OgPjUyU2CHLBBZNpZw@mail.gmail.com>
 <CAHmME9o==nBONywVgSjsmjs2H_A8itgmwibqzPmvivcSocKWRQ@mail.gmail.com>
 <CAK8P3a11g-UXcYdudDtp0TWCQAfotpc-63BqYwn-a9LDxV-b+Q@mail.gmail.com>
 <CAHmME9pnBtjJ86gsWgK8DCYKo_HFpyViHoGpJPTrYBONT01YVA@mail.gmail.com>
 <CAK8P3a0NBuqDX63+920q7Q+yO2xCoSd0O7xUDJv6BBoco2kVOg@mail.gmail.com>
 <CAHmME9rnnoFwh=EHAgdQFM+c33D9mgCoVML_+d=Js=pXPnsxKQ@mail.gmail.com>
 <CAK8P3a1AYGbgf6mmL-863+PXPBQw3AAtp5wQPL5duLCONGhHuw@mail.gmail.com>
 <CAHmME9r2G4viiF4sYqpuYOnFCtjWpjugqenoEeUrsU6MGBeSuQ@mail.gmail.com> <CAHmME9rCCei_CL1evDYQ44Eu8erbjx_jDzbpKeXD4jTGBu8v8A@mail.gmail.com>
In-Reply-To: <CAHmME9rCCei_CL1evDYQ44Eu8erbjx_jDzbpKeXD4jTGBu8v8A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 31 Dec 2019 17:14:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9q0z4RBhy7AETo0sPt+SfV7=zFra0iyZ-Sm54c-WG6CVg@mail.gmail.com>
Message-ID: <CAHmME9q0z4RBhy7AETo0sPt+SfV7=zFra0iyZ-Sm54c-WG6CVg@mail.gmail.com>
Subject: Re: [PATCH] mips: vdso: conditionalize 32-bit time functions on COMPAT_32BIT_TIME
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Christian Brauner <christian.brauner@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a "one click" reproducer:
https://data.zx2c4.com/mips-musl-libc-weird-crash-time32-compat.tar.xz

Untar that and hit `make -j$(nproc)`, and you'll get a freshly built
and crashing kernel+userland.
