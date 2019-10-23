Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232CBCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12D82084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mNuisqxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbfJWGAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:00:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37718 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbfJWGAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:00:48 -0400
Received: by mail-io1-f67.google.com with SMTP id 1so12136502iou.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2TS9P6vv1/KjpwotibIUiV1WTOJaYFrPVFUeByFlL1Q=;
        b=mNuisqxPnrBkatCUeMElaoaTrErkbBygAOl6zWPZOAVkX2Stz0GU1mUC12VlrMoIbW
         vuB6nAAC3k/JQeWJfBTnYtBOOUhZX2mUFquCESHdcxKKbbYvmThayGWeR4D5WTYku5SG
         V6pKuxz6q2+L15NEIGb3U3UbEUsfFcA27BJUW4ntmGeqAx2kKrTzc8al36BVMB9g4OmS
         hbibqpfFJ5I/0cR6dBzDFAfcNaX1aVGgfegFIwikFbid0wmroSYHtAVd17W4M+aPFiBz
         OvDUhUiD/1LX+MjSV3HijvBZRo6c5tD2wTptIJUNY1xBWEMkJL9Ww1tbYqmITjTbotUy
         S/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2TS9P6vv1/KjpwotibIUiV1WTOJaYFrPVFUeByFlL1Q=;
        b=o61wNnxr8SxuBSyI8+9BoGSyq12ILRRkuu+3kPqVDwVSDte+5zdw4/Fy+DllDv/UpH
         liGTWVwhQpno48a2mx3fgkJluEPylj64KlXpgxVKdL/DcivbJbYHeUYZEynoRpBOMEPp
         LF8rTNxI5+BhsBNYwkd9wiH0PKLRpFw1umUHWI0K69K0hUF8d1p0Dc9e46lAYqnm5WRm
         1opEWGYRKGdqGC1h6KKuOI79i4zgi7p6d4ONzACfmA6GAMorlZd2EyClj7s2ae6JvduP
         eEmdvM531EvbxrUeT9yPsGeaRHdBUqKnl3o/Hjnn+HmesmWdieAQfE+WOHOcd6n4AIXA
         2Lpg==
X-Gm-Message-State: APjAAAXrctNpkwdIEkq+rT6C0HcO9rJlONEaFMwknu0i1qUCwY1fnuoY
        LrPY4AmkqDciV3/zaEliGIMaWQ==
X-Google-Smtp-Source: APXvYqwfDpE3nzzIjN1bK137BVcWtvN3np6xWr9wrQ/QFTSUe2FjyxmNtM+oS3OpO+ELEkCW66YfHg==
X-Received: by 2002:a02:a157:: with SMTP id m23mr3994445jah.135.1571810447594;
        Tue, 22 Oct 2019 23:00:47 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b11sm7664661ilr.87.2019.10.22.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 23:00:46 -0700 (PDT)
Date:   Tue, 22 Oct 2019 23:00:44 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
In-Reply-To: <CAAhSdy3KccuzC0pV6Jy_diLwkdgb=SdHBQnsSoGrgpu6g7TCQA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910222250490.5600@viisi.sifive.com>
References: <20190925063706.56175-3-anup.patel@wdc.com> <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4> <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com> <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
 <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com> <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com> <CAAhSdy3KccuzC0pV6Jy_diLwkdgb=SdHBQnsSoGrgpu6g7TCQA@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Anup Patel wrote:

> On Wed, Oct 23, 2019 at 6:37 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> > Incidentally, just looking at drivers/platform/goldfish, that driver seems
> > to be some sort of Google-specific RPC driver.  Are you all really sure
> 
> Nopes, it's not RPC driver.  In fact, all Goldfish virtual platform
> devices are MMIO devices.

Is drivers/platform/goldfish/goldfish_pipe.c required for the Goldfish RTC 
driver or not?

If not, then the first patch that was sent isn't the right fix.  It would 
be better to remove the Kbuild dependency between the code in 
drivers/platform/goldfish and the Goldfish RTC.

If it is required, then surely there must be a simpler RTC implementation 
available.

> The problem is VirtIO spec does not define any RTC device so instead of
> inventing our own virtual RTC device we re-use RTC device defined in
> Goldfish virtual platform for QEMU virt machine. This way we can re-use
> the Linux Goldfish RTC driver.

With 160+ RTC drivers in the kernel tree already, we certainly agree that 
it doesn't make sense to invent a new RTC.


- Paul
