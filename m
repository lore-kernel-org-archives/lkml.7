Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D28C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6302081B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gfW+j1g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfG0IQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:16:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45961 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG0IQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:16:15 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so109600231ioc.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GqXvr0YJl2rBiC4sDBh/Naqmgvh+22fz1v/WVxyKO8Q=;
        b=gfW+j1g6IacoC5Ik0W7a2UYx4s7aGeOHrCvJbQGmUPqYge3B6Sc1txqFo+8b5MMhm/
         O5lhaKX2aC0KVc/syCF5b/U8jT3a2uneniChY/9H64jh8CMYGFI43iUIlbaWMEL1O3AU
         Q4Wge+YRXbNKeKQJSkh6n7Qsg1bBGoYZdWG2x/ylDWGyQgoXyVPEGEJVceDLg+BzbMqn
         DOuiJ7bEhFbXyMqhRWNXckKLUoV8bS4AEeGkPXzEdlwQ1jJndhDQG3FiWtzmemBPqTwB
         9P0mT+nlpWdRGlakHqeFUDnroqX1Tk/V/vWE4pwxLqrLPZbpUR3qzxaec7kpir3sb7A1
         UcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GqXvr0YJl2rBiC4sDBh/Naqmgvh+22fz1v/WVxyKO8Q=;
        b=bkfy+DQr2jWLqS+Bvskpwg8WmLMmamhtcpg8VGAZHW2yGetWXk/Sr1I7qOVoP/btyN
         qWZ/ztQ3WmcEq7gtPMy1N0rggeova2ZkZ9xFxScckm3Kpu0+JvLr2Jb26b0addLYfbRd
         CvgVealhh+BxoDq9gRO9G108hDaeXSzQ7h/SUmJ1vrt2C04gMQBFDYfwsIIOe1bub5Cl
         usW3qv7RqP7cxZ1WS2L8Ywx6K5jN58Kq3sg8KDOIQolY/hkoCjeHurkDvZqbbTWyY7Dj
         n8Aeceu386b9qAV3nTKbnkRaredftgeLMIVDp4Z4e++aWXMRnuYc3mgkcwSdA9Zn1JYk
         f51g==
X-Gm-Message-State: APjAAAW4y/nhcM+riwTSUItaMqU4rYX8qjbqyTuk+PumnrLmOO1PT3fC
        75RlXQa08BVrKTQIYQhLM4tG9A==
X-Google-Smtp-Source: APXvYqwRBk0cI7n1B/EwEinyQeclw5edSgKcI3WQbSY4Fch27L/Mj0UphkvhCqCFfyw+IVbwdf9D4Q==
X-Received: by 2002:a5e:c241:: with SMTP id w1mr86156837iop.58.1564215374902;
        Sat, 27 Jul 2019 01:16:14 -0700 (PDT)
Received: from localhost ([65.152.59.42])
        by smtp.gmail.com with ESMTPSA id y20sm45173594ion.77.2019.07.27.01.16.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 01:16:14 -0700 (PDT)
Date:   Sat, 27 Jul 2019 01:16:13 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     Anup Patel <Anup.Patel@wdc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string
 parsing.
In-Reply-To: <CAAhSdy0Eycc0ORSnh6LJeC_D_x9yLOkoc7OkPNuN6qOcZEGVWg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1907270108420.26998@viisi.sifive.com>
References: <20190726194638.8068-1-atish.patra@wdc.com> <20190726194638.8068-3-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com> <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com> <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
 <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com> <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com> <CAAhSdy0Eycc0ORSnh6LJeC_D_x9yLOkoc7OkPNuN6qOcZEGVWg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019, Anup Patel wrote:

> If your only objection is uppercase letter not agreeing with YMAL schema
> then why not fix the YMAL schema to have regex for RISC-V ISA string?

I don't agree with you that the specification compels software to accept 
arbitrary case combinations in the riscv,isa DT string.

> The YMAL schema should not enforce any artificial restriction which is
> theoretically allowed in the RISC-V spec.

Unless someone can come up with a compelling reason for why restricting 
the DT ISA strings to all lowercase letters and numbers is insufficient to 
express the full range of options in the spec, the additional complexity 
to add mixed-case parsing, both in this patch and in the other patches in 
this series, seems pointless.


- Paul
