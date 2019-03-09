Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90938C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D3520652
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Z8o81IH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCIU1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:27:18 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:57288 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbfCIU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:27:18 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2019 15:27:16 EST
Received: from mxback15o.mail.yandex.net (mxback15o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::66])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 713F1600BD;
        Sat,  9 Mar 2019 23:19:52 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id gUC8cd86v7-JneedDhV;
        Sat, 09 Mar 2019 23:19:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1552162790;
        bh=8FG/9gLREUJAOj5pH8rp0s0swEnerCijUGE6Ohzjl/M=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=Z8o81IH2y1SXL8ipRnhiKYErNurmH1xqaiE7fHw7Waa4oJAOUK6pspl9fzrRZju6d
         qjbSAYC/tZVI5mJ5Q48+CxCDPwHWhJt59xln2qaygMOJ2HjCGFw7QubuaN4IQdPaAY
         yAFg2Vp3ORmWIc1xKUZ2CGgx0PhZ9U3EsgC6nP/s=
Authentication-Results: mxback15o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-2fee75662a4f.qloud-c.yandex.net with HTTP;
        Sat, 09 Mar 2019 23:19:49 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     "lkml@sdf.org" <lkml@sdf.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel.wagner@siemens.com" <daniel.wagner@siemens.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "don.mullis@gmail.com" <don.mullis@gmail.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>
In-Reply-To: <201903091553.x29FrfMR018600@sdf.org>
References: <cover.1552097842.git.lkml@sdf.org>,
            <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>,
            <20190309140653.GO9224@smile.fi.intel.com> <201903091553.x29FrfMR018600@sdf.org>
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 09 Mar 2019 23:19:49 +0300
Message-Id: <10806701552162789@myt6-2fee75662a4f.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Although I'm thinking of:
>
> static bool __attribute_const__
> is_aligned(const void *base, size_t size, unsigned char align)
> {
> unsigned char lsbits = (unsigned char)size;
>
> (void)base;
> #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> lsbits |= (unsigned char)(uintptr_t)base;
> #endif
> return (lsbits & (align - 1)) == 0;
> }
>
> Any preference?
I think it would be better.

> I find "u32s" confusing; I keep reading the "s" as "signed" rather than a plural. How about one of: swap_bytes / swap_ints / swap_longs swap_1 / swap_4 / swap_8
In my opinion "swap_bytes / swap_ints / swap_longs" are the most readable.

(Good job)
