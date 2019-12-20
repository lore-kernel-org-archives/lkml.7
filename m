Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C13C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9826D24687
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhTe8eSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLTGET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:04:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35353 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLTGET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:04:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id j1so1396184lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 22:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnPyTr2iiNHnW0FS9YnHgx6tK9jG9pl7XCuokVZaafI=;
        b=PhTe8eSZM1CRDjHBFlNxQ5pvj1zgzFLNdRhHcC2Lp2XM1qd6wU3s0RWNTRZ1YN/AYu
         VXxyw8EzVnqlngZZuCsT7OS0cWhH6f2bwh/+61kgQ61FpQoYciZLc44V6zvFpz/d7byy
         CAQygGhDFRvLU6c1CCHW+oCu3PykihSZt8LF42wrm26Bsgx/47xwlonix+L8Ye+XhngK
         tPR1Gmhee2TnHDeDlMJGayfha+U8vZkBymqSd0qk4PeR2yE+jEBRTesDAMcyurPIMEVm
         G4WY33Ewvn/sNEMyCDmH5F9vZKC/9HaYCGJ0px7fV5So1GXVHsKGqu2KLCqjwC60Ttql
         SIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnPyTr2iiNHnW0FS9YnHgx6tK9jG9pl7XCuokVZaafI=;
        b=eigfBlApUQA5jMxcbcocQHOYFBZB2/HBeq/ysTjWnWWyLZPPRYcNjwhcQQGRE5+Mfp
         YtI4ew73Yr0sB7VG/pAOoNYwWz6dJ9FOGtfvGNBzlxCiiAt1G21PYRD9oCTxGvHY/HoV
         IiKUfJlICELUk9LvLex8UmE3HFhqK7EWav6OLsurRP64gXpnIcJcOxQZq2zh56BsbnEU
         DbyBzCN9vtVBFlwkPbZI4/gUhCZ2diaKoFFxyZjEF4fYnkNht9H7gsWTCJyk24R24q4a
         gaGVXVDbKF+7AAdt1IPgiktoYty+zwfkbmAsiGDEskLi7lLKCE9Zm7VP3yZCdtDXHxNU
         F2FA==
X-Gm-Message-State: APjAAAUdej3HetBpnRaz42imWZxXBn7LBpP0T7S7rklYXWffgtIvkvOb
        h1DGzhEbue3nXP8FhRXdw1FBHiHOQjRbnPikGiE=
X-Google-Smtp-Source: APXvYqyznCQjAejJGQyUMTiTnBung9lMO1/L3p896yj6PoSLgSFibyAZeOlUUZ0rSGDMIboCKjKbZnJNqx76W4BHskg=
X-Received: by 2002:a2e:8015:: with SMTP id j21mr8689791ljg.172.1576821857009;
 Thu, 19 Dec 2019 22:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20191219151928.ad4ccf732b64b7f8a26116db@gmail.com> <20191220031357.GA39061@google.com>
In-Reply-To: <20191220031357.GA39061@google.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Fri, 20 Dec 2019 07:04:05 +0100
Message-ID: <CAMJBoFPrPuPpcfNCKGF0EkSZ+0R7Un6HuoQhBPsznjVTUkVBSQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] Allow ZRAM to use any zpool-compatible backend
To:     Minchan Kim <minchan@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        "Theodore Ts'o" <tytso@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 4:14 AM Minchan Kim <minchan@kernel.org> wrote:

<snip>
> Look https://lkml.org/lkml/2019/10/29/1169
>
> z3fold read is 15% faster *only* when when compression ratio is bad below 50%
> since zsmalloc involves copy operation if the object is located in the
> boundary of discrete pages. It's never popular workload.
> Even, once write is involved(write-only, mixed read-write), z3fold is always
> slow. Think about that swap-in could cause swap out in the field because devices
> are usually under memory pressure. Also, look at the memory usage.
> zsmalloc saves bigger memory for all of compression ratios.

Yes I remember that. Since your measurements were done on "an x86" without
providing any detail on the actual platform used, they are as good as none.

~Vitaly
