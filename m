Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D50C28D1A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C8720673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Zf957eeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfFFIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:15:00 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:53222 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfFFIO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:14:57 -0400
X-IronPort-AV: E=Sophos;i="5.60,558,1549926000"; 
   d="scan'208";a="7719743"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Jun 2019 10:14:55 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 06 Jun 2019 10:14:55 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 06 Jun 2019 10:14:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1559808895; x=1591344895;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gidmcEXWd6Fs9Jm1YrLEtSu1pDj6rxSgxAoUC5x632M=;
  b=Zf957eeRwDVqFX58P4ouQ+lHOtr5F0uv+gAZpioj0rzkycSca9xzfIfv
   qHpfpUq+bjV/HpJ1JtvAG8riB7JQql2EBVGc3o4qNXwn3Zs3+NCYhVJ+0
   lPF9us9u+JD5RL1xCY860HkUIa9HI5RxWbYWODoWSez3hJ+nQvTHr8QHa
   HUfoeamWPtbDjHvC7fywDx77ERXMfrnD7q2tEaihI4nWV/IbvUpVJXA9N
   DEBOKU7FnisGp9yUiKV5tOsd9VmEq+bxEz8SDYR5rUUvwELpfVdCpQf1z
   bIRAcKu/byIfTXKZJA1w0pg6YgGTLJL8ZbJwlliIT1GXfhgNlpyrPo9Y8
   w==;
X-IronPort-AV: E=Sophos;i="5.60,558,1549926000"; 
   d="scan'208";a="7719742"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Jun 2019 10:14:55 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 9F20E280074;
        Thu,  6 Jun 2019 10:15:01 +0200 (CEST)
Message-ID: <61f233518ba863f9d5783dd10e468ee5bf22b69a.camel@ew.tq-group.com>
Subject: Re: [PATCH modules 0/2] Fix handling of exit unwinding sections (on
 ARM)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Russell King <linux@armlinux.org.uk>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org
Date:   Thu, 06 Jun 2019 10:14:44 +0200
In-Reply-To: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
References: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-03 at 12:57 +0200, Matthias Schiffer wrote:
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
> 
> Kind regards,
> Matthias


Hi,
any comments on these patches? If not, who is going to take them in
their tree?

Note that I'll be out of office for the next week, and I won't be able
to read my mail during this period.


Kind regards,
Matthias




> 
> 
> Matthias Schiffer (2):
>   module: allow arch overrides for .exit section names
>   ARM: module: recognize unwind exit sections
> 
>  arch/arm/include/asm/module.h | 11 +++++++++++
>  include/linux/moduleloader.h  |  8 ++++++++
>  kernel/module.c               |  2 +-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 

