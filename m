Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE6CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4962343B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUxZ5m5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfHTI0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:26:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:26:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so1827877wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKEgXsaZBb/YCND5t1KYTz/egS4PVDxIgI7teEb3ZVY=;
        b=gUxZ5m5R+J9KkZtmTbJbeoKhALYY0BXOQpA62gdGh7oGOhHrSvK6A4dkiLBrCthxfW
         cLVcP7zFwBZY+oI3GFeT+amQBp0Vmz6FMj8JH4jlBPKcoyzO+lwkHz4uSNt664DmOZ/H
         fxBA4GMSsNTCJlI30ufNmQJ9et6lQHTcLFKZOoOO1NxfpraopNIAchWM92L7cYP+fcay
         PnPO1qKmbVZAxApaqJDO8fObLd5ey2r7tg6c2fwC5W0b9TpGknA1NhVQhTMeIVjZ4v00
         YZWJuWtbfMFfXLgmjYNVFJz5e7SRLu3sDvXOw9MIvp2oAr4Ag+QUABNgp9TYbLJ4qmHf
         iiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKEgXsaZBb/YCND5t1KYTz/egS4PVDxIgI7teEb3ZVY=;
        b=lOp6/59d6FLu47s0X4lnEkZ/oZSivkoBTd6R96LBpRQCQDsaiPqjVVgd2xBiiGIQMU
         15CM1XLwF+B9h+Bjvx/L/OzHkRRC2X7wPPJuJQ7QXp8Ov2aS9WVZIx0EQ1Uq2NxdPVtf
         dmp6qaPjqysEZ8Mq9bIQZJO3h3xSqSZ5n8F3RUuOzrSXWCZEP48jIh8XovZ2HEnjAJqH
         A2vKZhsUsTCDM3JQww3SkV8zfhXh4HH+FtzeN7rLStYLtk8v6p0ruP1MNXVASzTiACEF
         PX4zDLzO8nAobNK2B5GYE5fUW8Es7/8Ty6t40qlWjZtPWFTV5EqxBQumBpwaER3HFcZC
         HmCQ==
X-Gm-Message-State: APjAAAWujNBUykUSp/adiOGAM1kIMteD8eCLewVdDbtvJhbrEZ89tPA4
        xWmx5SKjolpcmboIL+HD8CqR3UgPHwZdFY30w5E=
X-Google-Smtp-Source: APXvYqyJjqjhoNihgnyi7oHEnuV+8LCHW4txggAiWNfWs/GpXlRyY7nincPH3loeNx0KJ9NjXAp/aRjtSrorrzqvtMA=
X-Received: by 2002:a1c:a985:: with SMTP id s127mr24086524wme.163.1566289569347;
 Tue, 20 Aug 2019 01:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 20 Aug 2019 16:25:57 +0800
Message-ID: <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
To:     longli@linuxonhyperv.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 2:14 PM <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> This patch set tries to fix interrupt swamp in NVMe devices.
>
> On large systems with many CPUs, a number of CPUs may share one NVMe hardware
> queue. It may have this situation where several CPUs are issuing I/Os, and
> all the I/Os are returned on the CPU where the hardware queue is bound to.
> This may result in that CPU swamped by interrupts and stay in interrupt mode
> for extended time while other CPUs continue to issue I/O. This can trigger
> Watchdog and RCU timeout, and make the system unresponsive.
>
> This patch set addresses this by enforcing scheduling and throttling I/O when
> CPU is starved in this situation.
>
> Long Li (3):
>   sched: define a function to report the number of context switches on a
>     CPU
>   sched: export idle_cpu()
>   nvme: complete request in work queue on CPU with flooded interrupts
>
>  drivers/nvme/host/core.c | 57 +++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  include/linux/sched.h    |  2 ++
>  kernel/sched/core.c      |  7 +++++
>  4 files changed, 66 insertions(+), 1 deletion(-)

Another simpler solution may be to complete request in threaded interrupt
handler for this case. Meantime allow scheduler to run the interrupt thread
handler on CPUs specified by the irq affinity mask, which was discussed by
the following link:

https://lore.kernel.org/lkml/e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com/

Could you try the above solution and see if the lockup can be avoided?
John Garry
should have workable patch.

Thanks,
Ming Lei
