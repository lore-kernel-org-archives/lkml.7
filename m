Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A28CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83FE2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fvA+rdpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfLQByh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:54:37 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36165 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfLQByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:54:37 -0500
Received: by mail-io1-f65.google.com with SMTP id a22so9287158ios.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 17:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlnV9qvnMLCTAEFRF8r07x6ujflDHYlwsIYrVCyjVJg=;
        b=fvA+rdpJlAvWZnCSEt72CVd2qcmAk2SL7KECX8NXO2vlF23JzDdDL0yBr7yiIXvOel
         1B1fod8M5+cS0eD29pKgFhqf8nr6M/GgVfjIh23Ns7YMidcs8JvqOXf2rSf9QcX0//05
         i2FJET85F1TIiC5j0sCIDGm/ERoPhyompVAnQWgam5OWDK6Tqxhb3EnyoJ5LwO3DdXgq
         N2BOLCtE3aXLs2tLWjvgJdxcqgCSu7hd1Eur7zdUNc3HsY+ofl7Xxhgeiua58ORAyu1V
         8RWRKtfa6S/mNuCkfSWpOrhnyP7x0r++R6NchhEi0i4b1Og4B6y2MgENDMgm3BTX+R/Z
         JjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlnV9qvnMLCTAEFRF8r07x6ujflDHYlwsIYrVCyjVJg=;
        b=dU+HYClcGuaDdy6kGSiyYh9lmajmhm1nB7Wexfc7OKG0eUbuWR49VGeDppRTj1p04X
         K0vDSJvJlSIz4aUUkte5oHyp845TlzjSp2qg8iK37b4i3f6sYRf1tl8NcH5rZLbybpQO
         t26ROb4S4EbWCW4NuWDOvSagZd1vP9vleZtXOfTxbG+vdce0LYlM8otJvV/edeZ6uXWm
         V39QzRQBIDEeX38OvHqPRmdLQ8VA5Tgg7Vji2Si4sk78wwxdmTheVaB/sDgCXmKbOAB3
         /EvYBm6Swy6KvJVUUCnleWYRMarPiXINCPfzVcYWkjytjoZAWx3UoPZD4NTEzk1hHw0j
         b+PA==
X-Gm-Message-State: APjAAAXWn56luRoRKFew4w7UOaoDyrMcqXnT3NOhpMe96HV72MN0VF4H
        nh4uI4ibDoNTSva/WDtpt9ofdIJWFwdwWthgKzQy+A==
X-Google-Smtp-Source: APXvYqwpxAHjXEyFHWyWPYpZNMiv/knleP1pkVpKJvQ3kGnNs4qYLJFOyTKc5Uor7bFXpY5AKjj+unBC8GWILWYbrw4=
X-Received: by 2002:a5e:da0d:: with SMTP id x13mr1740295ioj.123.1576547676697;
 Mon, 16 Dec 2019 17:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20191217003057.39300-1-olof@lixom.net>
In-Reply-To: <20191217003057.39300-1-olof@lixom.net>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 16 Dec 2019 17:54:25 -0800
Message-ID: <CAOesGMjw5RaPR+s94RAHtMm9jTGBeqcST+=YMKLxrF9xa+c1MA@mail.gmail.com>
Subject: Re: [PATCH] riscv: export __lshrti3
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 4:31 PM Olof Johansson <olof@lixom.net> wrote:
>
> ARM64 exports it already, and recently it started showing up as needed
> with allmodconfig.
>
> To keep things building as expected, let's export on riscv as well.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>
> It'd be nice to see this go in through 5.5-rc, since the breakage showed
> up this merge window. It was triggered by ce5c31db3645 ("lib/ubsan:
> don't serialize UBSAN report"), but I think that was just coincidental.

Nevermind, I built the wrong config when I tested this. Need to pick
up some of the generic helpers also. Posting new patch separately.


-Olof



-Olof
