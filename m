Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E054AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA9D207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CmICvH8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfDBIZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:25:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41227 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfDBIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:25:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so2339690lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mLqGazU6rN+in+HWOWWGDjbKCiAOq44ih/Rglku8rg=;
        b=CmICvH8ejCwJEBwJDJRgYqm92pZaN/g0gJzWtIDs99mCW65WzIcAkRx/A+Hw/f8Eb9
         eGu8P9t4WYxwJiglXBIUihMv0N0nrW7KbZrh7xVjTgHJ261lKFdcC+zWDILhRmCj58+Z
         /TV6iUUnxUyVtrlBATU5O7vRmPEdK2plsSUxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mLqGazU6rN+in+HWOWWGDjbKCiAOq44ih/Rglku8rg=;
        b=XTTfg06dzJqlELrzBTUhzpOF+lwai9q4ccZmsNv/z36mejzkeYZsYYlFTJ1wCRYyyR
         c+OzuF1bSmVpRZ1MnTQZDAD67Le4TBCVvIhLw0D5H1wsaS4OQDanUBBXvim2PZ/fdc53
         FwYKVfebKh5clH6QmnH4nNNHUR5rMmIuEfuvCT/4ISOLa1eAYHyvNGsq9GBa+quV4MoH
         2NVC/Du5MXc60gGwnWe8KMBPqf1JBK0wXbo/hXRHx8711x1GxhVNELYJZBXFL25Kehj4
         jq1mfXUZD604/EJAbMqQgQuN1YZfl5a8+Ip95Hl40zS9OVirZskJTYO+3t3mNwxrlsBd
         5jAQ==
X-Gm-Message-State: APjAAAVC1DSjlF4pvWgFEwhWMj7xejGRWf9kWaZWkcUZeyCwK4WvhR2x
        CH3z8J04294y7z7PYk3eq9odfv2FmFDhfFQIlWPSNA==
X-Google-Smtp-Source: APXvYqzkXYaFtSVz0r3/YbiSI3rEnLnbNBPwbLaqqDPdL/bqp2Odb2cFHlPB+wPNyZkdSZDrf6+B1sgMlUrF1SiEbbk=
X-Received: by 2002:a2e:8905:: with SMTP id d5mr919358lji.59.1554193508040;
 Tue, 02 Apr 2019 01:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190214175725.60462-1-ray.jui@broadcom.com> <20190214175725.60462-3-ray.jui@broadcom.com>
 <20190327221452.GA15396@kunai> <c67178db-9459-b424-a29a-23bb0e0c5ca9@broadcom.com>
In-Reply-To: <c67178db-9459-b424-a29a-23bb0e0c5ca9@broadcom.com>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Tue, 2 Apr 2019 13:54:56 +0530
Message-ID: <CAHO=5PG=wsYZqa0+BVbvSKgWg9NgDOrDc8J2DoXn4BRRWmDvRg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] i2c: iproc: Add slave mode support
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray/Wolfram,

