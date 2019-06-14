Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DF8C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13AF20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfFNO22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:28:28 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:39040 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfFNO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:28:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 263333F418;
        Fri, 14 Jun 2019 16:28:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DlDNnNT6usmD; Fri, 14 Jun 2019 16:28:19 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 523023F348;
        Fri, 14 Jun 2019 16:28:18 +0200 (CEST)
Date:   Fri, 14 Jun 2019 16:28:16 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190614142816.GA2574@sx9>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net>
 <20190611133223.GA30054@roeck-us.net>
 <20190611172654.GA2602@sx9>
 <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
 <20190613153414.GA909@sx9>
 <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> You are right, the patch below fixes the problem. I did not get the warning
> with order==5. Nevertheless, I also tested with order==8; that works as well.
> 
> Thanks a lot for tracking this down!

You are welcome, and thanks for your report!

This patch series needs some redesign, I think, because the problem you
reported would come back if one attaches two or more devices to the
system. Local memory devices are typically memory constrained and so it
has to be used efficiently. I believe there are four kinds of alignments
to consider when memory is allocated in the pool:

	- 256 bytes for the host controller communication area (HCCA);
	- 32 bytes for the general transfer descriptors (TDs);
	- 16 bytes for the endpoint descriptors (EDs);
	- buffer alignment for data.

Using the greatest common alignment for all is clearly an undesirable
regression. The TDs and EDs could have their own subpools, perhaps, as
they are abundant. There is only one instance of the HCCA.

As mentioned, the USB subsystem could be improved to properly report
allocation failures, and the logic to retry allocations could be more
efficient by avoiding polling loops.

Fredrik
