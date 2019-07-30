Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3599C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E06620679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L0KSw+K5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfG3W6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:58:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34747 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfG3W6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:58:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so49191919oil.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KRfm4hy/MFFKWXNiJL6XJ0vTMvcV92W3VJ5w2T3yK6g=;
        b=L0KSw+K5lAXwUtfMvGFW5PkwM8L11L2y2HxjIx8uYFJhZLKHIBlKDAf4psYNcAGptC
         gXLfJVKL1zNxuKUm06qIPL4NOwBw3rloNIKDInPPfSLNYAljCfQr3UHzq3yxzsdbRCek
         V7f6gH93h7HkZFYo/FmnRzaaHRLNlz73DVfXhHFr7Zs9FanPepkowJ6YfynVUNrbWXy9
         d5nkiHQYL/FSrdx7IQZRm6xx+RefyEDTQQvxR5dXyKZEVsmCFUTRAtPvNHN9VPkIyTUP
         jElCnqkx23aAjsutHRY3h47swJFOeOIrarkF3xA1LqlZZmWJt7TrAExruQIM4oIqX3hz
         CPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KRfm4hy/MFFKWXNiJL6XJ0vTMvcV92W3VJ5w2T3yK6g=;
        b=ka1nQcn7M1FGWob17w9ziqTPv+V3UNp03kO5KO4+IbvjtEF9uovQpA1o9fbCRkTM9B
         UpnEij3GUTHSYpM60oEN3F267WydNZU7ugY/9ZTtVY23WuhVB07/6A9UJyt64l5Xtzc4
         ySmYHBWp+f9xIjbNS26XUNa1HxPO+pygry9vkEXUu6tqPwNDfLJ99vPxaPJKe8gibFUR
         m7/5jyKysTrUkJ903eOMooK1G/sTwkHAzW3LNDga4QRE5tUO1OezsbCnkh+A298saHA8
         eIuYq9fLoumU2d8LsidI/qi51zd1tC1gEvP1outlH6XSuYiI6Ct1E94kdmK9LlvPWnxU
         33dw==
X-Gm-Message-State: APjAAAWj17ZyTNHGklvhOzCVHey+7QqRt9p9yGPEYJTj52RC14gvleq3
        rlsGx6W2fMY1tWF2J7XLdxYowJMAsP0=
X-Google-Smtp-Source: APXvYqwYd9jZsg3WAi0A/1dLmsXwqtOlVeJq5lzjxtkCxX24GZiBqPoOrUl3Ao3GWeR/60TVSnsOyA==
X-Received: by 2002:aca:b208:: with SMTP id b8mr36981187oif.98.1564527497206;
        Tue, 30 Jul 2019 15:58:17 -0700 (PDT)
Received: from localhost ([2600:100e:b005:6ca0:a8bb:e820:e6d3:8809])
        by smtp.gmail.com with ESMTPSA id b21sm23167935otp.80.2019.07.30.15.58.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:58:16 -0700 (PDT)
Date:   Tue, 30 Jul 2019 15:58:13 -0700 (PDT)
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
In-Reply-To: <CAAhSdy1pqZP+M27idvfOB8eB8zhPD_7hx9S60FpOmWRHs-R2qg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1907301544560.4874@viisi.sifive.com>
References: <20190726194638.8068-1-atish.patra@wdc.com> <20190726194638.8068-3-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com> <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com> <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
 <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com> <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com> <CAAhSdy0Eycc0ORSnh6LJeC_D_x9yLOkoc7OkPNuN6qOcZEGVWg@mail.gmail.com> <alpine.DEB.2.21.9999.1907270108420.26998@viisi.sifive.com>
 <CAAhSdy1pqZP+M27idvfOB8eB8zhPD_7hx9S60FpOmWRHs-R2qg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019, Anup Patel wrote:

> On Sat, Jul 27, 2019 at 1:46 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > On Sat, 27 Jul 2019, Anup Patel wrote:
> >
> > > If your only objection is uppercase letter not agreeing with YMAL 
> > > schema then why not fix the YMAL schema to have regex for RISC-V ISA 
> > > string?
> >
> > I don't agree with you that the specification compels software to 
> > accept arbitrary case combinations in the riscv,isa DT string.
> 
> DT describes HW and HW follows RISC-V spec.

The RISC-V specification doesn't specify anything about how the DT data is 
to describe the hardware.

> Enforcing software choices in DT YMAL schema is not correct approach.

That's the point of the DT YAML schemas.


- Paul
