Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A854C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76AC214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576331815;
	bh=zgc0Zx4RCTZvjHiM32MSkd8oE0eF7nw3E7NruwqwPkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ficu4KzCjXTsaMELLV5GX9gPrA13KdLrs7wpJ5oBbje9bim4HZgL0gm+NQtDNoFQG
	 rtEKtrUrfLT5BPsyb3IsKpvXYs/ufT9FTKiXH5Aomz8pSrVYDT1kqfyRIg0vxKPeG4
	 f+sDuDfX0WQRQIwCEun9szhGyG+aBQpYWJmAa9wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLNN4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 08:56:53 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:35432 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbfLNN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 08:56:53 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ig7uU-0006r7-Vw; Sat, 14 Dec 2019 14:56:43 +0100
Date:   Sat, 14 Dec 2019 13:56:41 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20191214135641.5a817512@why>
In-Reply-To: <b7f3bcea-84ec-f9f6-a3aa-007ae712415f@huawei.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
        <1575642904-58295-2-git-send-email-john.garry@huawei.com>
        <20191207080335.GA6077@ming.t460p>
        <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
        <20191210014335.GA25022@ming.t460p>
        <0ad37515-c22d-6857-65a2-cc28256a8afa@huawei.com>
        <20191212223805.GA24463@ming.t460p>
        <d4b89ecf-7ced-d5d6-fc02-6d4257580465@huawei.com>
        <20191213131822.GA19876@ming.t460p>
        <b7f3bcea-84ec-f9f6-a3aa-007ae712415f@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: john.garry@huawei.com, ming.lei@redhat.com, tglx@linutronix.de, chenxiang66@hisilicon.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 15:43:07 +0000
John Garry <john.garry@huawei.com> wrote:

[...]

> john@ubuntu:~$ ./dump-io-irq-affinity
> kernel version:
> Linux ubuntu 5.5.0-rc1-00003-g7adc5d7ec1ca-dirty #1440 SMP PREEMPT Fri Dec 13 14:53:19 GMT 2019 aarch64 aarch64 aarch64 GNU/Linux
> PCI name is 04:00.0: nvme0n1
> irq 56, cpu list 75, effective list 5
> irq 60, cpu list 24-28, effective list 10

The NUMA selection code definitely gets in the way. And to be honest,
this NUMA thing is only there for the benefit of a terminally broken
implementation (Cavium ThunderX), which we should have never supported
the first place.

Let's rework this and simply use the managed affinity whenever
available instead. It may well be that it will break TX1, but I care
about it just as much as Cavium/Marvell does...

Please give this new patch a shot on your system (my D05 doesn't have
any managed devices):

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/its-balance-mappings&id=1e987d83b8d880d56c9a2d8a86289631da94e55a

Thanks,

	M.

-- 
Jazz is not dead. It just smells funny...
