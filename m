Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4909AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217F921852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6BqioMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGCSpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:45:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36214 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:45:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so2507486lfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwL7OY0gNWaqAz8g888XgOT0QU+pPo6Fz6l72ernDnk=;
        b=J6BqioMGnIUGMgw+WUUWZYDtzcbxXTqWSv7V0mjUaLDgSGZYj2C74mtre0YGgZQHmU
         B36ldcRLfqX6msPyDZU9viW8pqKFlSCd9dAJJWlwLb7lGNlij6pBCLpHSa1JsN9qPYt1
         L1CCXATRUrLB6lvLKxeGAgyKxjKcBXAj9N1/tYw5ty5wodmlCeKXImm7qLLjWjXK5WRw
         mk4h3Q4diWLMb4FskgO5lw6+inNdQz3VPiKC3S7J/9I/OGpjVH0xzAT1xYrQeuYgGxS7
         kPXZKS5TjsI0Nr/8EIFF4BS3x1atQ4uJukd1PldQnnXNtg0wzLFuSlD5Q+EMuOKShLXE
         K5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwL7OY0gNWaqAz8g888XgOT0QU+pPo6Fz6l72ernDnk=;
        b=sviu/fNfkHNAGjNwO1GDAr8KPoUm4dFK/yy+uQ7R1NTOnIB18ciPllT+aE9sdxnVtn
         55Ocs+gscEixt+B94LBR8UBXGtrKHzvkHGZ41pydA7+lSP9zIUWCBxQjoTbUBww0Q++D
         y4D7UlBECKXQAKSRxPHRFjT9xfh7VSo7KnA1zySpZZIlFh7xcBOmuRJEH1JDOXZMdJu/
         Lam+pBcKtARdvwVAcsaFg+J0/NynzSRC+romqLEsvNU20Nk0G7LihCVTisSt1gti2OEt
         QOXf3qlLUxa8CA7R9sk2Ni6Sqf2xkvk1xRQRa/kkjnLo2zH3joD5boPvIr8NhKRzVg/h
         r3Mw==
X-Gm-Message-State: APjAAAV7+o3wyuNqM8bevBJLRpewumhcxkvIVID+HmRKue8W2p1n12rd
        h0kcKD8L7MPk/HrY/zfmdnYPsJKihWvdVE2DY6w=
X-Google-Smtp-Source: APXvYqwxQ8LZckgiyHCxN+dUAHtaxvbDiTDnLwmLZL0pp1CCK2qiQvUeMWP5hjpgkk2mJyrfgFGoOc0WqWjqf21Q8IU=
X-Received: by 2002:ac2:5324:: with SMTP id f4mr2679732lfh.156.1562179505561;
 Wed, 03 Jul 2019 11:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190703001842.12238-1-alistair.francis@wdc.com>
 <20190703001842.12238-3-alistair.francis@wdc.com> <CAK8P3a37GLzp+w6m0SEV+9j_6sH91SuStyAEW-VzuJ5_dUCnZw@mail.gmail.com>
In-Reply-To: <CAK8P3a37GLzp+w6m0SEV+9j_6sH91SuStyAEW-VzuJ5_dUCnZw@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 3 Jul 2019 11:42:00 -0700
Message-ID: <CAKmqyKP07futGV1WsZwvqGzeR646eo-ysVy9RCqaSOG-2qhH_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv/include/uapi: Define a custom __SIGINFO struct
 for RV32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv-bounces@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 1:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 3, 2019 at 2:21 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > The glibc implementation of siginfo_t results in an allignment of 8 bytes
> > for the union _sifields on RV32. The kernel has an allignment of 4 bytes
> > for the _sifields union. This results in information being lost when
> > glibc parses the siginfo_t struct.
>
> I think the problem is that you incorrectly defined clock_t to 64-bit,
> while it is 32 bit in the kernel. You should fix the clock_t definition
> instead, it would otherwise cause additional problems.

That is the problem. I assume we want to change the kernel to use a
64-bit clock_t.

What I don't understand though is how that impacted this struct, it
doesn't use clock_t at all, everything in the struct is an int or
void*.

Alistair

>
>         Arnd
