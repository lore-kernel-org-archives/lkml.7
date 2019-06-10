Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D79C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AAE207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ieSZLelS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbfFJJfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:35:13 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:57668 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbfFJJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hvHEIsUHuFBpJysJSAh/TndXcB04oV4yePbtGuMBdHk=; b=ieSZLelSnKpjvNpvH2LPvshAf
        nDwm8iPPnsYNiFhs+BE5xIvXfmbYFHGIXXrH9fKXziYzO79y92u/Tbl/b0xHbZRw3KBWCC4dRA0do
        EK1YEYI5aUENNJlKGRA06BN33Vt+P+IJaLy8gJK1SBhS+F3ZahSFihKjyxiK2g3wlJj7M=;
Received: from merlot.physics.ox.ac.uk ([163.1.241.98] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1haGbQ-0003aw-G6; Mon, 10 Jun 2019 04:28:33 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1haGam-00039Z-E5; Mon, 10 Jun 2019 10:27:52 +0100
Date:   Mon, 10 Jun 2019 10:27:52 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
Message-ID: <20190610092751.GA11076@merlot.physics.ox.ac.uk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530141531.43462-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 03:15:13PM +0100, Vincenzo Frascino wrote:
> --- /dev/null
> +++ b/include/vdso/datapage.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_DATAPAGE_H
> +#define __VDSO_DATAPAGE_H
> +
> +#ifdef __KERNEL__
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/bits.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define VDSO_BASES	(CLOCK_TAI + 1)
> +#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
> +			 BIT(CLOCK_MONOTONIC)		| \
> +			 BIT(CLOCK_BOOTTIME)		| \
> +			 BIT(CLOCK_TAI))
> +#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
> +			 BIT(CLOCK_MONOTONIC_COARSE))
> +#define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
> +
> +#define CS_HRES_COARSE	0
> +#define CS_RAW		1

CS_HRES_COARSE seems like a confusing name choice to me.  What you
really mean is not RAW.

How about CS_ADJ to indicate that its updated by adjtime?
CS_XTIME might be another option.

Huw.
