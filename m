Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D48C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD61207FA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 15:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="m/T/kmTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfKIPcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 10:32:55 -0500
Received: from mout.web.de ([212.227.15.3]:59429 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfKIPcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 10:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573313448;
        bh=0TRIhuXTpZWJ9k/+KVQH24gg+fM7Xw4NmVteC0mbYD8=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=m/T/kmTv5DLPqdCqgeYXhrZ/ICGv4Lkw6c1gY+diLIyDpuld/0/Y8u8z4OTWpGGLb
         +IThsVXlhus3QJpFLXIAW9keWrjnkzzI4qYQGiLovkfw4AnVt1JY6bhkQemJTIIpUf
         AH9Up6FVky/V9lVZ+SL8PnGP7D5IcXsKq54Qtl6I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.82.67]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqXBp-1hymaH2YbZ-00e7lo; Sat, 09
 Nov 2019 16:30:48 +0100
To:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Anson Huang <b20788@freescale.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kohji Okuno <okuno.kohji@jp.panasonic.com>,
        Peng Fan <peng.fan@nxp.com>, Petr Mladek <pmladek@suse.com>,
        Richard Fontana <rfontana@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawn.guo@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ARM: imx6: Add missing put_device() call in
 imx6q_suspend_init()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <5acd7308-f6e1-4b1e-c744-bb2e5fdca1be@web.de>
Date:   Sat, 9 Nov 2019 16:30:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETuoqey96SmAJZIPrY4EohuOJG04PwwOUH7i61yRUz0OkVfhWSd
 7cR2iNt/n0apWdhjQcd8NhPcUbaaDc2gDX4Bx4QlqGj0FyQIkoQENsXlYGJv5KFXCDlMeWS
 CtBEO/mF1BWkU8ge9ZPNWUTdP/zkIBGEdt8pb2o1UDkw6UFitJfnpeWGcyw4iw4g8yYykLA
 4dJQA873p3zk6YNbBuuPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3xfO0GsM2lA=:bo9HHECv5EgE0zSiQebTBi
 pokYB6rYjzSwbobiZsZ6h0RSqmBdd06S280zqKS8NPvxZiIzAv9BIK+88obXPyqThnGFVhuG3
 Rivn51AVyK0SXTN29oYheuh8RyUuaVuy8/l2NuxFe5MTRz0xLeA7cWjhzUCBAtYDwZMFemaPj
 BdpIy+60AIvm4yU5wJQAy9PIdCoRC4B0pjb4oheM1R71RmL/8yct72SV0swq7KEDV/7sHHXR0
 jJ8aqvULmxYx+uThwjLz+iX/hRYbgGtzxtEfUBgsKE1SbMC++2pxpDOgHWBHQ9kdNnrQ9UPzU
 vipUecaNKhoSgYtjpGuQjjXPoxtCgJSTzr08cgwE9cLNg0tcAPdwu9S5Ic08ecg0ydIkpJpRQ
 4xto2+D5J8gbkqP0SxnT2a8oMCxteS3TRTA+L5UsDJhbwrRdSSmjYHDNmst2LYbjk39kl6kqe
 YyQlaMZ+djaukEVIFAQYDklp4CXs+IGdeZ1qre730IiYmQUo8nLhaORyInulhyC4YCusVVBJv
 Yob8qunvwR6Lz1gFs0x+yUXbefN9VKGWpH7p58tCMdPof47T6uup9KwEK3hnnAEJ0mYocT4o+
 DHvPAobFOyk4jq6zBJWZ7ry4QjcfCIivB8yhKNHrB3UI+0JjhmHqUZNIQI//rvijjKpxH+BDQ
 r0EZhemsw4jlONuTn5UX3EWU5/9Ifjb/HYr/9QQFdeaXRSLhy5vr5yUJMAuhhLJs0Dsku+sux
 b8yVlc1KFMpq2w44T3jEI0vjtlX5QIhBLGPr+7YwRfByqPRQKgxUhrfMnIMkWHXtSTCy04mWu
 vX2X7n7h2w1HZYjTsREeOfShk4ShT1ZWviAmWyUTph0MWYroPuh5PJCCabl2WvgslCF2WolQE
 YNxO70fzUCYZv9Y3SaiJDN3u+hXPVl3+aKLjxw5FAClJBLCu44n/jGvYKeznJDQ9Kw00/DmiR
 87ibmmVYnleaEpxbpFcp9Uc7Oprpz1XzOghAriddMboF5YlgUx1czL29mYvU0qBjUZZNgIM83
 MPuRIL7IL0Dvo0MdlXpMb9xgNamcta3BK0O/DWMmCM5QWp0DZLLgTyfsXKO06d1c5DEZiPvRW
 sZvtwIb9+wyQOEyrH1zhLPQkg/0J79n4X32JVwNKHmlZJ2cEt1TAqyaz891yO+xwOU+rcWqjy
 NA7cWy4zUofU/c4kDgTT/tl3ti9yMK7P+mcuHjVqxOkqCGopczQzHlHyqVhVtp8JdEOV+/3U5
 LzOPov8BJQPm+N1XW5N7mvN3VxZpWwHSzq8Jn7a67SadfSXa4JfZbHSnTQIk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 9 Nov 2019 16:16:33 +0100

