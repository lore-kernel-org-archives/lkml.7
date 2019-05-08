Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7744BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EA621019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfEHTAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:00:06 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40689 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfEHTAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:00:06 -0400
Received: by mail-it1-f196.google.com with SMTP id g71so5674197ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 12:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xFf9uuAjtBL9IH9yaswsFff4UsAX0yv8nQW3HavZOd0=;
        b=P96IPVq7a+MzxzE6zhmUbfGS9F4NHE58wjnePj+tjakHQwISmw+gMoiR82a711Ya37
         POtASZNuaDC6KyGpSokGHaYNwdwLJIFb3iQIAnViXDEoE7zvKUFTJpJ2S3fiyCgkLxKH
         +oavXVtKl+P9bm/K8YcPTAg9bGn2GLUHvMgBdpAAM04K+IFPAhG3X7WAQWOVGPjuGxhj
         /L6Nx+FdR9lfr4gOeKmZRijdEXRlza2d2TYOuvPfQXxm2BYISZzfhGRJmpuPiiiPZg/Q
         3PSlvX8pplZ90RcbOl8F93tmffEqEXzeLZda8nnDk+O1buofetwqpuuMQcI8ERMYfW6z
         cRrg==
X-Gm-Message-State: APjAAAWGulrqEgw+qZJpG9aYwcw4njedYBClnWExSh8IuG1MZM1Az5+P
        AN3D+9ATETMtLeHEexL9n8MzSA==
X-Google-Smtp-Source: APXvYqw6OgdbT39YQKJ9xLRkJPqn9ZlqEwws+dWhkTy0exKzhj9IaRuEi42/6M1yafHGW//gpVp7CA==
X-Received: by 2002:a24:2c8a:: with SMTP id i132mr4594039iti.130.1557342005215;
        Wed, 08 May 2019 12:00:05 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id r22sm841996ioh.54.2019.05.08.12.00.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 12:00:04 -0700 (PDT)
Date:   Wed, 8 May 2019 13:00:00 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@chromium.org, hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, rrangel@chromium.org
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Message-ID: <20190508190000.GA156909@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190503151224.GA3650@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503151224.GA3650@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 09:12:24AM -0600, Raul Rangel wrote:
> On Wed, May 01, 2019 at 11:54:56AM -0600, Raul E Rangel wrote:
> > I am running into a kernel panic. A task gets stuck for more than 120
> > seconds. I keep seeing blkdev_close in the stack trace, so maybe I'm not
> > calling something correctly?
> > 
> > Here is the panic: https://privatebin.net/?8ec48c1547d19975#dq/h189w5jmTlbMKKAwZjUr4bhm7Q2AgvGdRqc5BxAc=
> > 
> > I sometimes see the following:
> > [  547.943974] udevd[144]: seq 2350 '/devices/pci0000:00/0000:00:14.7/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0p1' is taking a long time
> > 
> > I was getting the kernel panic on a 4.14 kernel: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f3dc032faf4d074f20ada437e2d081a28ac699da/drivers/mmc/host
> > So I'm guessing I'm missing an upstream fix.
> > 
> 
> I'll keep trying to track down the hung task I was seeing on 4.14. But I
> don't think that's related to these patches. I might just end up
> backporting the blk-mq patches to our 4.14 branch since I suspect that
> fixes it.

So I tracked down the hung task in 4.14, it's a resource leak.
mmc_cleanup_queue stops the worker thread. If there were any requests in
the queue they would be holding onto a reference of mmc_blk_data. When
mmc_blk_remove_req calls mmc_blk_put, there are still references to md, so
it never calls blk_cleanup_queue, and the requests stay in the queue
forever.

Fortunately Adrian already has a fix for this: https://lore.kernel.org/patchwork/patch/856512/
I think we should cherry-pick 41e3efd07d5a02c80f503e29d755aa1bbb4245de
into v4.14. I've tried it locally and it fixes the kernel panic I was
seeing.

I've also sent out two more patches for v4.14 that need to be applied
with Adrian's patch:
* https://patchwork.kernel.org/patch/10936439/
* https://patchwork.kernel.org/patch/10936441/

As for this patch, are there any comments? I have a test running that is
doing random connect/disconnects, and it's over 6k iterations now.

Thanks,
Raul
