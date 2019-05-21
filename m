Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3996C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9378F217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R4Dlpcuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfEUMCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:02:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57439 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfEUMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:02:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190521120207euoutp0136fb41829abf21227151c35b82d709b9~gsQn5I_ud3228432284euoutp01N
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:02:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190521120207euoutp0136fb41829abf21227151c35b82d709b9~gsQn5I_ud3228432284euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558440127;
        bh=ifJpnpYKeGfoa9EI/dpaSOWkHwZALEyhwRZH/XL2H+0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=R4Dlpcuw50sEBGnZTzTsNITZNAV0aTwyCZRCCeyLJ1BkAY9Pld9SRdbsitcbIvKup
         Xz0WNs/FQOUBuLpdaMlurJMNMckiGSTzNcvXi4vXifF390Dy3308fLO3LY19nzgCan
         R27VXhmzMErzHfOBKYLx99lCzCNUQNx5lwLSSQxs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521120206eucas1p223fc73eb2413a4d1cdd944f2e7f1e5d1~gsQnJUFcv0878708787eucas1p2i;
        Tue, 21 May 2019 12:02:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F4.CF.04298.EB8E3EC5; Tue, 21
        May 2019 13:02:06 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521120205eucas1p27671f3b96e443da8b13bd10618a77636~gsQmQt4_Y0973209732eucas1p2G;
        Tue, 21 May 2019 12:02:05 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-20-5ce3e8bebbdd
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 46.9E.04140.DB8E3EC5; Tue, 21
        May 2019 13:02:05 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRU006F4RY90T20@eusync4.samsung.com>;
        Tue, 21 May 2019 13:02:05 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/5] ARM: dts: exynos: Add array of generic PHYs to
 EHCI/OHCI devices
Date:   Tue, 21 May 2019 13:58:46 +0200
Message-id: <20190521115849.9882-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190521115849.9882-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO7vbvXej1XUJHjQ0BkKFrgyJG2kZWNz+E4KKWtTKm+8Hm05N
        wxemmz2Wgg7zVb5iZnPzgeWzOZopOHNBplOaC8xnlBQbpuZ2lfzv+/t9P5xzvl8Ojgiecrzx
        mMQUWpooiReiPHbne+doYN93u/h4yZAnqVNrOWSNcZRD5tdpUdJsbsVIy9tKlFSb+1jki8YC
        hJw3OgDZYpzGSIetnEX+nbFyyIJeI0aq1sbQMD41ac2m9BoFSvVXvcKopZFhjNKtdLGoZ9MO
        QD1u1wBqVe8bgV/jhUTS8TFyWnrszC1edKO1FU0uOJxePLEIckDPISXg4pAIhitF5Wwl4OEC
        4iWAhWPrCDOsAujU/QA7VI9hkcMYjQAuTmjYLoNPeEBH6cyWxnGE8IPG8TjXGiGOwI5uLcbw
        mwBO5ra5D0KJIKhcVqIu7UmEwfoGK+qCEGIUgXXOIpbLOEBcgatVBjfEJvzhhrMBYS4LgQpV
        Gca8yA82tw6491wiFNbkzSHMfhOFk6azjA6HuuUd/iC0lBa7c0IiH0DbaAvGDA8BtOSpt3Oe
        hoOmjxwmwz5Y0lmOuKJBgg+LHggYhILr3+a3q1AB2DX1DlUBn4pdbVT8b6NiVxu1ANEALzpV
        lhBFy4IS6TSRTJIgS02MEt1JStCDrY8ysmH61QV+j982AAIHwr180mYXCzgSuSwjwQAgjgg9
        +SPDs2IBP1KScY+WJt2UpsbTMgPwwdlCL37mnq/XBUSUJIWOo+lkWrrjsnCudw4gxVTnqaY3
        bYVXzdn2BeHQ5YCcDxeqFetPXnvMfFr7OdUvqm0+73/urujLc79CS2bxjedrdh7Znt+B6TWP
        fHuWLtV+5laWlZ7IVcoD/hhXwi/2hlZ3Z80MGgb2L8yq8fTsNFOc2hisvV+PyFsUhpgsiVd9
        REdspM+c7WRTZWCskC2LlgQdRaQyyT+7e86EJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xa7p7XzyOMbgzQ9hi44z1rBbzj5xj
        tWhevJ7N4vz5DewWl3fNYbOYcX4fk8WiZa3MFi+P/GC0WHvkLrvFj4fTmSz+3LvDatG69wi7
        xYTfF9gceD1u3an32LSqk81j/9w17B5vTp9i99j4bgeTx+y7Pxg9+rasYvT4vEkugCOKyyYl
        NSezLLVI3y6BK2PZnQ1sBa0aFd03XjM2MO5R6GLk5JAQMJHYc+g1axcjF4eQwBJGie9zZ7KA
        JHgFBCV+TL4HZHNwMAvISxy5lA0SZhZQl5g0bxEziC0k0MgkMe+5O4jNJmAo0fW2iw3EFhFw
        kFiy9A4byExmgQvMEp07/rCDJIQFwiXen30JZrMIqEr8+7mUGWKXjUTnhGnsEAfJS6zecAAs
        zilgKzG/6TnUMhuJVzM6mCcw8s9Cct4shPNmITlvASPzKkaR1NLi3PTcYiO94sTc4tK8dL3k
        /NxNjMAI2Xbs55YdjF3vgg8xCnAwKvHwPrj3OEaINbGsuDL3EKMEB7OSCO/pU49ihHhTEiur
        Uovy44tKc1KLDzFKc7AoifN2CByMERJITyxJzU5NLUgtgskycXBKNTB2ux47rmzh7G72+7Z3
        SLRM512TXladteyN3wW8lM84XNx3fvXnmCn3tJbuT06N5D9qc/OU9hFxiVbnGd87Kjxian+m
        ahVe6+QIu+ZyfVqY8XODtGexN80XvTY/e1HpALOKz1OpE+y2zXlnv0VscFvg8a2dw9xo6bqN
        N++dFP6XXfvAhCfQyUSJpTgj0VCLuag4EQBVtN9BjAIAAA==
