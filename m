Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61BCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C0E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rrMjuW4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfC0OMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:12:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39849 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfC0OMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:12:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id t124so214286wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBQBY1Ay37YlRdu285Es/X+k+RnwhHCN8rBYW4Km494=;
        b=rrMjuW4yUpbQAe+2nqc92ctxI3YKkQ0hN+1T6pLx1J01uLIlBuNnUGX+hA7Z7hoZxE
         na6ugH38vgXjkkitafON8TJ+tDpF8cm9rFCJpS4rW24cDx3Zndj+GBFeJsIxJLUuqC4L
         4WbpUbjdqfJfBKet06DvLBMaCiOK4PdGwJPH2En5ou4aM4RE4HgXhrWZunXW/QnOci/t
         M3M8eBwGbjgjsxCc1G1aVLWEjaIQDejC7ZiTQA2RBsPzOuvggYwy3veyrLJwljk3STX2
         3fKtS0yaMtSMHJLkoKvV8w0tQKThrHWmYrVGi4st5ISLPRBwRkG7IbxFN83GhWytYpha
         2+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBQBY1Ay37YlRdu285Es/X+k+RnwhHCN8rBYW4Km494=;
        b=LLCsu739f67jFCFGPTXDubqo32zP3P4WE2TiuioCLg9CQOX6KNvtVKtd8ugbhplqHD
         wn9KOMzmY14v56sHmR+dI/SmHkWECf707ksh9eeT6WkAYbv7JYGrTmr2NQTsZFSh1rxs
         9ddW4QpVuJ3os7SUzGE/S82c8IfR5+XpkqGGf4NM+OOi6YxIcOv9YGvYv3eWOAGN9Gd+
         eU2WqRYmkcmOAYXNv0mirneFQkC3XicmGizU9uMlgsKVrXm4wjzOzvSZfkE/B35N3yDn
         EXlpl759qrBvTJXaY1qNtcp+6YKZQ+37SVTEkpXAqxYswv0cPsz+u5zf4DBrNNK93r4k
         L8OA==
X-Gm-Message-State: APjAAAWnLR/zBa6OUl1jM6h2Q7e8ZzCyKTe7Ll1HGMA0XRCukKoVg6SM
        fswq5tHIUKCYs362KJFfx5Fmw5uxqAo2NgPPgp5BvA==
X-Google-Smtp-Source: APXvYqxKzbrQ4NWQhaz26mpDd5OTb42toUOt/RSqkQXctEL2UMMsvXlDW0NG7Mk4gOYxa+DK5WwU5BOUD2WSejIy0yw=
X-Received: by 2002:a1c:b455:: with SMTP id d82mr13703860wmf.153.1553695935460;
 Wed, 27 Mar 2019 07:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190327100201.32220-1-anup.patel@wdc.com> <7edf91f1-1df5-5513-d372-d84edd12edf3@garyguo.net>
 <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com>
 <74227a1d-3928-3e92-c7a9-5c3e093b29ab@garyguo.net> <CAAhSdy1K6OiZ2nDGcERi7J1z-i6hDC2eWubYDnSqPGCxQKkn5g@mail.gmail.com>
 <4dca2cfe-069f-f458-b1a7-f87aa6718ef7@garyguo.net>
In-Reply-To: <4dca2cfe-069f-f458-b1a7-f87aa6718ef7@garyguo.net>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Mar 2019 19:42:04 +0530
Message-ID: <CAAhSdy220xHbLvGMBawNPETmuLCCXkN7d-73wKXe-0of39+wsw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Implement ASID allocator
To:     Gary Guo <gary@garyguo.net>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 7:39 PM Gary Guo <gary@garyguo.net> wrote:
>
> I think my code already get all the caveats cases covered. The only
> thing my code is missing is handling the case when ASID is not
> supported. Maybe it is better to work based on that instead?

Well, I have also spend enough time hardening this patch so help
me make this patch better.

The hint about 32bit system is useful and I will send v2 soon.

Regards,
Anup
