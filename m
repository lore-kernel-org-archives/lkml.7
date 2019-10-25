Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA06CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071FC21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Kf2QBuVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437949AbfJYIYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:24:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39082 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437938AbfJYIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:24:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so1253654wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QJej2zrE0QBqg+iZe6C/nm9jF4Wofv1H//Qo71L/Lag=;
        b=Kf2QBuVDRfq6+w0N7DCDZImKcWFxzkw3pvVhiEdnzg1XkUgGeTTSWLT/AXDil240QQ
         hoyIRS/bK4lqFnlz87IYHANGs4Xws7dB93EvJssGohry3bsXOshEno6Dqk4BPaPnfpRY
         MW1z665u1spkHgC4bGahdMT464TLw+1YH8Z8lmyJ1nskaMZZ46OQsKn2jmmBRxe0Ncvr
         RfQX4whxGZGnyVjXC+tZgkm3LVXnhyuhXcBmsUKSK8o7DckMmoVIGMkNC1lf4WASjicO
         /1VKnZn2qgrQn2r3sA6XsMoV6YvwKEEDchmOtm6V2itNyqrXRr+3KxQQLEV90vCR7S6U
         0kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJej2zrE0QBqg+iZe6C/nm9jF4Wofv1H//Qo71L/Lag=;
        b=raSmnYzg/EG5v8cxTffHvtSdodr0YeiD/g50yYfPx0lSR7GiTR96QSH+m/MAyYhDSZ
         Rq8HMF8W0J+/V0zSjzfBdJd8cNxAUuT+5xGD+qWpEyqKl6HyI2cIX+j48BDH/NM3nkg1
         iKuOVkC+HjyC6h9Fv7M+hmfsiHgHB6aALiwM5LKWAc3kpbe+E0kEKZ8sUQ382H/uSiSd
         j+2kG1w/EK64ScY8sopiBB49vypk2a3lcVupVbSDYfZGgmci8xJv6eK1z0bwlDdmTOfW
         k8/dnj3AcPpqI4ZX7xfVUp9oOUrH6phG4RbiDnYQcq3lrl4ByHQp/itZ0hRZ8QZ+qtKo
         OWGA==
X-Gm-Message-State: APjAAAWG0naSWxbYil6C7LzgV2ZwCpBi/SPjbkLdpRa04Tm9GuMl5gpw
        mQ43rjSWoZwbOgqJaKLzIOCT/Q==
X-Google-Smtp-Source: APXvYqyVbVYhcUVjlWsHAWMsNSTmIYOz09PiXSzKL+kucF3259sySENSkNokb9u6ffLnyHFkS8YN/A==
X-Received: by 2002:a5d:4aca:: with SMTP id y10mr1692223wrs.292.1571991887824;
        Fri, 25 Oct 2019 01:24:47 -0700 (PDT)
Received: from [66.102.1.109] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id b5sm1290058wmj.18.2019.10.25.01.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 01:24:47 -0700 (PDT)
Subject: Re: [PATCH 06/12] microblaze: use pgtable-nopmd instead of
 4level-fixup
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-7-git-send-email-rppt@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <aa7df5a1-5022-bc82-8816-74c956e2fd90@monstr.eu>
Date:   Fri, 25 Oct 2019 10:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571822941-29776-7-git-send-email-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 23. 10. 19 11:28, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> microblaze has only two-level page tables and can use pgtable-nopmd and
> folding of the upper layers.
> 
> Replace usage of include/asm-generic/4level-fixup.h and explicit definition
> of __PAGETABLE_PMD_FOLDED in microblaze with
> include/asm-generic/pgtable-nopmd.h and adjust page table manipulation
> macros and functions accordingly.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/microblaze/include/asm/page.h    |  3 ---
>  arch/microblaze/include/asm/pgalloc.h | 16 ----------------
>  arch/microblaze/include/asm/pgtable.h | 32 ++------------------------------
>  arch/microblaze/kernel/signal.c       | 10 +++++++---
>  arch/microblaze/mm/init.c             |  7 +++++--
>  arch/microblaze/mm/pgtable.c          | 13 +++++++++++--
>  6 files changed, 25 insertions(+), 56 deletions(-)

I have take a look at this and when this is applied on the top of
5.4-rc2 there is not a problem.
But as was reported by 0-day there is compilation issue on the top of
mmotm/master tree and I am able to replicate it.
It means there are other changes in Andrew's tree which are causing it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

