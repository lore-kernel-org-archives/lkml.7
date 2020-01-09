Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67456C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457C220721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbgAITv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:51:26 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43554 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbgAITv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:51:26 -0500
X-Greylist: delayed 1685 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 14:51:25 EST
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 5A8EE3AB693;
        Thu,  9 Jan 2020 19:14:53 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DBC1920003;
        Thu,  9 Jan 2020 19:14:51 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [RFT] mtd: onenand: samsung: Fix iomem access with regular memcpy
Date:   Thu,  9 Jan 2020 20:14:50 +0100
Message-Id: <20200109191450.10775-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103164158.4265-1-krzk@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 14ebf24175df0f216256c8483ee2974f35a1a89c
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-03 at 16:41:58 UTC, Krzysztof Kozlowski wrote:
> The __iomem memory should be copied with memcpy_fromio.  This fixes
> Sparse warnings like:
> 
>     drivers/mtd/nand/onenand/samsung_mtd.c:678:40: warning: incorrect type in argument 2 (different address spaces)
>     drivers/mtd/nand/onenand/samsung_mtd.c:678:40:    expected void const *from
>     drivers/mtd/nand/onenand/samsung_mtd.c:678:40:    got void [noderef] <asn:2> *[assigned] p
>     drivers/mtd/nand/onenand/samsung_mtd.c:679:19: warning: incorrect type in assignment (different address spaces)
>     drivers/mtd/nand/onenand/samsung_mtd.c:679:19:    expected void [noderef] <asn:2> *[assigned] p
>     drivers/mtd/nand/onenand/samsung_mtd.c:679:19:    got unsigned char *
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
