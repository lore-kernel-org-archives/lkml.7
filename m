Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EC0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662F0205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="VHy58OKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfCYMs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:48:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40797 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbfCYMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:48:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so9943495wri.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmYmF1rE18fG3Rlx04uuJ/vHCzEwQZmoDYft6UmHsgo=;
        b=VHy58OKLgp+OKOD3PlGUO9Dayq94gLzcy46KSCSIgdzQg7RkOwxW4LnU9n4zA7RpTd
         tWzoY8LgsYExSLWq48c+D9+TAxOGi472iHmRb11VBKY+wiRlGJE5E6AHVMKegsAmAdHU
         l9Pi0rwitMHjkYjEZIx9MPvb0cKuQIZrm9GX5rNzkBhiHhd3mfkbXU7RFBOofXg8I3ap
         u4CArOCkneMu7SJ0nKU4phz/tpxZER0KMmcU0p7oIPYrv8UrEbyYVZJFK/NCZZb6eFtP
         hUNnMkxft6hEhwo0qQudhrfkmo84LhW68KSCZaUZHN83PCxu3SLNZoCQm4MT1NnLdFmE
         i5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmYmF1rE18fG3Rlx04uuJ/vHCzEwQZmoDYft6UmHsgo=;
        b=SZqS8T8AAUl+20xYZRf8/xvcUnx0xi57Rkbvo/p95Ilcs6i7x8nEgm/pwSDsWeUdcB
         HW+Qmf3xzELmM8sivtLtK1ZAFxrhoKWlB6SB9YaxHgSR0nJIFpvCTEsJxwaqzEfDxkJU
         h8f/Pb+4FvdTZ2wcJECRTB+FNWDVDIKCUNkAO8sx0jiXs3rYCtwcpCdVX1e8qvmXitI/
         qPXtM09MhUgIJ5xryqOkLwZTArMRCVovhM5yTCKsfCC1E+reTAUN4t8Vew1DR2GTiVEq
         Usff310NgAmF3ituLHR+G8Fkx9obEnu7oRhbpHNF315yA17OMg5kHuytgt95taiBhlWu
         fZzg==
X-Gm-Message-State: APjAAAXZJOPZdPrIyUsVbVJAtWp/1yX7H9NegcDp7zm+DW7l/PMcn4bm
        xFhl9weSGr9DD8b1+L1CMS50zbh/mZv1x4m2FLRrXw==
X-Google-Smtp-Source: APXvYqxg01ImCE822MGGI0rIgz8Ae6A/LRFHbW+pCoCyB5tVDcH0f2I5D7+B3ZtTJMOirALfWs8DYtBEcNedPlkr+yE=
X-Received: by 2002:adf:fe03:: with SMTP id n3mr3360051wrr.59.1553518136709;
 Mon, 25 Mar 2019 05:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190325092234.5451-1-anup.patel@wdc.com> <20190325092234.5451-5-anup.patel@wdc.com>
 <20190325113935.GD27843@infradead.org>
In-Reply-To: <20190325113935.GD27843@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 18:18:45 +0530
Message-ID: <CAAhSdy2dds7pp8=XX+zbKbMoWbgjPxP6r4aMZJeHyqHV2MP4CQ@mail.gmail.com>
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

In case you missed my previous response about why its not just
about a very narrow corner case ......


We trying to addresses following issues in current code:
1. The current setup_vm() maps all possible kernel virtual addresses (128GB
on 64bit system and 1GB on 32bit system). The amount RAM present on
real systems might be much less so we should not have kernel mappings for
non-existent RAM. Of course, we don't know amount of RAM available in
setup_vm() so we have to split page table setup in two parts and do minimal
required mapping in setup_vm().
2. NOMMU kernel requires a swapper_pg_dir with identity mapping (VA == PA)
and without it we get boot-time crash so we cannot skip it for NOMMU case. For
NOMMU, the PAGE_OFFSET will typically be 0x80020000 (or 0x80xxxxxx). This
means swapper_pmd array (which uses -PAGE_OFFSET) will be over-sized
causing compile errors.
3. For both NOMMU with tiny memory and MMU with tiny memory, the current
setup_vm() is not allowing us to place kernel on non-2M (or non-4M) aligned
addressed there by causing memory below kernel to be wasted.
4. For MMU based kernel, the current setup_vm() is hard-wired for fixed 2M
mapping size. It will require more changes if we want to do 1G mappings.

The above issues motivated us to re-write setup_vm().

We are trying to make initial page table setup more flexible and robust so that:
1. We don't have any unwanted mappings pointing to non-existent RAM
2. We can have any value of PAGE_OFFSET for NOMMU case without the
page table arrays becoming oversized
3. We can create mappings of best possible size to get good performance
4. We can boot from any 4K/2M/1G (or just 4K) aligned load address

Also, the end result of all this is a much more readable page table setup code
shared between setup_vm() an setup_vm_final() where the differences are
abstracted via mapping ops.


Regards,
Anup
