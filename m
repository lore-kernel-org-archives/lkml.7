Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC67C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EB321530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EBbxJy8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfFUMfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:35:34 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:39003 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfFUMfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:35:34 -0400
X-IronPort-AV: E=Sophos;i="5.62,400,1554760800"; 
   d="scan'208";a="7910699"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 21 Jun 2019 14:35:32 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 21 Jun 2019 14:35:32 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 21 Jun 2019 14:35:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1561120532; x=1592656532;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5tDcdFA7jt8oRJCaRznIaC8jGoQmD68px+5NZuAjsmM=;
  b=EBbxJy8mZJFU6+uPddrVEBEOugyrubakp1oD3LsqOslvl/CZo5fDxZbM
   HatbJuyRnWa79a8POBo8M7Y7dzAhcCWQnDH08/xH2W+MjAA+BGnfeK1XZ
   0bSl4PvF7ZcytPOZtnlHoAOGcHVcejqfDNDMKFm+1Fs1DjBDnAM0JMHik
   B9BUm6qaC0kwTR+kqePvQKHn3pkMUGaZUrpT6X+j6LoEnPp58G7/7uQfl
   +fh10r9sTeU7LQ+qO1hcDDZcaTuFyeEKTF/kDqO0epMtvohnRSLNGgzNd
   umeeOyZ7hT/0SO/D4MtogO0ThrEBIdXZYuqTzUX4oSoMRYiZTgPSCEZQP
   Q==;
X-IronPort-AV: E=Sophos;i="5.62,400,1554760800"; 
   d="scan'208";a="7910698"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Jun 2019 14:35:32 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 957D7280074;
        Fri, 21 Jun 2019 14:35:51 +0200 (CEST)
Message-ID: <c52edcd84b01970113fc046d11c38276d51886e0.camel@ew.tq-group.com>
Subject: Re: [PATCH modules v2 0/2] Fix handling of exit unwinding sections
 (on ARM)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Date:   Fri, 21 Jun 2019 14:35:29 +0200
In-Reply-To: <20190607104912.6252-1-matthias.schiffer@ew.tq-group.com>
References: <20190607104912.6252-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-07 at 12:49 +0200, Matthias Schiffer wrote:
> For some time (050d18d1c651 "ARM: 8650/1: module: handle negative
> R_ARM_PREL31 addends correctly", v4.11+), building a kernel without
> CONFIG_MODULE_UNLOAD would lead to module loads failing on ARM
> systems with
> certain memory layouts, with messages like:
> 
>   imx_sdma: section 16 reloc 0 sym '': relocation 42 out of range
>   (0x7f015260 -> 0xc0f5a5e8)
> 
> (0x7f015260 is in the module load area, 0xc0f5a5e8 a regular vmalloc
> address; relocation 42 is R_ARM_PREL31)
> 
> This is caused by relocatiosn in the .ARM.extab.exit.text and
> .ARM.exidx.exit.text sections referencing the .exit.text section. As
> the
> module loader will omit loading .exit.text without
> CONFIG_MODULE_UNLOAD,
> there will be relocations from loaded to unloaded sections; the
> resulting
> huge offsets trigger the sanity checks added in 050d18d1c651.
> 
> IA64 might be affected by a similar issue - sections with names like
> .IA_64.unwind.exit.text and .IA_64.unwind_info.exit.text appear in
> the ld
> script - but I don't know much about that arch.
> 
> Also, I'm not sure if this is stable-worthy - just enabling
> CONFIG_MODULE_UNLOAD should be a viable workaround on affected
> kernels.
> 
> v2: Use __weak function as suggested by Jessica

Hi Russell,

this patch series is still waiting for your thoughts - in reponse to
v1, Jessica already offered to take it through her tree if you give
your Acked-by.

Thanks,

Matthias


> 
> 
> Matthias Schiffer (2):
>   module: allow arch overrides for .exit section names
>   ARM: module: recognize unwind exit sections
> 
>  arch/arm/kernel/module.c     | 7 +++++++
>  include/linux/moduleloader.h | 5 +++++
>  kernel/module.c              | 7 ++++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 

