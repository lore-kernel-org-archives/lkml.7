Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F4BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E72820B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="bbNfokFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDGJ04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 05:26:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44253 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDGJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 05:26:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so5546239pgj.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f7PuE3PU9IZAKRYkOlaFgDb8K/95QJK0u4dqN4qojd8=;
        b=bbNfokFimd5HQORnbNhwUODAS598jejVD1m12V8aOtncSZySR/fuC68GhmvdZv8mHX
         IDGCOsc9Sum7PTqZbkZMJinGVMDJq4Sn9drQIQeqSn1UiTV3U+gfGTXbcSSY1R9i+Ufg
         4QxUmA29ITT+FZI4a5sudgZAKlbpNY8FW5N9ZPCNkTln+HxmNLJlwN5FJtqdtfNENOuT
         Gh3Cv3B7j7xEb5YQq5rmYH6tQINkdti6qA+0SwNRzWZjNYgsPAAIfD2j3M1nRrwWdS3m
         TKdqdqrTMhEdv6sQB91s+hcktNGv2UQlEuUavw54FAYpLcO7o0q9Zo9KDFr6kKuIQzN9
         lGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f7PuE3PU9IZAKRYkOlaFgDb8K/95QJK0u4dqN4qojd8=;
        b=YIpzxCRS114o09aAaEMEzaudtP1dVOZGUuLSLKYvzbIIFeW4m5mox2jUvi6Iy4kMLn
         PPwtatNN8dLvNDyodbRsfPobYP3vuHvxfhB8fDXwsh5Pno6LsUyLPjAl1FjXkha2JrI+
         jxSMvi1EYzj7qShJQmKoVOHnbHFQsjBqTci45nhHs8ZOAXfbdyyh47BaN4C80YRAqMei
         uSwR3CBUeuqgnY23OKnnHssHAFVKMTMMW1tnAg7Tey6oghZTdkRuje207yrX1jHW+sEm
         LQqX7+T9S2B1WLNqRHZBzx3kj+4Pg0dFox07ev5/WPbgkXgLs398XycUyls8EKvi7iae
         Cwyw==
X-Gm-Message-State: APjAAAV+7MelSp0e9ZURdyJqanF1z4ypUYZIjv9Q2s512f6p4C2nQvsv
        VFFH3AgsH6i/ZSMRBwxbcj8MXA==
X-Google-Smtp-Source: APXvYqwgo4bTgsxmi78CDfl635n91U8QaX0z12SPG7nm2Hj+GWiGO204fmPYgSQ9TyOccAM69j6ZWA==
X-Received: by 2002:a63:460a:: with SMTP id t10mr21326844pga.354.1554629215717;
        Sun, 07 Apr 2019 02:26:55 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:8daf:800d:46cf:9ade? ([2601:646:c200:1ef2:8daf:800d:46cf:9ade])
        by smtp.gmail.com with ESMTPSA id n17sm20446687pgk.81.2019.04.07.02.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 02:26:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: 8b275b3754 ("x86/irq/64: Remap the IRQ stack with guard pages"): BUG: unable to handle kernel paging request at ffffb659000a1000
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <alpine.DEB.2.21.1904071121270.1840@nanos.tec.linutronix.de>
Date:   Sun, 7 Apr 2019 02:26:54 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A03AEEC0-2398-42DE-80DF-7BE4D81EFEF5@amacapital.net>
References: <5ca84952.hpEqUp6kap0tafzR%lkp@intel.com> <CALCETrX_ys9dJZOkN7QBjWz9Y1iukQDaJaASPAkGtWvwNkOESw@mail.gmail.com> <alpine.DEB.2.21.1904071121270.1840@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 7, 2019, at 2:23 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Sat, 6 Apr 2019, Andy Lutomirski wrote:
>> I haven't spotted the actual bug yet, but the faulting instruction is:
>>=20
>>  2a:    65 8b 35 09 ca 75 63     mov    %gs:*0x6375ca09(%rip),%esi
>>    # 0x6375ca3a        <-- trapping instruction
>>=20
>> This seems to be faulting just above the top of the stack (the thing
>> in RSP), so I suspect that there is some path that is shoving the
>> remapped value into GSBASE, which is wrong.
>>=20
>> Also, FWIW, there was some reason that I initialized all the virtual
>> mappings for all possible CPUs early.  I don't remember what it was,
>> and it may not have been a good reason, but I put at least some
>> nonzero amount of thought into it :)
>=20
> There is absolutely no reason to have irq stacks before init_IRQ(). 32bit
> uses at runtime allocated irq stacks for years.
>=20
> If the CPU takes a device interrupt before that, then there are way more
> things which explode than just the irqstack pointer being NULL.
>=20

Fair enough.  Although the patch I emailed in the other thread allows at lea=
st the entry code to survive on 64-bit at the cost of just a couple lines of=
 code.

But the kernel does indeed seem to work fine without the change. Feel free t=
o disregard that part :)=
