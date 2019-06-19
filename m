Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E934C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209D52084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560945079;
	bh=I9GUMrpXQQ4kP+XRlQm8nsuNTpCDLDeTZGuUV6StNpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ztHZHkQKEss+G2NC7nQKizLb15gPd1QfnwPtUd1KtJzpfBC8G0NXj5P3TxFpWE+nk
	 BOXXlA3mQDCWKtgKFabMJRuhKFdNquIMSZlJ7Zj4/5Zj6kWtHo66BpX/n4l6FoSqp9
	 /QRMNLhZB4ka07fSv2QTqkHRLzFGjPq4T9aaC2Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfFSLvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfFSLvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:51:17 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FB321530
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560945076;
        bh=I9GUMrpXQQ4kP+XRlQm8nsuNTpCDLDeTZGuUV6StNpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EmwB9jSneP5zvx+aO02e5ajh7HUMAmZwr7xBYZDziZHiVUbMqpfSn8oGPrp0ASWB1
         sAvfxTB1iTWoia0261g0Sybv0xAczcIdmA2GuWCcWniP/g8jQtbG7aTs0gHCmOwBgQ
         YLpwwQIAR7bV4++qpk+nQNV5GnVE/J+aFsVTa1nU=
Received: by mail-wr1-f51.google.com with SMTP id x4so3045813wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:51:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVJ0hwn89+QR4Mlkk56KObNLgFngH3SDlMI/XxiXNN1Df1c1+qY
        j+aF9muHcImhfXvIb9fcDthx2wRmuhSOQJjFye4=
X-Google-Smtp-Source: APXvYqy+0U1Ub7AMCGJu+3bTvhBYfZ23ab1bs8cRs50+HW9TdRv1m5YTdwBFzYfP6I5ojcMFW3AyuYO4S1RyjAIIWQ0=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr4144332wro.343.1560945074589;
 Wed, 19 Jun 2019 04:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-1-julien.grall@arm.com> <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com> <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
In-Reply-To: <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 Jun 2019 19:51:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
Message-ID: <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, aou@eecs.berkeley.edu,
        gary@garyguo.net, Atish.Patra@wdc.com, hch@infradead.org,
        paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 4:54 PM Julien Grall <julien.grall@arm.com> wrote:
>
>
>
> On 6/19/19 9:07 AM, Guo Ren wrote:
> > Hi Julien,
>
> Hi,
>
> >
> > You forgot CCing C-SKY folks :P
>
> I wasn't aware you could be interested :).
>
> >
> > Move arm asid allocator code in a generic one is a agood idea, I've
> > made a patchset for C-SKY and test is on processing, See:
> > https://lore.kernel.org/linux-csky/1560930553-26502-1-git-send-email-guoren@kernel.org/
> >
> > If you plan to seperate it into generic one, I could co-work with you.
>
> Was the ASID allocator work out of box on C-Sky?
Almost done, but one question:
arm64 remove the code in switch_mm:
  cpumask_clear_cpu(cpu, mm_cpumask(prev));
  cpumask_set_cpu(cpu, mm_cpumask(next));

Why? Although arm64 cache operations could affect all harts with CTC
method of interconnect, I think we should
keep these code for primitive integrity in linux. Because cpu_bitmap
is in mm_struct instead of mm->context.

In current csky's patches I've also removed the codes the same as
arm64, but I'll add it back at next version.

> If so, I can easily move the code in a generic place (maybe lib/asid.c).
I think it's OK.

Best Regards
 Guo Ren
