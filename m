Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2631AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A8621871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qiSMagSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfCOSxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:53:13 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:40795 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfCOSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:53:13 -0400
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id B39F535000F2;
        Fri, 15 Mar 2019 21:53:09 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 72gey84DEa-r7YOHG7U;
        Fri, 15 Mar 2019 21:53:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1552675988;
        bh=gYi1bkdm2UN24eCSwHaiBnNoXAS1A4aKl7rArIjkGlw=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=qiSMagSDYAeOEu+r55qj+9rSs9Zx+Lnbu4hZoRiZeaSLvhCb7Lta+mzK2Id2qt1j6
         5TxDWpgGmCKy9qo26DSItwfyok9bJK6zVGw8mtL7Prd70+0GWq90KgUerUx/jOIXSk
         gURFY7BrXQMeTXMKPIU0+4E6dp0jlqCjgZQIkQ3o=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt2-66bcb87429e6.qloud-c.yandex.net with HTTP;
        Fri, 15 Mar 2019 21:53:07 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        George Spelvin <lkml@sdf.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Dave Chinner <dchinner@redhat.com>,
        Don Mullis <don.mullis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAMuHMdV_Y8COyhExkf-rj1oC39iDyf3iPrN2FxH8tQnmpi6D3g@mail.gmail.com>
References: <cover.1552097842.git.lkml@sdf.org> <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
         <20190314091041.GU9224@smile.fi.intel.com> <201903150433.x2F4X9oT024601@sdf.org>
         <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>
         <201903151023.x2FANDVY013031@sdf.org> <CAMuHMdVgmb8eZ7bD+jye8DG7cQRywvVmwo_XNJ00f198pDcwxQ@mail.gmail.com>
         <201903151659.x2FGxi3R012970@sdf.org> <CAMuHMdV_Y8COyhExkf-rj1oC39iDyf3iPrN2FxH8tQnmpi6D3g@mail.gmail.com>
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 15 Mar 2019 21:53:07 +0300
Message-Id: <23331552675987@myt2-66bcb87429e6.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to present the case to spur discussion, but it realy is
> a *question* I'm asking about whether to do that, not a suggestion
> phrased as a question.

> If it's just x86_64, use size_t everywhere, and let them suffer, for not
> being real 64-bit ;-)

But what is the problem of local typedef with a good and clear comment?
