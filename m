Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30406C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C5520717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLBPUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:20:35 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35829 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLBPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:20:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id k196so16386434oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 07:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZuADHJjdt3e4tzY3ik1VV2f6I5KfdSAWCDV5TgBy8c=;
        b=QZaFAz5trun8AhW599sIA/4YZj/jkHqteeiUbRERw3iaWvYtTk2B6ptlWde5ac3fim
         mwCh6eTCfMSG1iWj+54mm+xOfb7qx0YZJQwN8saMEr0eoTzLrOG219/a8o22QlpHOri0
         R2lgHBLSpS1TMiNFlVPNDAWuf1z12RDeT/ZSVITQ3T4OF+iKe7Dau8hyEDex+wp22EmG
         R7dItILHgT+FxuDOK4U5ADTFfiXaoBAMA05helsTqH3mCnNPGqnPzXL4lFVsiNDhRMP5
         8GofZsXCdZadLrGQGI9cP3nIbo6i8dy6TP2pS9DxDKjm44d0xWK+TWr9+Vw/KI1DWQ7n
         6yKw==
X-Gm-Message-State: APjAAAVy/BKuWihUETO9C4+FGq3g7utFUrk80LlTl35cD5tdU/0GflxR
        BuajlPLBz4gQifZLB6N+eWATlDLFHlb4Nn1dUmQ=
X-Google-Smtp-Source: APXvYqxcJujnpy6eDi+fniufBaWM+dXwkUtuBqcg/errP/gLT+ZjwUJ1hx2NltqHxVQShTGK67k/PLx269WTrKFYnq4=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr8555094oia.102.1575300034214;
 Mon, 02 Dec 2019 07:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20191202133650.11964-1-linux@roeck-us.net>
In-Reply-To: <20191202133650.11964-1-linux@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Dec 2019 16:20:23 +0100
Message-ID: <CAMuHMdUz7gewcFPE=cnVENGdwVp6AZD7U4y1PtwXTAmoGmvGUg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Fix build on systems with STACKTRACE_SUPPORT=n
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 2:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On systems with STACKTRACE_SUPPORT=n, we get:
>
> WARNING: unmet direct dependencies detected for STACKTRACE
>   Depends on [n]: STACKTRACE_SUPPORT
>   Selected by [y]:
>   - STACKDEPOT [=y]
>
> and build errors such as:
>
> m68k-linux-ld: kernel/stacktrace.o: in function `stack_trace_save':
> (.text+0x11c): undefined reference to `save_stack_trace'
>
> Add the missing deendency on STACKTRACE_SUPPORT.
>
> Fixes: 12a280c72868 ("drm/dp_mst: Add topology ref history tracking for debugging")
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Sean Paul <sean@poorly.run>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
