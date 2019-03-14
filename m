Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32174C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18DA21872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vdx8LfPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfCNUFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:05:55 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:42883 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbfCNUFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:05:54 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 16:05:53 EDT
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net [IPv6:2a02:6b8:0:1619::94])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id A4C7D940426;
        Thu, 14 Mar 2019 22:59:57 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback18j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ylhy0F4dbV-xt0apvg4;
        Thu, 14 Mar 2019 22:59:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1552593596;
        bh=gcpmbk+jd0iWV8QKlwVbOQzs8qrR8+lTwaxReVLl4pM=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=vdx8LfPduNdx1OsTiPsBrywM8+199pyePhw0zZgWnrF2y5Z/wn0Rsr7u//7o5RCSg
         c5/VleT188wAG5CKAwXHG0JpEThQ78iCEtJzwfECX3XCXzgfWnCzNz+O17ikQqRecu
         T0g6bw9nO2ZEsSvmY5u8gohxNgNDbXzTuQczz6J0=
Authentication-Results: mxback18j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-2074c606c35d.qloud-c.yandex.net with HTTP;
        Thu, 14 Mar 2019 22:59:55 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        George Spelvin <lkml@sdf.org>
Cc:     "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "13@sdf.org" <13@sdf.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel.wagner@siemens.com" <daniel.wagner@siemens.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "don.mullis@gmail.com" <don.mullis@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>
In-Reply-To: <20190314121811.GY9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
         <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
         <20190309140653.GO9224@smile.fi.intel.com>
         <201903091553.x29FrfMR018600@sdf.org>
         <20190314092958.GV9224@smile.fi.intel.com>
         <201903141009.x2EA9q1Z025888@sdf.org>
         <CAMuHMdW0jd-oNtgBf=aHfzVoBbVh0OJYC6ELhDv3VrcGwUECwA@mail.gmail.com>
         <201903141153.x2EBrtKi000133@sdf.org> <20190314121811.GY9224@smile.fi.intel.com>
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 14 Mar 2019 22:59:55 +0300
Message-Id: <1145741552593595@sas2-2074c606c35d.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Pistols at dawn?

> swap_bytes
> swap_4byte_words
> swap_8byte_words
or
>  swap_bytes / swap_ints / swap_longs
>  swap_1 / swap_4 / swap_8

Yes, in my opinion, swap_bytes / swap_ints / swap_longs are the most readable because we have both swap_ints and swap_longs functions (in one file near each other), so I don't think that there will be any confusion about size. 
But actually, it doesn't matter which name will you take, because the meaning of each, in my opinion, is obvious enough, so I don't mind about any of these options.

-- 
With Best Regards,
Andrey Abramov
