Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3C3C00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8702070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567696178;
	bh=NfBX9KrULy9QnrJyx1vJdGwafFge3XYVRmLdsNYeQxg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ScA96rca59fE5St7jW5lnIGkBIKBg+zbOfuVYFiP0KXtLGxBuDWqmwtbzyZ7xDLQR
	 1eO1829NMN1pp7bRQUv+ciU+zzVBZbFMKCjBj13N07VZUSXivB8biWZuRdVbbeVErn
	 KB1s0CQjCO7h5LpfNmVHQK1G1/9FHn0iRG7iGDbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbfIEPJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:09:37 -0400
Received: from foss.arm.com ([217.140.110.172]:46602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731401AbfIEPJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:09:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFCD81000;
        Thu,  5 Sep 2019 08:09:36 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B4B3F67D;
        Thu,  5 Sep 2019 08:09:35 -0700 (PDT)
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     John Garry <john.garry@huawei.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
 <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
 <ef258ec7-877c-406a-3d88-80ff79b823f2@huawei.com>
 <20190904102537.GV9720@e119886-lin.cambridge.arm.com>
 <8f1c1fe6-c0d4-1805-b119-6a48a4900e6d@kernel.org>
 <84f6756f-79f2-2e46-fe44-9a46be69f99d@huawei.com>
 <651b4d5f-2d86-65dc-1232-580445852752@kernel.org>
 <8ac8e372-15a0-2f95-089c-c189b619ea62@huawei.com>
 <73c22eaa-172e-0fba-7a44-381106dee50d@kernel.org>
 <a73262e6-6ece-4946-896b-2dad5ca28417@huawei.com>
 <a90e6f99-cad3-8eda-dd08-0ab05ed9ca04@kernel.org>
 <ecdb638b-d5d3-efdc-becd-478ce6e6ff96@huawei.com>
 <e3a4a04a-4669-5a03-5115-84c6573b99e9@kernel.org>
 <d48c9e64-2a65-45a5-c61e-b69505531b1e@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <e14e2b68-1d72-46c7-0255-1b3039d089d7@kernel.org>
Date:   Thu, 5 Sep 2019 16:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d48c9e64-2a65-45a5-c61e-b69505531b1e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 15:53, John Garry wrote:

[...[

>> Awesome. Can I take this as a Tested-by?
> 
> Sure, btw, could you please also add:
> 
> Reported-by: Jiaxing Luo <luojiaxing@huawei.com>
> 
> ... as he did initial discovery and analysis on the problem.

Sure. Now pushed to irqchip-next.

Thanks,
	
	M.
-- 
Jazz is not dead, it just smells funny...
