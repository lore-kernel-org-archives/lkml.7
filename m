Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6530A21743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560438559;
	bh=Ue3Z7U9hr74Z8GIjZ585RF0eCSwfODtZtHlyBbMZnKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DKYXm1+cFB+BeaZ+iYP/c98kgikXRHySbQkQGwPamWjbo0I8Yhak5pkuSgmFk1URH
	 ySBtcPkQAECpMGBijycTxMw/M/2psSyvhGf7yj/ZkAf79maleG2Wyy7283roqMQfL4
	 OACqMDBpsy+Ms5tqVcyvnegSBmZ2TSWRagIJW2Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbfFMPJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732364AbfFMN61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:58:27 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614EB20673;
        Thu, 13 Jun 2019 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560434306;
        bh=Ue3Z7U9hr74Z8GIjZ585RF0eCSwfODtZtHlyBbMZnKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I11A0m7YsjaGCU0KvbICAk2pDIL3R4p/wm2jSc5Abg2a+vVhGz234KAI2DV/7CXpn
         iyBhVQSfqQQRPqQj8XKdIyzVIyqI0ROflt+OWK9d4EL7FSYt8MStkxNeoIMN4XvYOD
         CZbWAbmLkVfFIEQMLjJLyrNqOom4y0cL/YG6UViU=
Date:   Thu, 13 Jun 2019 08:58:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, arnd@arndb.de,
        linux-pci@vger.kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        wangkefeng.wang@huawei.com, linuxarm@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v4 1/3] lib: logic_pio: Use logical PIO low-level
 accessors for !CONFIG_INDIRECT_PIO
Message-ID: <20190613135825.GG13533@google.com>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560262374-67875-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:12:52PM +0800, John Garry wrote:
Another thought here:

>  	if (addr < MMIO_UPPER_LIMIT) {					\
>  		ret = read##bw(PCI_IOBASE + addr);			\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
> +		struct logic_pio_hwaddr *range = find_io_range(addr);	\
> +		size_t sz = sizeof(type);				\
>  									\
> -		if (entry && entry->ops)				\
> -			ret = entry->ops->in(entry->hostdata,		\
> -					addr, sizeof(type));		\
> +		if (range && range->ops)				\
> +			ret = range->ops->in(range->hostdata, addr, sz);\
>  		else							\
>  			WARN_ON_ONCE(1);				\

Could this be simplified a little by requiring callers to set
range->ops for LOGIC_PIO_INDIRECT ranges *before* calling
logic_pio_register_range()?  E.g.,

  hisi_lpc_probe(...)
  {
    range = devm_kzalloc(...);
    range->flags = LOGIC_PIO_INDIRECT;
    range->ops = &hisi_lpc_ops;
    logic_pio_register_range(range);
    ...

and

  logic_pio_register_range(struct logic_pio_hwaddr *new_range)
  {
    if (new_range->flags == LOGIC_PIO_INDIRECT && !new_range->ops)
      return -EINVAL;
    ...

Then maybe you wouldn't need to check range->ops in the accessors.

Bjorn
