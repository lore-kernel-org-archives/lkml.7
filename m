Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3BFC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A3120820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZX4fLDuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfIWPYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:24:45 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:48953 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfIWPYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:24:45 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5c870d66;
        Mon, 23 Sep 2019 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=8zzuCZXCZAoOQeNoK08hAiyUbsQ=; b=ZX4fLD
        uRi22sY4dnKAgyHl7/B6qFwTZIwrwe7CX9XizZ2rajREu7C8rcWVcvWuZWbd4Gqu
        k2UGnkyHP1BigoSxifQqHr8GUJkL/L6gMEWUn5NTkNNJ++bytBuggykVxw/P1kkW
        sCkX5JB21L2lGyS4og48LHiVXjo71xvwGgoaJYSmdKZaHA3dqKmP307b0TGxuq2d
        XUbfAU+1OQkyesGPzoHUzTJMadewfCMEFvhWqzL/A0NuOmG7VclEfaLWy9snlOTT
        zj3Ap70oQ8TyWVBV8Qp5hxAxcdA9pLQ3mjDd0hIayrRwWoce/YRcJuPlCKJSRGLd
        lW7RRXsePfYb2bPA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a3da75fb (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 23 Sep 2019 14:39:13 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id s22so12465524otr.6;
        Mon, 23 Sep 2019 08:24:43 -0700 (PDT)
X-Gm-Message-State: APjAAAWuVs6VlfrWTbMlY7xdSlhvHB9/w2TdAIalI+NV49cZNaTXD6VW
        GG5zOW2LQmoMtkIZiBAm3KcVfJfSrxRZ/r6oy/w=
X-Google-Smtp-Source: APXvYqwgWw8Nt90k1KXN8nXE9xGerbP4lvbQ6ih8TbATzS9WfcxGaxFXrFvbPkM1i9qlgkfIMbntPM9wVWziH17rIbw=
X-Received: by 2002:a05:6830:20cd:: with SMTP id z13mr291875otq.243.1569252282678;
 Mon, 23 Sep 2019 08:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190923144612.29668-1-Jason@zx2c4.com> <20190923150600.GA27191@dell5510>
In-Reply-To: <20190923150600.GA27191@dell5510>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 23 Sep 2019 17:24:31 +0200
X-Gmail-Original-Message-ID: <CAHmME9pKWuJ+oKfrKxhrjLCEw1qcWE=sCZSLOGyUMvW+eUS2cw@mail.gmail.com>
Message-ID: <CAHmME9pKWuJ+oKfrKxhrjLCEw1qcWE=sCZSLOGyUMvW+eUS2cw@mail.gmail.com>
Subject: Re: [PATCH] ipv6: Properly check reference count flag before taking reference
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently even with this (certainly correct) patch attached, users
are still experiencing problems. Bug hunting continues, and I'll
report back if I figure something out.
