Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014CC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3EA206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdUJ7h2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfLUSZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:25:56 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:39950 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUSZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:25:55 -0500
Received: by mail-il1-f177.google.com with SMTP id c4so10826637ilo.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 10:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=46sx+Vb67cSSSe/vCV735AD3OJXjZtu7U3ors7QzgjQ=;
        b=mdUJ7h2Tn0S47NStXFoyVoV45psWREV98hV9GMYUeaxgaV+xyXLy3GiYWGVwoqGwCo
         ffsLhVC2AlPsmLPYsNKgzoT2WXiPfPSytRxV4xwaXJPIEIFU2YhV17TsWuOb3R/j2jwJ
         2oRyjlNrQBGC6E+Cs9ZBTXzYKGyCEM3g50JmBWJkYTN3S4fsaM877U6E1A6+fIaaS5Hu
         1BniEHcpzHXav4DtwamT7C1+O8LOWyJu41XaX7rF/Du2iFbef9y/SIGDztefvEQuCG6q
         G5mtAOyWlkatCX+SNH9IPymiEjX6IDYuQ3tQ7CcISXODUo0imImypkMVJ/e418ZH5XXs
         SsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=46sx+Vb67cSSSe/vCV735AD3OJXjZtu7U3ors7QzgjQ=;
        b=IXhDrtwm+pFj6y8UUC61o19ToKaxyDTitf+nFD/J4FiNmsOh5Qxj3Zp9+vtN6aSrjM
         aOVcqP9VNImCD1G+8Bp5y/ULAoX0t/kEIfc66faiePdj2Q0onUAKoAsaN29PWJmbaZ1+
         d9kGbKkZOxnzEAdZafUoWACihRxaLZdJhdHx6WhwGtO0NuA9bPCmexmpeZkezUCVBObo
         p7TFFKWtdR6bIXzHEczqQS9cs6CDC0geSW1ONqulh/N5Ih/LAMk9Sz1duQiDAIHlOHZt
         ugO6JwcbViWMN6es+9quMFAkV8TMIwjrtirrlkd0bAeR1pewPYmUuwE5t+7+aWuhz0l7
         ukMg==
X-Gm-Message-State: APjAAAXbrHvskxypfOULC3g93ILNXgSPOqoDkzVDqZjEZuuyDZyn2IwR
        OLN+AuCZcPX93ljeyhWTXgnBZh1jPLycVnELVgk=
X-Google-Smtp-Source: APXvYqxMlM0pt5KlvJvxtuSrqsEkL9bo1iHcnU+i35tmf71843JWb6fUfBzC1i/Dk4oHBBEIoXFf1yGwBT04hRE2IBw=
X-Received: by 2002:a92:7402:: with SMTP id p2mr17278757ilc.64.1576952754586;
 Sat, 21 Dec 2019 10:25:54 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sat, 21 Dec 2019 10:25:43 -0800
Message-ID: <CAKgT0UeSs_qy8g5QoXpgcw2685+JtJPY+rehggraoGSYPrP1Aw@mail.gmail.com>
Subject: Regression seen when using MADV_FREE vs MADV_DONTNEED
To:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v15 of my patch set which can be found here
(https://lore.kernel.org/lkml/20191205161928.19548.41654.stgit@localhost.localdomain/)
I had introduced an RFC patch that used MADV_FREE in QEMU instead of
MADV_DONTNEED. When testing that I had used a next-20191120 kernel on
the host. When preparing the numbers for my latest version I had
updated the host to next-20191219, and that is where I encountered an
issue where MADV_FREE is significantly slower than MADV_DONTNEED when
used to report the pages from the QEMU to the kernel and then
eventually fault them back into the guest. No regression was seen with
MADV_DONTNEED.

I just wanted to put it out there that it looks like something has
added spinlock overhead as high as 60% for 16 cores using MADV_FREE to
notify the system that a given transparent huge page isn't needed, and
then eventually faulting the memory back in. I'll try to bisect this
as time permits, but just thought I would put this out there in case
somebody has already found something similar and gotten root cause.

Thanks.

- Alex
