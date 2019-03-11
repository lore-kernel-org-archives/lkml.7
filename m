Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CA4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB432075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCKQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:30:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44453 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:30:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so3067998qkj.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyZWQWfp/FJXoGFvDb0qXMDwCtW0Mjc5FVARq4ddSlU=;
        b=a04yXCqGMgiPlXAOb96aq2y7n+BpwdwVEOnzko/6XQ08f0/H/vXfOuPRLZ4c48squk
         iLqpHNy2jFFXaXzd/CAiZxvZu0v0GQDrmfQ0v3e04zNSlMmMLJLiWMH+7MCIqOwbqT/h
         MCUoD+den/g3DsdG8MBIFT/axxbFN/SMk+L1ujsYU2WXZFyzLzGKeI4tVktFudebEvH8
         /LrAvFDnxv0DEfHA6hkSLUDV1NU0GasujTcSFvEhoAo4FBhOWIVrFDdRLLCFQVLMqZTw
         y14RDKbg+hhoTAYGY1tgpp+VzhbOdG1DWbq4dCSBnfipb4sgRrvY5VWHjKN6SMknJWSd
         YrUg==
X-Gm-Message-State: APjAAAVf/8YBAKTFpjxO7KoPup8/0VJlbnCwZyZCPQthNrpDUwoDfIVq
        4IstOoIQww//GhWBdWsmEdOtTYQSNvf/gBNA+0M=
X-Google-Smtp-Source: APXvYqxe0vRPjee8/ew/xXd15DBYr/aEm1W/RBTClx//br1WEGFLM+QXlRE343ElFvgPcMFCA0zRx4FL1A+SjqQ6Qxw=
X-Received: by 2002:ae9:e10d:: with SMTP id g13mr11670288qkm.343.1552321813736;
 Mon, 11 Mar 2019 09:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk> <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk> <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
 <20190308103429.ycasmpt6tcpsoqps@shell.armlinux.org.uk> <CAKv+Gu_9=G3U6Yaw8fLfTP3QT38WdwrFaC-BqLTCr2NihWA2ZA@mail.gmail.com>
 <20190308105835.tovswk5rwxusmxdu@shell.armlinux.org.uk> <CAKv+Gu-Od+hBosThTWFooz9FMKnu3g0oNh_2hmidetbB-_YyjQ@mail.gmail.com>
 <CAK8P3a1ECw_g1AqsVavD8hhVEGqNk6Kcx_U0L=0d29eu561NhA@mail.gmail.com> <CAKv+Gu8qgsnPV=uWR2jkJ5bsYihekkEvWNuw4whLdLrbBa7gnA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8qgsnPV=uWR2jkJ5bsYihekkEvWNuw4whLdLrbBa7gnA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 17:29:56 +0100
Message-ID: <CAK8P3a0QCgLbXpztUQXAhWLp=ArJUqmtcuXNZUeXZBH+N1QeaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:36 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Mon, 11 Mar 2019 at 15:34, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Mar 8, 2019 at 12:56 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > On Fri, 8 Mar 2019 at 11:58, Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> > > > On Fri, Mar 08, 2019 at 11:45:21AM +0100, Ard Biesheuvel wrote:
> >
> > My first attempt (before finding the original patch from Mikael Pettersson)
> > was to change the probe to pass '1' as the value instead of '0', that
> > worked fine.
> >
>
> Which probe is that?

diff --git a/kernel/futex.c b/kernel/futex.c
index c3b73b0311bc..19615ad3c4f7 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3864,7 +3864,7 @@ static void __init futex_detect_cmpxchg(void)
         * implementation, the non-functional ones will return
         * -ENOSYS.
         */
-       if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
+       if (cmpxchg_futex_value_locked(&curval, NULL, 1, 1) == -EFAULT)
                futex_cmpxchg_enabled = 1;
 #endif
 }

      Arnd
