Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0710C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849852075B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="MUlymysR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfDMIOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:14:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39479 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDMIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:14:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so14865945wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wn4/xM7eXxUVxJInAMlGqk/Y3nt07oH+FHDMqGpVAZs=;
        b=MUlymysRm4wgBaNp4BGtjqDOxDRkuiyq3vIjJsDg9NI7vGsv28yqcy196A1I/2XM4g
         bQdyDqqp1FKVQXgYQB3JntfZ9xev47hXWHYZ3S236rpYCjFd12RJ2HgshuoK3AWPmG/F
         zMDixzU7uTPU3nOK1jDwnyvjvenxU2BMydAXbynNJx/WpUTJKAjlfxeapYfSHOffKFmM
         7wa0CSgniqQKLVqL/gOMLezWJuKUZA7yNr1MvpI9/mabhINCtfW1YC9gZGWt7GZb3gXw
         fWNoX7gjaQlUCFJnZPy4Sg3c3Svhgv5pgwLoGwFJCJUgYvMNKc2bxvE2/9+1SLNP05UV
         58HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wn4/xM7eXxUVxJInAMlGqk/Y3nt07oH+FHDMqGpVAZs=;
        b=lWnEfeScsKGWPgDfmkf7v2O4+YDqLFbdaU2W67qnhx16Gec96HVpkH2mD4VNHx/1jF
         cvhTmCgGl1Z7IYpVdqYVvYK8CbBrqEGelBfp/W5lrZ72/bjyEaJBpMqUzQhS8Oh/7Hl0
         i3cUYBrv6Xu/yuU3KfzzjZToBFw4xg+p+jemMpacfdKGCvezMLuOUPiuhGD3QQ/6++vk
         FwW5/jICvk97Ha/9Vbr0VONcMW5I09tlJpy8jjig6R7OlPgEoUkptO07PTfTi+1H8xDU
         8PEok3eksVf0vPZdT42Tgx/rIQaTFAiya2P12oHZ1j72/Q1yCdZedpAzknWhbfskONXV
         XxtA==
X-Gm-Message-State: APjAAAUOFoPIbt5mUk6su9x6jFbOqASQGKXX1tCfNR1dcHUNs0QLdT8N
        HfuvuTp7aQ+mGU50MGdP5AcRtwHMalz3NSqLKaToZQ==
X-Google-Smtp-Source: APXvYqzqckDrnbID+rwPmWPFrsdkd6YiQhJ9EDt7tuwu8rpor3/V0tbRulo6NCKekB1TnqaC5tp/OFqsx7G+JZL8iCo=
X-Received: by 2002:adf:f110:: with SMTP id r16mr685549wro.153.1555143269795;
 Sat, 13 Apr 2019 01:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190413073906.53676-1-anup.patel@wdc.com> <20190413073906.53676-2-anup.patel@wdc.com>
 <20190413075355.GA30428@infradead.org>
In-Reply-To: <20190413075355.GA30428@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 13 Apr 2019 13:44:18 +0530
Message-ID: <CAAhSdy0wmMZxdmeo9bhVFNJy4H+DPg5enw2bKw6hh_AUpy0Z-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] RISC-V: Add separate asm/encoding.h for spec related defines
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 1:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 13, 2019 at 07:39:35AM +0000, Anup Patel wrote:
> > It's better to have all RISC-V spec related defines in one place
> > so this patch adds separate asm/encoding.h for such defines which
> > can be included in assembly as well as C code.
>
> <asm/csr.h> can be included from assembly just fine already.
> and we already do that.  So I don't really see much of a point
> in splitting it.

We would be also having #defines which will help us decode
load/store instructions as well. This will be used for load/store
emulation for MMIO devices in KVM hypervisor.

Consider this patch as preparatory patch for the KVM support
we are working on.

Regards,
Anup
