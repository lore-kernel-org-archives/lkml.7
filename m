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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36113C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38A021881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="o84rgSNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfICRVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:21:12 -0400
Received: from mout.web.de ([212.227.17.11]:39577 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfICRVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567531253;
        bh=FXHer4LS/K6DO9RLxyjvUffNhlgAajLjnHLokdZTuZk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=o84rgSNYxwoLLP3G7J7mBcc8avDaEYVm2p6Bq3gIrhzlTBmlsxLRdiBQ8MTTzmzMJ
         acW6Wm1qQRM39X2RpzpBwP/64QLAA8wTEN+/0nsf8bDONcHqqqR8pvJxSan80vh/9V
         en3p3WlkKEHPq+VYd1XdP6eeUBbiGf0VC0spcqtU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ls91n-1iAKxm2SAZ-013tMe; Tue, 03
 Sep 2019 19:20:53 +0200
To:     kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Anders Larsen <al@alarsen.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fs/qnx: Delete unnecessary checks before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <056c8b8e-abaa-8856-4953-118d14048ddc@web.de>
Date:   Tue, 3 Sep 2019 19:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pMN6nlSgPWYDBfgtXpnS+8dkS6Q00ugg+Deh+COvFZ/eMNfXV+Z
 NHh+ypzuJWYpWK4/DUqq597tAJVRB1OXAUJOqgwhIA1RUBgWvEbGNcrBRmAD2IJQNa13uED
 S8m6tAvf+3dJG/oM9qF0AhxWbXY6lB8dGT0jin4jC/2sMnJVdE5LkpKGsA8rfRu0RMN0H3W
 eniXrPi5JknsVcUebk/GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r2+FVradAVI=:n4cRroHg61TC1f0lG+9gw7
 oDZWgvsmHAfoKga2REE7MhkH87CFMKySkig6jZBIcztdZFU/0uz3JLS8e6ltB3GWHrsnymhVw
 oUnzdS4j/njUehvLP2fyhMfVc7Yf23crRXLLBFHBF1bHWBLzTcltWL+7U/HuFP9UUKjckNhxG
 nteBso8A7LiboGMQM4Xr4IZZk+uN+At8jHY7cM0e3JriE/gMfGzZA+6B0zrovKNg/sAwFrn9O
 AXWjLrV5BXpJ3ypa3lZg25frvAKoBVGXrsCl+ZwlRToGOJsQObEjfiZlC+0RNw3wexK59Sb/8
 kULEtrwsMH2/+AyrDmiwl4GzDc42QeUGc2fXyTdqfhpIXnpQrVbC569FCKpZ2oKg0P6QfeCYN
 84I8IB4Z6b02v8r+/4r8suyOCRomICgQYZ1jAxFn9IkDDUTJYT2zdC9CgfUYqvJKEcGd6Ar9D
 whE5f7GO//2JpqISeJwt2ncArBsTniz+zrMWDrMc8ccWiCudF78wcGaJJVRzm2c9NreBsHGGy
 wDaz2iOZOMKzcU93rLh8Hcv4vpP2FjgkcdMEM63nDMQWdDp4G56rBMHKX+jt4Jefj6b21fnCl
 c076RgyPBhe/lRentFeggXukqkbF6Y5SfV8u2ri0cRZTwPeCS4UG1LWk77IE0ZdvnB4/Rm2mL
 iUN8dyEAt7tIeSYci2cXMiKxDzz0qmjgHcA8N5K1oxblj2nya5BL9TkLifIpvECnirbuALcpT
 barcwSHlTwyjEquQAZlwTNWvTNuuN158dcJCOdYGvD+0SJNruDwZGTOOvOuK15M9/BGR7haEw
 zmEU8Ie+usIKgK+1sdv70xEU/ghyNnqSZZzIMf+HUKpMaR47Je60LHUpa58m2qE+783KmHezE
 B31cdFiVdAi0lAKGCrLMU5eWXl+miCaLN8CSNnh4quF4/Mwd6rDbDtyOgcQlyBU3SCaLeJq7w
 1v0dRk+08L6nQwY5GQGD6miWBwxr06Na527xqaQjJrOMm/K7GFIL4z/P1ORVmO+brjHi3PGgv
 xAixsETXIkKybXnuw92qEpUJpBofsCeQ4hczOGEs+498VajWuvU+eGdfIhOeYR9x5O7m/ypJg
 cEvu9/edgkO1B/mnGe/X9ssW/R7NxcUAnQWcqiDR6Brw6FBt9JWjtXcH8GChiM6vvYtvgFCV+
 5KBcGpNcMnUhvtXpynnuInZsJoefE6ktplDxK5BRaW0rw3LfxwyW5mqmc80dqxuAtyJNoP2q/
 +3KYc8rN/EAFVrQxX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 19:15:09 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/qnx4/inode.c | 3 +--
 fs/qnx6/inode.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e8da1cde87b9..018a4c657f7c 100644
=2D-- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -118,8 +118,7 @@ unsigned long qnx4_block_map( struct inode *inode, lon=
g iblock )
 				bh =3D NULL;
 			}
 		}
-		if ( bh )
-			brelse( bh );
+		brelse(bh);
 	}

 	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %ld =3D %ld\n",ib=
lock,inode->i_ino,block));
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 345db56c98fd..083170541add 100644
=2D-- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -472,10 +472,8 @@ static int qnx6_fill_super(struct super_block *s, voi=
d *data, int silent)
 out1:
 	iput(sbi->inodes);
 out:
-	if (bh1)
-		brelse(bh1);
-	if (bh2)
-		brelse(bh2);
+	brelse(bh1);
+	brelse(bh2);
 outnobh:
 	kfree(qs);
 	s->s_fs_info =3D NULL;
=2D-
2.23.0

