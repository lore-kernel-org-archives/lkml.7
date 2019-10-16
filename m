Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B3FFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F0D2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404488AbfJPKoi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:44:38 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38514 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfJPKoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:44:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E0BB860632C6;
        Wed, 16 Oct 2019 12:44:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6FufNbvA2Q6M; Wed, 16 Oct 2019 12:44:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8312360632EE;
        Wed, 16 Oct 2019 12:44:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sYeCDUamV9iC; Wed, 16 Oct 2019 12:44:35 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4ED9760632C6;
        Wed, 16 Oct 2019 12:44:35 +0200 (CEST)
Date:   Wed, 16 Oct 2019 12:44:35 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1581937397.24882.1571222675188.JavaMail.zimbra@nod.at>
In-Reply-To: <20191016100803.31003-1-ben.dooks@codethink.co.uk>
References: <20191016100803.31003-1-ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] ubifs: possible missed le64_to_cpu() in journal
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: possible missed le64_to_cpu() in journal
Thread-Index: w8iv2kuYlm145q0tWl6kPtPgp4Op6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
> An: linux-kernel@lists.codethink.co.uk
> CC: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>, "richard" <richard@nod.at>, "Artem Bityutskiy"
> <dedekind1@gmail.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "linux-mtd" <linux-mtd@lists.infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 16. Oktober 2019 12:08:03
> Betreff: [PATCH] ubifs: possible missed le64_to_cpu() in journal

> In the ubifs_jnl_write_inode() functon, it calls ubifs_iget()
> with xent->inum. The xent->inum is __le64, but the ubifs_iget()
> takes native cpu endian.
> 
> I think that this should be changed to passing le64_to_cpu(xent->inum)
> to fix the following sparse warning:
> 
> fs/ubifs/journal.c:902:58: warning: incorrect type in argument 2 (different base
> types)
> fs/ubifs/journal.c:902:58:    expected unsigned long inum
> fs/ubifs/journal.c:902:58:    got restricted __le64 [usertype] inum
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> fs/ubifs/journal.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index d6136f7c1cfc..388fe8f5dc51 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -899,7 +899,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct
> inode *inode)
> 			fname_name(&nm) = xent->name;
> 			fname_len(&nm) = le16_to_cpu(xent->nlen);
> 
> -			xino = ubifs_iget(c->vfs_sb, xent->inum);
> +			xino = ubifs_iget(c->vfs_sb, le64_to_cpu(xent->inum));

Good catch!

Thanks,
//richard