On Tue, Apr 2, 2019 at 3:03 AM Ray Jui <ray.jui@broadcom.com> wrote:
>
> Hi Wolfram/Rayagonda,
>
> On 3/27/2019 3:14 PM, Wolfram Sang wrote:
> >
> >> +static void bcm_iproc_i2c_slave_init(
> >> +    struct bcm_iproc_i2c_dev *iproc_i2c, bool need_reset)
> >> +{
> >> +    u32 val;
> >> +
> >> +    if (need_reset) {
> >> +            /* put controller in reset */
> >> +            val = readl(iproc_i2c->base + CFG_OFFSET);
> >> +            val |= BIT(CFG_RESET_SHIFT);
> >> +            writel(val, iproc_i2c->base + CFG_OFFSET);
> >> +
> >> +            /* wait 100 usec per spec */
> >> +            udelay(100);
> >> +
> >> +            /* bring controller out of reset */
> >> +            val &= ~(BIT(CFG_RESET_SHIFT));
> >> +            writel(val, iproc_i2c->base + CFG_OFFSET);
> >> +    }
> >> +
> >> +    /* flush TX/RX FIFOs */
> >> +    val = (BIT(S_FIFO_RX_FLUSH_SHIFT) | BIT(S_FIFO_TX_FLUSH_SHIFT));
> >> +    writel(val, iproc_i2c->base + S_FIFO_CTRL_OFFSET);
> >
> > Will flushing FIFOs work when a slave is register while a master
> > transfer is on-going at the same time?
> >
>
> Okay, as you pointed out in a subsequent email, this can't happen.
>
> >> +
> >> +    /* RANDOM SLAVE STRETCH time - 20ms*/
> >
> > What is a "random stretch time"? 20ms sounds like a lot. Also, missing
> > space before comment terminator.
> >
>
> Rayagonda,
>
> Could you please help to comment on the choice of the 20 ms to allow
> clock stretch from the slave? In probably all cases, the slave should
> not need more than 1 ms? 20 ms does seem way too long as Wolfram pointed
> out.

In fact we are programming max slave stretch time  ie 25ms, comment
should be correcting.
Its maximum time for slave to complete read/write operation, if slave
is done with read/write then clock will not be stretched further, it
will be released immediately.
Hence I feel no harm in programming max timeout value.
Also determining correct slave stretch is very subjective and depends
on slave type as well.

Best regards,
Rayagonda

>
> Will fix the missing space before comment terminator.
>
> >> @@ -224,22 +473,25 @@ static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c)
> >>
> >>      /* put controller in reset */
> >>      val = readl(iproc_i2c->base + CFG_OFFSET);
> >> -    val |= 1 << CFG_RESET_SHIFT;
> >> -    val &= ~(1 << CFG_EN_SHIFT);
> >> +    val |= BIT(CFG_RESET_SHIFT);
> >> +    val &= ~(BIT(CFG_EN_SHIFT));
> >>      writel(val, iproc_i2c->base + CFG_OFFSET);
> >>
> >>      /* wait 100 usec per spec */
> >>      udelay(100);
> >>
> >>      /* bring controller out of reset */
> >> -    val &= ~(1 << CFG_RESET_SHIFT);
> >> +    val &= ~(BIT(CFG_RESET_SHIFT));
> >>      writel(val, iproc_i2c->base + CFG_OFFSET);
> >>
> >>      /* flush TX/RX FIFOs and set RX FIFO threshold to zero */
> >> -    val = (1 << M_FIFO_RX_FLUSH_SHIFT) | (1 << M_FIFO_TX_FLUSH_SHIFT);
> >> +    val = (BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT));
> >>      writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> >>      /* disable all interrupts */
> >> -    writel(0, iproc_i2c->base + IE_OFFSET);
> >> +    val = readl(iproc_i2c->base + IE_OFFSET);
> >> +    val &= ~(IE_M_ALL_INTERRUPT_MASK <<
> >> +                    IE_M_ALL_INTERRUPT_SHIFT);
> >> +    writel(val, iproc_i2c->base + IE_OFFSET);
> >
> > This block looks unrelated, but I won't be too strict here...
> >
> >> +    case M_CMD_STATUS_FIFO_UNDERRUN:
> >> +            dev_dbg(iproc_i2c->device, "FIFO under-run\n");
> >> +            return -ENXIO;
> >> +
> >> +    case M_CMD_STATUS_RX_FIFO_FULL:
> >> +            dev_dbg(iproc_i2c->device, "Master Rx FIFO full > 10ms\n");
> >> +            return -ETIMEDOUT;
> >> +
> >
> > ... however, this looks really unrelated to me. This is about master
> > transmission, or?
>
> This should be submitted in a separate commit. Will do that in the next
> iteration of patch series.
>
> >
> > Rest looks OK.
> >
>
> Thanks,
>
> Ray
