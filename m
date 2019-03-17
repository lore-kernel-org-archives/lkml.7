Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF585C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0972082F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 21:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552857536;
	bh=iQWObzdMd+1G2mscRi6fwTjrskVAsPtEXZDVMOusDiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MGjI7cIl8vmVeSsdRc9zcsjZFwGF3rEzBaTEen4qhxd953JT1QxNksFFKkv7iqrt9
	 wHTa7loVV/Wr/nciyfVI3EAxSI0m0hvL6YBKMjcJPndxStgm2dbh+LCHgFs+wAsde5
	 yBN5EnoJ4JT+0nS46n/TX7+SRDvD21cZJ/R9tvhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfCQVSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 17:18:55 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38494 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfCQVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 17:18:54 -0400
Received: by mail-lf1-f49.google.com with SMTP id a6so7889792lfl.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lShswvubGaKX5BMzNtg5olzzP5MwYelMRVbMqFijlp8=;
        b=BpcjAw8JGf8o735Yrl4XLXeA8pGNqD9kcJ18fPgtqfbcrDZvl9nd6s7Q9cuckI9mFb
         0ZDI6MZzODBJJt/Lk59D4eSWzWqKvMnHx3dpvMbj4kWglY/ygHW4p30oYQiEfAPv9Wtd
         vM+Ho2a768aQJFYfSYovamVx5cISB1/hn5mn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lShswvubGaKX5BMzNtg5olzzP5MwYelMRVbMqFijlp8=;
        b=tuI9RIviDELsU5xbK+UjFf2sdcRSJHu/KgjadYIYj/dWtmLUwK1sKGavzSM249+DM+
         CxYq9iDcx52pPNomnrlz9KhPGMQj4ouiGcN3+kiW19pIXmvI285qgyM5hqX26MXhYru3
         y8HigRmlamndytD5CwbUgU3j0sqLhVFcIIcn4dMqG4xu/aDWWfU+1+7yMHdMmMmc9UXr
         tstPtZdf2HUXnpXuQlTKfH6HyQJEOj/OB9PEsI+Qymw8VkCx+Eiem0vIrncyHctFMD4q
         Nm+KYaG/gnbfEflO8LKKS+PHt0UFd0dnvc6CyoCi8JYEgt2M3WUThcQJMMKwZl7CzCsU
         Wn5w==
X-Gm-Message-State: APjAAAV3d9RtuTnwN6WUdt2tJStTf5uzwVFuHPElMJ/IzMJ8EMDGP2Qr
        jUBTsY+jV5MNz9lpNxnTaM9DsA4u4+M=
X-Google-Smtp-Source: APXvYqwe5chBFVSSYXsfbeOceA2CYWQAbsUOOQ2B6pCeU1D6LDGbOWg3cltcPP6AEr28P5iHSf5PlQ==
X-Received: by 2002:a19:6d01:: with SMTP id i1mr7794686lfc.118.1552857532736;
        Sun, 17 Mar 2019 14:18:52 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n65sm1659238lfn.10.2019.03.17.14.18.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 14:18:51 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id x13so12219017ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 14:18:51 -0700 (PDT)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr8605983lji.135.1552857531301;
 Sun, 17 Mar 2019 14:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190308173154.GC214730@google.com>
In-Reply-To: <20190308173154.GC214730@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Mar 2019 14:18:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
Message-ID: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.1
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 9:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - Report PCIe links that become degraded at run-time (Alexandru Gagniuc)

Gaah. Only now as I'm about to do the rc1 release am I looking at new
runtime warnings, and noticing that this causes

  genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
  pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22

because you can't have a NULL handler for a level-triggered interrupt
(you need something to shut the interrupt off so that it doesn't keep
screaming!).

Happens on both my desktop and my laptop, regular intel CPU and
chipset, nothing odd in either case.

Everything else works, but the new BW notification obviously will
never work this way.

This is not holding up rc1, obviously, but I thought I'd mention it
since I noticed it as part of my "let's see that nothing regressed"
checks..

                    Linus
