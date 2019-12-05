Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB0020801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="RA4tiDzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfLEQds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:33:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52120 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLEQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:33:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so4594444wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oi4NxqIcB/sLBs0ZuKTjMv5e03fZL2Q3JzIP+n3fXmY=;
        b=RA4tiDzg8xnt85vBNiTM8llJjCZOYbDw6eGVTzKAdeDWOme5cGtcTQF98ptJ/nQf6B
         IqTMoOYdJbaoPjFpTlzKfXt+99zF4bXB56j1Gel47AQ0OmhgCkLgla7g8STbsf03EEY4
         HC3GdgIrBYGgJO3gJbeY7VVOiVUGxpXP26EtBosLK0cG2ZN9gTMCLA0FA5HSlYOUFhpM
         0GPL9mfrC1MGj7xQ4ENqoDFeNw6XdhPpz7N2un++jCbjtu1898ymrk6ca/CXSosSYn5g
         uGxzZc3apmIFN65W1szYpl2QhjIuLXISDTxKD1x7YnCyfFq4SkyBsgPaMh9hpCkQC3E0
         3AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oi4NxqIcB/sLBs0ZuKTjMv5e03fZL2Q3JzIP+n3fXmY=;
        b=L0Yi/dMdC/7zbg+GQQZ6jP5KtK+AYUNLhL2DGGq5cpXh2yULTZ5s99nzCDUNBVBtFG
         OfQNMGCg3VC2nhuoSiB0vTmvPJgrcsKszSLkkU5w5eIgydUcHe7uto4vPvEPyFPQmb0v
         GfWk9Gohp6moGIAmsXcO4IiHV4pv2xLDG1IuTQ0IQm3JeQZP+ZwphSIux3udSNhVpWPF
         qqFME2y4m66bGjYXF/bpcBFov63StW6l1H/WkW1mHZCehLQ1Upa9Ulkwhor0EkPks9cj
         VogfwPwM6iT2xtFsV9am7OpbjzHBUIHgxUEx7CYyJagazv24SBixtSiNNzIuVxvouaDm
         V0ng==
X-Gm-Message-State: APjAAAWn0GGh1f29meU30ESM9o+sLwAxRzkwgbiVyeZ1SIiGHK/c5Fzu
        aM0Te88ceyrbQhFRDrzUqnl+B9NSD7Mk8hZ0LoSmSw==
X-Google-Smtp-Source: APXvYqxAnS8Y4PwGJJZsCFD6graed10C1Q8H4y95lmg4TYZGi+8RZTvZjcSKIECPuS9AbZC8TYmezaXOsc3pJ7MT+0I=
X-Received: by 2002:a1c:9602:: with SMTP id y2mr6074952wmd.23.1575563625723;
 Thu, 05 Dec 2019 08:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20191205005601.1559-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 5 Dec 2019 22:03:34 +0530
Message-ID: <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add debug defconfigs
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 8:33 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Thu, 5 Dec 2019, Anup Patel wrote:
>
> > Various Linux kernel DEBUG options have big performance impact
> > so these should not be enabled in RISC-V normal defconfigs.
> >
> > Instead we should have separate RISC-V debug defconfigs having
> > these DEBUG options enabled. This way Linux RISC-V can build both
> > non-debug and debug kernels separately.
>
> I respect your point of view, but until the RISC-V kernel port is more
> mature, I personally am not planning to merge this patch, for reasons
> discussed in the defconfig patch descriptions and the subsequent pull
> request threads.
>
> I'm sure we'll revisit this in the future to realign with the defconfig
> debug settings for more mature architecture ports - but my guess is that
> we'll probably avoid creating debug_defconfigs, since only S390 does that.

We have a lot of users (Yocto and Buildroot) dependent on the Linux
defconfig. I understand that you need DEBUG options for SiFive internal
use but this does not mean all users dependent on Linux defconfig
should be penalized in-terms of performance.

This is the right time to introduce debug defconfigs so that you can
use it for your SiFive internal use and all users dependent on normal
defconfigs are not penalized in-terms of performance.

If you still don't want debug defconfigs then I recommend reverting
your DEBUG options patch and you can find an alternative way to
enable DEBUG options for SiFive internal use.

Regards,
Anup
