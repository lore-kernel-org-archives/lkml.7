Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900FBC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE3A2089E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfEHTa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:30:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51620 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEHTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:30:26 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hOSGm-0003S7-1g
        for linux-kernel@vger.kernel.org; Wed, 08 May 2019 19:30:24 +0000
Received: by mail-pg1-f200.google.com with SMTP id a8so13259369pgq.22
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 12:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cCKA80aIyIzqzmA17kQSPJ30eCGEekyYUlZQPpyEa+Q=;
        b=eClFBmvUP+qP7zyRm+ioUFzdN6BSzhtxcXK4OWCdYhd/WmUUsYJYMUkNaELvA91rtP
         Ofw64WKeGQWJGDlTi8+soOO/CshFhGTzcoKcGjExJOAlZ4feit8auOlsDqXxmnc29d8G
         R31HrwFYzEJ2RTm+Rs50XTnwbRedQL3kWQLFN7w7RQIBVYWFrYJUz2aTPubdKYDhMD2m
         S6IFUmFJTEEKnHVlPYVB2DpxFnmhUJ7FGFnJCiHQy6xAkvwiM9h15uradDSMyasdQhJt
         NxNA817TP0sbxczwjlnPvfz8SdxPKF1b9l8RM/py1rTQGjVynGjnWSscEbtnBlvJ9T0X
         Um/g==
X-Gm-Message-State: APjAAAXP/KnwGFO00dlzWBGdU76BviIVC/LM3ftIeKiWO/AahrbJyaqr
        41Wtfbhh12cRtT9RXGr02py2pRnZOLCdQDtAt5IR/DS3cPSazBjnVcEwyabTUywWKzo3yx/exrN
        VANchxHrh9qvtYL206kcPpo3p2lzosim2euJjwTGJpw==
X-Received: by 2002:a17:902:b092:: with SMTP id p18mr32652963plr.323.1557343822779;
        Wed, 08 May 2019 12:30:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyg7+aZTDLDPgmVT2n/95vy67ghG5QewkjADQCz3WUrlQ4lRrhvdNgQh3JMNa+O6N4fax2lkw==
X-Received: by 2002:a17:902:b092:: with SMTP id p18mr32652935plr.323.1557343822519;
        Wed, 08 May 2019 12:30:22 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id o71sm29925608pfi.174.2019.05.08.12.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:30:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190508191624.GA8365@localhost.localdomain>
Date:   Thu, 9 May 2019 03:30:18 +0800
Cc:     Keith Busch <keith.busch@intel.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Transfer-Encoding: 8bit
Message-Id: <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 03:16, Keith Busch <kbusch@kernel.org> wrote:

> On Thu, May 09, 2019 at 02:59:55AM +0800, Kai-Heng Feng wrote:
>> +static int nvme_do_resume_from_idle(struct pci_dev *pdev)
>> +{
>> +	struct nvme_dev *ndev = pci_get_drvdata(pdev);
>> +	int result;
>> +
>> +	pdev->dev_flags &= ~PCI_DEV_FLAGS_NO_D3;
>> +	ndev->ctrl.suspend_to_idle = false;
>> +
>> +	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>> +	if (result < 0)
>> +		goto out;
>> +
>> +	result = nvme_pci_configure_admin_queue(ndev);
>> +	if (result)
>> +		goto out;
>> +
>> +	result = nvme_alloc_admin_tags(ndev);
>> +	if (result)
>> +		goto out;
>> +
>> +	ndev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
>> +	ndev->ctrl.max_segments = NVME_MAX_SEGS;
>> +	mutex_unlock(&ndev->shutdown_lock);
>
> This lock was never locked.

Yea, will fix this.

>
> But I think these special suspend/resume routines are too similar to the
> existing ones, they should just incorporate this feature if we need to
> do this.

That’s my original direction, but this requires a new bool to  
nvme_dev_disable(), so it becomes
static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool  
suspend_to_idle)

And it starts to get messy.

Kai-Heng
