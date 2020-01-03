Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0B6C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABF92084D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgACBeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:34:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgACBeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:34:44 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2C7D0E5B6DDB8F977E82;
        Fri,  3 Jan 2020 09:34:42 +0800 (CST)
Received: from [127.0.0.1] (10.57.64.164) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 09:34:34 +0800
Subject: Re: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, fengsheng <fengsheng5@huawei.com>,
        kXinwei Kong <kong.kongxinwei@hisilicon.com>
References: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <20191227002239.GH27497@sirena.org.uk>
 <afad8a97-6159-bf7e-466a-fdbaf0a07d4a@hisilicon.com>
 <20200103010409.GG3897@sirena.org.uk>
From:   kongxinwei <kong.kongxinwei@hisilicon.com>
Message-ID: <fca15988-22eb-2ba9-037e-7f7f51221fe4@hisilicon.com>
Date:   Fri, 3 Jan 2020 09:34:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200103010409.GG3897@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.64.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/3 9:04, Mark Brown wrote:
> On Sat, Dec 28, 2019 at 04:31:53PM +0800, kongxinwei wrote:
> 
>>> I'd be much more comfortable here if I understood what this was
>>> supposed to be syncing - what exactly gets flushed here and why
>>> is a memory barrier enough to ensure it's synced?  A comment in
>>> the code would be especially good so anyone modifying the code
>>> understands this in future.
> 
>> Because of out-of-order execution about some CPU architecture,
>> In this debug stage we find Completing spi interrupt enable ->
>> prodrucing TXEI interrupt -> running "interrupt_transfer" function
>> will prior to set "dw->rx and dws->rx_end" data, so it will result
>> in SPI sending error
> 
> Could you update the commit message to say that, and ideally also
> add a comment saying something like "Ensure dw->rx and dw->rx_end
> are visible" please?
> 
OK, i WILL update it.

