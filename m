Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDA8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E9B22D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fC1oVZvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfICOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:20:55 -0400
Received: from mout.web.de ([212.227.17.11]:40273 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfICOUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567520444;
        bh=vMgAzBXUWskQTecRcuVXqAK+gjDpq21bPltTH0WE3wk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=fC1oVZvEWv3nQ3lMjV2GfDu7pzJfKRimmvc/pvavAk45RDjSLrIzWsSLverB/AgBM
         REktN3nbH98jahG46oyagHSJIdLvUVrs3gs+E5UI81MKz8M+sWdLpWCOsh3+wSU39H
         MNK71aeMReNY6PXKV5zn5SicosL3oHerj8a1wryc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbQKW-1hmNpv439g-00Ii7G; Tue, 03
 Sep 2019 16:20:44 +0200
To:     linux-ntfs-dev@lists.sourceforge.net,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ntfs: Delete unnecessary checks before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <43a59c6a-3635-1fab-1945-292d637663c9@web.de>
Date:   Tue, 3 Sep 2019 16:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ztnoEwB7aMfeVUajX7qUfS9p3bmeZ+tI6B5JJX3RDPEb+rx6u+e
 AhF0Nmvk8ckkG0Q7m1ou9EBafIyIc/fDLaZHj+dQrcISogiH4Y7ZDSxK6wN/yRgRMn7S895
 2kly7v5wiPInx6nwBoJjJRnr14EGgm0f7TFdNdBFf5tUwQh2vrOxh7LaQqVkT4Q9DgSgpkr
 MCLp1Y2CUuWabv3RfAmJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1SMwqbzjxTU=:VdhFO7S5YgunW7J5HVQzoe
 liyI15Kc45OF7p1O9Ne3rmQbQTR1LOP2GzATySlYk83qxhMRhJOR6ehj8qwf2DNBrYWFae72A
 kfGUB3scE/e1N2zt+8HED9EvXI6hQjC6wTN9QNRTuC/dPvL22WN9Hd6265FUlDS2fJQyBfhg0
 WvMGXjnjlHF/CuPbP2jsPX/IOJbLgBc3HWf9T2O/vxBJMX+ek2Db0+j8A4cNDaudQvNZRbwUV
 B6yybjJvYhdIpI6lspkERMmYnKi6JoOCKZH3PXMTmYKlf7eyy9+fjUtPORk8NlKqP8LyWKVIo
 MlN+1xGTSqKgtt8gffd33RonoP+0F6rVFRHo/ZLAsBA08tvaAT5vIT5LA9YwzUov+bNr3FLhu
 ggweaHDP9jW59xtTtUodg/5Y6oxUfiUZm2bSAq+CVv8kMpNTPWCB2L5P2tcNRDnjcjfDm4UyA
 OyjQ2Sc6ho2X+vJUfw6wNf7Dyje6y7AWVFZlN9uZDB6XM4koZtP9RBzbzRlzH3g8D3R/cu+A2
 ms/a5Hfwod0zRBWiBDtMDTFaKR/ls6CRPzWGmwzqKN9d1iBp6v4tc+muN4bRf2vt/vEPbEHdt
 VgjKdL0+EhNwnqS1kIXDK7NrSjwV2fQEoWqfwu/UAn4QeENNEaZcvXh+2DDA9wAMm6ZQEpksV
 /kNGjpReHmQCYqPlI9c99U/CN/QjaEY/Eq1iM9Irypsgv+0cUCH49gyBY7VT1GTyRn1Lrjq/a
 6K8FhoTjQMrlH1jAqPR+6TCnDi304awOZkd00n6ODqtYiLhQIm4u0ZEeIH5+coNQuDVKidHGj
 RJj8doEBB5iZ+h8ATRoJVfdDdUXJt/oAzuIgZRQM0ErLOB7iRUUNLbaeiohugfzUUKuZNiSUA
 qdxF4gI80+67O+CvaAsBeSjvwrdk8rWMYocL0k/YFZDA+icpIq4GUp4jyv6gGvgfan3h9f9RQ
 M1ReG9B82NPrivORCJWkk2RNLPRxJySIBxlasmgDSB9ijgCO0Loy5yxW8TEUSyww89Hj7WZoH
 PUQb9rpHZ+i0uFyYj2z6jeV82AfLk/37epwrJ9QJvWgUMdvcGrYdVr7+uQ46LDqZnvtogr/Y9
 TFCTwWM7x3MdHFgHHHaRVWetpr6eJ+HtL5ZPjdiHvjJAzkDjXZpZEpCVfwA+IaxClGrJe82WO
 E9vMb7OsmI7ROjuVZu7HILYjT2S/npvdaOHcxVIYSNoeKoLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 16:18:07 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ntfs/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 29621d40f448..f0ed1a3e5c7e 100644
=2D-- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -676,8 +676,7 @@ static struct buffer_head *read_ntfs_boot_sector(struc=
t super_block *sb,
 	} else if (!silent)
 		ntfs_error(sb, read_err_str, "primary");
 	if (!(NTFS_SB(sb)->on_errors & ON_ERRORS_RECOVER)) {
-		if (bh_primary)
-			brelse(bh_primary);
+		brelse(bh_primary);
 		if (!silent)
 			ntfs_error(sb, "Mount option errors=3Drecover not used. "
 					"Aborting without trying to recover.");
@@ -703,8 +702,7 @@ static struct buffer_head *read_ntfs_boot_sector(struc=
t super_block *sb,
 	} else if (!silent)
 		ntfs_error(sb, read_err_str, "backup");
 	/* We failed. Cleanup and return. */
-	if (bh_primary)
-		brelse(bh_primary);
+	brelse(bh_primary);
 	return NULL;
 hotfix_primary_boot_sector:
 	if (bh_primary) {
=2D-
2.23.0

