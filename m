Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866E1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F5F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfDWH4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:56:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41033 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWH4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:56:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id p185so7884105qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 00:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drottAMtYmKU9aIP9QteRVXWvX5mLpwGFqAS5blJq4g=;
        b=ZKg/7A6IQ9EGEFYg/6KulIfwwgdh9/tJWUERAOQITNt3hdKeI1cBpb6bk2dI/Fd1fJ
         USKVRwsjBbb70ympf0d1uBIZq2Gzs5SEtouE2a7R1WBDdhN8bpShhBZoCgQFm5Bmts8B
         tDrdy1rs9PMt9bAtL/aMxdzYbBaQCPCa/q4Qlpkj9vW+0vxEdSR3/AmPzlfbwXEO80Wz
         wKyPXYaqpC26j3952w6BzqvNc57i2TRr6Tdntjao/GB/fJ+dhuh9r/cN6c7EtqoaGYAb
         lYJV1EhRy7phm3vEIDo408yoffLJldFRzvkwMbPdm+vfKMtUxQTRi6HvGKjEMjSaqdlU
         a7Wg==
X-Gm-Message-State: APjAAAUQLlwwBB2J1tDOMPPpiyD24TCbuc2VPXLig86s+vwsaNsh7fqK
        uXHyOjnpmqDMb0KpFh4VzujNbpybWPMR3fiCvTU=
X-Google-Smtp-Source: APXvYqy9z98LNYidD1fMH7e/zi+lT0tkk+rx8KZTXFi1hKAJgNwxluq9e0B5BZl1pZTEGw3PUL0Q7mAZLmL62vpBqmc=
X-Received: by 2002:ae9:ee15:: with SMTP id i21mr17105303qkg.107.1556006167764;
 Tue, 23 Apr 2019 00:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190421114749.20385-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190421114749.20385-1-huangfq.daxian@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Apr 2019 09:55:51 +0200
Message-ID: <CAK8P3a2Xj6ZHw1ENrzhj=e-PWHov_6hEwi51783+fg8n-o3esw@mail.gmail.com>
Subject: Re: [PATCH v2 03/06] misc: genwqe: Fix misuse of %x
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Frank Haverkamp <haver@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 1:48 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> The pointer should be printed with %p or %px rather than
> cast to long long type and printed with %016llx.
> Change %x to %p to print the pointer.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

I would recommend to also use %pad for printing dma_addr_t if you do this.

      Arnd
