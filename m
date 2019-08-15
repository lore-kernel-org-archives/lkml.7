Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F9C3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1496206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Bem7inz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfHOVrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:47:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37426 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733108AbfHOVrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:47:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so2459791wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=qR0uRCLWr0fwYhkZ5CZUa06tpLXq3JbP/69EsnC89D4=;
        b=Bem7inz1CjvAJpashAouOkDp5paYAW61fzhw3M49cprfC45G+LsXnAV0n7tv7IA1Bf
         CF/5R8GZfuWve90+Wnlm8MLINBs2nApNMbAXdxAnARp5eTZeF6qhdruHqkdo/Ofv28bV
         vagTnS0nSq8iI3hsQf3/34XjFp5JiTzUblnP5TNK9v1Wl4nTJkCEcXdYJo5na65jqYVU
         KsxKVlhJCQ6qeaImF9s2cXLo/H74n/yzVCL2U2XzdafC78H7QKD34OS9U6wb9vJxCLGQ
         zYK+D9TPoVDeYaluiJowHgPiLCWzuL0hpBANWtvG1/opo2yO6kcDABO/wLCb+lcrndA9
         NOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=qR0uRCLWr0fwYhkZ5CZUa06tpLXq3JbP/69EsnC89D4=;
        b=FtdAtm1RrtnjwMkg/4EntsUxwUzK6IDAl3PIM0iIDZqfx4rrN7ovL6RCydl1cmok1Z
         eDLEt3oCFwm0RLwPRabJo9Cy58B/Zbk2OF0FlTlzcsZf14Cr/c578UG3Iz3x4YtttVMO
         dfbZ3V5IJ9In7ePIHBuwD4AzR7pd6Cngl99JIln7QKEdFKo2S5PrXmn4wlbb9zGZ+sE2
         QLM/6d1hLRi2cPzt5DDbJINbAEOMpOjblcU3QfZiZFEPGOgTq4cGhMAYwnD7jEHKJEJc
         ycidSDhbpeRC0pOAN5SdaJDpm3Efai6gkfC9oVVvOs2olD9KEGOgcwCcyeq93QSXxE1x
         +Uzw==
X-Gm-Message-State: APjAAAWLgDdn1rOFQJ2SRfEHZ/obdR3mPkvUfbAI1/6762jzSbJKevK0
        wTgZ2MOx3wxWzNAGF4xblB0XNA==
X-Google-Smtp-Source: APXvYqyWy0qSQmX4RM6r8wecu8znhO37vR1LXTXQhqz0zduoqs3MAawZ8jCrg7wbV6BBSL3VELeAMg==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr4337532wma.80.1565905630259;
        Thu, 15 Aug 2019 14:47:10 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c19sm1965858wml.13.2019.08.15.14.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 14:47:09 -0700 (PDT)
Message-ID: <5d55d2dd.1c69fb81.df0fe.9eee@mx.google.com>
Date:   Thu, 15 Aug 2019 14:47:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Kernel: v5.3-rc1-84-g2ced74113e7f
X-Kernelci-Tree: clk
X-Kernelci-Report-Type: bisect
X-Kernelci-Branch: clk-next
Subject: clk/clk-next boot bisection: v5.3-rc1-84-g2ced74113e7f on panda
To:     tomeu.vizoso@collabora.com, Stephen Boyd <sboyd@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
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
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

clk/clk-next boot bisection: v5.3-rc1-84-g2ced74113e7f on panda

Summary:
  Start:      2ced74113e7f Merge branch 'clk-init-destroy' into clk-next
  Details:    https://kernelci.org/boot/id/5d55b8e459b514d41bf122b4
  Plain log:  https://storage.kernelci.org//clk/clk-next/v5.3-rc1-84-g2ced7=
4113e7f/arm/omap2plus_defconfig/gcc-8/lab-collabora/boot-omap4-panda.txt
  HTML log:   https://storage.kernelci.org//clk/clk-next/v5.3-rc1-84-g2ced7=
4113e7f/arm/omap2plus_defconfig/gcc-8/lab-collabora/boot-omap4-panda.html
  Result:     c82987e740d1 clk: Overwrite clk_hw::init with NULL during clk=
_register()

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       clk
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
  Branch:     clk-next
  Target:     panda
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     omap2plus_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit c82987e740d12be98b8ae8aa9221b8b9e2541271
Author: Stephen Boyd <sboyd@kernel.org>
Date:   Wed Jul 31 12:35:17 2019 -0700

    clk: Overwrite clk_hw::init with NULL during clk_register()
    =

    We don't want clk provider drivers to use the init structure after clk
    registration time, but we leave a dangling reference to it by means of
    clk_hw::init. Let's overwrite the member with NULL during clk_register()
    so that this can't be used anymore after registration time.
    =

    Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
    Cc: Doug Anderson <dianders@chromium.org>
    Signed-off-by: Stephen Boyd <sboyd@kernel.org>
    Link: https://lkml.kernel.org/r/20190731193517.237136-10-sboyd@kernel.o=
rg
    Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..efac620264a2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3484,9 +3484,9 @@ static int clk_cpy_name(const char **dst_p, const cha=
r *src, bool must_exist)
 	return 0;
 }
 =

