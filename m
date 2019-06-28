Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CEFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF862070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfF1G4n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:56:43 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36860 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfF1G4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:56:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7C8296089331;
        Fri, 28 Jun 2019 08:56:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CklqlVsz2Y-i; Fri, 28 Jun 2019 08:56:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2CA096089332;
        Fri, 28 Jun 2019 08:56:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KBjp4V1tNdXd; Fri, 28 Jun 2019 08:56:41 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 00C1F6089331;
        Fri, 28 Jun 2019 08:56:40 +0200 (CEST)
Date:   Fri, 28 Jun 2019 08:56:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1264454795.19263.1561705000880.JavaMail.zimbra@nod.at>
In-Reply-To: <20190627174101.4291-1-huangfq.daxian@gmail.com>
References: <20190627174101.4291-1-huangfq.daxian@gmail.com>
Subject: Re: [PATCH 44/87] fs: jffs2: replace kmalloc and memset with
 kzalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: replace kmalloc and memset with kzalloc
Thread-Index: /mS+4pTDjR7Av4sfrwGnQFfj/xIdQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Fuqian Huang" <huangfq.daxian@gmail.com>
> CC: "Fuqian Huang" <huangfq.daxian@gmail.com>, "David Woodhouse" <dwmw2@infradead.org>, "richard" <richard@nod.at>,
> "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Donnerstag, 27. Juni 2019 19:41:00
> Betreff: [PATCH 44/87] fs: jffs2: replace kmalloc and memset with kzalloc

> kmalloc + memset(0) -> kzalloc
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> fs/jffs2/erase.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
> index 83b8f06b4a64..30c4385c6545 100644
> --- a/fs/jffs2/erase.c
> +++ b/fs/jffs2/erase.c
> @@ -43,7 +43,7 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
> 	jffs2_dbg(1, "%s(): erase block %#08x (range %#08x-%#08x)\n",
> 		  __func__,
> 		  jeb->offset, jeb->offset, jeb->offset + c->sector_size);
> -	instr = kmalloc(sizeof(struct erase_info), GFP_KERNEL);
> +	instr = kzalloc(sizeof(struct erase_info), GFP_KERNEL);
> 	if (!instr) {
> 		pr_warn("kmalloc for struct erase_info in jffs2_erase_block failed. Refiling
> 		block for later\n");

You missed this "kmalloc" instance. :-D

> 		mutex_lock(&c->erase_free_sem);
> @@ -57,8 +57,6 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
> 		return;
> 	}
> 
> -	memset(instr, 0, sizeof(*instr));
> -
> 	instr->addr = jeb->offset;
> 	instr->len = c->sector_size;

Thanks,
//richard
