Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FA2C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5C52189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGCIba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:31:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34044 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfGCIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:31:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so1574192qkt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gupEF9jHb4RzPuAg+T8xsoakul4xbVXicnB4KpLcvrc=;
        b=oUcMr8nRbGfJA0GfRpBimD/vix6wb35Ehd+ZXW5dACIgbdli9lzvqPzKRcIwmbWw2E
         NPtjHN1WQRs3J+/HdeO2dd5ubDPJZJfkWreY3Hqnvd2+AGwaVP3k8optRvO+G2a1EfSu
         pRVmd4QY9eto7pIEBnpY+PXgQvtMuq92cznp+VnWvRt1LFC6GDHOn6VmcaQe/1tfmuTU
         tFqIjOSizfKTCBts7gjmbxzHrgegXFaPcaupue4xZpp6r4JUFmqIzWsaTECMZlT7+cPm
         ZKAvz7FJOg+0r7IRY2XEck++hkdn8dlO9HFxnB+Tw3WecJ8RWekfXIjdWsl9HpNrm72S
         3ilA==
X-Gm-Message-State: APjAAAXN/oFY/fY8SeEWrpN0bFHtBs57BdWjp4LIpDGHxsVPt7cRoItP
        iaeV+YhAKfuV1oLMCKRJATflmII4XJJZXcQi6G4qfWNY
X-Google-Smtp-Source: APXvYqz+CVyXI9hqnh1NF4tQfqhgdYjB1397IjdPSMYNbSz7VUpaTnI1wCwe218x6XFv2wKptaSYlTh9/RvxSoUoUDk=
X-Received: by 2002:a05:620a:12db:: with SMTP id e27mr29913352qkl.352.1562142688972;
 Wed, 03 Jul 2019 01:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190703001842.12238-1-alistair.francis@wdc.com> <20190703001842.12238-2-alistair.francis@wdc.com>
In-Reply-To: <20190703001842.12238-2-alistair.francis@wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jul 2019 10:31:11 +0200
Message-ID: <CAK8P3a1LkapKKbwEKnX57YricbAkPLCpqSTXnpL7grVYauSLSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] uapi/asm-generic: Allow defining a custom __SIGINFO struct
To:     Alistair Francis <alistair.francis@wdc.com>
Cc:     linux-riscv-bounces@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 2:21 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Allow defining a custom __SIGINFO struct. This allows architectures to
> apply their own padding and allignment requirements to the struct. This
> is similar to the __ARCH_SI_ATTRIBUTES #define that already exists, but
> applies to the __SIGINFO struct instead of the siginfo_t struct.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

I don't think there should be another special case for rv32 here,
we already have too many exceptions for architectures that
were different for no good reason.

Please keep the same definition that everything else has.

       Arnd
