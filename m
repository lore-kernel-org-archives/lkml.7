Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ADDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B254920815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NHU7KZ5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEPOvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:51:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37679 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:51:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so4226727qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MS2skw+KrEHdESEF2xxKoDYDGwqEs5RP/vpZUAIc9w8=;
        b=NHU7KZ5WPgjex7taKMhAcaxSBI0pOFebtIsJGsWl7hh4wR4Jw0JQV+f+8CsLvEZUbF
         NIDFb/pi21lwTr0YsGzwZJQx6OfWVsu0RwJCS6m/LR7guuYqpXcsMJibNxqnnrzwz29B
         RxfDU88NXLj6+eFsvDvW+DZy5jnZAcJtqI1Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MS2skw+KrEHdESEF2xxKoDYDGwqEs5RP/vpZUAIc9w8=;
        b=bumfLoLJ7/Z318cYseuQfUx8WNZ0ZYAXLuVxPkjBx9D/u6m6rnt9siWfNTvEmXdJVU
         nFQyk7QLxJM3DuifO7hzOPzzQ7Re5D8Q2+D8S8nFNnZVdPr+kyQ7XYcK4dCyPU/lnoVN
         ENVVssOLZP6pyc+mIB1YoPFlTEUK40Pk8keHKziAN2Ptl55IhDo5bML0OnlRebBcZxFw
         ld4Zz1Q/W0GSdrxrqXqSnps+3UzCntUsqd0XQBf+6+4MbCBM8P8f2BKIjw4VLLZVDkk/
         j4TK5D/SNf6lHYR5sI2qv16ESMDhh4xphL/Cs73yy2ock/mZYBH+KGY0xNH0MSIVANmU
         VBrg==
X-Gm-Message-State: APjAAAWAhGlyn9YpcsvclIBdpFsPKeRxebmm9WotURxxSAGtycf0Qz4k
        FEtlIYed+QvkJFYUwflP2fG5J89FBiZS+LFeY5AZew==
X-Google-Smtp-Source: APXvYqzVMPGWHrCFhHM2Qm59YhTIVEDyDKb8QkCN50flg0QSHVH1nVxNOjHLPHdaUYliQm5qek/b0gsTg+bhNCIjvIU=
X-Received: by 2002:ac8:1aa4:: with SMTP id x33mr41119563qtj.69.1558018311752;
 Thu, 16 May 2019 07:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102817.188519-1-hsinyi@chromium.org> <20190516102817.188519-2-hsinyi@chromium.org>
 <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
In-Reply-To: <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 16 May 2019 22:51:25 +0800
Message-ID: <CAJMQK-jrJQri3gM=X6JRD6Rk+B5S4939HJTptrQMY64xEWr1qA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: implement update_fdt_pgprot()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:37 PM Rob Herring <robh+dt@kernel.org> wrote:

>
> Why not just map the FDT R/W at the start and change it to RO just
> before calling unflatten_device_tree? Then all the FDT scanning
> functions or any future fixups we need can just assume R/W. That is
> essentially what Stephen suggested. However, there's no need for a
> weak function as it can all be done within the arch code.
>
We need to add a new seed for kexec
