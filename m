Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA2C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BF32083B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfGDVCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:02:01 -0400
Received: from ale.deltatee.com ([207.54.116.67]:53414 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfGDVCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:02:00 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hj8rW-0003V8-PO; Thu, 04 Jul 2019 15:01:51 -0600
To:     Max Gurtovoy <maxg@mellanox.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190703230304.22905-1-logang@deltatee.com>
 <20190703230304.22905-2-logang@deltatee.com>
 <786259e6-ffed-8db3-74d0-71ed5a760079@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d79a4c2d-9326-2805-b2a2-ca265ab2a717@deltatee.com>
Date:   Thu, 4 Jul 2019 15:01:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <786259e6-ffed-8db3-74d0-71ed5a760079@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, maxg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 1/2] nvmet: Fix use-after-free bug when a port is
 removed
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-07-04 3:00 p.m., Max Gurtovoy wrote:
> Hi Logan,
> 
> On 7/4/2019 2:03 AM, Logan Gunthorpe wrote:
>> When a port is removed through configfs, any connected controllers
>> are still active and can still send commands. This causes a
>> use-after-free bug which is detected by KASAN for any admin command
>> that dereferences req->port (like in nvmet_execute_identify_ctrl).
>>
>> To fix this, disconnect all active controllers when a subsystem is
>> removed from a port. This ensures there are no active controllers
>> when the port is eventually removed.
> 
> so now we are enforcing controller existence with port configfs, right ?
> sounds reasonable.

Correct.

> Did you run your patches with other transport (RDMA/TCP/FC) ?

Just RDMA and loop. I suppose I could test with TCP but I don't have FC
hardware.

Logan
