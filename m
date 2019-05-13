Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA76C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D961D208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mG/THQWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfEMWbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:31:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44728 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEMWbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:31:18 -0400
Received: by mail-io1-f67.google.com with SMTP id f22so11224200iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZTesufEDxec+5sA8PoolbYSfD3zUTYkwZ95SB2LoCtU=;
        b=mG/THQWen8d9t08ReVXM/a4ba8YySpitPWAsXt/KNMLaALTtLfL2x+XjbBwHg6/dDT
         jnYtVVRVZiYOeoCmL38LjdVXrHpbjVlR2mhfGp2mqAUlpw0/xYDUOhVJtk4U/HWSZQOi
         s7kjzCf7KUV3xOayKwlKeYEMsMakNSWOX5xBAJto1mbmlTvsR0xZZwvojS5J3nkPvsDI
         ZDLU2mAFOFKZNjd0kf8RCrCmHUgxoeC3XRa3ftrzRQot4vTvpKbK/WGUszS8qCEub6XR
         WOJB4DHsMpVUJVqmuCCLG4FrfjPWqgt2mjRii/pYhZrPlSf3bKrUCgEZ75J3ns1zVyD+
         TMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZTesufEDxec+5sA8PoolbYSfD3zUTYkwZ95SB2LoCtU=;
        b=NlXK2At3exAPjc1OBGfLsnpewZTvrrtY1iawssvt1Fry1rLglX1qADuKozyd8IgCHW
         JP9/dQYW1km49gN/LhJP4t+BmT4grThlvivdd1nFE2AZbddyMrPzhXRPwXDyQi+wOSvL
         XG0bNHOVvP2l5jf3AMfiLeH6XP1gEoxruYE9ccJMvVSDkNFtEmSfwC8DYByXzqPMA4CZ
         8VXlGOfTJGaRV6m7IwdMZgS904YFXtR0xGnynSZd0jGk8rQXwLNA65LghBs4S5y1OuOb
         +xCuF+zT8d2UTD0bFNz925uv996ckuII12Q6G4cy5yUjPw368HPiVJTuEzxzAZofpyBK
         8hGw==
X-Gm-Message-State: APjAAAURcnKVBs1qO22rO1lxB3HsUf6vVdb+ZKCUSnLaihaJi0SI15W/
        /PScxO3LGgntSOVUFh1weV1meg==
X-Google-Smtp-Source: APXvYqxNdwk0XZB5PFfMdoQ14j5bk/oLnEmvEFIPFapRf1016EP0cu/TyH5p23c/PgySsZ6D9t5wCg==
X-Received: by 2002:a5d:9948:: with SMTP id v8mr4043411ios.190.1557786677263;
        Mon, 13 May 2019 15:31:17 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id c62sm368695itd.17.2019.05.13.15.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 15:31:16 -0700 (PDT)
Date:   Mon, 13 May 2019 15:31:16 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>, merker@debian.org,
        linux-riscv@lists.infradead.org
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
In-Reply-To: <20190501195607.32553-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1905131522370.21198@viisi.sifive.com>
References: <20190501195607.32553-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2019, Atish Patra wrote:

> Currently, last stage boot loaders such as U-Boot can accept only
> uImage which is an unnecessary additional step in automating boot flows.
> 
> Add a PE/COFF compliant image header that boot loaders can parse and
> directly load kernel flat Image. The existing booting methods will continue
> to work as it is.
> 
> Another goal of this header is to support EFI stub for RISC-V in future.
> EFI specification needs PE/COFF image header in the beginning of the kernel
> image in order to load it as an EFI application. In order to support
> EFI stub, code0 should be replaced with "MZ" magic string and res5(at
> offset 0x3c) should point to the rest of the PE/COFF header (which will
> be added during EFI support).
> 
> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Seems like we're stuck with this basic format for EFI, etc.  Even though 
we may be stuck with it, I think we should take the opportunity to add the 
possibility to extending this header format by adding fields after the 
basic PE/COFF header ends.

In particular, at the very least, I'd suggest adding a u32 after the 
PE/COFF header ends, to represent a "RISC-V header format version number".  
Then if we add more fields that follow the PE/COFF header -- for example, 
to represent the RISC-V instruction set extensions that are required to 
run this binary -- we can just bump that RISC-V-specific version number 
field to indicate to bootloaders that there's more there.

One other observation - if what's here was copied from some other 
architecture, like ARM, please acknowledge the source in the patch 
description.

thanks

- Paul
