Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D1DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D13C20644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AF1H2hPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfITN3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:29:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46538 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfITN3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:29:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id f21so6133647otl.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1EFKSI2taSOuRAW19A6gM/LOvRhsiSAjxhmMibFXx8=;
        b=AF1H2hPLVVGNc+OiNsqAjyKg8k+pL+BHKPOnn4mgK/uS3ttkHlL+v9rg5rnlbRuzYW
         6GAFAllYHLe4G5GMp+MxPWpyWWpZvDcLb6yq6VydzUIE+r0SyCY13Z0SkkqjPor5odeg
         nE4WRem05gKBGGA/aESGTm9OV2DQufZk18wN6ZD5n5mNeWGSxntxtCtOppZMOVNPotgZ
         Nvbjg/AkYxhuAL7guoueUUHYygUNzmv4uKHDLNgggyvnbdDVczwqeUMRUv0D80/ndspo
         At1eaFi2Ci/Nd4QodoPs9JSqKQ3s3qjiTbKptc3Ur04E7qR5kwGHLS8VB9novgt4gId6
         FB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1EFKSI2taSOuRAW19A6gM/LOvRhsiSAjxhmMibFXx8=;
        b=P0TwqkLjsFNENL7SPOq5xtGjPZ27RluwSUVs9YpHhpod0G5hHZDtlYsQdHU4YBhZdI
         Ga42ufJVSzawt9dNM9TloYuL4P+QiacyPuRQBLvV7PHr8VFluaCrvU+i9w1lByiX5PN3
         +aqDJm8YD498vxvjAJKs/+ukfPIrz/xp45BaQyvbURCI7zZESRaCX00b5n5O0yYjxRMs
         rfuL0Ty/AMWni5oc15wDs7Rop9StPZXyW9j1XSAxwaiX6ZrCygfF2KzVBPkgBnF8NJ0e
         guRVTl9sUSpdo9nxll6ZAj8xFgtgiZG8aomiPuUHPss0ew7oC/cOKwL48ZX681jdjakl
         xWuQ==
X-Gm-Message-State: APjAAAXWxiHUqYr0bmDbFhpnG19yqk12COYcFjtvOjqIRw/wS11mFJbT
        tB2lEyT3zOgFxybotRwFvgrLLcy1lNg8V6881+JF2k95xNw=
X-Google-Smtp-Source: APXvYqyPEEVYGqYC4zvTbO/6W6S45SlzHK0YpaI9OdY6IVv6zKDyKISjMw/3lHYqjdiirbdck92GKcdyAa/1P07TNGc=
X-Received: by 2002:a9d:4e1e:: with SMTP id p30mr11740947otf.224.1568986140111;
 Fri, 20 Sep 2019 06:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <3c0eb4e9-ee21-d07b-ad16-735b7dc06051@bluespec.com>
 <mhng-df6c7aad-d4fd-4c44-96c8-bf63465e0c97@palmer-si-x1c4>
 <20190916223323.07664bc2@why> <alpine.DEB.2.21.9999.1909170525170.30255@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1909170525170.30255@viisi.sifive.com>
From:   David Abdurachmanov <david.abdurachmanov@sifive.com>
Date:   Fri, 20 Sep 2019 16:28:48 +0300
Message-ID: <CAPSAq_y8x7AxU1jA25_9DRtHnup1w6AZTjgj-iQ1F3n-FH3+DA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Marc Zyngier <maz@kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
        Darius Rad <darius@bluespec.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 3:26 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> Just tested this on the SiFive HiFive Unleashed.  Seems to work OK;
> however I did not stress-test it.
>
> Tested-by: Paul Walmsley <paul.walmsley@sifive.com> # HiFive Unleashed
>
>
> - Paul
>
>
> # !cat
> cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>   1:          0          0          0          0  SiFive PLIC   5  10011000.serial
>   3:          0          0          0          0  SiFive PLIC  51  10040000.spi
>   4:       6266          0          0          0  SiFive PLIC   4  10010000.serial
>   5:        102          0          0          0  SiFive PLIC   6  10050000.spi
>   6:         37          0          0          0  SiFive PLIC  53  eth0
> IPI0:      1134      21128       9024     220261  Rescheduling interrupts
> IPI1:        10        143         18          7  Function call interrupts
> IPI2:         0          0          0          0  CPU stop interrupts
> #

I have applied the patch on top of 5.2.9 kernel and tried to stress it
with stress-ng interrupt stressors for 2:30+ hours.

# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  1:          0          0          0          0  SiFive PLIC   5
10011000.serial
  3:          0          0          0          0  SiFive PLIC  51  10040000.spi
  4:      34240          0          0          0  SiFive PLIC   4
10010000.serial
  5:        102          0          0          0  SiFive PLIC   6  10050000.spi
  6:          0          0          0          0  SiFive PLIC  53  eth0
  7:          0          0          0          0  SiFive PLIC  32
microsemi-pcie
IPI0:  32013933   28068736   29345256   23346339  Rescheduling interrupts
IPI1:     78514      78586      63144     100317  Function call interrupts
IPI2:         0          0          0          0  CPU stop interrupts
