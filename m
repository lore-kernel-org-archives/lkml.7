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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A371EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683F620659
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DXIZYB0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfGAP2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:28:19 -0400
Received: from mout.web.de ([212.227.17.12]:39627 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfGAP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561994894;
        bh=jNhErwSMTeNELfsM9KLdpW5pjmYfL5y8hYO3Mt6I18k=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=DXIZYB0p6EBxANR/9bvZ+Qsbq7vZiFK+xonemPQg/TT+uPB8w00fx2SOs647CkhHx
         mKbPMxwNoiymJKXQcignX6VCqvavfKkLVOtWs17rDOJo2lkMlFEqaf6n4wAp96Anms
         sIAXZqqANFn5UYifXWOVC2P4ILskrflz9QArUCTs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6DuI-1iRqa41w42-00yBFi; Mon, 01
 Jul 2019 17:28:14 +0200
To:     linux-raid@vger.kernel.org, Shaohua Li <shli@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] md/raid: Replace a seq_printf() call by seq_putc() in three
 functions
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <50f0f51c-16c6-8d31-b265-8a007e6f7251@web.de>
Date:   Mon, 1 Jul 2019 17:28:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ywUpMb787bQvtiUb0KKGmPA/weiTP8ya+diTTLJcflrI6wQK1P6
 lvV0C8Ou5LDpkmLBa3OR5+7+dre/phbamNmCxO6/D9y6WJ4Lvf8Ti7wT9V5FTZ7pdKZrOfZ
 e4sXhAmr8dIaXg2AF5PT0oEIyH51NbbrIeNfoxXjN79vWYxCFN0vdTVcjh35mSRjMrZgyxe
 CJmm47OPxZhoNlVo+CgPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kBCzHH4kDGE=:zfbc1xODO51Rdqp4DdDvZr
 rBnMPFTAbrFw3oy7CuEjHyHkGkvcsptVSc31RSNG3dGSYC2Qh+tX6PzsQcVF9XqJJcB9qFKu2
 cZ9LmqJunaE6ZL0gf6vgMxjckS+KetaOxPVMXN6Vl9WjO4iQT2kMWIp/XVQlRzCZ6miCr+/+l
 T6N8ggJXbNoPMV88qN1uGcU0xIQAtqXL0pmLSLHFq01VhpSS14VGZ1SuNSFZN7ijbocRYL5x6
 ySRI0WLhGZl7PMIy1gdh36MgGx/LGXKYFH8n5XEyxMNlZ8cUx1IgdEK/gjyQ71AAJUETQ8PuX
 /qk6y85M5wuTwK+uh9IDri+WxKUd6ou/QX8a9awV1v7y6L1elZTHFChd3WTMhBlbiD7iA5PPw
 eYHFKs64xhHb43fwEzEPpplBUIQzWyiQxd3LOoyqs8ui6GqxHupyAcgvi5Tvw0cbjpGqClAnG
 /OwVKFMSYOVC4GtpotOG7F/gBAYLn9lO5lxLygNH4FPhhiSd2dcVWKG1y9/VWmkm6LDhJAlY/
 wrkpeetUvaRaMrDgQA0IjEa1+cgHPoqV1/DFGVe8vnQfMRGqBRbfqxH4WO+BqhD5FXTNcaAa1
 n0r6zQ9FlRgZs/4+NUfJsn2RMD2JatEMjoKL45MyTc/pvhqFu7BKiKsDVSWsmXcvYv84SWBZV
 rbhnUEmgVvVhIHx92HmRBHHzqTbPxa+CAZUv3+Xzmau3KcLlMG5F4hKq5ANCaiNqyrIN7a6OZ
 9LdFaeoXXqiS6NVq4OiXBAXDH9309HBHbfqAgDBHTW3IpG/GmwA0P43FLs0ElcdS20dx7UhI7
 7zbs6lCDyNPZWBp9T7aBk1yTf0rKHjdAqZTG5ds/mfWhchpy4d/pvwnfWbkTTZngJT7uun0K/
 yH618zIgi5dw02tNu3L22MpDOXKsVnCyf5Ioes51OeAQr8RalqxlFlOaMRg4wMIOC2jSYLZ4u
 bUmbRbzNqWu0wsLR86X6FUuYfdXP047O4ihCszn0XbzHnmzf+N+2W8ROX9nrUl/GR+57US1oo
 XIBMWk4cRIpg177XQ4ancEHYFpjsVvMPCxUvmb1ajhqAaqFDNl5rB+Wb8E9TYvft8RjFV5Mqf
 WP8jEDeE6lu63J5TGDfBobab7flWsLSc3S9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jul 2019 17:10:13 +0200

A single character (depending on a condition check) should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_putc=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/md/raid1.c  | 4 ++--
 drivers/md/raid10.c | 3 ++-
 drivers/md/raid5.c  | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 34e26834ad28..769d79a1d2cf 100644
=2D-- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1597,7 +1597,7 @@ static void raid1_status(struct seq_file *seq, struc=
t mddev *mddev)
 	rcu_read_lock();
 	for (i =3D 0; i < conf->raid_disks; i++) {
 		struct md_rdev *rdev =3D rcu_dereference(conf->mirrors[i].rdev);
-		seq_printf(seq, "%s",
-			   rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
+		seq_putc(seq,
+			 rdev && test_bit(In_sync, &rdev->flags) ? 'U' : '_');
 	}
 	rcu_read_unlock();
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 8a1354a08a1a..4e7da5dcbf86 100644
=2D-- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1572,6 +1572,7 @@ static void raid10_status(struct seq_file *seq, stru=
ct mddev *mddev)
 	rcu_read_lock();
 	for (i =3D 0; i < conf->geo.raid_disks; i++) {
 		struct md_rdev *rdev =3D rcu_dereference(conf->mirrors[i].rdev);
-		seq_printf(seq, "%s", rdev && test_bit(In_sync, &rdev->flags) ? "U" : "=
_");
+		seq_putc(seq,
+			 rdev && test_bit(In_sync, &rdev->flags) ? 'U' : '_');
 	}
 	rcu_read_unlock();
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3de4e13bde98..4b0e93869801 100644
=2D-- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7510,6 +7510,7 @@ static void raid5_status(struct seq_file *seq, struc=
t mddev *mddev)
 	rcu_read_lock();
 	for (i =3D 0; i < conf->raid_disks; i++) {
 		struct md_rdev *rdev =3D rcu_dereference(conf->disks[i].rdev);
-		seq_printf (seq, "%s", rdev && test_bit(In_sync, &rdev->flags) ? "U" : =
"_");
+		seq_putc(seq,
+			 rdev && test_bit(In_sync, &rdev->flags) ? 'U' : '_');
 	}
 	rcu_read_unlock();
=2D-
2.22.0

