Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20097C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D078321871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="PJRBuWKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfCOT3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:29:49 -0400
Received: from forward501j.mail.yandex.net ([5.45.198.251]:46196 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbfCOT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:29:49 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2019 15:29:48 EDT
Received: from mxback9o.mail.yandex.net (mxback9o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::23])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 052A0338021F;
        Fri, 15 Mar 2019 22:23:57 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback9o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 5WqSDuoMvB-NrT46FoB;
        Fri, 15 Mar 2019 22:23:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1552677835;
        bh=nhIb6iGmfpwq6ZLxMG2Q6cth4mwUfNUHZsPbfG8hneQ=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=PJRBuWKlYSBiShr+SxtPFcIIesZwR+jaOtdip/GyiMDtkpvTcgrKPPZBbgj4U22P6
         aSP/Tejzm8YuafdTof793C0zs8yEKKq2SvIwO47f4Or5pyIORyCmKjCVII82mKTNcq
         flCj/tn/F+c7dsyygYwryK9dM1HoDWyp1Unvrg0A=
Authentication-Results: mxback9o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt1-e20b74e6250c.qloud-c.yandex.net with HTTP;
        Fri, 15 Mar 2019 22:23:53 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        George Spelvin <lkml@sdf.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Dave Chinner <dchinner@redhat.com>,
        Don Mullis <don.mullis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20190315190614.GH9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
         <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
         <20190314091041.GU9224@smile.fi.intel.com>
         <201903150433.x2F4X9oT024601@sdf.org>
         <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>
         <201903151023.x2FANDVY013031@sdf.org>
         <CAMuHMdVgmb8eZ7bD+jye8DG7cQRywvVmwo_XNJ00f198pDcwxQ@mail.gmail.com>
         <201903151659.x2FGxi3R012970@sdf.org>
         <CAMuHMdV_Y8COyhExkf-rj1oC39iDyf3iPrN2FxH8tQnmpi6D3g@mail.gmail.com>
         <23331552675987@myt2-66bcb87429e6.qloud-c.yandex.net> <20190315190614.GH9224@smile.fi.intel.com>
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 15 Mar 2019 22:23:53 +0300
Message-Id: <69031552677833@myt1-e20b74e6250c.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



15.03.2019, 22:06, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>:
> It makes harder to read and understand the code. One needs spend deciseconds /
> seconds to catch instead of santiseconds of time.

If it is true for someone (for example, for me it is almost as readable
as a simple size_t), then I agree with Geert who said: "use size_t everywhere".

With Best Regards, Andrey Abramov.
