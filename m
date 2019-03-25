Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29BB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="G2NeGcEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfCYMmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:42:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38160 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbfCYMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:42:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id a188so8877562wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFzQ7GNWaVAumVgyG+cSi21Ho8TZd42FGY9Arz6Y4yY=;
        b=G2NeGcEmWHclffPMp8dUCG/6loXXv/rvUbFk/uX22GzsqP403bHLIUxlXsgedWXZNa
         6Uke4A3u5L6eGGQxsJ17AhBLXkINWZAqMsZDzT79MdtXk44EAgO/vtt1HmxWqXbHMNkA
         vXI3MMf2cKs3EU/4a19bvD9vmAAaCZJdCp8hh8yf6EW1NupQOnAz/4HskGu29O/OFPRh
         4PiR4lQ8MMejiCsz8PplG8dDnoL+FlDAnpIeziQP70bZ6C6ddF29s2xQlQj4HS1Qf1KR
         PjBICPXdJE4KjzD0QWrrqaPqPFMdLi17WRUNIPnq1CEgduHHAKsfBuk09F9taifS4w0A
         KkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFzQ7GNWaVAumVgyG+cSi21Ho8TZd42FGY9Arz6Y4yY=;
        b=TW7jDp04gXfIeoAD4QMKkHVqNx6rhYe144ujwCJn7P33ILMXTBPobrApXsi4/iSgnc
         bI1fgALowbVBSyq5/S5YCcUZO/UqMsaxtQyfZTMn9OR/BeFUDW6qPek6fQS4wo7SdDkV
         B2lMo3mxTYv6nMxMEer1jae02UTiD/ijkVXM69hXWoV29jassPz0Fmtve/HNw8I8lnTk
         Z8gPMLObo0dgU47CWQGxX3RGC1Jx6bYdxEc6RNOjvgARLeHP8w1wj9YReUyjaYYr8vPW
         6cPMEruUJWkriUskKy3lPwsHOAzrCpy71rffLhQs/L6KtGtMlPQfppujXofxBYBIyBEJ
         8DnA==
X-Gm-Message-State: APjAAAX4kWALCz+UYaBhR5Jxudb6goKDc5OOJ5i8QHzQ41E0p/2kmR46
        zXaV0VKwFe+rTtwzB8GqkoAZsVMgmUpfdThkN5gARA==
X-Google-Smtp-Source: APXvYqy1THQscj2/NI24dCHt73h12xj88wpspCSSBitjdiDq7X5eA/XadjO2SIQabTihz8+MhenEqwJlR43yR9iLwxw=
X-Received: by 2002:a1c:b455:: with SMTP id d82mr5854534wmf.153.1553517760087;
 Mon, 25 Mar 2019 05:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190325092234.5451-1-anup.patel@wdc.com> <20190325092234.5451-5-anup.patel@wdc.com>
 <20190325113935.GD27843@infradead.org>
In-Reply-To: <20190325113935.GD27843@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 18:12:28 +0530
Message-ID: <CAAhSdy3MZFayMDTiEEV7WseUsxgcWT_um=nbPgXUBFik19OYuQ@mail.gmail.com>
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

On Mon, Mar 25, 2019 at 5:09 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> I'm still not sold on this at all.  It is a lot more code, a lot harder
> to read code and all for a very narrow corner case that isn't even
> going to be enabled in default configs.

The old page table setup code does not exist anymore.

It uses new code for 2M mappings as well.

In fact, it will also try to create 1G mappings if possible.

The code is lot better, readable and flexible.

Regards,
Anup
