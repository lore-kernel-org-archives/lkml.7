Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B250C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E034B216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nJld9cUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfGEPSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:18:25 -0400
Received: from mout.web.de ([217.72.192.78]:38361 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfGEPSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562339894;
        bh=gvIgmfrrzEX9Dp4LMXHUn3Gt+CnMAoWQeRAK9nB/a9Q=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=nJld9cUklM0PwCN7r1zDZ6MZNGZMrtjHHtVHPhdquh3635AkX3NZcvfmriXtiYmvt
         Yggu6CvcZfJy2DNoi1/RVM7/0NV0Z9zio7aM3k3hu25qIFHJkvqU0KzGcoGewOOdKi
         PrFuUpzV8RW3RQrYeS/n1J1XipQ7bCQGpDdclxgQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.45.164]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHGil-1hmyT03z5X-00E7V0; Fri, 05
 Jul 2019 17:18:14 +0200
To:     linux-m68k@lists.linux-m68k.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] m68k: One function call less in cf_tlb_miss()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c5713aa4-d290-0f7d-7de8-82bcdf74ee95@web.de>
Date:   Fri, 5 Jul 2019 17:18:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWjln+sGM9TFwBI02ZuPQsUGbrVpO37DMer0EdXvorXjftJQHws
 Lg2vMRlG48KyPIcmkAoR9cb1fvYqH8dyLydlmB9XbZRlnmuOcr9a7qAWKjIrerk7PTL4CQi
 H0wMFPXB+1DLFdRrp8rGzsmsYTGNFL9YCr9ELiJf1JsuAvhxwlS0OC+VGRgmj0lh0AK0yml
 dTAmt0R49FspVnoob/z5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ddjx9cHgnM=:DFso/W8oC8kip8hiteFHQj
 ryhtnUWM8UxszhpE/Y/MaW+kWz9KmKJQ8Hb3tdovALTtfA5OP1s5y3bkmqmIJyEsokUP18V0S
 5BnZIesVQracHlKkg8NonUO+YJZKFhVnbYlJFYX6uyu6feEVNsb2Gna0fCqj49noRrj0EXqtr
 4v/eu3AFsnsh4Pn43HFSRBkK4wT6568+B7q6puZ12yhXvqrRfS+RGEZPESkWhnzUsokPq1uLk
 MtNSUmWVs9tvWoJrIaK1hY3hxeYg4Rts+Vn9wZ88VNDXqRICfT09Y6pg/mFQ63fFwozhDpxMJ
 KzHMsFRUguIGqsrWSzXKawzV6lKp53CPuHUEkKwqvjkhDTIi2e5XUh/kGH47G6rIF3ZKohMYs
 CIYLJOnDfB+4VC6yeO5vYRfUVFKIF0/1z9u6zy2M5y3ZrJTwjegKc1Tb6jjcmeakLI7MAF6NA
 Q7EEqCNSB661lGvWE8zNBMXp/wGCbw29FpTNr9KQsS/xQEI1T0vheCo+nsiwhOZPSR4ux8Rdn
 fyaTMASc4NttA2afexOP4NZwUxHM4BB5UN5eLcEPvwPWLeozIRI6LVbmSIiUPzcwTEaHBQtXN
 xNtG4Ap1210jztcWkSQpFfgJVgMZWxHBkzoj5zAOOD8MryIIHyr3iA1QBixAhSUT4UTZj5Vxx
 b0WIhqJAPiJ6bIyYok95qXL0YLFjqWXsVNH315IHp+Jb6YLs3tueElnPAk1ng8NIbp0jC7NHN
 J9vV3jZM2fGbvsRnmhIypsl/86NhbJb8eord+P1o4DBhv/p8H1zH0elbypblIyYTexBouluKJ
 Lvg+qqWgJO3bu7DdMDmNkF4F9wnMWzDmHvjw4R+TVFSVN6MNXeE2FPSNwx53TXL6TQdhI1TqL
 lAhXiUZCDz2Gqhoi2kRAV3t9PEevUy2WpNmRRtVJXgbPJBO6gen96yt+8WjvxYpiWowdPlUdU
 YG+bKkK1v3Ct/SICiUqKj3sOVypDBkmdCmpeviFGv4aNXaG1az4BxB/nTJSBTwMTQElPWKuCn
 4Neox1zWcp6CvvLI8ZxMFxdXe7lsYVIISxJgdq1A1L3KmpvbvCUWOtAtAkN4s2StKYWTeNQEV
 QdGPVDxxIBWJlfLNkwytHQEVrROBL8I6E2E
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jul 2019 17:11:37 +0200

Avoid an extra function call by using a ternary operator instead of
a conditional statement for a setting selection.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/m68k/mm/mcfmmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 6cb1e41d58d0..02fc0778028e 100644
=2D-- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -146,12 +146,10 @@ int cf_tlb_miss(struct pt_regs *regs, int write, int=
 dtlb, int extension_word)

 	mmu_write(MMUDR, (pte_val(*pte) & PAGE_MASK) |
 		((pte->pte) & CF_PAGE_MMUDR_MASK) | MMUDR_SZ_8KB | MMUDR_X);
-
-	if (dtlb)
-		mmu_write(MMUOR, MMUOR_ACC | MMUOR_UAA);
-	else
-		mmu_write(MMUOR, MMUOR_ITLB | MMUOR_ACC | MMUOR_UAA);
-
+	mmu_write(MMUOR,
+		  dtlb
+		  ? MMUOR_ACC | MMUOR_UAA
+		  : MMUOR_ITLB | MMUOR_ACC | MMUOR_UAA);
 	local_irq_restore(flags);
 	return 0;
 }
=2D-
2.22.0

