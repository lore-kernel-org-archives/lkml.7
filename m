Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E6C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C362821721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eh8pCLow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfJHMMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:12:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44598 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbfJHMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:11:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id u22so16415858qkk.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMN6AE/Wckiy15zsiQVxc8Ha0nqrOTJmAoLEeM+N80A=;
        b=eh8pCLowBh+BgvZfmBoGRvtXPz9zE1aDs0RO30fbYsKrn8CCi0iz7dLb+5ZAUaoxjI
         h8+YdOrv4kFWisVv0+ypSez27VEQps+efiGk7jOMYv3keDR/Y6/soCbxUzNbJXsWmunL
         vpPylf8BdgPE/ZA1QeOokTinVOQWJUymEUANn2Y+dJMoeBbgBazYB8JxeoNrYQwBHkLP
         +Y93UIITl3fYH+rqskwFY4S7s0OHFw4upx8Nhqyxd6tVP1iDJRTOXsPTSYokzso/fTTr
         QdOgkswn28Rv8/n9whT/owI7R/u5774xcNIdbtAtjI/OLjhmtMk6lPra8liDCk+ffMra
         +nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMN6AE/Wckiy15zsiQVxc8Ha0nqrOTJmAoLEeM+N80A=;
        b=pzXJDK32x6NrGLphtLaSR7No0hFrT8xsX9KUEKdivK3esH1GL1mpCUAnnBud5fOt3C
         QxH7B/7g6OHGttFM5mFTPqlpx6xDIGjdZsj2sol8N9bfzoDytqIDr+DLvWkn3G64F/CE
         vLPOHM4w8AhIxK6l/7A9z1RJcqLU2xcUKTQjrzAPa6gxRUoBZjW7xCugXinAcovBsSbc
         9TJ13TQQxnOCNofijcE3kFPUoEKwgWKqUosvnitd9L484JpfKL2mx7HbiU1N0nzg4WSG
         MDqNWIYmLscX2B5BgYcylbAVgKA7dgvhkmuHtP/zZSB+VOmUt+PyxP4UB8prW7azSIOR
         N8Lg==
X-Gm-Message-State: APjAAAUW5heEnc+9irqatV84TUU55R2s5uGWA4JFTFK/tApOSO05P21t
        hrA7FCWf+rrI44BvtO5X356U8fvULr0DXPG2/qKTTQ==
X-Google-Smtp-Source: APXvYqyJTh5B6y0iJNFqTbgDhKIdXD1dXKap90/51GY/1HBwwtMG0+QVGVvei9Jaj15xHEza/1jKSqBJZkqQ4s2WLQ0=
X-Received: by 2002:a37:d84:: with SMTP id 126mr26540903qkn.407.1570536695225;
 Tue, 08 Oct 2019 05:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <1570532528.4686.102.camel@mtksdccf07> <D2B6D82F-AE5F-4A45-AC0C-BE5DA601FDC3@lca.pw>
In-Reply-To: <D2B6D82F-AE5F-4A45-AC0C-BE5DA601FDC3@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Oct 2019 14:11:23 +0200
Message-ID: <CACT4Y+Zbx-2yR-mN5GioaKUgGH1TpTE2D-OgLbR2Dy09ezyGGQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
To:     Qian Cai <cai@lca.pw>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 1:42 PM Qian Cai <cai@lca.pw> wrote:
> > On Oct 8, 2019, at 7:02 AM, Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > I don't know very well in UBSAN, but I try to build ubsan kernel and
> > test a negative number in memset and kmalloc_memmove_invalid_size(), it
> > look like no check.
>
> It sounds like more important to figure out why the UBSAN is not working in this case rather than duplicating functionality elsewhere.

Detecting out-of-bounds accesses is the direct KASAN responsibility.
Even more direct than for KUBSAN. We are not even adding
functionality, it's just a plain bug in KASAN code, it tricks itself
into thinking that access size is 0.
Maybe it's already detected by KUBSAN too?
