Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA51DC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9FD20859
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="kbYWVTwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfDWAQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:16:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35690 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfDWAQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:16:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so16377072wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=bNcR4GariwcIWB7Ldm6PZ7yAXAc0Mrz3En4tWQRCg7U=;
        b=kbYWVTwG8SbTFcwewaa8Q247VrcCuwpA62MjRuCq3BA5hU7raNQeF6jRv5IkbLQFXV
         5bT6WIdBUykZKfLePQYq90a9e0fzuVc7YtwpaEwxOzf5cxFHP3QXxvIcBDhEytJlbkcO
         3c5oVI/xAwoDLWWrzK0FuRYXH02swaI+J7lMGSN/jmrTEGN7ZJ2Sz06gOR88edz/vT1M
         fLiH4XtfE/OASp0EDZnP7WUBjRWAQi73KmYDdAQJPJtUV59ir6Hs9YmqsX5278wtPQfb
         1ZNeJwOHWUV9sqCoYhXYQPYyKfeN68WSg6RuIs/avPEMBIGpjwxv6wPSqkjd0SmIs9d0
         I/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=bNcR4GariwcIWB7Ldm6PZ7yAXAc0Mrz3En4tWQRCg7U=;
        b=ghad2lO/qRfaUye5JgOCTtERMKtbuMkP36cWRarwrWzRqhruoI3pSPDSI1EDoWb8gm
         68ieegGllic+QP53KCF9nRsLB/7hnL3+ROZyqP59A+pUALNHdY8Jbb/CH/G8iLkLEYHN
         lOL8D1wOJWgvPgojRWAljyendXpFFXnQzCn2277pyMIkvEe9h5Ag2zuy+LXQmTq/VvQt
         iU9py+qguJnbxqNugLxhedxQrUTpbYMTEhRiu8lJlFzb5tL1U1oWJ+R7qHY3jA89EvYY
         sSEflIJIa5kx0iyp6Dhrkmc+GNfZ9ix0rfG2tAkKgkxpapBbp9KyVUlM7F7/BgQRBPFp
         JTpA==
X-Gm-Message-State: APjAAAV6L675p99NwLPcZPYsAwPSR+TNLa7E7yrjrw7vethxNELMIdoD
        HPSer1FFtSMWeum3G/gCwhyAQA==
X-Google-Smtp-Source: APXvYqwyAPYYp1H22CooFegAFUbiag6x5/U80iFNFC9OJ4prSu4lle6EU31DBRzalOWBiwzWdOqWcA==
X-Received: by 2002:a1c:4cf:: with SMTP id 198mr30935wme.125.1555978605379;
        Mon, 22 Apr 2019 17:16:45 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id w10sm11011375wrv.8.2019.04.22.17.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 17:16:44 -0700 (PDT)
Message-ID: <5cbe596c.1c69fb81.e252.b9d0@mx.google.com>
Date:   Mon, 22 Apr 2019 17:16:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.1-rc1-142-ga55b079c961b
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: clk
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: clk-next
Subject: clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
To:     Jeffrey Hugo <jhugo@codeaurora.org>, tomeu.vizoso@collabora.com,
        Stephen Boyd <sboyd@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda

Summary:
  Start:      a55b079c961b Merge branch 'clk-hisi' into clk-next
  Details:    https://kernelci.org/boot/id/5cbe3cdb59b514fd22fe6025
  Plain log:  https://storage.kernelci.org//clk/clk-next/v5.1-rc1-142-ga55b=
079c961b/arm/omap2plus_defconfig/gcc-7/lab-baylibre/boot-omap4-panda.txt
  HTML log:   https://storage.kernelci.org//clk/clk-next/v5.1-rc1-142-ga55b=
079c961b/arm/omap2plus_defconfig/gcc-7/lab-baylibre/boot-omap4-panda.html
  Result:     ecbf3f1795fd clk: fixed-factor: Let clk framework find parent

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       clk
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
  Branch:     clk-next
  Target:     panda
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-7
  Config:     omap2plus_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit ecbf3f1795fda56122632c1d024cfd0d3f4fe353
Author: Stephen Boyd <sboyd@kernel.org>
Date:   Fri Apr 12 11:31:50 2019 -0700

    clk: fixed-factor: Let clk framework find parent
    =

    Convert this driver to a more modern way of specifying parents now that
    we have a way to specify clk parents by DT index. This lets us nicely
    avoid a problem where a parent clk name isn't know because the parent
    clk hasn't been registered yet.
    =

    Cc: Miquel Raynal <miquel.raynal@bootlin.com>
    Cc: Jerome Brunet <jbrunet@baylibre.com>
    Cc: Russell King <linux@armlinux.org.uk>
    Cc: Michael Turquette <mturquette@baylibre.com>
    Cc: Jeffrey Hugo <jhugo@codeaurora.org>
    Cc: Chen-Yu Tsai <wens@csie.org>
    Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
    Signed-off-by: Stephen Boyd <sboyd@kernel.org>

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 241b3f8c61a9..5b09f2cdb7de 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -64,12 +64,14 @@ const struct clk_ops clk_fixed_factor_ops =3D {
 };
 EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
 =

-struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
-		const char *name, const char *parent_name, unsigned long flags,
-		unsigned int mult, unsigned int div)
+static struct clk_hw *
+__clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
+		const char *name, const char *parent_name, int index,
+		unsigned long flags, unsigned int mult, unsigned int div)
 {
 	struct clk_fixed_factor *fix;
 	struct clk_init_data init;
+	struct clk_parent_data pdata =3D { .index =3D index };
 	struct clk_hw *hw;
 	int ret;
 =

@@ -85,11 +87,17 @@ struct clk_hw *clk_hw_register_fixed_factor(struct devi=
ce *dev,
 	init.name =3D name;
 	init.ops =3D &clk_fixed_factor_ops;
 	init.flags =3D flags | CLK_IS_BASIC;
-	init.parent_names =3D &parent_name;
+	if (parent_name)
+		init.parent_names =3D &parent_name;
+	else
+		init.parent_data =3D &pdata;
 	init.num_parents =3D 1;
 =

 	hw =3D &fix->hw;
-	ret =3D clk_hw_register(dev, hw);
+	if (dev)
+		ret =3D clk_hw_register(dev, hw);
+	else
+		ret =3D of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(fix);
 		hw =3D ERR_PTR(ret);
@@ -97,6 +105,14 @@ struct clk_hw *clk_hw_register_fixed_factor(struct devi=
ce *dev,
 =

 	return hw;
 }
+
+struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div)
+{
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, -1,
+					      flags, mult, div);
+}
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
 =

 struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
@@ -143,11 +159,10 @@ static const struct of_device_id set_rate_parent_matc=
hes[] =3D {
 	{ /* Sentinel */ },
 };
 =

-static struct clk *_of_fixed_factor_clk_setup(struct device_node *node)
+static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *clk_name =3D node->name;
-	const char *parent_name;
 	unsigned long flags =3D 0;
 	u32 div, mult;
 	int ret;
@@ -165,30 +180,28 @@ static struct clk *_of_fixed_factor_clk_setup(struct =
device_node *node)
 	}
 =

 	of_property_read_string(node, "clock-output-names", &clk_name);
-	parent_name =3D of_clk_get_parent_name(node, 0);
 =

 	if (of_match_node(set_rate_parent_matches, node))
 		flags |=3D CLK_SET_RATE_PARENT;
 =

-	clk =3D clk_register_fixed_factor(NULL, clk_name, parent_name, flags,
-					mult, div);
-	if (IS_ERR(clk)) {
+	hw =3D __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, 0,
+					    flags, mult, div);
+	if (IS_ERR(hw)) {
 		/*
-		 * If parent clock is not registered, registration would fail.
 		 * Clear OF_POPULATED flag so that clock registration can be
 		 * attempted again from probe function.
 		 */
 		of_node_clear_flag(node, OF_POPULATED);
-		return clk;
+		return ERR_CAST(hw);
 	}
 =

-	ret =3D of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	ret =3D of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
 	if (ret) {
-		clk_unregister(clk);
+		clk_hw_unregister_fixed_factor(hw);
 		return ERR_PTR(ret);
 	}
 =

-	return clk;
+	return hw;
 }
 =

 /**
@@ -203,17 +216,17 @@ CLK_OF_DECLARE(fixed_factor_clk, "fixed-factor-clock",
 =

 static int of_fixed_factor_clk_remove(struct platform_device *pdev)
 {
-	struct clk *clk =3D platform_get_drvdata(pdev);
+	struct clk_hw *clk =3D platform_get_drvdata(pdev);
 =

 	of_clk_del_provider(pdev->dev.of_node);
-	clk_unregister_fixed_factor(clk);
+	clk_hw_unregister_fixed_factor(clk);
 =

 	return 0;
 }
 =

 static int of_fixed_factor_clk_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 =

 	/*
 	 * This function is not executed when of_fixed_factor_clk_setup
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [21eb35a1ae4db08d32e2b5a8d9fe476c16056511] Merge commit 'tags/clk-f=
ixes-for-linus^0' into clk-next
git bisect good 21eb35a1ae4db08d32e2b5a8d9fe476c16056511
# bad: [a55b079c961be4c94df8616583d0182b51b868a5] Merge branch 'clk-hisi' i=
nto clk-next
git bisect bad a55b079c961be4c94df8616583d0182b51b868a5
# good: [b6c3e3069dadab64103f62cbdf19e5f07c42cc04] Merge branch 'clk-samsun=
g' into clk-next
git bisect good b6c3e3069dadab64103f62cbdf19e5f07c42cc04
# good: [3f644cdb2351fe21cded6ee1e5c13ea7905c3a64] Merge branch 'clk-zynq' =
into clk-next
git bisect good 3f644cdb2351fe21cded6ee1e5c13ea7905c3a64
# good: [dde4eff47c82c52a72af333d9e55370eee6d95d6] clk: Look for parents wi=
th clkdev based clk_lookups
git bisect good dde4eff47c82c52a72af333d9e55370eee6d95d6
# bad: [e04cb6e358cbcdce56cda317725131252ecf6ccd] Merge branch 'clk-parent-=
rewrite-1' into clk-next
git bisect bad e04cb6e358cbcdce56cda317725131252ecf6ccd
# bad: [ecbf3f1795fda56122632c1d024cfd0d3f4fe353] clk: fixed-factor: Let cl=
k framework find parent
git bisect bad ecbf3f1795fda56122632c1d024cfd0d3f4fe353
# good: [601b6e93304a65f8f7c37168763ab9ba5b195ce5] clk: Allow parents to be=
 specified via clkspec index
git bisect good 601b6e93304a65f8f7c37168763ab9ba5b195ce5
# first bad commit: [ecbf3f1795fda56122632c1d024cfd0d3f4fe353] clk: fixed-f=
actor: Let clk framework find parent
---------------------------------------------------------------------------=
----
