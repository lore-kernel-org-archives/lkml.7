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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA082168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EUR+SG8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfICTae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:30:34 -0400
Received: from mout.web.de ([217.72.192.78]:56445 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfICTae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567539032;
        bh=4T5ny1AS1GJwZchXT6ocqT0k9xc1p63z1kQ3jTt1dBQ=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=EUR+SG8iElxs9PXN60LFs0C3OMVgK0asX5EwMwAPs9UEqk6NQ+zHa/HrYhVti5EFd
         CKNamc/VH/pXNexkEGb7vDSpHkbIQCS3YymY2OuECbIYDVTUO0nAPtwRov3OJvnXh4
         hBQYOvaGn8i+q8QxDIswk0XfLf63IFMs8LmJBUnE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lh6UN-1iYSat0KUZ-00oYkS; Tue, 03
 Sep 2019 21:30:32 +0200
To:     kernel-janitors@vger.kernel.org,
        Evgeniy Dushistov <dushistov@mail.ru>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ufs: Delete an unnecessary check before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d57685d8-d0ce-4a53-177f-a98d116d2981@web.de>
Date:   Tue, 3 Sep 2019 21:30:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrlEPxGj2xKjYWxLkpKXeE8NbVCD6VV8dE/T2QQXTiLSjspp5dN
 y7Beq+4QzUCYvAz4Wi3WmTQ3hgqzBR0JK2K7mSe1OeX3XayLP7BiMokcSUwu3ftMnkX9ofc
 RankEHryYFG9vhgWAy1Pg3gyEmUiHYOzXazFaeNxe33+HFGwvGhhbqYk1714w6XTHSKUkZm
 c2TT0rUwZmpEfUDslCFyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cO36QQGygiU=:cQjy2KXybhpur1pWBRMC+j
 fAruuji/pDGgyxZj5jJmII3nLNuhYGdVtSUVtZkMwwM3oM3p3rXqytZuBTXkZ/K0rLESmZwy7
 v/t+3cL21gpKw9Wh8hyILHa8gcjzrOkqUpOCSZBlYn45edxhI63dKlKPQDLdxOxk7/tHCqajc
 Fyc00gYhx9OeSL2LYUdCs3r29OAlvE6p7DvTolrvvdWar4tbJlmMuUKcPaXclu5vmziMIT9Dm
 E9I12V8lWnpYlpGcacpJ1iBSM5PZzrUTdg1FMo4gMPN20ZkFQOrvdIy/6hxg1Xdq670oTuVM3
 L15UGVI1alO576jiOX7PCC0rIPAJxeMFWFhDLXO8AYOkjwId199nDy5nRTgIyiCW9rQD6C7t9
 tVQGxpipFpZiLlEekBGsvjBbdmLarhr64igCYFTRAMJo4z0gbeiibmC9Uznnh2dgTCojDEaOt
 Ijl57Hd4sgPrgDD1+gMSQRDmrtGD0Aymfh6V9HaVpL07WOWBYYMgwnpr5SJdxCKt01NkiWaVh
 7pIZ6op4NBp+riXjopjWeqKW2KMdCGZOF5O+gw9AyjVD/j3U7QRSFpyL2A3hGlNwDOEiE+TvI
 HKupd52hg0FnCBMvFH90F5k7tYoWOhQqI1xhU2lx3aFAZLC/dAYyjFoV8lKvAuyzTqfDOLh9P
 x9h+PDwrHFkO3oC7opuyfMHCLSDwPqJRVmsaWyKVTLbS4l19FOX7gwnnl5sWyPczRgIDvgv/Y
 P9YKa8QZkDcK46Y4kzpKKl9eniInK5VTnKoFmd9VTg+Gw1zM6ojJZYkUP+aZwO42bZgw122Xw
 rUaDKgxpHaBK/F45LxtqXV7RtXHPfKv63Ly8FhnV4+z1VZK0+NCucR4DS6G1shTnyPP3r/oh3
 8fXnnGMb4aOKpTY0dO6IvBxXbaUtNc2H8AOO/RcgWskfmhbPZPtMAYnNsr9KicAYebx+ekZRu
 beWG06HHke9dR1OTH6s6yKn4KTSpvUp/WjmKK3t7qOrDbKs/5WDZKtUCwxdE+YxwlP4Lry+NM
 8qtNNrZxWEzgk6KU82lpH/sFbCfa41INH3f4IE813RXMZu3uuEs1hZURxkQPPf7hpn1f6Nmx/
 IJ/UxsuZCCnKH7cCYP+UY26+GwEMfWF4soKrddMdd3G5ncsFJs3X8jXnyY9Ho5B7+LItboc/N
 H+NUqLyOVQ/8fZ0XIq8qsth7qyNytAEKZiBgTMBIsSIDKu8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 21:27:55 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ufs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 1da0be667409..20799faa307a 100644
=2D-- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -574,8 +574,7 @@ static int ufs_read_cylinder_structures(struct super_b=
lock *sb)
 	kfree (base);
 	if (sbi->s_ucg) {
 		for (i =3D 0; i < uspi->s_ncg; i++)
-			if (sbi->s_ucg[i])
-				brelse (sbi->s_ucg[i]);
+			brelse(sbi->s_ucg[i]);
 		kfree (sbi->s_ucg);
 		for (i =3D 0; i < UFS_MAX_GROUP_LOADED; i++)
 			kfree (sbi->s_ucpi[i]);
=2D-
2.23.0

