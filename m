Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C8C00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 05:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE3D2071A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 05:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAEFwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 00:52:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEFwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 00:52:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E6471B255;
        Sun,  5 Jan 2020 05:52:41 +0000 (UTC)
Subject: Re: [PATCH v4 2/8] ARM: Prepare Realtek RTD1195
To:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20191123203759.20708-1-afaerber@suse.de>
 <20191123203759.20708-3-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <bfe6448c-0e06-f0cd-460f-6aabc667f5e2@suse.de>
Date:   Sun, 5 Jan 2020 06:52:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191123203759.20708-3-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.11.19 um 21:37 schrieb Andreas Färber:
> Introduce ARCH_REALTEK Kconfig option also for 32-bit Arm.
> 
> Override the text offset to cope with boot ROM occupying first 0xa800
> bytes and further reservations up to 0xf4000 (compare Device Tree).
> 
> Add a custom machine_desc to enforce memory carveout for I/O registers.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>   v3 -> v4:
>   * Added reservation of boot ROM (James)
>   
>   v2 -> v3:
>   * Fixed r-bus size in .reserve from 0x100000 to 0x70000 (James)
>   
>   v1 -> v2:
>   * Dropped selection of COMMON_CLK (Arnd)
>   * Dropped selection of AMBA, SCU, TWD
>   * Added comment about text offset to distinguish from HTC comment above
>   * Added machine_desc with .reserve to exclude peripheral spaces (Rob)
>   
>   arch/arm/Kconfig                |  2 ++
>   arch/arm/Makefile               |  3 +++
>   arch/arm/mach-realtek/Kconfig   | 11 +++++++++++
>   arch/arm/mach-realtek/Makefile  |  2 ++
>   arch/arm/mach-realtek/rtd1195.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 58 insertions(+)
>   create mode 100644 arch/arm/mach-realtek/Kconfig
>   create mode 100644 arch/arm/mach-realtek/Makefile
>   create mode 100644 arch/arm/mach-realtek/rtd1195.c

This patch was lacking a MAINTAINERS update. Squashing:

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b626563fb3c..b48461736971 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2204,6 +2204,7 @@ M:        Andreas Färber <afaerber@suse.de>
  L:     linux-arm-kernel@lists.infradead.org (moderated for 
non-subscribers)
  L:     linux-realtek-soc@lists.infradead.org (moderated for 
non-subscribers)
  S:     Maintained
+F:     arch/arm/mach-realtek/
  F:     arch/arm64/boot/dts/realtek/
  F:     Documentation/devicetree/bindings/arm/realtek.yaml


Unfortunately this on v5.6/soc branch will conflict with adding an entry 
for the DTs on v5.6/dt branch, so I guess the best way to handle this 
will be a follow-up patch for the v5.6/soc branch (which may trigger 
pattern warnings due to the files getting added on a different branch)?

diff --git a/MAINTAINERS b/MAINTAINERS
index b48461736971..01081bea2488 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2204,6 +2204,7 @@ M:        Andreas Färber <afaerber@suse.de>
  L:     linux-arm-kernel@lists.infradead.org (moderated for 
non-subscribers)
  L:     linux-realtek-soc@lists.infradead.org (moderated for 
non-subscribers)
  S:     Maintained
+F:     arch/arm/boot/dts/rtd*
  F:     arch/arm/mach-realtek/
  F:     arch/arm64/boot/dts/realtek/
  F:     Documentation/devicetree/bindings/arm/realtek.yaml

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
