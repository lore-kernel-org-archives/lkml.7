Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285EDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF09207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TYJlOMF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfJWBHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 21:07:01 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38162 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfJWBHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 21:07:00 -0400
Received: by mail-il1-f194.google.com with SMTP id y5so17298620ilb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 18:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HWO7yS040YN9ygzKwM7Iiq1eggk2WSVzMxvdmCJxTAY=;
        b=TYJlOMF6UdCArlzyrqcMSueIwlX2j0yf5xLo3vXieheL7oW7kiPQnQ9ckj+KFCE0/c
         6EulMnd58a5ZVy9efaKslK7lVo/8p6LnHFNfsWibqUY6aifbVFFr5npILT6RrhmFEcbE
         Pbh/vgCmjEkv3uOvr4yPU85VAbhWfrDF12yv3WTu3o17qlc0wrlSQRKv4tu9g2k4bVX+
         0T/84bgQkY82/S01VbjjRXcSl2lYgz9NG9w6bF6QfYb12lEuoIJdpj6LpR3P9B4DPYF6
         UorOanl4XGIRpwU3AJnlCu5ApAWlC029yLANfWbZb8GZc9g03AGs40kUTwcDYNLIfBnH
         zCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HWO7yS040YN9ygzKwM7Iiq1eggk2WSVzMxvdmCJxTAY=;
        b=YS6eeAweHdTuBq4D7ZIjZhMPE49VeqAbLPOF30WphIA6mYoQR+fuV/WWo3XPlNxIJ3
         WUdQws/oJL9hzKaOtGh5kbxQcH3D9N6nqh/QsHh+Dn34hVcyijHx9duUfBnQpz6B13yi
         zeVysKPIbR+pf4sUp+ABUrr7qHyhXm0J7F78e6IsmmML77D8cH1tmktSxNfDGLiBW24i
         3ew8zcw/EaZksPfeqMF0L+zxp0pcn0vl3r3q9/B5OwW6XweZm0VRaiQkOPf1jdAccjUc
         4MCvKg5odpEWHFtGHHTUyiqyWzL1y8E0yieLqeziiVHsyOihoq6v9r9C0xApXssoajrc
         T6Dw==
X-Gm-Message-State: APjAAAW76nxrTZ1SbjcQ6kudlRWT6EHuHKxLNdzLkT8lUzO5kYP9kiDN
        gUFwg90lsMDHgracg4QofKJ93Okf88s=
X-Google-Smtp-Source: APXvYqxV/TMbIFPWC+V5RaBuYoBsRlkm6Ti6k/ihWCnbo14PsG+UHmULY2sHqCNrLdwP+b7P+DoMdg==
X-Received: by 2002:a92:5a9b:: with SMTP id b27mr34644602ilg.180.1571792819781;
        Tue, 22 Oct 2019 18:06:59 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id d17sm917352ioe.31.2019.10.22.18.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 18:06:59 -0700 (PDT)
Date:   Tue, 22 Oct 2019 18:06:57 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     Anup Patel <Anup.Patel@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
In-Reply-To: <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com>
References: <20190925063706.56175-3-anup.patel@wdc.com>  <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>  <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>  <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
 <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Alistair Francis wrote:

> I think it makese sense for this to go into Linux first.
> 
> The QEMU patches are going to be accepted, just some nit picking to do
> first :)
> 
> After that we have to wait for a PR and then a QEMU release until most
> people will see the change in QEMU. In that time Linux 5.4 will be
> released, if this can make it into 5.4 then everyone using 5.4 will get
> the new RTC as soon as they upgrade QEMU (QEMU provides the device
> tree). If this has to wait until QEMU has support then it won't be
> supported for users until even later.
> 
> Users are generally slow to update kernels (buildroot is still using
> 5.1 by default for example) so the sooner changes like this go in the
> better.

The defconfigs are really just for kernel developers.  We expect users to 
define their own Kconfigs for their own needs.

If using the Goldfish code really is what we all want to do (see below), 
then the kernel patch that should go in right away -- which also has no 
dependence on what QEMU does -- would be the first patch of this series:

https://lore.kernel.org/linux-riscv/20190925063706.56175-2-anup.patel@wdc.com/

And that should go in via whoever is maintaining the Goldfish driver, not 
the RISC-V tree.  (It looks like drivers/platform/goldfish is completely 
unmaintained - a red flag! - so probably someone needs to persuade Greg or 
Andrew to take it.)

Incidentally, just looking at drivers/platform/goldfish, that driver seems 
to be some sort of Google-specific RPC driver.  Are you all really sure 
you want to enable that just for an RTC?  Seems like overkill - there are 
much simpler RTCs out there.


- Paul
