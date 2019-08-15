Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB593C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 03:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D152208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 03:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="vgyMxZyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfHODf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 23:35:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42987 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbfHODf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 23:35:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so993146wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 20:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=tzH18a4Yz+szTgI8M3pVorYGS+ZN6NxiMdBI+qyWdjE=;
        b=vgyMxZyhj9sPu8N86M18yhpSAVOvtqbA0BjeL/5BXcEVXa55Xf1sJl1jJvC62tFJ1y
         O3BPjp/yvabiopeEcfCej+O1+AYdLgbFTCVSI2yBR7fIb7wlEsfgl4DMbW6WgB6W5QKu
         X8goyCOJzQ1RVEqCBZ0ifTlASgMbO39+mDKcUiBzRJoQc8027TJjND32ygg/SGhgk1t9
         HSDB6It0V51XwRIZ/bYBqleGpJiqiFtU/OWiebsVVb5ZVmHWvz30Ewoe16dgUm7PJIDp
         EidoTgCYliZPJvD3dK6ivJOAczBtGkl2dyxVU+lSBgSmVZuB2/qp5koqK6/Q1heCxIhN
         ki6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=tzH18a4Yz+szTgI8M3pVorYGS+ZN6NxiMdBI+qyWdjE=;
        b=Yb+c5FltVR8onut1d8Sza7A/OFfCdB5fJygMsX5RM+468Ir0gRuK6G+pUT93ItzDJr
         sQJFe9bzbA0fCCMgO1a9S5C89Mlv/u0z4mTi2ZyyQwBkjo0uV2VzaDC0QM45Kt8GlOgv
         1ez75Y9nJhV1x3RgeLqPYEfAJiqIdUAtGsq5l21BCxpCoKYrpK71WuGOe3gUYovFoU3r
         NqfoyhPw82NBAXwg0jlMSgWHDZ7utYT8EqhNzrHmMubFXErz8GqWFW54pb4Em5BJWH/I
         wTp16NeWvnuTwIAVpenjQp6lOZf2Da0ANzQcMAXOQjt6S4Y5dsBgl0YBbR9MHpD9i1Xw
         dDkA==
X-Gm-Message-State: APjAAAXTXJgVxaa15X+vXbtxUhE6SR9PVKRoA8VySKWtrIkRZ/C/k1ss
        0Q8WTCeKS87CJIsTQvLWc6nbbg==
X-Google-Smtp-Source: APXvYqy4DftgVp2X8IKxQg4KxvqEbBb17jHrydLbirOURnLc4p4A3fJ9KdvCzP296F82C4xOgjKc5A==
X-Received: by 2002:a05:6000:1041:: with SMTP id c1mr2584396wrx.99.1565840125867;
        Wed, 14 Aug 2019 20:35:25 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id p9sm1430761wru.61.2019.08.14.20.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 20:35:25 -0700 (PDT)
Message-ID: <5d54d2fd.1c69fb81.e13e5.7422@mx.google.com>
Date:   Wed, 14 Aug 2019 20:35:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Kernel: v5.3-rc1-79-g31f58d2f58cb
X-Kernelci-Tree: clk
X-Kernelci-Report-Type: bisect
X-Kernelci-Branch: clk-next
Subject: clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on
 sun8i-h3-libretech-all-h3-cc
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

clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on sun8i-h3-libretec=
h-all-h3-cc

Summary:
  Start:      31f58d2f58cb Merge branch 'clk-meson' into clk-next
  Details:    https://kernelci.org/boot/id/5d54b9d159b514324cf1226e
  Plain log:  https://storage.kernelci.org//clk/clk-next/v5.3-rc1-79-g31f58=
d2f58cb/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/boot-sun8i=
-h3-libretech-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//clk/clk-next/v5.3-rc1-79-g31f58=
d2f58cb/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/boot-sun8i=
-h3-libretech-all-h3-cc.html
  Result:     c82987e740d1 clk: Overwrite clk_hw::init with NULL during clk=
_register()

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       clk
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
  Branch:     clk-next
  Target:     sun8i-h3-libretech-all-h3-cc
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
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
# bad: [31f58d2f58cb0a8fbf58af88b6a5133bed23bf9b] Merge branch 'clk-meson' =
into clk-next
git bisect bad 31f58d2f58cb0a8fbf58af88b6a5133bed23bf9b
# good: [1d97657a4794ab23b47bd9921978ddd82569fcf4] Merge branch 'v5.4/dt' i=
nto v5.4/drivers
git bisect good 1d97657a4794ab23b47bd9921978ddd82569fcf4
# bad: [c82987e740d12be98b8ae8aa9221b8b9e2541271] clk: Overwrite clk_hw::in=
it with NULL during clk_register()
git bisect bad c82987e740d12be98b8ae8aa9221b8b9e2541271
# good: [e22cce5f419f3c5aa07c8b0d2f8860d49980dbae] clk: qcom: Don't referen=
ce clk_init_data after registration
git bisect good e22cce5f419f3c5aa07c8b0d2f8860d49980dbae
# good: [3445b1287ac6cf410ecd4536b880172b98e6133d] clk: socfpga: Don't refe=
rence clk_init_data after registration
git bisect good 3445b1287ac6cf410ecd4536b880172b98e6133d
# good: [735822a8b114f73289679178ff075b73facd4571] phy: ti: am654-serdes: D=
on't reference clk_init_data after registration
git bisect good 735822a8b114f73289679178ff075b73facd4571
# first bad commit: [c82987e740d12be98b8ae8aa9221b8b9e2541271] clk: Overwri=
te clk_hw::init with NULL during clk_register()
---------------------------------------------------------------------------=
----
