Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F87DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142022077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575904681;
	bh=xBCiKRJvlz07kt4QEU1+dVyc64vZJjcsmGkYjjE13M8=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=C7PSdyWElknbT73FSiUfXqEWglnyf+kyFg2TxHq1sgKZ/8OBz601ClA50ENPcsmA1
	 EURJ3B9OlELvknzBbKgNjA3jgqE5ZLl9Ssg8IbKWaqiGYEYZYQzZe0Usfq8JmYalJ9
	 joKPaCloiAgLVKlLtvV69B4AGvPdZJBY4bpEXVb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLIPR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:17:59 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:53349 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfLIPR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:17:59 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ieKnE-0002Jf-Go; Mon, 09 Dec 2019 16:17:48 +0100
To:     Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Dec 2019 15:17:48 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        <tglx@linutronix.de>, <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
In-Reply-To: <305198e5-f76f-ded4-946b-9cfade18f08c@suse.de>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <305198e5-f76f-ded4-946b-9cfade18f08c@suse.de>
Message-ID: <c06752c858229854b37af3b47779b126@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: hare@suse.de, john.garry@huawei.com, ming.lei@redhat.com, tglx@linutronix.de, chenxiang66@hisilicon.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-09 15:09, Hannes Reinecke wrote:

[slight digression]

> My idea here is slightly different: can't we leverage SMT?
> Most modern CPUs do SMT (I guess even ARM does it nowadays)
> (Yes, I know about spectre and things. We're talking performance here 
> :-)

I only know two of those: Cavium TX2 and ARM Neoverse-E1.
ARM SMT CPUs are the absolute minority (and I can't say I'm 
displeased).

         M,
-- 
Jazz is not dead. It just smells funny...
