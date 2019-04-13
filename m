Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D059C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16592075B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="zsgFh4ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDMIPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:15:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34488 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfDMIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:15:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id r186so2055051wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGAqxRlimZcOm/Xnh2p9ngnwXcLC61Kd6elJxjX23VM=;
        b=zsgFh4iiVEwsELbHacinBUU3Cnmzy1mXBMRvQJPYvIInH4pi4yjZ+WtapkeRGZcYws
         oTVMNZNBiz0c9aRuaHcPOmJ2lToCZGL8GD3dHk2IdY1hB5DUa6qqk+j8ajt/dc7p0wqP
         k2/0FTtqFuak7qUrPpcJcrb/r9jJSyvpLOqxd4UJD/Sb/YxaKJNUyN9j4kc6EYgb6pAJ
         0Pq2nuzH3dc+q74dGuq2t/ZnNhAoUb6+q0m3ZmIxxySKhH0N06gP5yznnfaLb3zEDnZc
         7zBKMJAqMbojJDRwVu9TC4CCiy0XeViK6j1F9PyX1u3f8r5WG3rjqXRzR2+X9AiA47BV
         9Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGAqxRlimZcOm/Xnh2p9ngnwXcLC61Kd6elJxjX23VM=;
        b=dxSJOT4FOYULbNbhjeBiYIYu4mbFM6OFtH6fVijYeilxEcfyDIkrsGt91WlXTtj0gi
         QourVOmlw2/8nMGwhU3LKHCrHLvcIIbkb/qMPiLldJIUOy7QdHXDLR7wdcxi+Q6YwYjo
         nETr5KTo+GAMxUJf+IDWiPTraf+3lFxjZEHshHNGPv+6y1i5g5Na7uIvW9QBO56uojp/
         u1FSWeq3qpLoh2I4h+11ck8JwqXIg4/lsvyaIkuNOcCOdLk0h8GDZiM1WwZiUYhyMjvY
         +GgwKGX8+aGuv0NAe3ztO7Z0rvFZOKS9rC6VPl0CcZ/yzwn1uPU6xZ48JEWaqqze12GX
         5PJg==
X-Gm-Message-State: APjAAAU6R5rHeJLtVWY6Gge0dOiWo8lmXAkRpXMuHkEDNwC84sqQ6EUf
        6x4c++5/IOyjwlcuu+y0zD+DQWvBYN9qvPoyc3q+HA==
X-Google-Smtp-Source: APXvYqzxTOptLpLvIZ+s4YBYwiUgW/U2Oo9cQPEaaI40BOJY/WK61fjvQvyk45Z6tkeCofkvMQzRf+3HRccRPa5FUDg=
X-Received: by 2002:a1c:544f:: with SMTP id p15mr13683726wmi.65.1555143318269;
 Sat, 13 Apr 2019 01:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190413073906.53676-1-anup.patel@wdc.com> <20190413073906.53676-4-anup.patel@wdc.com>
 <20190413075548.GC30428@infradead.org>
In-Reply-To: <20190413075548.GC30428@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 13 Apr 2019 13:45:07 +0530
Message-ID: <CAAhSdy2MJVOLQ_nTTf6FvSOPbyaCxL-J-eT2PfGMubptBL+rnw@mail.gmail.com>
Subject: Re: [PATCH 3/3] RISC-V: Access CSRs using CSR numbers
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

On Sat, Apr 13, 2019 at 1:25 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 13, 2019 at 07:39:44AM +0000, Anup Patel wrote:
> > We should prefer accessing CSRs using their CSR numbers because:
> > 1. It compiles fine with older toolchains.
> > 2. We can use latest CSR names in #define macro names of CSR numbers
> >    as-per RISC-V spec.
> > 3. We can access newly added CSRs even if toolchain does not recognize
> >    newly addes CSRs by name.
>
> This looks mostly fine, but also please remove all the comments
> regarding using sptbr instead of satp now that they are not true
> anymore.

Sure, will do.

Regards,
Anup
