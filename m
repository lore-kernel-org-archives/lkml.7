Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB41CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158EC21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571991887;
	bh=0yFG+kT6F508T2Hc/wC/YechJ6TeSnjGGYRJK13BwSM=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=xvmHn21U3vkDTtliW71pphED4L6Oci51TsjBlyVXzjdRG9iXTC/JRRqmR2B3uGU8y
	 q74dXwhVOKkuMHKNhKOH+Kz/AEiT/Ec7buOHByROVQUc9SEvYfEKCDzKsSSFTnpLFR
	 4g+o1JQi+/8ii6srkhL+axXUQMn86EPnf4QAtyAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437915AbfJYIYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:24:46 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:55430 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406192AbfJYIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:24:45 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNutf-00012T-1B; Fri, 25 Oct 2019 10:24:35 +0200
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Use the exact ITSList for VMOVP
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Oct 2019 09:24:34 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <wanghaibin.wang@huawei.com>, <jiayanlei@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1571802386-2680-1-git-send-email-yuzenghui@huawei.com>
References: <1571802386-2680-1-git-send-email-yuzenghui@huawei.com>
Message-ID: <0f99f6a4ea567f53d38fb3bc0e6f59e4@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, wanghaibin.wang@huawei.com, jiayanlei@huawei.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-23 04:46, Zenghui Yu wrote:
> On a system without Single VMOVP support (say GITS_TYPER.VMOVP == 0),
> we will map vPEs only on ITSs that will actually control interrupts
> for the given VM.  And when moving a vPE, the VMOVP command will be
> issued only for those ITSs.
>
> But when issuing VMOVPs we seemed fail to present the exact ITSList
> to ITSs who are actually included in the synchronization operation.
> The its_list_map we're currently using includes all ITSs in the 
> system,
> even though some of them don't have the corresponding vPE mapping at 
> all.
>
> Introduce get_its_list() to get the per-VM its_list_map, to indicate
> which ITSs have vPE mappings for the given VM, and use this map as
> the expected ITSList when building VMOVP. This is hopefully a 
> performance
> gain not to do some synchronization with those unsuspecting ITSs.
> And initialize the whole command descriptor to zero at beginning, 
> since
> the seq_num and its_list should be RES0 when GITS_TYPER.VMOVP == 1.
>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

I've applied this as a fix for 5.4. In the future, please cc LKML on 
all
IRQ-related patches (as documented in MAINTAINERS).

         M.
-- 
Jazz is not dead. It just smells funny...
