Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88387C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62520674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aTIeH/Bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfK0PcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:32:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44641 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0PcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:32:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id a67so19973155edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xep35NOUiSEhnzznO79e2fvbBNLtDBMI+/zstnlMPYc=;
        b=aTIeH/BzHrCwyIraGx4HfI21tiaCubyUHiuQLrXwGLSUKVjrY+ps0pcmHy4eRlm3PN
         tfitfqcvNJ3HUbAvxjz2HdEovCrH1HSvt6qWxfxsn8svACC2PNmYiYZzDkqLIyvPD6dc
         SYbo+KHbjyt8Gx0q6nOilLA1ErlqeWRysumRcNDAwNmxity5rmmVIGyPcg216/ETEdi2
         FVU2F3dSV6nNMy3ZkFOkTupdiy6zg7MY2h6uBYIHGOtj5Mi/BVhJfvPAqUFMhZ8chHHM
         LM7sC4fo5gcgcFmNR+aeax3OQJQyxyaxAW5JiCFgFEy33LjEUzX6TT964OfF+8/eCNRz
         3NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xep35NOUiSEhnzznO79e2fvbBNLtDBMI+/zstnlMPYc=;
        b=lYNYPR4xF48sUtkjkiCskjFwgWc4D/IqqK5WU3a0p0Hyj7CAaGC5/FFlHEfG+W0Ho/
         I5Cfc9l7Ou86klzihcZDEmZbZElqg6bpRoYTOr579W38HyJPQW1Zh04GYCkzDlde2tqS
         2aXriLMLP0rH10jCKzVVGvntlTtbE9xHAxzt+vofEPNcA2DytyBy0ngYKTRu2bjzfQAV
         jEBC3jzWYnJRrNHsWsAJiAIfAhkhJKT2arlhGONW2LLFxC7D/5twlZqkvzvmf7m9CycZ
         4aZiCyaL2NtntzD1impsWYQDNZ1vzbbvfnF16M+atZOSDyPWigmAcnQO+MAeNYOwFaK2
         1Obg==
X-Gm-Message-State: APjAAAVoIivhtJCUC9qgSWcWUSazaD/isJdS7vyTFOm41+1043ujo94K
        whjqgjygCBIWbRgJJlQ2QvVab+pP6yCORjOZIWItjA==
X-Google-Smtp-Source: APXvYqw+fdhDVDwoSsZuVb3eLmS5SoW5oV0ma0DwgE4YGBgMCjVO3YAn2ZeKw6HasOpTNrIjFoMuZFR2WFJKRJ/d0OA=
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr1286976ejb.322.1574868725771;
 Wed, 27 Nov 2019 07:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
 <20191122022406.590141-4-pasha.tatashin@soleen.com> <20191127151154.GC51937@lakrids.cambridge.arm.com>
In-Reply-To: <20191127151154.GC51937@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Nov 2019 10:31:54 -0500
Message-ID: <CA+CK2bDDom_pwLC-ABwDw66ynyELH3f3NdjUEdhr1LYLkgWJvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: remove the rest of asm-uaccess.h
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Nov 21, 2019 at 09:24:06PM -0500, Pavel Tatashin wrote:
> > The __uaccess_ttbr0_disable and __uaccess_ttbr0_enable,
> > are the last two macros defined in asm-uaccess.h.
> >
> > Replace them with C wrappers and call C functions from
> > kernel_entry and kernel_exit.
>
> For now, please leave those as-is.
>
> I don't think we want to have out-of-line C wrappers in the middle of
> the entry assembly where we don't have a complete kernel environment.
> The use in entry code can also assume non-preemptibility, while the C
> functions have to explcitily disable that.

I do not understand, if C function is called form non-preemptible
context it stays non-preemptible. kernel_exit already may call C
functions around the time __uaccess_ttbr0_enable is called (it may
call post_ttbr_update_workaround), and that C functions does not do
explicit preempt disable:

> We can certainly remove the includes of <asm/asm-uaccess.h> elsewhere,
> and maybe fold the macros into entry.S if it's not too crowded.

I can do this as a separate patch.

Thank you,
Pasha
