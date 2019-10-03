Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEA4C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CAE20700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="DXp0N9M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfJCFaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 01:30:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33112 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfJCFaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:30:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so1451282wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 22:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKOOmFJoWYoEPN+uqtmhf6aauubkx5IFocgXqh0aQII=;
        b=DXp0N9M7YUJCq9IoMUwGmDeleNVsb98z4MSfodW+tVsnEydckKyJ1XMHTsB0rbtdNU
         sP/qSwdvfNgwx9qtCNSaU2CNk6CQgNuJ+a0xYGD9F+ZgzkBZgVULfUCN6nlKnHyMEqiq
         LlChvZ+diAcyvscPqIMfNJX/mYJfiVB56j1kUHWiXk0L34LWrOdxqjuz3zfewRRnLt9Z
         Ci7Fl2OHWikQrTFBx2qnwebIA+UoRSwoKdS1AVRSmDfG8cp/nYoHHiMMiQ5Y0+rooK7N
         4/Fnj/zul2VDdZfUblpZ+zGa19KM1dmWsZVZnMA/YTORlIuq0SQvAamA92VPAkIBHTv/
         HXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKOOmFJoWYoEPN+uqtmhf6aauubkx5IFocgXqh0aQII=;
        b=CUPn5lq/rxQi0Fzx0HKBRHjcqJ45O+gjwP5oI9OCxEMNYkwClFO1X/dtdq8tdslBM+
         AcMw+T65zWDdCX9C59rMS7n6SCijy+mCvC6m/GBa+rWhbHQdzXY0RxcxnFTrue+TVmvw
         VaE6IwyY3b4hOmSVZ3RELERJk58YwtbKymrrG2Gdp3pq9vQu3WK9crUor/9JViTt+p8t
         2dALN3/iGCf3JBG2W4rzjW2PBxbKHMU+ZPLaTGbWKbT6wMFn8Y7n7TK0sqfo0pBY+qL6
         gDSyHybQ7YOl3JF3a7yoDI2ItA9ZV2Gr0Sv6o0JwBvcVfeUyizv3dv7mqkx51NfgPj2N
         VkTQ==
X-Gm-Message-State: APjAAAVfdpt59MCa0XVjRCWruXtFopnkMpqmiPYuune8RQo2b0T50lvd
        W09ZFTcUqoX4KP4DFox5U/xZBSw82tQGXcmV7xCGfw==
X-Google-Smtp-Source: APXvYqyYtSNsSITbR86n+CKf4F746HTQXw8m95TdwzKZpdisLevGSmmfp17GxGe1VP6NycjkRGhyI8T3BFH/Gmk9qzc=
X-Received: by 2002:adf:ef12:: with SMTP id e18mr1611901wro.65.1570080616914;
 Wed, 02 Oct 2019 22:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190927000915.31781-1-atish.patra@wdc.com> <20190927000915.31781-4-atish.patra@wdc.com>
 <20190927222107.GC4700@infradead.org>
In-Reply-To: <20190927222107.GC4700@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 3 Oct 2019 11:00:05 +0530
Message-ID: <CAAhSdy2kAze4bt17kVA3tB4H6qXPMSUroi5ybPcTvFB_=p48oQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: Move SBI related macros under uapi.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 3:51 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Sep 26, 2019 at 05:09:15PM -0700, Atish Patra wrote:
> > All SBI related macros can be reused by KVM RISC-V and userspace tools
> > such as kvmtool, qemu-kvm. SBI calls can also be emulated by userspace
> > if required. Any future vendor extensions can leverage this to emulate
> > the specific extension in userspace instead of kernel.
>
> Just because userspace can use them that doesn't mean they are a
> userspace API.  Please don't do this as this limits how we can ever
> remove previously existing symbols.  Just copy over the current
> version of the file into the other project of your choice instead
> of creating and API we need to maintain.

These defines are indeed part of KVM userspace API because we will
be forwarding SBI calls not handled by KVM RISC-V kernel module to
KVM userspace (QEMU/KVMTOOL). The forwarded SBI call details
are passed to userspace via "struct kvm_run" of KVM_RUN ioctl.

Please refer PATCH17 and PATCH18 of KVM RISC-V v8 series.

Currently, we implement SBI v0.1 for KVM Guest hence we end-up
forwarding CONSOLE_GETCHAR and CONSOLE_PUTCHART to
KVM userspace.

In future we will implement SBI v0.2 for KVM Guest where we will be
forwarding the SBI v0.2 experimental and vendor extension calls
to KVM userspace.

Eventually, we will stop emulating SBI v0.1 for Guest once we have
all required calls in SBI v0.2. At that time, all SBI v0.1 calls will be
always forwarded to KVM userspace.

Regards,
Anup
