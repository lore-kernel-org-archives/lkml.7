Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A92CC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEA820731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ceQRv59a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgAFWpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:45:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFWpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:45:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so51708010wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=4jaeLvpP2qneskbzJTPZb7U3dBVtOsfHYgFOFKC8CSE=;
        b=ceQRv59apd5RpJqDwNEMWEv1QSI4nRrWshN4esrTz6kOgmt6LLE2UDdkTzqHT46VCv
         Gl9mFUqXMnOqI/DKnDdivDG3ppApsZhq3w2QZXxcIHBDfs+HAOqEznS5c9OVvRkHGz14
         ZStwoXk1OySrS6AYxa/EwNyR0fosmi3jyAtBwhCFo7Nv9lGC4y5liLlKRuOU7Bh80/Q8
         iCEW6KOQqtz2uefs5h37+3R3YROe80jGE0Hbc8DzUfJGUBWpiZwVvxYobajsgDWjMCCC
         /TOn5yjdSsI+0Vz4Ry40CtLcRu59GN4Jr8EQgtbzs4RXmCRPbxrH2M6H1nGz3mARD7IF
         NTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=4jaeLvpP2qneskbzJTPZb7U3dBVtOsfHYgFOFKC8CSE=;
        b=o7YEv4U/Ouh+9vnLKMMdSSGpS60LKV+qeJgUJViTlpTW4mLu36FuqQ2bqQB9Fk3sIY
         n7j72bRqIdUIpBOnWfLj+4+6TyIWdQwiD8j8uwokeEu6WyIp8cNmMinWCBOUJnCtFMfF
         qh+UYWSMVwRIwfzCsuNLK4dRqQbpbYWkM0kw3NbcdQ9eYITXOX6FB/HBLz17DB/ouFwZ
         ozqwLN7MEJ0dFhOp1hS0IvpA6M1szinwsX+q+t80os4A442xmS6zgAELxXZhH0WyeXwh
         fzZ6hkGlnxsfujH38q4fG7iFLoOBmezYyj2QxXwBnhI/ySO6FdeT0mrYorEUh77FVNr/
         vOOQ==
X-Gm-Message-State: APjAAAVidWwVlyPFNNHw3jA3R0HI7TUSQC3E1aIay2BC5FbwYh10f/jx
        aly6Ayg7sMT8+bGXw8oW6wLO1g==
X-Google-Smtp-Source: APXvYqysJ8O6JvRmm0pORN1iwP7wjJcGIUjb1Yaud3LIttL/RMspbfKVfE21IM2u8wpb261O+TNvxQ==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr99028991wrr.32.1578350749403;
        Mon, 06 Jan 2020 14:45:49 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u13sm25216150wmd.36.2020.01.06.14.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:45:48 -0800 (PST)
Message-ID: <5e13b89c.1c69fb81.c8c2e.1609@mx.google.com>
Date:   Mon, 06 Jan 2020 14:45:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Kernel: next-20200106
X-Kernelci-Tree: next
X-Kernelci-Report-Type: bisect
X-Kernelci-Branch: master
Subject: next/master bisection: boot on sun7i-a20-olinuxino-lime2
To:     guillaume.tucker@collabora.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        tomeu.vizoso@collabora.com, mgalka@collabora.com,
        Alexandre Torgue <alexandre.torgue@st.com>, broonie@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

next/master bisection: boot on sun7i-a20-olinuxino-lime2

Summary:
  Start:      9eb1b48ca4ce Add linux-next specific files for 20200106
  Details:    https://kernelci.org/boot/id/5e12e663019cf4926197312f
  Plain log:  https://storage.kernelci.org//next/master/next-20200106/arm/m=
ulti_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/boot-sun7i-a20-olinuxin=
o-lime2.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20200106/arm/m=
ulti_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/boot-sun7i-a20-olinuxin=
o-lime2.html
  Result:     5253fe05bb47 phy: core: Add consumer device link support

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     master
  Target:     sun7i-a20-olinuxino-lime2
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 5253fe05bb47a2402f471d76078b3dcc66442d6c
Author: Alexandre Torgue <alexandre.torgue@st.com>
Date:   Mon Nov 4 15:37:13 2019 +0100

    phy: core: Add consumer device link support
    =

    In order to enforce suspend/resume ordering, this commit creates link
    between phy consumers and phy devices. This link avoids to suspend phy
    before phy consumers.
    =

    Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b04f4fe85ac2..8dfb4868c8c3 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -29,7 +29,7 @@ static void devm_phy_release(struct device *dev, void *re=
s)
 {
 	struct phy *phy =3D *(struct phy **)res;
 =

-	phy_put(phy);
+	phy_put(dev, phy);
 }
 =

 static void devm_phy_provider_release(struct device *dev, void *res)
