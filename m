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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BF5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0FC215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cwcZsKZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfICNAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:00:23 -0400
Received: from mout.web.de ([212.227.17.12]:59201 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbfICNAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567515614;
        bh=TACTq/7Sh2DvF7fuE38uHW8xjRw9dstZVOuHVc/RdWE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=cwcZsKZOeGJmNLAuYpwMqdXSzxeq1C7lr3E8SekM2paXCsGGiGdbANX6u/eqpiTY9
         PKZH6vsJLn5kbTi3Zhh6rf5V22zMWLfGm1L7LFsIV7bVgZo9ikrAOWUE3WNOx5ot+t
         7xzcDOHU4MItAfss/7483ztRJWXgazGIVYvy8Xbg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHY1o-1i1qcs04Wy-003Okn; Tue, 03
 Sep 2019 15:00:14 +0200
To:     kernel-janitors@vger.kernel.org,
        Ogawa Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fat: Delete an unnecessary check before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cfff3b81-fb5d-af26-7b5e-724266509045@web.de>
Date:   Tue, 3 Sep 2019 15:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jOe2WCQLf1U8ptMwO58KaHweDBDQAwUhPPNh8BGjGvr6xP4so55
 TI/zxzDnmZ12T7KStp+lk6qqca2WbO9Frn2Jf7UHGOJWGr7upW+6XPtV58LwlD2Yw1pz2pk
 9aWLoH/dBBW7AmV1Jt/s587VN2GGhnJp56qrJHC6BSEzmY7/Qk7K2186nCzZ4mktxsM1CKP
 2GU0yZC/bn5GKfCuOXUKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gi9UswCkrqc=:ot7nqrx0CRTJgNTkcFpXhT
 QfNjI/rxQiMj4wE2st0bS176PbAux4C/EIKG+Pz74x72JrAW7AFimZwL7bsbYVirfBHmLw0k/
 OySYs8dIcyUcBQcq26xbcvAIIS6S8oZyBRYrMjwUpC8iR2xFTs/mNvgDFlP/04bBTzyhMZHw5
 TUI2wIzxMJ1P5pzaJFqJT+43+jT+UXUctOO7/rEtjCvTrVS5vEM4I36K04IC/VrbnY2ypMrfn
 LJd3MmPzjQMdV83FJSZP+mH6aFeORv48/JGwySAdVo7sfjE377qIt09dbQnwCuRPvdgQmtEu5
 szk+ixgoeNXd0d6RZtJ8sI7W+/uLrKzjjOcPzShmDQaBhVGMgX1Wwj85u00IKL5eiItM7dqgy
 rw73UpjUV1NY/FdiMTysBYccaWWPanmzc2SVLjS46vk3xZN/+E2h4vXGa8xjEj9Pc8UK5/Ue1
 lHKAW834BLKVc4mqpf7BS4pxolj7kopWOJF5D1diW8/zNBWi/owZ5L2AeVVMfsSYPqVyzmo9x
 iEp4ckFjzWAL31ERTvPHbPFBcSugOLiNdISCIU5AtlcqbSROMCD0qzX4WmYbF3VILSECUn9F0
 a5V728KlZCEN1ECTsQ6eMPbwjCH5t41QhE3LV1MgA8a0JDejM4JP0o4tAntdKTvMKc7fnsAu8
 8zIb3fihDwvsdAFSkDX7WJyoiqBNWqySe7y+JDvloQMzNXzSAJdwdxl6+KiHlm+DMjHj+x1bv
 cy4eaJJY4GHwBTtA51V+eI3mkpFVu7Qv/OxTlqATfYm0G2G9WrLk3wDSUv0ZKR5i6p6g0MbIG
 si1xd5wigax7yKVakk+oeaEWfMKTYvzFqHUH15jMbPvyEtO/LW3uY5Bb3fKdf3uMgp6jfeMVE
 o2zT09k3B/Q3qkXflJFJiKIZJuzgJFzaz91qO64u6SntDDyqs0+DhBAfl23XD2j/9sXPAhfcf
 iE8LK+FQ+oJoo1rGByeFgOqpmJei5BQa2QJwGSzWv9XFs9zAsK9CigiFOtAnFnXuClUAHHBEw
 HpEjDhtDqDGSyC8RxrnY9I7T0CM0+UJhTZF6J6h2xmzdrIUsnO7x5jtJEW3nL2JqSFRq0nVfR
 m08pkwfgmtZkIS0BGGqvTyL2+jHochRlppaxSMBpsTcdmthUtRfbGKTAL0yOT2tQzSCyp/wjH
 EFv2g9jRoXmA5nZL9NIFG5nLBcadXHr414vBezBAKqbQvG/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 14:56:16 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/fat/dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 1bda2ab6745b..f4bc87a3c98d 100644
=2D-- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -88,9 +88,7 @@ static int fat__get_entry(struct inode *dir, loff_t *pos=
,
 	int err, offset;

 next:
-	if (*bh)
-		brelse(*bh);
-
+	brelse(*bh);
 	*bh =3D NULL;
 	iblock =3D *pos >> sb->s_blocksize_bits;
 	err =3D fat_bmap(dir, iblock, &phys, &mapped_blocks, 0, false);
=2D-
2.23.0