-static int clk_core_populate_parent_map(struct clk_core *core)
+static int clk_core_populate_parent_map(struct clk_core *core,
+					const struct clk_init_data *init)
 {
-	const struct clk_init_data *init =3D core->hw->init;
 	u8 num_parents =3D init->num_parents;
 	const char * const *parent_names =3D init->parent_names;
 	const struct clk_hw **parent_hws =3D init->parent_hws;
@@ -3566,6 +3566,14 @@ __clk_register(struct device *dev, struct device_nod=
e *np, struct clk_hw *hw)
 {
 	int ret;
 	struct clk_core *core;
+	const struct clk_init_data *init =3D hw->init;
+
+	/*
+	 * The init data is not supposed to be used outside of registration path.
+	 * Set it to NULL so that provider drivers can't use it either and so that
+	 * we catch use of hw->init early on in the core.
+	 */
+	hw->init =3D NULL;
 =

 	core =3D kzalloc(sizeof(*core), GFP_KERNEL);
 	if (!core) {
@@ -3573,17 +3581,17 @@ __clk_register(struct device *dev, struct device_no=
de *np, struct clk_hw *hw)
 		goto fail_out;
 	}
 =

-	core->name =3D kstrdup_const(hw->init->name, GFP_KERNEL);
+	core->name =3D kstrdup_const(init->name, GFP_KERNEL);
 	if (!core->name) {
 		ret =3D -ENOMEM;
 		goto fail_name;
 	}
 =

-	if (WARN_ON(!hw->init->ops)) {
+	if (WARN_ON(!init->ops)) {
 		ret =3D -EINVAL;
 		goto fail_ops;
 	}
-	core->ops =3D hw->init->ops;
+	core->ops =3D init->ops;
 =

 	if (dev && pm_runtime_enabled(dev))
 		core->rpm_enabled =3D true;
@@ -3592,13 +3600,13 @@ __clk_register(struct device *dev, struct device_no=
de *np, struct clk_hw *hw)
 	if (dev && dev->driver)
 		core->owner =3D dev->driver->owner;
 	core->hw =3D hw;
-	core->flags =3D hw->init->flags;
-	core->num_parents =3D hw->init->num_parents;
+	core->flags =3D init->flags;
+	core->num_parents =3D init->num_parents;
 	core->min_rate =3D 0;
 	core->max_rate =3D ULONG_MAX;
 	hw->core =3D core;
 =

-	ret =3D clk_core_populate_parent_map(core);
+	ret =3D clk_core_populate_parent_map(core, init);
 	if (ret)
 		goto fail_parents;
 =

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2ae7604783dd..214c75ed62ae 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -299,7 +299,8 @@ struct clk_init_data {
  * into the clk API
  *
  * @init: pointer to struct clk_init_data that contains the init data shar=
ed
- * with the common clock framework.
+ * with the common clock framework. This pointer will be set to NULL once
+ * a clk_register() variant is called on this clk_hw pointer.
  */
 struct clk_hw {
 	struct clk_core *core;
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [21a2f76849f16d5a48d205b68e923694bc93aaf3] Merge branch 'clk-fixes'=
 into clk-next
git bisect good 21a2f76849f16d5a48d205b68e923694bc93aaf3
# bad: [2ced74113e7f0e2e7dd4c1b4c09b4020cc75fa23] Merge branch 'clk-init-de=
stroy' into clk-next
git bisect bad 2ced74113e7f0e2e7dd4c1b4c09b4020cc75fa23
# good: [7c9dc000bd199f1f90c4e9f1b2814c0dd0ebaa2c] Merge tag 'clk-meson-v5.=
4-1' of https://github.com/BayLibre/clk-meson into clk-meson
git bisect good 7c9dc000bd199f1f90c4e9f1b2814c0dd0ebaa2c
# bad: [47add07b00b64d8e698e5a6fb50bf900d1e89167] clk: milbeaut: Don't refe=
rence clk_init_data after registration
git bisect bad 47add07b00b64d8e698e5a6fb50bf900d1e89167
# good: [f4bfe4fff7ecb7aea391120608cfe1d9bc1a1f49] clk: sirf: Don't referen=
ce clk_init_data after registration
git bisect good f4bfe4fff7ecb7aea391120608cfe1d9bc1a1f49
# good: [735822a8b114f73289679178ff075b73facd4571] phy: ti: am654-serdes: D=
on't reference clk_init_data after registration
git bisect good 735822a8b114f73289679178ff075b73facd4571
# bad: [ad8bb39501bc50ec04c88f123273f3e7ea8394ca] clk: socfpga: deindent co=
de to proper indentation
git bisect bad ad8bb39501bc50ec04c88f123273f3e7ea8394ca
# bad: [c82987e740d12be98b8ae8aa9221b8b9e2541271] clk: Overwrite clk_hw::in=
it with NULL during clk_register()
git bisect bad c82987e740d12be98b8ae8aa9221b8b9e2541271
# first bad commit: [c82987e740d12be98b8ae8aa9221b8b9e2541271] clk: Overwri=
te clk_hw::init with NULL during clk_register()
---------------------------------------------------------------------------=
----
