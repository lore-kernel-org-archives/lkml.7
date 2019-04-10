Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293ECC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA7C2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="03zhtP3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDJGJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:09:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34489 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfDJGJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:09:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so1394777wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NA0KH+84Yze/o0gKU4OJJ1enqUC1AklFzqfQAGl58rs=;
        b=03zhtP3hjGilRQUkBcV1cNKSgX7z2b5GRHf1ymBh/GZlNqm5s2d+DrUV8UKkVC/gXR
         PaCLH1oZEfRhwXZeeU5YRiGnbI2kZKGoQ4xOERU2HkgDgMVhzc/Mex5eh1cTkXD1hwWn
         h9GL4PYVxzAxC+TeTiWbBEYHNRKPGQySw+fKF+u9vNnN/CUGFa8PaRfvhv+CmvbBO3Jr
         vaBWZaMFKUAAkoXBeaaWGH9C/6uXfV5VhnZNqL11WR+SaZ7MC4xd4kD9ReLRxFgt1FOb
         VmlEywxpHr1XxM7LM6vvCiHwqgwKWaN3JnLU4hCS14Ct/P8hDhepmuKb3mTEi3Q11qVT
         VEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NA0KH+84Yze/o0gKU4OJJ1enqUC1AklFzqfQAGl58rs=;
        b=Yo/IkzcXIoUQawl3S5umH6GsWcBVETN03/ngls0BhfgOxyH9Vo0RP3xnGDRtpqApNF
         MMl4xQiW3Vcu5uTlYyxVhnLv3BOMPMO+zSMDILarZo0qo7Yfp1M1ph+Ui8VQk5nttsfd
         afPumRFeyfksc7xjEiqEvmFkN1a0NrXx6/UEySyI2K0zpPsGewA3kYWTNlJikswmx0N7
         zi+wPi+UZckrdGwBvc4JqiggDaSOgShJIqNrAE2fc1Uv0x/u8mvFO6dvC8/Qfwy+IDYo
         2JTkA8EBN4yK6xXDY56PxiOfDI8+ImWXhH1Tz+49bLMcBkRLxfc9vAe9TV/6ntdDu5eH
         V1OA==
X-Gm-Message-State: APjAAAXcI+d9BtTqwo2QjDUJaHi6wSOnlOnXdtJEkyq6uPdFbkYs9Bok
        YBNhpVnKumHRiHFFRBA8/k0qQpN1RX7ZGmdHOKH/3w==
X-Google-Smtp-Source: APXvYqwGsVM+lp4TTutXtH2uxGhqQuhFdsD+/tvxC3JYLlOvD13BeFR7y/2cQJcno8YdIZdoNpSM/QAGK99XEXzYIIg=
X-Received: by 2002:adf:f110:: with SMTP id r16mr24701189wro.153.1554876555377;
 Tue, 09 Apr 2019 23:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190312220752.128141-2-anup.patel@wdc.com> <mhng-02f905c7-fb28-4997-9769-2cb88c581881@palmer-si-x1c4>
In-Reply-To: <mhng-02f905c7-fb28-4997-9769-2cb88c581881@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 10 Apr 2019 11:39:03 +0530
Message-ID: <CAAhSdy1UZ3VZAa+Gtf0KQUY9Ebwm7p=qAB+Xv7HDAjfUYpFuAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] RISC-V: Add separate defconfig for 32bit systems
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 10:14 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 12 Mar 2019 15:08:12 PDT (-0700), Anup Patel wrote:
> > This patch adds rv32_defconfig for 32bit systems. The only
> > difference between rv32_defconfig and defconfig is that
> > rv32_defconfig has  CONFIG_ARCH_RV32I=y.
>
> Thanks.  I think it makes sense to have this in 5.1 so I'm going to take it
> into the next RC.

Thanks, Palmer.

Can you consider "[PATCH v3] RISC-V: Fix Maximum Physical Memory 2GiB
option for 64bit systems" for 5.1?

Refer, https://patchwork.kernel.org/patch/10886895/

The above patch is also required for 64bit system with more than 128GiB memory
(i.e. server-class system).

We can remove "Maximum Physical Memory 2GiB" option as separate patch.

Regards,
Anup