@@ -566,12 +566,12 @@ struct phy *of_phy_get(struct device_node *np, const =
char *con_id)
 EXPORT_SYMBOL_GPL(of_phy_get);
 =

 /**
- * phy_put() - release the PHY
- * @phy: the phy returned by phy_get()
+ * of_phy_put() - release the PHY
+ * @phy: the phy returned by of_phy_get()
  *
- * Releases a refcount the caller received from phy_get().
+ * Releases a refcount the caller received from of_phy_get().
  */
-void phy_put(struct phy *phy)
+void of_phy_put(struct phy *phy)
 {
 	if (!phy || IS_ERR(phy))
 		return;
@@ -584,6 +584,20 @@ void phy_put(struct phy *phy)
 	module_put(phy->ops->owner);
 	put_device(&phy->dev);
 }
+EXPORT_SYMBOL_GPL(of_phy_put);
+
+/**
+ * phy_put() - release the PHY
+ * @dev: device that wants to release this phy
+ * @phy: the phy returned by phy_get()
+ *
+ * Releases a refcount the caller received from phy_get().
+ */
+void phy_put(struct device *dev, struct phy *phy)
+{
+	device_link_remove(dev, &phy->dev);
+	of_phy_put(phy);
+}
 EXPORT_SYMBOL_GPL(phy_put);
 =

 /**
@@ -651,6 +665,7 @@ struct phy *phy_get(struct device *dev, const char *str=
ing)
 {
 	int index =3D 0;
 	struct phy *phy;
+	struct device_link *link;
 =

 	if (string =3D=3D NULL) {
 		dev_WARN(dev, "missing string\n");
@@ -672,6 +687,13 @@ struct phy *phy_get(struct device *dev, const char *st=
ring)
 =

 	get_device(&phy->dev);
 =

+	link =3D device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
+	}
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(phy_get);
@@ -765,6 +787,7 @@ struct phy *devm_of_phy_get(struct device *dev, struct =
device_node *np,
 			    const char *con_id)
 {
 	struct phy **ptr, *phy;
+	struct device_link *link;
 =

 	ptr =3D devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -778,6 +801,13 @@ struct phy *devm_of_phy_get(struct device *dev, struct=
 device_node *np,
 		devres_free(ptr);
 	}
 =

+	link =3D device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
+	}
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get);
@@ -798,6 +828,7 @@ struct phy *devm_of_phy_get_by_index(struct device *dev=
, struct device_node *np,
 				     int index)
 {
 	struct phy **ptr, *phy;
+	struct device_link *link;
 =

 	ptr =3D devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -819,6 +850,13 @@ struct phy *devm_of_phy_get_by_index(struct device *de=
v, struct device_node *np,
 	*ptr =3D phy;
 	devres_add(dev, ptr);
 =

+	link =3D device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
+	}
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/=
rcar2.c
index 440d213e1749..791908f8cf73 100644
--- a/drivers/usb/renesas_usbhs/rcar2.c
+++ b/drivers/usb/renesas_usbhs/rcar2.c
@@ -34,7 +34,7 @@ static int usbhs_rcar2_hardware_exit(struct platform_devi=
ce *pdev)
 	struct usbhs_priv *priv =3D usbhs_pdev_to_priv(pdev);
 =

 	if (priv->phy) {
-		phy_put(priv->phy);
+		phy_put(&pdev->dev, priv->phy);
 		priv->phy =3D NULL;
 	}
 =

diff --git a/drivers/usb/renesas_usbhs/rza2.c b/drivers/usb/renesas_usbhs/r=
za2.c
index 021749594389..3eed3334a17f 100644
--- a/drivers/usb/renesas_usbhs/rza2.c
+++ b/drivers/usb/renesas_usbhs/rza2.c
@@ -29,7 +29,7 @@ static int usbhs_rza2_hardware_exit(struct platform_devic=
e *pdev)
 {
 	struct usbhs_priv *priv =3D usbhs_pdev_to_priv(pdev);
 =

-	phy_put(priv->phy);
+	phy_put(&pdev->dev, priv->phy);
 	priv->phy =3D NULL;
 =

 	return 0;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 56d3a100006a..19eddd64c8f6 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -234,7 +234,8 @@ struct phy *devm_of_phy_get(struct device *dev, struct =
device_node *np,
 			    const char *con_id);
 struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_nod=
e *np,
 				     int index);
-void phy_put(struct phy *phy);
+void of_phy_put(struct phy *phy);
+void phy_put(struct device *dev, struct phy *phy);
 void devm_phy_put(struct device *dev, struct phy *phy);
 struct phy *of_phy_get(struct device_node *np, const char *con_id);
 struct phy *of_phy_simple_xlate(struct device *dev,
@@ -419,7 +420,11 @@ static inline struct phy *devm_of_phy_get_by_index(str=
uct device *dev,
 	return ERR_PTR(-ENOSYS);
 }
 =

-static inline void phy_put(struct phy *phy)
+static inline void of_phy_put(struct phy *phy)
+{
+}
+
+static inline void phy_put(struct device *dev, struct phy *phy)
 {
 }
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [768fc661d12559b0dbd99d941b3bf28fe92fd365] Merge tag 'riscv/for-v5.=
5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect good 768fc661d12559b0dbd99d941b3bf28fe92fd365
# bad: [9eb1b48ca4ce1406628ffe1a11b684a96e83ca08] Add linux-next specific f=
iles for 20200106
git bisect bad 9eb1b48ca4ce1406628ffe1a11b684a96e83ca08
# good: [14f98ad9cf39f6dba9a0ee4d5a7844f72fb5dd6c] Merge remote-tracking br=
anch 'crypto/master'
git bisect good 14f98ad9cf39f6dba9a0ee4d5a7844f72fb5dd6c
# good: [7e83dfa54c9d473f0a79775c97c2ec265300d748] Merge remote-tracking br=
anch 'sound/for-next'
git bisect good 7e83dfa54c9d473f0a79775c97c2ec265300d748
# good: [9b19f21b01e41b56d0c4ebb29713058858db4254] Merge remote-tracking br=
anch 'driver-core/driver-core-next'
git bisect good 9b19f21b01e41b56d0c4ebb29713058858db4254
# bad: [abe0382594f8afadbbf9774bfa1accb41e9afe39] Merge remote-tracking bra=
nch 'vhost/linux-next'
git bisect bad abe0382594f8afadbbf9774bfa1accb41e9afe39
# bad: [3c4bafba69e79c34abcf9f2853d6756bf4b6bc1c] Merge remote-tracking bra=
nch 'staging/staging-next'
git bisect bad 3c4bafba69e79c34abcf9f2853d6756bf4b6bc1c
# bad: [9b1e5f8654cffaf96e0194d107ffef4b118a47b8] Merge remote-tracking bra=
nch 'tty/tty-next'
git bisect bad 9b1e5f8654cffaf96e0194d107ffef4b118a47b8
# good: [5e637d2be26385286748f494fdca30079bbe916f] tty/serial: Migrate suns=
u to use has_sysrq
git bisect good 5e637d2be26385286748f494fdca30079bbe916f
# good: [71a1fa0df2a3728b8ccb97394be420d1f03df40e] usb: typec: ucsi: Store =
the notification mask
git bisect good 71a1fa0df2a3728b8ccb97394be420d1f03df40e
# bad: [f17cb451270ca75198eed922da64b076a7176df6] phy: qcom-qmp: Add SW res=
et register
git bisect bad f17cb451270ca75198eed922da64b076a7176df6
# bad: [7c118f6da9b7e46db7c815fd64090ec289f02d19] dt-bindings: phy: drop #c=
lock-cells from rockchip,px30-dsi-dphy
git bisect bad 7c118f6da9b7e46db7c815fd64090ec289f02d19
# good: [24dbe0aaa0030231d4d35886d3552121d208df69] phy: ti-pipe3: make clk =
operations symmetric in probe and remove
git bisect good 24dbe0aaa0030231d4d35886d3552121d208df69
# bad: [df0d0e07be73ccb21a8851f777fe4bf49f998bb8] phy: qualcomm: Adjust ind=
entation in read_poll_timeout
git bisect bad df0d0e07be73ccb21a8851f777fe4bf49f998bb8
# bad: [5253fe05bb47a2402f471d76078b3dcc66442d6c] phy: core: Add consumer d=
evice link support
git bisect bad 5253fe05bb47a2402f471d76078b3dcc66442d6c
# first bad commit: [5253fe05bb47a2402f471d76078b3dcc66442d6c] phy: core: A=
dd consumer device link support
---------------------------------------------------------------------------=
----
