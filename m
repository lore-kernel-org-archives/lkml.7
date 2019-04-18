Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C927CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C092183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kBrtG7Dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbfDRMuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:50:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47724 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388375AbfDRMuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:50:19 -0400
Received: from zn.tnic (p200300EC2F112E003868EF36058F9C84.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:3868:ef36:58f:9c84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E21341EC0380;
        Thu, 18 Apr 2019 14:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555591817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HNUlulpvxLgueM5KwBkwZM9kUDW+7A8qOVVjx5GX6Uc=;
        b=kBrtG7DrmDlg8mxIQUX5owKGGclTe/MBIAH9iD2NUhLnfRQd3qUywuC2WSVxNxdiSswvBJ
        wiOxluTdbEuF3tWsjegvWHRIV1vL3uwrPM2YU/U/uJ7TipAiuABJ2L8cSPdjA5YOSfhhaI
        DNJOA+eOM7DIpkSEnXwMo7qCr+VX3N4=
Date:   Thu, 18 Apr 2019 14:50:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        mchehab@kernel.org, james.morse@arm.com, sachin.ghadi@sifive.com
Subject: Re: [PATCH 3/3] edac: sifive: Add EDAC platform driver for SiFive
 SoCs
Message-ID: <20190418125015.GI27160@zn.tnic>
References: <1555328443-30874-1-git-send-email-yash.shah@sifive.com>
 <1555328443-30874-4-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555328443-30874-4-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:10:43PM +0530, Yash Shah wrote:
> This initial ver of EDAC driver supports:
> - ECC event monitoring and reporting through the EDAC framework for SiFive
>   L2 cache controller.
> 
> This driver registers for notifier events from the L2 cache controller
> driver (arch/riscv/mm/sifive_l2_cache.c) for L2 ECC events
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/Kconfig         |   1 +
>  drivers/edac/Kconfig       |   6 +++
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/sifive_edac.c | 121 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 129 insertions(+)
>  create mode 100644 drivers/edac/sifive_edac.c

Please add a MAINTAINERS entry like the other EDAC drivers do so that
you can get CCed on patches/bug reports.

The rest looks ok to me.

I'd still like for James to have a look too, when he gets to it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
