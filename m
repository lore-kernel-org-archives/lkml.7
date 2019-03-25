Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16043C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C0320828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="fkz8R3nF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfCYQRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:17:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33698 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfCYQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:17:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so10900600wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OCmxubdP2nbG77xoMJhNUuIbCr81ZRpBEz8MY/sedY=;
        b=fkz8R3nFiYXZ5FV4x8L6CwBRZiNK8Ot9sdcN3g3MzXMsrPlZd6PcjbRzgnuY8kE1OS
         /hcJIEHKEgY9ZGCE5NpAcJgGfKVo30avcrBhBypPlOzFiCEHFfzYRVFOYN5OLQhQEkap
         d4wvo8GhNDJAqEpGyCgoWgsAnxiNMRFUd9b3icZYilCh7AtAJp/wo2s1nzDABq7nsXkw
         ls/MGbksqpmCHJynL2YuEhTz/cro1i3+X0KW/STI7EKiwi9S5WB/tCM3VpVATZJiDQA/
         DQjDvsn8L9TRXZYE/vQAyer+MrGJ0F5Ybs7kJjqBmZfmrD8Fx4tw2Uu6prviXMZww1sK
         /g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OCmxubdP2nbG77xoMJhNUuIbCr81ZRpBEz8MY/sedY=;
        b=Y0ySQspb4jeuhl3Ko4r5x27gmPSoSNVuqZ+44YuXKmaYZIG59A8DUWV55jlC3Z9xc8
         xHxLv4t/Zp9QN+/sj+O/lo6ZLnqD+RfoqjLok+kTMirD0Hbj1NGAonPaSzFkX4gQ10B8
         ELnZk7RckRrUhIasdbp4D9u6zdu96TgEF2ETyELHQ24MZKN0Ld6I8LelYOLFDzXV/IAG
         cbnpFgcta0j1TKZvjmNrtPcO9I6iuy4RP95nWWolF1RwW6nPDrtBSgxRZLcp5tPgXobj
         56EJCC9jplnNKVtbU0GtsFrxf1FA2SerJa9qH6YQZaJszuaBKtmOAQP9izEcy63Q9VR6
         13kA==
X-Gm-Message-State: APjAAAXd5A8v7aHYwOUlljQXeYZbfAqdDryyeoNJKZxxKYdkOQxnHJHP
        50nFo2kGVvHe1msnO+6MXqAbW9BfLV8UWWJHFhcfNg==
X-Google-Smtp-Source: APXvYqzhEAzIBWMezXF/NqdzgaUTCmVD/3dJHiiLysFJvH4kjjrJP9VcS0tC0D2ucluHcBvt1nHIe+mZawWQxH6PsfI=
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr2653855wrx.187.1553530630082;
 Mon, 25 Mar 2019 09:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190325092234.5451-1-anup.patel@wdc.com> <20190325092234.5451-5-anup.patel@wdc.com>
 <20190325113935.GD27843@infradead.org> <CAAhSdy2dds7pp8=XX+zbKbMoWbgjPxP6r4aMZJeHyqHV2MP4CQ@mail.gmail.com>
 <20190325145919.GB14826@infradead.org>
In-Reply-To: <20190325145919.GB14826@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 21:46:59 +0530
Message-ID: <CAAhSdy2je-_=AHPawbV-8cUR0P7WvqDZ5wNdEmDVQkR-a88Eog@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned address
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 8:29 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 25, 2019 at 06:18:45PM +0530, Anup Patel wrote:
> > We trying to addresses following issues in current code:
> > 1. The current setup_vm() maps all possible kernel virtual addresses (128GB
> > on 64bit system and 1GB on 32bit system). The amount RAM present on
> > real systems might be much less so we should not have kernel mappings for
> > non-existent RAM. Of course, we don't know amount of RAM available in
> > setup_vm() so we have to split page table setup in two parts and do minimal
> > required mapping in setup_vm().
>
> Why do you even care about kernel mappings for non-existant ram.

We care because there will always be some buggy kernel driver/code going
out-of-bound and accessing non-existent RAM. If we by default map all
possible kernel virtual address then behaviour of buggy accesses will be
unpredictable.

Further, I think we should also make .text and .rodata sections of kernel
as read-only. This will protect kernel code and rodata.

Above things add more debugablity to kernel and also help us catch bugs
faster.

>
> > 2. NOMMU kernel requires a swapper_pg_dir with identity mapping (VA == PA)
>
> Bullshit.  nommu per defintion does not have page tables, and thus

Yes, I know but we did see a kernel crash in-absence of kernel page table
with identity mappings.

>
> > 3. For both NOMMU with tiny memory and MMU with tiny memory, the current
> > setup_vm() is not allowing us to place kernel on non-2M (or non-4M) aligned
> > addressed there by causing memory below kernel to be wasted.
>
> As mentioned a few times - nommu per defintion does not have page
> tables, and in my uptodate nommu port none of this code is even compiled
> in.  If someone still compiles that code in some codebase that is just
> a bug that needs to be fixed.
>
> For MMU with tiny memory is is a theoretical case, but I still haven't
> seen a good rationale why we'd care for that case.

Lot of RISC-V systems being built today target resource constraint
use-cases (such as IoT or embedded) where more RAM is more
cost and more power.

It is very useful to have Linux RISC-V run on just few MBs (if possible).

>
> > 4. For MMU based kernel, the current setup_vm() is hard-wired for fixed 2M
> > mapping size. It will require more changes if we want to do 1G mappings.
>
> And why do we care?  Even if we come up with a good reason for 1G
> mappings we'd better find a way to select it at run time and not require
> a gazillion of options to select how to map the kernel.

1G mappings will give better performance compared 2M mappings.

This will be very useful for performance hungry system with lot of RAM.

This patch selects 1G or 2M mapping at runtime based on load address
alignment.

Regards,
Anup
