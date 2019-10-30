Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECBFCA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08A22083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfJ3IUk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:20:40 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35385 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfJ3IUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:20:40 -0400
Received: from xps13 (67.173.185.81.rev.sfr.net [81.185.173.67])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0599F200011;
        Wed, 30 Oct 2019 08:20:35 +0000 (UTC)
Date:   Wed, 30 Oct 2019 09:20:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     joern@lazybastard.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH v1] mtd: devices: phram.c: Fix multiple kfree statement
 from phram_setup
Message-ID: <20191030092036.38cf4f11@xps13>
In-Reply-To: <20191029170849.GA6279@saurav>
References: <20191029170849.GA6279@saurav>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saurav,

Saurav Girepunje <saurav.girepunje@gmail.com> wrote on Tue, 29 Oct 2019
22:38:49 +0530:

Are you a robot?

> Remove multiple kfree statement from phram_setup() in phram.c

This does not describe what you are doing, you don't remove them you
factorize them. And honestly I am not convinced this change is useful
in old code.

> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
> 
> Change in v1:

Your first version is v1, how can you be at v1? It is almost v3 already!

> 
> - Add change suggested by Miquel Raynal <miquel.raynal@bootlin.com>
>   "The goto statement should not describe from where it is called but the
>    action it is supposed to take. 'goto free_nam;' would be better."

This is a copy/paste of what I have said. What I want you to write is:

"
- Rename the goto statement to describe bla bla bla.
- Fix the typo in the goto label.
"

> 
>  drivers/mtd/devices/phram.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
> index c467286ca007..38f95a1517ac 100644
> --- a/drivers/mtd/devices/phram.c
> +++ b/drivers/mtd/devices/phram.c
> @@ -243,22 +243,22 @@ static int phram_setup(const char *val)
>  
>  	ret = parse_num64(&start, token[1]);
>  	if (ret) {
> -		kfree(name);
>  		parse_err("illegal start address\n");
> +		goto free_nam;

Come one...


Thanks,
Miquèl
