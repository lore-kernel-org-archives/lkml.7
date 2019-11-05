Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80BBC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9583C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfKEXDt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:03:49 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:53592 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfKEXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:03:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 029076083247;
        Wed,  6 Nov 2019 00:03:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YttQJIBwfaTv; Wed,  6 Nov 2019 00:03:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E7A25608325B;
        Wed,  6 Nov 2019 00:03:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ixxa3dKDNkm8; Wed,  6 Nov 2019 00:03:42 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id BD6116083247;
        Wed,  6 Nov 2019 00:03:42 +0100 (CET)
Date:   Wed, 6 Nov 2019 00:03:42 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at>
In-Reply-To: <20191105200344.1e8c3eab@xps13>
References: <20191021193343.41320-1-kdasu.kdev@gmail.com> <20191105200344.1e8c3eab@xps13>
Subject: Re: [PATCH] mtd: set mtd partition panic write flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: set mtd partition panic write flag
Thread-Index: TMsKjlq8YvqFfxDXeku9945usY1L9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> An: "Kamal Dasu" <kdasu.kdev@gmail.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "bcm-kernel-feedback-list" <bcm-kernel-feedback-list@broadcom.com>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Brian Norris"
> <computersforpeace@gmail.com>, "Marek Vasut" <marek.vasut@gmail.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra"
> <vigneshr@ti.com>
> Gesendet: Dienstag, 5. November 2019 20:03:44
> Betreff: Re: [PATCH] mtd: set mtd partition panic write flag

> Hi Kamal,
> 
> Richard, something to look into below :)

I'm still recovering from a bad cold. So my brain is not fully working ;)
 
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Mon, 21 Oct 2019 15:32:52
> -0400:
> 
>> Check mtd panic write flag and set the mtd partition panic
>> write flag so that low level drivers can use it to take
>> required action to ensure oops data gets written to assigned
>> mtd partition.
> 
> I feel there is something wrong with the current implementation
> regarding partitions but I am not sure this is the right fix. Is this
> something you detected with some kind of static checker or did you
> actually experience an issue?
> 
> In the commit log you say "check mtd (I suppose you mean the
> master) panic write flag and set the mtd partition panic write flag"
> which makes sense, but in reality my understanding is that you do the
> opposite: you check mtd->oops_panic_write which is the partitions'
> structure, and set part->parent->oops_panic_write which is the master's
> flag.

IIUC the problem happens when you run mtdoops on a mtd partition.
The the flag is only set for the partition instead for the master.

So the right fix would be setting the parent's oops_panic_write in
mtd_panic_write().
Then we don't have to touch mtdpart.c

Thanks,
//richard
