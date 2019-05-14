Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A7C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC3D2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dIDbl08z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfENAj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:39:56 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39045 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:39:56 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so2043143itf.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 17:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kMZ5w85F7GQqBXnYMmtQZ+xbVTO8OslBtbOYC6aSOnc=;
        b=dIDbl08zuYEXjpcqx5vKPssywdXTZxvDMCnbtlVVbXHC97okSbaxXNZpoFGB/UovIx
         XoNy7bRb7HHziO9YZaDJxH0NKnSIMjQ+anjVkDM2z+PgnN/HRC9xUdqv81IzsDJKWChr
         K756P8PpDsujRhQqr77vMsEUI1ZULdqJ7QDQnH+geiBWrD64ANnYy9jNOVPAdTi5+ngh
         fadPDEslLEAUiySuMIlfbc8wfrZSVhxEbiE9zKtdsj/ohJZn7u4TFbLScXkiEvyHUqO8
         fDcOd0W2a2UwGMTHMw43d7np5QJOHencef/vU/jqX6rHMgAauiHTMBZaGwlof4Y+TRyX
         Jizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kMZ5w85F7GQqBXnYMmtQZ+xbVTO8OslBtbOYC6aSOnc=;
        b=pqtom9Q9HWCx9fnouly/mE8DnpdaNPzqc+c5Yi1ns7gUzrwiHYDWYeSaL+07kOJlhR
         9lVtGk9MMZN93pgd5Sg0W/Kr5+QtZXUvB1qdllmuL69RbtvjEa7K1uPDOsdWWr4ctVjR
         nO2gWWRNGwGxJXi2xJ0F5TkfRFtCyCUfTw1s9t544JTrc17ou3m3uecI9MyTw6gIHrrw
         8jw/QskafpSe18dk22qe6kr460VGLGmn/nx2n25Z3TaTCPfEPTgNps0hp7rmPbnEB+Bu
         suXvYKAnvqalc7LFbnvS3urZcwZ2BWXtjFJiK35RcGS4bb7stkg25DDA8zldkruLv2GY
         a/xw==
X-Gm-Message-State: APjAAAXB6LO815LlCZtbFce/pHrMsAsU4eM71YofhuTYpPk8PGs77H6p
        RkfThvN+D58Nx+VXHl3lFyuvpg==
X-Google-Smtp-Source: APXvYqx0TpHx62U3H8GkYS/wTRgE90Fw0RHn+5MFL4cRHZ+i1FZufTyt2KrESO10KRzC2lbCsu/ukA==
X-Received: by 2002:a24:2758:: with SMTP id g85mr1604621ita.30.1557794395577;
        Mon, 13 May 2019 17:39:55 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id c11sm494780itj.31.2019.05.13.17.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 17:39:55 -0700 (PDT)
Date:   Mon, 13 May 2019 17:39:54 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "merker@debian.org" <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
In-Reply-To: <a3eb8e32-5344-801e-03ef-98107ed13130@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1905131735450.21198@viisi.sifive.com>
References: <20190501195607.32553-1-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1905131522370.21198@viisi.sifive.com> <a498967c-cdc8-637a-340b-202d216c5360@wdc.com> <alpine.DEB.2.21.9999.1905131704371.21198@viisi.sifive.com>
 <a3eb8e32-5344-801e-03ef-98107ed13130@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019, Atish Patra wrote:

> On 5/13/19 5:09 PM, Paul Walmsley wrote:
> 
> > What are the semantics of those reserved fields?
> 
> +struct riscv_image_header {
> +	u32 code0;
> +	u32 code1;
> +	u64 text_offset;
> +	u64 image_size;
> +	u64 res1;
> +	u64 res2;
> +	u64 res3;
> +	u64 magic;
> +	u32 res4; ---> We can use this for versioning when required
> +	u32 res5; ---> This is reserved for PE/COFF header
> +};

I saw that in your patch.  The problem is that this doesn't describe what 
other software might expect in those fields.  Can anything at all be 
placed in those reserved fields?

> > > Do we need to add it now or add it later when we actually need a version
> > > number. My preference is to add it later based on requirement.
> > 
> > If it isn't added now, how would bootloaders know whether it was there or
> > not?
> > 
> > 
> Here is the corresponding U-Boot Patch
> https://patchwork.ozlabs.org/patch/1096087/
> 
> Currently, boot loader doesn't care about versioning. Since we are updating a
> reserved field, offsets will not change. If a boot loader want to use the
> versioning, it should be patched along with the kernel patch.
> 
> Any other boot loader that doesn't care about the version, it can continue to
> do so without any change.
> 
> My idea is to enable the minimum required fields in this patch and keep
> everything else as reserved so that it can be amended in future as required.

If those fields really are reserved for implementors to do whatever they 
want with them, then that might be a reasonable approach.  That seems 
unlikely, however, since specification authors usually reserve the right 
to use reserved fields for their own purposes in later versions.


- Paul
