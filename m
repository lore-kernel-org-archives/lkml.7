Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3471AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0251F2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuB9zeV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfHMPTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:19:38 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45864 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbfHMPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:19:38 -0400
Received: by mail-ot1-f51.google.com with SMTP id m24so20889187otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOnoMgXqKq1vs4vu/W8CjnF2zZaw37NzLE5+L/kr/6I=;
        b=MuB9zeV+1J3fDJG7l8B1bO1dN9X2BD86LiswQC9q5uVLDqEavCxZAwtBR/VHbYRxts
         LkWVBlc2c4QvUYH0QmDe+kkuB0p9pgxpnBc5LwAi0Z8otemdM3mWZ1/SaA3skSoiMdoU
         I5b+H8wFI4JCAKTKpi0n2R3XLK8OfrtmIa/cuUWCqWVoSPf3vESgsfRgLzEfzur182oF
         7b+BAhWhBCA3uQuvBFmp717DVdMrBrldjC1DM8sxZkM9iKzgSag9D+6RgXJgFvbHbgnb
         XW+RuGLDBvP7yDT6ngTOVLqrZgaN6xFItwjapZp3Q+j7G6KzBCnHFZmJTlNreeiQJQ1D
         R9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOnoMgXqKq1vs4vu/W8CjnF2zZaw37NzLE5+L/kr/6I=;
        b=CSuyJ8GwNlwifzuO2tFiI3P4mBxIr81881O775Yg8uHn92LUUEDRZmrLio/NduXR2v
         kTkkzNVcfLsHZYVu53+XXvXNbTQeSwCO38EfN+PQb1f3g+VKZxCF+kH4/99JNTNuxVk2
         2OLTLQduRkFcEhOHYWABotkM8T3VWRonyvcWmaN3mNNnPlcWT7tNZoQAHXb2hsBEYLLj
         NBDffThE13g744jcwfpThiW2S/SmBE2wMEPdFRYQnKq59Dt2hA1Z/GFp8weCOgjxyXNJ
         vU4QINtPVI2q9IcqoueEt+k71fW8lnlZhnbjxS1GbjOQpScpnUE7ATxrIHQPzI0/cn93
         oEGw==
X-Gm-Message-State: APjAAAU6J6EF+L1E/J6bPOmILIbTTCmHvfsExdA2hWlRuO6ghQuJD71k
        UMprmA/9Z9khf491qtxPr1FMypTmLTrtZEB5JQ==
X-Google-Smtp-Source: APXvYqxv9ykEk/dLEC0deju1RJRlzc6Md7QXRbADTdgBo6/NAYHbLOHiW4/U50/RP2TN9PAbr2xkORrqr7YrHrP8Beg=
X-Received: by 2002:a5d:8997:: with SMTP id m23mr36028965iol.198.1565709577258;
 Tue, 13 Aug 2019 08:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com>
 <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com>
 <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com>
 <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com> <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com>
 <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com>
 <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de>
 <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com> <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com>
 <alpine.DEB.2.21.1908121917460.7324@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908121917460.7324@nanos.tec.linutronix.de>
From:   Woody Suwalski <terraluna977@gmail.com>
Date:   Tue, 13 Aug 2019 11:19:18 -0400
Message-ID: <CAM6Zs0UoHZyBkY9-RLdO-W+u09RZPbzq-A-K01sHyRkfoEiYTA@mail.gmail.com>
Subject: Re: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit guests
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 1:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 12 Aug 2019, Woody Suwalski wrote:
>
> > I have added a timeout counter in __synchronize_hardirq().
> > At the bottom I have converted while(inprogress); to while(inprogress
> > && timeout++ < 100);
> >
> > That is bypassing the suspend lockup problem. On both 32-bit and
> > 64-bit VMs the countdown is triggered by sync of irq9.
>
> So ACPI triggered an interrupt, which got already forwarded to a CPU, but
> it is not handled. That's more than strange.
>
> > Which probably means that there is some issue in ACPI handler and
> > synchronize_hardirq() is stuck on it?
>
> The ACPI handler is not the culprit. This is either an emulation bug or
> something really strange. Can you please use a WARN_ON() if the loop is
> exited via the timeout so we can see in which context this happens?
>
Thomas, Rafael

A. Learning the Wonderfull World of Gmail Web Interface. Maybe w/o top
posting this time....
B. On 5.3-rc4 problem is gone. I guess it is overall good sign.
C. To recreate problem I went back to 5.2.4. The WARN_ON trace shows
(in reverse):
entry_SYSCALL_64_after_hwframe
do_syscall_64
ksys_write
vfs_write
kernfs_fop_write
state_store
pm_suspend.cold.3
suspend_devices_and_enter
dpm_suspend_noirq
suspend_device_irqs
?ktime_get
?synchronize
synchronize_irq
__synchronize_hardirq.cold.9

Comm: systemd-sleep

Would that help?
Thanks, Woody
