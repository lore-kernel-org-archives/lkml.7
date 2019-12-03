Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DEBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A97206E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575388737;
	bh=0WERqZV6Vj6Tny6kL1uWFaFzjd1fwN4u+V1D8uSbG0c=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=p0B0fYH1z3zRbg9F1XcOl+dpOTOTqXGS0gruUqtvnYFdRw3Tb76Fcp/fAJj80kddu
	 yMz2u/TWpBONhiLc0TFKTjZZARE+rORHdd2lgdxKYLXCG49yURX8l0F/Zvw4JqIIk1
	 AWRdVFAGaLymnHiCM7/uLTCh0yf1eyQ73GX+FF5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfLCP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:58:55 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:53916 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbfLCP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:58:52 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1icAZc-00084G-W2; Tue, 03 Dec 2019 16:58:49 +0100
To:     Yao HongBo <yaohongbo@huawei.com>
Subject: Re: ITS restore/save state when HCC =?UTF-8?Q?=3D=3D=20=30?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Dec 2019 15:58:48 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Yangyingliang <yangyingliang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <james.morse@arm.com>
In-Reply-To: <c8649d75-a9b8-4680-c253-3172774ac33d@huawei.com>
References: <fd89d78030914d19939a1fc1c6eb5048@huawei.com>
 <e04e35e0a14f1507ac4a3d56899adcae@www.loen.fr>
 <c8649d75-a9b8-4680-c253-3172774ac33d@huawei.com>
Message-ID: <c03d0b67a814288402b90bcdba600d26@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yaohongbo@huawei.com, guohanjun@huawei.com, yangyingliang@huawei.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org, james.morse@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ James, who wrote most (if not all) of the arm64 hibernate code

On 2019-12-03 02:23, Yao HongBo wrote:
> On 12/2/2019 9:22 PM, Marc Zyngier wrote:
>> Hi Yaohongbo,
>>
>> In the future, please refrain from sending HTML emails, they
>> don't render very well and force me to reformat your email
>> by hand.
>
> Sorry. I'll pay attention to this next time.
>
>> On 2019-12-02 12:52, yaohongbo wrote:
>>> Hi, marc.
>>>
>>> I met a problem with GIC ITS when I try to power off gic logic in
>>> suspend.
>>>
>>> In hisilicon hip08, the value of GIC_TYPER.HCC is zero, so that
>>> ITS_FLAGS_SAVE_SUSPEND_STATE will have no chance to be set to 1.
>>
>> And that's a good thing. HCC indicates that you have collections 
>> that
>> are backed by registers, and not memory. Which means that once the 
>> GIC
>> is powered off, the state is lost.
>>
>>> It goes well for s4, when I simply remove the condition judgement 
>>> in
>>> the code.
>>
>> What is "s4"? Doing so means you are reprogramming the ITS with 
>> mappings
>> that already exist in the tables, and that is UNPRED territory.
>
> Sorry, I didn't describe it clearly.
> S4 means "suspend to disk".
> In s4, The its will reinit and malloc an new its address.

Huh, hibernate... Yeah, this is not expected to work, I'm afraid.

> My expectation is to reprogram the ITS with original mappings. If
> ITS_FLAGS_SAVE_SUSPEND_STATE
> is not set, i'll have no chance to use the original its table 
> mappings.
>
> What should i do if i want to restore its state with hcc == 0?

HCC is the least of the problems, and there are plenty more issues:

- I'm not sure what guarantees that the tables are at the same
   address in the booting kernel and the the resumed kernel.
   That covers all the ITS tables and as well as the RDs'.

- It could well be that restoring the ITS base addresses is enough
   for everything to resume correctly, but this needs some serious
   investigation. Worse case, we will need to replay the whole of
   the ITS programming.

- This is going to interact more or less badly with the normal suspend
   to RAM code...

- The ITS is only the tip of the iceberg. The whole of the SMMU setup
   needs to be replayed, or devices won't resume correctly (I just tried
   on a D05).

Anyway, with the hack below, I've been able to get D05 to resume
up to the point where devices try to do DMA, and then it was dead.
There is definitely some work to be done there...

         M.

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index 4ba31de4a875..a05fc6bac203 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -27,6 +27,7 @@
  #include <linux/of_platform.h>
  #include <linux/percpu.h>
  #include <linux/slab.h>
+#include <linux/suspend.h>
  #include <linux/syscore_ops.h>

  #include <linux/irqchip.h>
@@ -42,6 +43,7 @@
  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
  #define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
+#define ITS_FLAGS_SAVE_HIBERNATE_STATE		(1ULL << 4)

  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
  #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
@@ -3517,8 +3519,16 @@ static int its_save_disable(void)
  	raw_spin_lock(&its_lock);
  	list_for_each_entry(its, &its_nodes, entry) {
  		void __iomem *base;
+		u64 flags;

-		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+		if (system_entering_hibernation())
+			its->flags |= ITS_FLAGS_SAVE_HIBERNATE_STATE;
+
+		flags = its->flags;
+		flags &= (ITS_FLAGS_SAVE_SUSPEND_STATE |
+			  ITS_FLAGS_SAVE_HIBERNATE_STATE);
+
+		if (!flags)
  			continue;

  		base = its->base;
@@ -3559,11 +3569,17 @@ static void its_restore_enable(void)
  	raw_spin_lock(&its_lock);
  	list_for_each_entry(its, &its_nodes, entry) {
  		void __iomem *base;
+		u64 flags;
  		int i;

-		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+		flags = its->flags;
+		flags &= (ITS_FLAGS_SAVE_SUSPEND_STATE |
+			  ITS_FLAGS_SAVE_HIBERNATE_STATE);
+		if (!flags)
  			continue;

+		its->flags &= ~ITS_FLAGS_SAVE_HIBERNATE_STATE;
+
  		base = its->base;

  		/*

-- 
Jazz is not dead. It just smells funny...
