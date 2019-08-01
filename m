Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD862C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8DA20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfHAQ1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:27:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56624 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfHAQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:27:50 -0400
Received: from localhost (unknown [IPv6:2603:3004:624:eb00::2d06])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CB304153EF902;
        Thu,  1 Aug 2019 09:27:48 -0700 (PDT)
Date:   Thu, 01 Aug 2019 12:27:45 -0400 (EDT)
Message-Id: <20190801.122745.9301893283319822.davem@davemloft.net>
To:     avifishman70@gmail.com
Cc:     venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, tmaimon77@gmail.com,
        tali.perry1@gmail.com, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v1 2/2] net: npcm: add NPCM7xx EMC 10/100 Ethernet
 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190801072611.27935-3-avifishman70@gmail.com>
References: <20190801072611.27935-1-avifishman70@gmail.com>
        <20190801072611.27935-3-avifishman70@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 01 Aug 2019 09:27:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <avifishman70@gmail.com>
Date: Thu,  1 Aug 2019 10:26:11 +0300

> +#Eternet 10/100 EMC

"Ethernet"

> +#ifdef CONFIG_NPCM7XX_EMC_ETH_DEBUG
> +#define DEBUG
> +#endif

Please don't control the DEBUG define in this way.

> +#if defined CONFIG_NPCM7XX_EMC_ETH_DEBUG || defined CONFIG_DEBUG_FS
> +#define REG_PRINT(reg_name) {t = scnprintf(next, size, "%-10s = %08X\n", \
> +	#reg_name, readl(ether->reg + (reg_name))); size -= t;	next += t; }
> +#define DUMP_PRINT(f, x...) {t = scnprintf(next, size, f, ## x); size -= t; \
> +	next += t; }

Really, get rid of this custom debugging infrastructure and just use
generic facilities the kernel has for this, as designed.

> +static int npcm7xx_info_dump(char *buf, int count, struct net_device *netdev)
> +{
> +	struct npcm7xx_ether *ether = netdev_priv(netdev);
> +	struct npcm7xx_txbd *txbd;
> +	struct npcm7xx_rxbd *rxbd;
> +	unsigned long flags;
> +	unsigned int i, cur, txd_offset, rxd_offset;
> +	char *next = buf;
> +	unsigned int size = count;
> +	int t;
> +	int is_locked = spin_is_locked(&ether->lock);

Reverse christmas tree (longest to shortest) ordering for local variables
please.

Audit your entire submission for this problem.
