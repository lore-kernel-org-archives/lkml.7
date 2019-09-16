Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D863DC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C88214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfIPITV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:19:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47068 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfIPITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:19:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id k25so547904oiw.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 01:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFM2Z8obtleKHt1TpwVYG5b3rzbMixss5WksjCYt77U=;
        b=O1QYoajm1d3UHE6Mxj//Q843tF18GdoIZvDY11bJsbF1JrB2lDXPjGGQIanESoCQO2
         GeAdQusDrbxNbhL5ctwh7VXjLUxeHe4sOZBXW+L9V4WfmMyvynrH86K+ol4B3mAJS7lz
         yNHW2/eFkXMogoLjQbYeSnHwmzy8Ss9YutlQhOXuJOzUWN5gk1Lt1sIMLVT+m+ffCH91
         sIAmrpvGZFkozbiwk0EUr1H3wbKaIYxUve5zqNf+ZwofcSeh3MZ2JXZLgbHspmWc8D7i
         tkHwc3UzxfiQ1uRXfcIjoJHcsfftghjRiQHHOuK69fzfXy6Apw1GCjCN7WggqNNN2sdV
         PrsA==
X-Gm-Message-State: APjAAAWKuhssFY+NxsCfOWU3iNNOPPaxLWW733iuqomQHggyPk+wyt64
        CRavGhXa1ILZ4lIoUYsyKThjNuCyZ62ANe2Ur4g5XA==
X-Google-Smtp-Source: APXvYqxmMh8+z21CCANjfRHwBtoQHuioo0RxiCduoaYtRHxitxAQT24o79Bo7XChKiqM/8dzKcfCZ7onhF93J7/e5ks=
X-Received: by 2002:aca:3908:: with SMTP id g8mr4499345oia.54.1568621959476;
 Mon, 16 Sep 2019 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190916065853.12394-1-geert@linux-m68k.org>
In-Reply-To: <20190916065853.12394-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Sep 2019 10:19:08 +0200
Message-ID: <CAMuHMdVO6S_U96O6VYgK3xaDPhsT_X=O9ibGfCqKjBGcFgmyLg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 9:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.3[1] to v5.3-rc8[3], the summaries are:
>   - build errors: +0/-0
>   - build warnings: +50/-50

Just the levelspread noise.
Anyone with an idea to get rid of it (and to prove they're all false-positives)?

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4d856f72c10ecb060868ed10ff1b1453943fc6c8/ (all 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f74c2bb98776e2de508f4d607cd519873065118e/ (all 242 configs)

> 122 warning regressions:

>   + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