A coccicheck run provided information like the following.

arch/arm/mach-imx/pm-imx6.c:586:1-7: ERROR: missing put_device;
call of_find_device_by_node on line 485, but without a corresponding
object release within this function.

Generated by: scripts/coccinelle/free/put_device.cocci

Thus adjust jump targets to fix the exception handling for this
function implementation.

Fixes: df595746fa69db2e36d89677df26ba51f9706c1b ("ARM: imx: add suspend in=
 ocram support for i.mx6q")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/mach-imx/pm-imx6.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 1c0ecad3620e..baf3b47601af 100644
=2D-- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -493,14 +493,14 @@ static int __init imx6q_suspend_init(const struct im=
x6_pm_socdata *socdata)
 	if (!ocram_pool) {
 		pr_warn("%s: ocram pool unavailable!\n", __func__);
 		ret =3D -ENODEV;
-		goto put_node;
+		goto put_device;
 	}

 	ocram_base =3D gen_pool_alloc(ocram_pool, MX6Q_SUSPEND_OCRAM_SIZE);
 	if (!ocram_base) {
 		pr_warn("%s: unable to alloc ocram!\n", __func__);
 		ret =3D -ENOMEM;
-		goto put_node;
+		goto put_device;
 	}

 	ocram_pbase =3D gen_pool_virt_to_phys(ocram_pool, ocram_base);
@@ -523,7 +523,7 @@ static int __init imx6q_suspend_init(const struct imx6=
_pm_socdata *socdata)
 	ret =3D imx6_pm_get_base(&pm_info->mmdc_base, socdata->mmdc_compat);
 	if (ret) {
 		pr_warn("%s: failed to get mmdc base %d!\n", __func__, ret);
-		goto put_node;
+		goto put_device;
 	}

 	ret =3D imx6_pm_get_base(&pm_info->src_base, socdata->src_compat);
@@ -570,7 +570,7 @@ static int __init imx6q_suspend_init(const struct imx6=
_pm_socdata *socdata)
 		&imx6_suspend,
 		MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));

-	goto put_node;
+	goto put_device;

 pl310_cache_map_failed:
 	iounmap(pm_info->gpc_base.vbase);
@@ -580,6 +580,8 @@ static int __init imx6q_suspend_init(const struct imx6=
_pm_socdata *socdata)
 	iounmap(pm_info->src_base.vbase);
 src_map_failed:
 	iounmap(pm_info->mmdc_base.vbase);
+put_device:
+	put_device(&pdev->dev);
 put_node:
 	of_node_put(node);

=2D-
2.24.0

