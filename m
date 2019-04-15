Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD7C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F3820874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="e9tZMp82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfDOH3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:29:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36785 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfDOH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:29:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so18918258wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivIVXuZ5JKkuM5ppYwTsuuwYicPT88VzrKEjWRVhs2s=;
        b=e9tZMp825I78uwxh6o9KBmyQB4Ndl0aUXW2SYVr90HonLdnlv8VVuEEP3H9Srj7oxU
         bBTGxgvps20X5brAYRwvDMRIVUq8j8maXtnGrm19+fXQ+USOYVPQFw3n0Ix4TWcSCTGE
         AMuqHwNkT8zXGAyUcKmLQeBVe4PUGGhKHJX2bpZIJTE6WZ6xs9n9jPr93niAXNkiOAi6
         QNWj+2FFWw3M5jKt03p04i3CCdpsz6krAgSmZ0vZYMIulw9PNPkCZtb+HaxMAJRCHcGE
         YEqA5nuCK2ILUxZfbez4P9wZmSWwNVDhzlKAmthQlalPXVTNOQtOs3OQZNf0t3CnTE1N
         CGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivIVXuZ5JKkuM5ppYwTsuuwYicPT88VzrKEjWRVhs2s=;
        b=AKck0qKnrCAlUSxSdJQCb1+uryratr+hXHo5dCPcV/FK4ZrzlGVl5Wsxwbp9/abVlA
         Z+nko0J6rB2rT/OfI7Xgl8VLLffs9RGAfBHdx67KtE/ibcTbRp7VSNmUNUECnZDIIPdE
         pYilv6YDpAdY1NStHE9o4HGUXXajDIRnB1fQ2ghie0SVau9dOuszR924jjriFoN/HiWK
         2K09z72d7wAhdrjpUWkjXYAHRDIh9z7l3f+/xA0g1wTIzewPKUWycVXaKFkTHHt7UWZG
         3xWRkIEO36z/ZRqh9/neOOWj6RdPLYmTyzZHytX96Gyq8DQeDSf/BIen9zChI/z9dVHp
         nnqg==
X-Gm-Message-State: APjAAAUWpHEO2dtZ0bAKlu6q/N2w0QsHVBgNVpPqWJ1E2jnlri3x8DOu
        wgQCYaovl4PnuLZzglFbnTzNPstHToFkMnutl8q5GQ==
X-Google-Smtp-Source: APXvYqzMwM6jim76mVHi8HYN0XBfCBJY4neXemYe2YujsAkXLixF10Rv04VEr5xG6muqTde888krC3tY5phghSWBhSU=
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr19209628wmf.97.1555313382718;
 Mon, 15 Apr 2019 00:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190413153807.116227-1-anup.patel@wdc.com> <20190413153807.116227-2-anup.patel@wdc.com>
 <20190415054949.GA9279@infradead.org>
In-Reply-To: <20190415054949.GA9279@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 15 Apr 2019 12:59:31 +0530
Message-ID: <CAAhSdy36A9-A4YiGuQptzbUL-VVnfJtRU_5jfC+nD4-fq+M8-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] RISC-V: Add separate asm/encoding.h for spec
 related defines
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:19 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 13, 2019 at 03:38:35PM +0000, Anup Patel wrote:
> > It's better to have all RISC-V spec related defines in one place
> > so this patch adds separate asm/encoding.h for such defines which
> > can be included in assembly as well as C code.
>
> As per the discussion of version 1 on Saturday I disagree with this
> move.  There is both a philosophical and a practical reason for that:
>
>  a) in RISC-V CSR access is really nicely split out into a separate
>     number space, just accessed through a few special instructions.
>     It has no overlap with the rest of instruction encoding
>  b) <asm/csr.h> is pulled into just about every file build in the kernel
>     though <asm/irqflags.h>, <asm/switch_to.h> and <asm/thread_info.h>
>
> So even if you want to later add a new <asm/encoding.h> for instruction
> encoding details later, I'd rather prefer to keep CSR access separate
> from it.

Sure, no problem. I will add asm/encoding.h for instructions later.

Regards,
Anup
