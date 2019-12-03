Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8ADC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D10620684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2ym4D4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfLCXTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:19:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39889 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfLCXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:19:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so2304762plk.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 15:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9aXu3KlzmsFJZ6e1TagDw+H66vR2neNxwDhx8plTDXE=;
        b=P2ym4D4fL1+2jZqsid93tZ5apni+LjMsWc92QordN593FLqJA+W4QsDirE/huNl5P1
         knTb5ViKDuyT37oe2VN6u4X65E0qoBXrLkTPFAuJUi/5puCIe1qhO5AoFzYvaAhJhDJ/
         ZGHsuAM2+IsfbemFqexEjQZ4n4aB/Wh5ZwyttSwHl/fUGPvWV8l/4obp0kKZH4Bn7wN8
         NCNmGeMIhEC8bdCNINKJ3DfitAYpZweN1bWtt3twrfio7lymvab4N1QAZRZDbCoA8ly6
         E8ZrLQ9Zp/SCypjcbsQgMv1HiPrzTDj5AEqazdjiq8h5eXDuVNBII9xFODUIIb0IxZ2V
         PfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9aXu3KlzmsFJZ6e1TagDw+H66vR2neNxwDhx8plTDXE=;
        b=AV5kGwhXe5BxOYPlZLuDsbDrfv7KqMTT6UDseXrzkyrFm8fgzg1sZI6oUXPduspgwD
         howaTvUvQcOine6nAtdujVS2NjoZRo7TezBptxK9Rtw8PWA+HT3RXzkvzqexCyT4xcl0
         357pZLq8IvZebJoc24qpXqIF9fqaQjCRJv1gv79b4fILRQET9HOaVuMkls0xpjwckRt/
         Q7eJhjXzp5AyNCzLHq0SkbAQENfqlzu1MzhbFj5hc6TRVdX8BHQKS1YSOLp2W8xL93iZ
         nB0rvoAsfZttZB3fQ1hNfXQM7OfwbWLbs4d7sfPCwV1D+cNrrrj1sMSNMLeLxriuOgLL
         3DmA==
X-Gm-Message-State: APjAAAUq4FnYeBnQ2pGwUroBgsWCFAiMLpFFnoFaZdgmFau7sKqbxAv1
        Qa6st9aQwGJm68Pb7CZ6Qw8X93eHe+fG33lOJwG1mA==
X-Google-Smtp-Source: APXvYqwaPUhrCsgUEC6zT/MsYaJdSktVjMyOaLL/ZwQxaZzTYw2kYgyCxNVMDYa3yDWpwXTVusT3MTlJbF4W8DELTSA=
X-Received: by 2002:a17:902:7c84:: with SMTP id y4mr417290pll.297.1575415143951;
 Tue, 03 Dec 2019 15:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20191125202937.23133-1-roy.van.doormaal@prodrive-technologies.com>
 <20191126074025.5112-1-roy.van.doormaal@prodrive-technologies.com>
In-Reply-To: <20191126074025.5112-1-roy.van.doormaal@prodrive-technologies.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 15:18:52 -0800
Message-ID: <CAFd5g450nWm47mFi10W+J=oiaO_sV0fXh3SwH0zxX6ZF1qZ-Xw@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/aspeed-i2c-ic: Fix irq domain name memory leak
To:     Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:41 PM Roy van Doormaal
<roy.van.doormaal@prodrive-technologies.com> wrote:
>
> The aspeed irqchip driver overwrites the default irq domain name,
> but doesn't free the existing domain name.
> This patch frees the irq domain name before overwriting it.
>
> kmemleak trace:
>
> unreferenced object 0xb8004c40 (size 64):
> comm "swapper", pid 0, jiffies 4294937303 (age 747.660s)
> hex dump (first 32 bytes):
> 3a 61 68 62 3a 61 70 62 3a 62 75 73 40 31 65 37 :ahb:apb:bus@1e7
> 38 61 30 30 30 3a 69 6e 74 65 72 72 75 70 74 2d 8a000:interrupt-
> backtrace:
> [<086b59b8>] kmemleak_alloc+0xa8/0xc0
> [<b5a3490c>] __kmalloc_track_caller+0x118/0x1a0
> [<f59c7ced>] kvasprintf+0x5c/0xc0
> [<49275eec>] kasprintf+0x30/0x50
> [<5713064b>] __irq_domain_add+0x184/0x25c
> [<53c594d0>] aspeed_i2c_ic_of_init+0x9c/0x128
> [<d8d7017e>] of_irq_init+0x1ec/0x314
> [<f8405bf1>] irqchip_init+0x1c/0x24
> [<7ef974b3>] init_IRQ+0x30/0x90
> [<87a1438f>] start_kernel+0x28c/0x458
> [< (null)>] (null)
> [<f0763fdf>] 0xffffffff
>
> Signed-off-by: Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

Sorry for the delayed response.
