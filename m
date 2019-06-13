Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80808C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5E3206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="MeM9nY7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfFMP0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:25 -0400
Received: from mail.intenta.de ([178.249.25.132]:34947 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbfFMLoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:44:02 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jun 2019 07:44:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=QQPcew8OO4uWb22KfzOtVt5mqOvY+NBIVgehiNO+p5g=;
        b=MeM9nY7f3cZ90lL4rVQxYVufUJWVijCGsM8VNa570Vmemc9Y+dPh2CCk5QfPO4GgEQUkL4OOlgOR4WhNgsmBoKs2WpSYk3Kg5aXldYB6IXl7JmJyoCOrpFeuO25V4zrTlJCrDErXf//tD2uVv+ns67OSh4os0L8yg52I4x1CGatCTdyIUC7XBlk0KBce244jX/LJEfkIb3Y+6aEnWG0PJBoDtWLmtDZDhY4Z5g4BCxHFamAOkk/A8HFC8oIWvFrfWAICoZf0GmntVxKisUifc3lPHOQV3USodD50SuOMP3ZkMXbNipcN+pxWQTz5pOJt2kmnNMJxxVROtECIevg8xg==;
X-CTCH-RefID: str=0001.0A0C0201.5D023595.00A2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Thu, 13 Jun 2019 13:37:57 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v14] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Message-ID: <20190613113756.53nzb6o2vuurep2a@laureti-dev>
References: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190425112338.dipgmqqfuj45gx6s@laureti-dev>
 <DM6PR02MB4779EE37978EC0E6475C55D7AF390@DM6PR02MB4779.namprd02.prod.outlook.com>
 <20190429121804.4jzspv4goehwdpez@laureti-dev>
 <BYAPR02MB4776C0226F9A9F55C9A6DE44AFEF0@BYAPR02MB4776.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BYAPR02MB4776C0226F9A9F55C9A6DE44AFEF0@BYAPR02MB4776.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

On Thu, Jun 13, 2019 at 10:18:00AM +0000, Naga Sureshkumar Relli wrote:
> I spent much of time to address all your comments.
> All are addressed and tested. except the above one(address offset calculation)
> I didn't see any issue with the address calculation.

Let me first point out that this comment was not trying to imply a bug.
I was trying to understand the code by comparing it to similar code and
that turned up an inconsistency, which can be intentional or a bug in
either of the sides being compared.

> for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
> 	nfc_op->addrs |= instr->ctx.addr.addrs[i] <<
> 			 (8 * i);
> }
> If you go through the nand_base.c, there nand_fill_column_cycles() API, fills the first two or one address cycle
> Based on bus width and page size.
> That means, addrs[0]/[1] will be updated here.

The problem at hand is that `addrs` is imprecise. In this code, there
are `instr->ctx.addr.addrs`, `addrs`, and `nfc_op->addrs`. All of them
are different. My original remark was targeting the possible confusion
of these different `addrs`.

> And the page is updated to the next offsets.
> In the similar way we have to extract the offsets in driver.
> So the first four address bytes are stored using the above for() loop and if the
> Address cycles are more than 4, then store the remaining offsets as well.
> 
> I just compared the offsets that are updated in driver with the offsets(page and column) that the frame work(nand_base.c) is sending, and the offsets are same.
> I have also checked these offsets with older driver(not exec_op() implemented) and both are matching.
> 
> So I didn't see any issue with this addrs calculation.
> As per the statement mentioned by you, this driver consumes addr[0], addr[1], addr[2], addr[3] and
> If more address cycles needed, then addr[4] and addr[5]. This is correct.

Again, the lack of precision makes it difficult to discuss the matter.
You refer to `addr`, but there is no `addr`. I assume that you meant
`addrs` here. Based on that assumption, your second last statement is
wrong. The driver consumes `addrs[0]|addrs[-offset]` rather than
`addrs[0]` as the first byte.  Then it proceeds consuming
`addrs[1-offset]` instead of `addrs[1]`, `addrs[2-offset]` instead of
`addrs[2]`, and `addrs[3-offset]` instead of `addrs[3]`. Finally it
consumes `addrs[4]` and `addrs[5]` if more cycles are needed.

I would not have commented the code if it were actually using `addrs[0]`
through `addrs[5]`. Your description looks reasonable to me, but it
doesn't match the code.

I'm looking forward to the next version of the patch.

Helmut
