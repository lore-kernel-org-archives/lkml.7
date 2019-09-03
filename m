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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F60C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68204208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CNfpiGAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfICMLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:11:31 -0400
Received: from mout.web.de ([217.72.192.78]:58651 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfICML3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567512684;
        bh=OYzSpkXzo3N0yrcGnf9ZJcXlu1TQyZVYxWc2jy0YVQE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=CNfpiGAR36jnD1aAPhTwM/ZLwpxFj37ngRwoamvrsPipYO+gUnKOcDXLR8CBtXVMq
         mF2/K7FqCkSfYSniaqhbU0X/tID6lAh234Po4e0Qbi0tSyKY213//VTIV2+jqMVCfB
         tPi8PaFDewucVUKiALMlla/qLO+C5xecG3BrvY7s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfRzh-1iY8wP20Fd-00p7jm; Tue, 03
 Sep 2019 14:11:24 +0200
To:     kernel-janitors@vger.kernel.org,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] befs: Delete an unnecessary check before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <83cda9b2-a2c9-2201-48b7-3bf2273d7e87@web.de>
Date:   Tue, 3 Sep 2019 14:11:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SnsXIffvl5NsA82F7aK/VOQJBQUn0ksIVEB1hdYAhKD1dOqGd4T
 AFLy/GK27/w1m3jBpozCbYr0WsbGj4yv5MvAuekog6H5wux8AcAG8wyDwiAvUU9PB3VgktY
 xTRq5GQ202/k6vQ9QDi1INy02Uzbw6W/91KDcmetH2c78FpjIMXBZStd7YMtHreS6t61WDO
 RmduduBnm85lRnZSixurw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wb7PjVxuNw0=:xq1a6ySS2hTWG72Ala8Uuw
 VxfVB/VslmeGw5YvGQN9LPzWYaxKlLoNv6rpNfruMfSFG7CvaZ+eyMb7Qk1WKM1WjgoBI2fmL
 E6HZj1fcQftEddJ10KobOWRNmSCJaxGF0QaoyqezqxSWoyXspXXyCpfuDzgDSBRENOHNk3t1c
 SuM7MSQvB/VUEjqajgTmKUX+6brfL0VmR4uT4npR/6dmi2FrQWtwxwOCk5kILLQ6xuOhiFL7k
 MBSR4bp2e86dzcN68eV2iG0AHfCbi9wCEJIWHEC9VDexNiGjf/zqF7z88VrmfyGfOscUK+zWC
 FAlcUQRP/0rB5jCKTNnH49P1tN5bX2n5qIVdsPxdZ199rbMHkQtnjKfOBf07CYCv59jWw0EtO
 lNinEPZt4Ly9seMS7UqJVM2yPgmIxy69mOPkh8v9ItowEjQneeZL1T8HlsBE9oB70ji5zokA/
 xch/+yX0+rOXH5/1pa4Q6Yr/4WNtIDAtqbhb4XP0357xNPO2lmYwnm6HRgsHnLHqrx7wQFbV2
 Ao9g3mjbywOwoJi5kg2s9nkNBiJbOCzDDbCyeosRzOCcBnV8xVVVJ2Eqv19HZGsshTnVPJVIy
 SHsN9VMVZtttvpo/PSC78wcrD4FBPeioI+KTn7j07+qECHHxmzGfAraDmDYzlLc5TgTbu0Z+Z
 Ndf6pr2Mrv+PpJ0UMTlm9vOZhucBPXUw9cFvlQj7G7p3cAlnAZuLwDhWJZyiMN5DxkpyVL5tF
 yGx2w+hp13nSdSuPFvd+bwi0lGjttXPWpY3C64zYVHO6Kxw1lCw1B4N4YEIs5D4naslruuaL2
 I+fvT8obhWOUOJtwOXx70x/OXK1sB16ZPP85aXTlFSwAwzJajGPb2GXLiHokuXUy1plR7jDpA
 7gLfUNiU8e1VvpUDSlU75YsCKxW9ap1s3lrNkRZZxJ+6mopcP6pOLfGnLrPxGv4IEpwq+/uj9
 LofqgxvSy/7SmQP+2tp+7FFCgI9DjNIgjxaODQsON3S9y0o3CzAnFtIgLbDWoiGNzlPv0cbjT
 bLxe5v+86FyWbMxPc04N3UAQOM4cunYKhWhdQLkUPjOGrbyVy5vpgPYN/9j3i+wT660lFA+pn
 sYvGIWs51OLB2BYFtwipCjY0/hOR2Jhh6vuvyYb0HkUnE70eQHVCxXUHDgFV/4TjTPMl9AzCs
 x9MvveFt2FyuPnDiAI1fIpog7cPjquRzG0esqwke1Ebq/8Jw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 14:04:05 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/befs/btree.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index 1b7e0f7128d6..a293e9ce1410 100644
=2D-- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -194,10 +194,7 @@ befs_bt_read_node(struct super_block *sb, const befs_=
data_stream *ds,
 	uint off =3D 0;

 	befs_debug(sb, "---> %s", __func__);
-
-	if (node->bh)
-		brelse(node->bh);
-
+	brelse(node->bh);
 	node->bh =3D befs_read_datastream(sb, ds, node_off, &off);
 	if (!node->bh) {
 		befs_error(sb, "%s failed to read "
=2D-
2.23.0

