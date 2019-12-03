Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00F220640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLCIlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:41:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32921 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfLCIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:41:37 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ic3kV-0004nh-KB; Tue, 03 Dec 2019 09:41:35 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1ic3kU-000288-NI; Tue, 03 Dec 2019 09:41:34 +0100
Date:   Tue, 3 Dec 2019 09:41:34 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        "siva.durga.paladugu@xililnx.com" <siva.durga.paladugu@xililnx.com>
Subject: Re: ubifs mount failure
Message-ID: <20191203084134.tgzir4mtekpm5xbs@pengutronix.de>
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:38:04 up 148 days, 14:48, 142 users,  load average: 0.14, 0.18,
 0.18
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 03, 2019 at 04:52:32AM +0000, Naga Sureshkumar Relli wrote:
>    Hi,
> 
>     
> 
>    We have upgraded our Linux kernel to 5.4 from 4.19.
> 
>    And I tried mounting ubifs using this kernel on NAND partition with below
>    command and saw that
> 
>    There is an issue with memory allocation.
> 
>    #mount -t ubifs ubi0:data /mnt/
> 
>    mount: mounting ubi0:data on /mnt/ failed: Cannot allocate memory
> 
>     
> 
>    I saw that there is a commit on fs/ubifs/sb.c, where it is allocating all
>    the required memories at one shot.
> 
>    [1]https://lkml.org/lkml/2018/9/7/724
> 
>    By reverting the above patch, I am able to mount successfully the ubifs.
> 
>    By reverting this patch, we are allocating, writing and freeing in a
>    manner such that, we don’t see memory allocation issues.

Sorry, I can't see how this patch causes failing memory allocations. And
no, this is not expected. Could you sprinkle some printks and track down
where it fails? Is it the obvious place here:

	if (!sup || !mst || !idx || !ino || !cs) {
		err = -ENOMEM;
		goto out;
	}

If yes, which allocation fails and how much memory did we try to allocate?
If no, where does it fail? Also, where are you using UBIFS. Is it NAND flash
or NOR flash?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