X-CMS-MailID: 20190521120205eucas1p27671f3b96e443da8b13bd10618a77636
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521120205eucas1p27671f3b96e443da8b13bd10618a77636
References: <20190521115849.9882-1-m.szyprowski@samsung.com>
        <CGME20190521120205eucas1p27671f3b96e443da8b13bd10618a77636@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a standard array of PHYs to Exynos EHCI/OHCI devices. This is a first
step in resolving the conflict between Exynos EHCI/OHCI sub-nodes and
generic USB device bindings. Later the sub-nodes currently used for
assigning PHYs to root ports of the controller will be removed making
a place for the generic USB device bindings nodes.

Suggested-by: Måns Rullgård <mans@mansr.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                  | 4 ++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 2 ++
 arch/arm/boot/dts/exynos4412-itop-elite.dts     | 2 ++
 arch/arm/boot/dts/exynos4412-odroidu3.dts       | 2 ++
 arch/arm/boot/dts/exynos4412-odroidx.dts        | 2 ++
 arch/arm/boot/dts/exynos4412-origen.dts         | 2 ++
 arch/arm/boot/dts/exynos5250.dtsi               | 4 ++++
 arch/arm/boot/dts/exynos54xx.dtsi               | 4 ++++
 8 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 36ccf227434d..7b94fbd9ed6c 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -380,6 +380,8 @@
 			clocks = <&clock CLK_USB_HOST>;
 			clock-names = "usbhost";
 			status = "disabled";
+			phys = <&exynos_usbphy 1>, <&exynos_usbphy 2>, <&exynos_usbphy 3>;
+			phy-names = "host", "hsic0", "hsic1";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			port@0 {
@@ -406,6 +408,8 @@
 			clocks = <&clock CLK_USB_HOST>;
 			clock-names = "usbhost";
 			status = "disabled";
+			phys = <&exynos_usbphy 1>;
+			phy-names = "host";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			port@0 {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index bf092e97e14f..dbd6b43dbe52 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -204,6 +204,8 @@
 
 &ehci {
 	status = "okay";
+	phys = <&exynos_usbphy 1>;
+	phy-names = "host";
 	port@0 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 0dedeba89b5f..1763b42c01cb 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -146,6 +146,8 @@
 	/* In order to reset USB ethernet */
 	samsung,vbus-gpio = <&gpc0 1 GPIO_ACTIVE_HIGH>;
 
+	phys = <&exynos_usbphy 1>, <&exynos_usbphy 3>;
+	phy-names = "host", "hsic1";
 	port@0 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 96d99887bceb..5bbaccffc9be 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -105,6 +105,8 @@
 };
 
 &ehci {
+	phys = <&exynos_usbphy 2>, <&exynos_usbphy 3>;
+	phy-names = "hsic0", "hsic1";
 	port@1 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index a2251581f6b6..306dd9365a91 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -72,6 +72,8 @@
 };
 
 &ehci {
+	phys = <&exynos_usbphy 2>;
+	phy-names = "hsic0";
 	port@1 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 698de4345d16..e609e2af22d1 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -88,6 +88,8 @@
 &ehci {
 	samsung,vbus-gpio = <&gpx3 5 1>;
 	status = "okay";
+	phys = <&exynos_usbphy 2>, <&exynos_usbphy 3>;
+	phy-names = "hsic0", "hsic1";
 
 	port@1 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index d5e0392b409e..2d23e99985e1 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -617,6 +617,8 @@
 
 			clocks = <&clock CLK_USB2>;
 			clock-names = "usbhost";
+			phys = <&usb2_phy_gen 1>;
+			phy-names = "host";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			port@0 {
@@ -632,6 +634,8 @@
 
 			clocks = <&clock CLK_USB2>;
 			clock-names = "usbhost";
+			phys = <&usb2_phy_gen 1>;
+			phy-names = "host";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			port@0 {
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index ae866bcc30c4..ab1642cf0428 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -180,6 +180,8 @@
 			compatible = "samsung,exynos4210-ehci";
 			reg = <0x12110000 0x100>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb2_phy 1>;
+			phy-names = "host";
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -193,6 +195,8 @@
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0x12120000 0x100>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb2_phy 1>;
+			phy-names = "host";
 
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.17.1

