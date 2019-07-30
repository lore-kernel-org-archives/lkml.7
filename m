Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F8FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C3A20882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="LrczV40P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfG3H0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:26:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfG3HZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:25:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so64543300wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHsfGOiHudmcq3LRs8Aej8bkXt/7q6tGTs328qFT3fk=;
        b=LrczV40PBYaEexs2nulDPR9CbIEw7ONJ5yLSnCOFXbBboSYj4LvB840cLolZPaw7D7
         2SH/3EZ21korc3Uq3tCl5SXaAiI8mZ/Qh6D+mIJstzIy1ez/cPVHYOdwB0h2O0dVyohc
         nxGd5YiRj3L5zZ7QzRfEaUwQFuL2R8291rzLiLCJWEY7dWxNSKh525tdU02FOSmR67l0
         5qd8nclSVf1X3wt81DKacMW3Az7iMY2pq0tKyalbqZ0+SpswNxqkNPCeKU5+CW++CaT0
         0i00b+aNdPcm9Ydin1BMYTueOxMbaRh5qYlmxtwSbiG1CjFl/xxjpkuVu0HVzlN7I/2z
         BolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHsfGOiHudmcq3LRs8Aej8bkXt/7q6tGTs328qFT3fk=;
        b=SxoyFQIYEUNx+yh45O+NLQCeN2ruxELmSVYgMJ8Sz635dPpsczynycevUycr3Zo6N/
         Bn2mlwdeUyu7i3nmnpwKBM1EfcGBCJRe3jv7zTDPqwpBPSOoAuUk4Amke7KBMot1HmCQ
         DW82W7/5vq5a+R+hq9Vco0zVQW720o9C43etg7wDAEIkUyq5M0R9eLRZQf5qT6rCF5Aw
         bMpzk4A5gD9QDf1R6KJHrd+MgZO292bF7WPIS5yBH1Vrn9mEsTgWghTl+pRGg7iaF9hN
         hNHEbDVj188ABiJIZZP0X2abnLjxyNRz+qP+cabqtwTEvwa1Q3ZAaND6ZMgQC4F2k7Ia
         LXKg==
X-Gm-Message-State: APjAAAX3vH1OqcMY3RBEHI2ZPlyyLN2/4TOD67j6Vgp+JvGlmt10rYwj
        ZD2SjUGCFWDVYZc/wKu225hbhokQzgBVIJ/7t6o=
X-Google-Smtp-Source: APXvYqzfPqQlTpifZXrLgaPOHcYZc+NXl65yC/U+gpC8aBM5EAS2Ozjrobt3zBDfVK+pW5CxK1jdZLTWfym4UfgP5I0=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr118068531wra.328.1564471542194;
 Tue, 30 Jul 2019 00:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <mvm5znkau8u.fsf@suse.de>
In-Reply-To: <mvm5znkau8u.fsf@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 12:55:30 +0530
Message-ID: <CAAhSdy2jKQspZNwvd5VnZ8iyWjwe0fGXR+3WwP9cn5pEOcSfVg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] KVM RISC-V Support
To:     Andreas Schwab <schwab@suse.de>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:23 PM Andreas Schwab <schwab@suse.de> wrote:
>
> ERROR: "riscv_cs_get_mult_shift" [arch/riscv/kvm/kvm.ko] undefined!
> ERROR: "riscv_isa" [arch/riscv/kvm/kvm.ko] undefined!
> ERROR: "smp_send_reschedule" [arch/riscv/kvm/kvm.ko] undefined!
> ERROR: "riscv_timebase" [arch/riscv/kvm/kvm.ko] undefined!

Strange, we are not seeing these compile errors.

Anyway, please ensure that you apply Atish's KVM prep patches
(https://lkml.org/lkml/2019/7/26/1271) on Linux-5.3-rcX before applying
this series.

Regards,
Anup
