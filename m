Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8957EC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF94217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559119334;
	bh=kLcWkuMUD1c9UKeh1Icn/by3J3KUqRiWwfXRFd6P5x8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FYDuuBtg3saM3pehzXKPr/TmVHvGlkYr6FxGuX5jyIm/JaN3yf+l6YjGGR+4mP/CH
	 g/jWGTwIERATdKSVSUrl4+c4gB7YbuHVT0KRgolamDi1WHsEkAq0lNz/PM6cqXbpQC
	 YuaisGbYQe14Izn9dJY4kKORzd5Rmy6RCZrvSgHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfE2ImN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2ImN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:42:13 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC632081C;
        Wed, 29 May 2019 08:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559119332;
        bh=kLcWkuMUD1c9UKeh1Icn/by3J3KUqRiWwfXRFd6P5x8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TpzDSS2RYXCTm80dxTw9lE8EUlXiI94NlWx9ro3r8TnxPR1QYZFdHgBvQgtL3AGoO
         8epxsYy9MpT3LjEr3evqQesj4oMRKkK/VIuSDK9u6y3OLQEtScwMDfNa/GnwXzM5F5
         +G9B5pr36kY5XqsaRKjnZBikURUEDj2GfLK6MAik=
Received: by mail-lj1-f181.google.com with SMTP id e13so1553655ljl.11;
        Wed, 29 May 2019 01:42:12 -0700 (PDT)
X-Gm-Message-State: APjAAAUFtWprd4rks9Qn/r6JVxomoxzzB9dSlwI7nwhVlRYQ1RVMwnaz
        rMSVFzLBzLhxKCXx150ydP68jnwahhQ/0s/oEQo=
X-Google-Smtp-Source: APXvYqzUzMIm/yFZwUkBnd9PJV+6XSRK74Of5UYSuWnDEXSI3A+Id6tCaQkHsfE2heRDgEkW5hmncH1hvrpO/lvVcHY=
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr3098090lji.64.1559119330847;
 Wed, 29 May 2019 01:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190528082903eucas1p1ef54fa6aee420bffa11be61d5efb4c46@eucas1p1.samsung.com>
 <20190528082846.21625-1-m.szyprowski@samsung.com>
In-Reply-To: <20190528082846.21625-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 May 2019 10:41:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcgbSHDAnRc+9dtiuLOQ2Ah9mVrYvEdd33M_AAuC5Z5xg@mail.gmail.com>
Message-ID: <CAJKOXPcgbSHDAnRc+9dtiuLOQ2Ah9mVrYvEdd33M_AAuC5Z5xg@mail.gmail.com>
Subject: Re: [PATCH] ARM: Add workaround for I-Cache line size mismatch
 between CPU cores
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 at 10:29, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Some big.LITTLE systems have I-Cache line size mismatch between
> LITTLE and big cores. This patch adds a workaround for proper I-Cache
> support on such systems. Without it, some class of the userspace code
> (typically self-modifying) might suffer from random SIGILL failures.
>
> Similar workaround already exists for ARM64 architecture. I has been
> added by commit 116c81f427ff ("arm64: Work around systems with mismatched
> cache line sizes").
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This workaround is needed on all supported Exynos big.LITTLE SoCs: 5420,
> 5422 and 5800.
>
> Resend reason: removed RFC tag as there are no comments, I will upload
> this patch to the patch tracking system

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
