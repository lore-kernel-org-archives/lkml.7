Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE17C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48522146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="T0FjnRPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfGALQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:16:49 -0400
Received: from mout.web.de ([212.227.17.12]:35283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfGALQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561979803;
        bh=dZ4VcO9pNxsQV4z29dsXRp5NdEoer3A955Q78CzC6Gw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=T0FjnRPeKHYk6XmnMGFJW9iGNjFPVjhw8lbwgwalXdCIIvJBAUimTGXfHUpSewV/+
         gkzr5US0/gnRfFEA7MBRdSUr1wsJKWfDxuItyd+p+/Iy+Zge09PnJ5J86PJl9Yb/CQ
         l/wJUgs9g9hvvGvOL8ZcJ0SgRH0I6DxGtiWL+aNk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3T5g-1iYUt129Zo-00qyEw; Mon, 01
 Jul 2019 13:16:43 +0200
To:     linux-raid@vger.kernel.org, Shaohua Li <shli@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] md-multipath: Replace a seq_printf() call by seq_putc() in
 multipath_status()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ad2e4b58-268e-c9e5-8a66-8cb5dee8d91e@web.de>
Date:   Mon, 1 Jul 2019 13:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1c20TXWNrjNbZ4TuxWQThN9i7ALgGwSyB2fkS0vBGm1yF0ch/zq
 PI7KsJfdMxrVBMDom7mdNkGR+wDf12qP0BEwjAnka7nhHmNtsv6GSYK0jGawJOpzKUFyGh/
 ura5+DD/uv7fdWyYLo19+noZaty+tQskevsk6Uh0P3EmAx6qRpAdzkelzD6p1czcl+Q25i1
 VI/P7et4lQ6ntibv6SAIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0eZuVMS2BKE=:L4wXZcJHrCyntAOgsKTguO
 EKRZ+UUMQzsnohTfiZaha9je1XhPC/3U8yGMDZtJgCnUvhnOFJuZMW22E39qDakwHoJpIlSoB
 Ca2KsxqShwypsOH8eIcduItHzJQDuVovDkIpnI1QdQKCpMGT/aXWuCEdc42HYXYp9KOlKre3F
 Y66bpONpIiwofsxKwCJAyvaNBA2vemMLTyF05xAkCRkOBJ3fl/ncX10IGaKFGPEMGKhxzh4wP
 4h7A/QFYAq2qJW2WgU1hmRYsc6bd4B6wUYdmAKnPzcJFg2U0wfJY9ejmjVvwIi1UI2u4vlnpB
 cJXr73fskkj8sy+WY+WggMYxLhNNdaIHhfP4IrQ/G+grZJ9NT8TYjLAV6PfOf08fG8gLfD1yH
 wntpuQO5XauHzQCQVXxfWBbXxwrlHLDZQuWvt5v1aN7dludNE0lhrSolHOpVo+Ua+cZBFLvWO
 3c1SLluQIphqwdg3Ca/JJNKT0lnL77CGI8i2VDO22meAypumiEAK3mPOmlZc9oJVmq0pj8a2g
 KcjIVh0kQsS97ioDWm7Yi594x9UbJxBr3jd3EGgwD1xrdtc+uocQx5m46n8AEO/1f1hKo0pBX
 Q3Cnd86/RQ0Zv5tlhNeb/p53sU1Tts5XP9ajSZaxSHOEA7N+F3p7l8mlPQUb5EkCmsJPGc74U
 P6ovKJOdHG2J7+kG2NTyBBEa5aUltO9fKIE92XPtQc02WVqrtSMbeglCgu6YONGtzdm5HrTF7
 YSqzAZZLqG4tPIqIhMq+q017dQh2qL05U1FYPqbuexKBJbCZBhQoqauw04D/BS4iaJVI+Nbnk
 wiky5o76RLHmblbnZ0ixJeQAUBOmPtcw6UmFOlbg5cEcb0gDDXHVZvnd7Z+w5RX03u4favs+i
 ArHZFkcP8fV5h4v6NFEitKq6sv/C2EZg0GC8KS1v0YBfaXuIdF9saN+3U6AdcDx5bZQ9BOcts
 1d3usfEHCiQABjgeDHckBTk6TIu2MVgh4vcJIeSrLqehvhKb6KtHUTBUSNZTCgmOb91ytjE1W
 Xv+8dMwTLpsw8QndqVaxERRdzSxpDqhKkzjIzKI+vy8j1KbswPO2eFJnwvJT5IWUOi1ny5c3y
 kOM+OfR2Yn0Kx9FriiMG4JJZdRY/0SXmSUM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jul 2019 13:07:55 +0200

A single character (depending on a condition check) should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_putc=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/md/md-multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 6780938d2991..3bf6f97ea264 100644
=2D-- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -146,7 +146,8 @@ static void multipath_status(struct seq_file *seq, str=
uct mddev *mddev)
 	rcu_read_lock();
 	for (i =3D 0; i < conf->raid_disks; i++) {
 		struct md_rdev *rdev =3D rcu_dereference(conf->multipaths[i].rdev);
-		seq_printf (seq, "%s", rdev && test_bit(In_sync, &rdev->flags) ? "U" : =
"_");
+		seq_putc(seq,
+			 rdev && test_bit(In_sync, &rdev->flags) ? 'U' : '_');
 	}
 	rcu_read_unlock();
 	seq_putc(seq, ']');
=2D-
2.22.0

