Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F65C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12E82133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ROLJEM3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfJEKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:12:54 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34105 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfJEKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:12:54 -0400
Received: by mail-ot1-f51.google.com with SMTP id m19so7364846otp.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFOCBrqNZDwM6pl40B9XkMxOq6CUdwnHiKCt7Sl+jQc=;
        b=ROLJEM3IWUFRfBFi581FXDXj/cI+jXWMRiCVo4oqUdNxxyDcxLLHMZLQ0YcpqBrB6u
         KUlHgJr+/f5lTzTwdB2B2JgngdPmmU8a4vA/K6yutWjbzHLcV7Vc5PMWHxCdodpo8Jv1
         WdU0czR3Uor9cydhW3UQOQxZPoa7+BFPyKhginQOEyRH3Tu75z3PlEHARHiVeXETpTvY
         nca3sT/fpRLTXmVacqgb+STlL0W8nX/BebaY6+737GiP+qGw+8aUxG2kQiHr50uQkU/5
         GhY4pBUHQIV285SI4FZASifcEv9R1CvuoH1YVTpad5k3FvkVk+obf7dkXUnaztM4lKJz
         nuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFOCBrqNZDwM6pl40B9XkMxOq6CUdwnHiKCt7Sl+jQc=;
        b=TYSVB2hyRwKYdzBjCHVBLQRZqA+dFtoEk3bAV5kMEY4rOpVl13SGftznr+jABL+VJp
         b8kWa8eCSOfw7ZRGTwvpsUeTn1ZllqDBY7FynjUO/xM92Ummp1dFT6C3fpZtvRTNLSIT
         3Kaka6hYyeQnhL6k7zM2zCPxx75NR2oNtQjK0wmevy69XlIiJruXRFV2j0H3UylOqgB5
         9d5Qofr5PaKD//k4M+gFRnzdAjXoxm6/AQLBSTAJqHhKNarMbqjB7ef8riyh09hx1r3I
         iI/AJiU353cHndDUO5TXl2/q51Lj8XqpyqhmBRrhYRTg4XqG5Mc0GFNnPmbcGt2TToJe
         /vfQ==
X-Gm-Message-State: APjAAAWIXmv9ViEK/Qadr+4y3lfjPz8tHxQshuXBhZLsWkbis2rPbIDq
        uSR5A/E+Od6whS19pkDH1jUlOsfd449KT5pn8DxLxg==
X-Google-Smtp-Source: APXvYqz1VQ4AIEzazmZG0WklBEiTZb1+tjjoI27/iBUhnOoUuzK7HY+CHdNWsvuhnUaqQnmfKGo1mxnKaD4tKpuoNMQ=
X-Received: by 2002:a9d:6e81:: with SMTP id a1mr8653199otr.363.1570270373154;
 Sat, 05 Oct 2019 03:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191003124820.57a0fca8@lwn.net>
In-Reply-To: <20191003124820.57a0fca8@lwn.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 5 Oct 2019 03:12:42 -0700
Message-ID: <CAPcyv4iKhVPd1KoMRLsMdr16F-ziPpMxV-HCFVLOgzY6EFusUg@mail.gmail.com>
Subject: Re: [PATCH] genalloc: Fix a set of docs build warnings
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 11:48 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Commit 795ee30648c7 ("lib/genalloc: introduce chunk owners") made a number
> of changes to the genalloc API and implementation but did not update the
> documentation to match, leading to these docs build warnings:
>
>   ./lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
>   ./lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
>   ./lib/genalloc.c:1: warning: 'gen_pool_free' not found
>   ./lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
>
> Fix these by updating the docs to match new function locations and names,
> and by completing the update of one kerneldoc comment.
>
> Fixes: 795ee30648c7 ("lib/genalloc: introduce chunk owners")
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks Jon. Apologies for the lack of due diligence on my part.
Changes look good to me.

Acked-by: Dan Williams <dan.j.williams@intel.com>
