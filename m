Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84FFCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43B621872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rgd5N1hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbfJWSUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:20:47 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42242 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732916AbfJWSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:20:47 -0400
Received: by mail-il1-f194.google.com with SMTP id o16so11758438ilq.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=cr0Vtx0reZzkDlmdhcZ3EYluM7nHng2kcraV93Vgyr8=;
        b=Rgd5N1hvz98N4/5VEEjWMENv0zY4o15fAXfVUmgXOr5kFwb2L1JpLNz74sJlH0XA8x
         +X/AkcKRO1SXMyEjgnLOVWCTYrKz0HWpMpvCqdceKMS5XsK+3L4gwptudK9AQ60Hdf0S
         2+o4rzJjttjdcn5wqz8LgV8iCH2TpGlmVT1LVfFDyzgkPdd/Qvq/yaSNzVnhsZYPzful
         Xx2UoMpzlFlQeJUHzBUpVkOjsqQ7/bDkYRebDZw01F6cXRoR//2X5S2w+KWN9gh7N5C0
         dcXVc97a2onezO/+e8+f6xibPyK6YKAoANs7QIxhk3hYACxdP3W+FG+O9XYOywPF+vgC
         VYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=cr0Vtx0reZzkDlmdhcZ3EYluM7nHng2kcraV93Vgyr8=;
        b=A6pH/9TeECCBhfu49krLt+0JQOOZUzjm80jyupBCNmx10sO7aoM+WrkTzFq0+7H1zT
         BVQFUHC4ag7UzRuz3lycj5ikARhLzFMvqeJMfBR/fa7nRo9G61q3urSYLw5H6DWZ1Etk
         OMUnYEwoo8v+2VF+ypb1DJ5xH70ZpC/sd7nbci5FnmgItgQQkp8uyHAzyJcKZPWJl3CT
         xn9qHntW1yjeuelJ9rW0ATmDNhlGpIo1tooyEPgwZYDJJUFDq+/RdaBIe7LUlrY/ZLSJ
         x9GwWhRmAqRHpMRpb7Xg5JmA/vqrAdW7v2GCYnpu2qoBak/zQDWSPoSy3JCx2Dj9ywTJ
         u6AA==
X-Gm-Message-State: APjAAAWRv1G2QNTp0Vu1kMFJKxqITC/nEXa1TmCKF6f12Bwzg9iuwXyc
        JeSn4p5WKE4f/kgCGOUaMBp2ag==
X-Google-Smtp-Source: APXvYqw3iYvv5VTYTmNduAhmYFVuDjtYBkkgceBDIdE9o6mjkUsbecydETj/isIWbbDpFLIhTEgJeA==
X-Received: by 2002:a92:9198:: with SMTP id e24mr17314487ill.184.1571854846193;
        Wed, 23 Oct 2019 11:20:46 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id f8sm6989137ioo.27.2019.10.23.11.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 11:20:45 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:20:43 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
In-Reply-To: <678b7a7a82adb389e34f023d282a7935f41e356a.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1910231105170.16536@viisi.sifive.com>
References: <20190925063706.56175-3-anup.patel@wdc.com>  <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>  <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>  <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
  <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com>  <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com> <678b7a7a82adb389e34f023d282a7935f41e356a.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Alistair Francis wrote:

> On Tue, 2019-10-22 at 18:06 -0700, Paul Walmsley wrote:
> > On Tue, 22 Oct 2019, Alistair Francis wrote:
> > 
> > > I think it makese sense for this to go into Linux first.
> > > 
> > > The QEMU patches are going to be accepted, just some nit picking to 
> > > do first :)
> > > 
> > > After that we have to wait for a PR and then a QEMU release until 
> > > most people will see the change in QEMU. In that time Linux 5.4 will 
> > > be released, if this can make it into 5.4 then everyone using 5.4 
> > > will get the new RTC as soon as they upgrade QEMU (QEMU provides the 
> > > device tree). If this has to wait until QEMU has support then it 
> > > won't be supported for users until even later.
> > > 
> > > Users are generally slow to update kernels (buildroot is still using 
> > > 5.1 by default for example) so the sooner changes like this go in 
> > > the better.
> > 
> > The defconfigs are really just for kernel developers.  We expect users 
> > to define their own Kconfigs for their own needs.
> 
> From experience most people use the defconfig, at least as a starting
> point.

We'll definitely add it to the defconfigs, but I think it makes sense to 
do that once the patches hit the QEMU master branch.  (No need to wait for 
a QEMU release.)

That roughly matches what I understand the Linux kernel's approach is to 
adding hardware support: no point in adding hardware support until it 
looks likely that it will actually exist.  Otherwise it just adds churn 
and maintenance burden.

> I was under the impression that everyone was on board with this going
> in. In QEMU land it doesn't make sense to add it if the kernel isn't
> going to, so we need to be on the same page here.

Whatever RTC gets added into QEMU, we'll take defconfig patches for.  I 
don't care which one it is.  Based on the patches that hit the kernel 
lists, it initially looked like the Goldfish RTC was more complicated than 
it needed to be; but it turned out I just didn't look deeply enough.

> From the other discussions it looks like you are happy with this change
> overall right?

Yes


- Paul
