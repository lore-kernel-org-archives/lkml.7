Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A672BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F6E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mn3lTba5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfEUMBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:01:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56913 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfEUMBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:01:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190521120109euoutp0159911ce00886a36dba158bef494a9ed7~gsPxyZu5f3027530275euoutp01_
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:01:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190521120109euoutp0159911ce00886a36dba158bef494a9ed7~gsPxyZu5f3027530275euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558440069;
        bh=6VLrRSqRy8rjxJcV9QOeKBQKOJLGDo2GyIqea/dqdoo=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Mn3lTba5ZwfA4uRYqefIzC5uBAojO04OFOhCdW9uViSlbilTUeYY4Eeg7z4chYGgd
         POs1AGHvJmRiz3k/O+huFarncZ4dcmnRtz9KsKjQKJblpMJUYXraA867IU5smqZa5O
         JN60MUEhtkj5SHSVGg5RsXrtQn8ZR/BtXz4DRyCI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190521120108eucas1p1b26384e5a73d0c198dd50b1331d73dc5~gsPxGnjvt0539705397eucas1p1v;
        Tue, 21 May 2019 12:01:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FB.CA.04377.488E3EC5; Tue, 21
        May 2019 13:01:08 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190521120107eucas1p1a56efaa0e7f2117063e70683276edc10~gsPwaBaJD0547705477eucas1p1n;
        Tue, 21 May 2019 12:01:07 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-93-5ce3e8846205
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EC.22.04146.388E3EC5; Tue, 21
        May 2019 13:01:07 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRU006F4RY90T20@eusync4.samsung.com>;
        Tue, 21 May 2019 13:01:07 +0100 (BST)
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
Subject: [PATCH 1/5] dt-bindings: switch Exynos EHCI/OHCI bindings to use
 array of generic PHYs
Date:   Tue, 21 May 2019 13:58:45 +0200
Message-id: <20190521115849.9882-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190521115849.9882-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7otLx7HGEzYLGqxccZ6Vov5R86x
        WjQvXs9mcf78BnaLy7vmsFnMOL+PyWLRslZmi5dHfjBarD1yl93ix8PpTBZ/7t1htWjde4Td
        YsLvC2wOvB637tR7bFrVyeaxf+4ado83p0+xe2x8t4PJY/bdH4wefVtWMXp83iQXwBHFZZOS
        mpNZllqkb5fAldGw9hBTwUyZiknTDrA1MDaIdTFyckgImEgsO/mevYuRi0NIYAWjxMkf3UwQ
        zmdGieU7/7J2MXKAVS0+nQMRX8YocXnDF0aQbl4BQYkfk++xgNQwC8hLHLmUDRJmFtCU2Lp7
        PTuILSTwn1Hi58UsEJtNwFCi620XG4gtIuAgsWTpHTaQmcwC55glFv/sYAJJCAskSux5NR2s
        iEVAVeLDkuXMELtsJDZdmskMcbW8xOoNB8BsTgFbiflNz5lBBkkINLNLPPzwhA2iyEViyY45
        rBC2jERnx0EmqCJGiYfn1rJDOD1A7zTNYISospY4fPwiK8QPfBKTtk1nhnifV6KjTQiixEPi
        Tvs5VkhQTGCU2LuhgXECo/QspNCYhQiNWUihsYCReRWjeGppcW56arFRXmq5XnFibnFpXrpe
        cn7uJkZgOjn97/iXHYy7/iQdYhTgYFTi4bV4+DhGiDWxrLgy9xCjBAezkgjv6VOPYoR4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwTj55JueL3rm1l1fM
        jy0zOTDxgy1fwKQbWxkn+OlsuLAiLfXXyXWLG7n7bVgmtG24wfPS9vZcHefvK28Zimt1cEv/
        2hTxOv3frsC2bab7Ax/J8PB67r87KfnpC4YdQbGhYacXTBM96vxheXmIEcvuvK8P3pwxLi+8
        vDZGW3xJ2jvn5fc5+Ty2XFViKc5INNRiLipOBABB0zvzIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t/xa7rNLx7HGNxfpG+xccZ6Vov5R86x
        WjQvXs9mcf78BnaLy7vmsFnMOL+PyWLRslZmi5dHfjBarD1yl93ix8PpTBZ/7t1htWjde4Td
        YsLvC2wOvB637tR7bFrVyeaxf+4ado83p0+xe2x8t4PJY/bdH4wefVtWMXp83iQXwBHFZZOS
        mpNZllqkb5fAldGw9hBTwUyZiknTDrA1MDaIdTFycEgImEgsPp3TxcjJISSwhFHiaVswiM0r
        ICjxY/I9FpASZgF5iSOXskHCzALqEpPmLWLuYuQCKm9kkrjQ8ZUJJMEmYCjR9baLDcQWEXCQ
        WLL0DhtIEbPABWaJzh1/2EESwgKJEi8a5jCD2CwCqhIflixnhlhmI7Hp0kwwWwJo2eoNB8Bs
        TgFbiflNz5khjrOReDWjg3kCI/8sJPfNQrhvFpL7FjAyr2IUSS0tzk3PLTbUK07MLS7NS9dL
        zs/dxAiMj23Hfm7ewXhpY/AhRgEORiUe3gf3HscIsSaWFVfmHmKU4GBWEuE9fepRjBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHeDoGDMUIC6YklqdmpqQWpRTBZJg5OqQZG0QfLON5OeZ1sdsHO
        JpYnPMSU+3nGrRfHp7B7fY8ImWX5o3bX8vnlHZ8TKnSeL43Zsu9v2BWd4j8PGf6+e/R8isj6
        PclVnzQb7n0U6t8SYtW6VW6R58J89znLfp8I3CZ2nSdo/fL1q16evp69ZDnX/Fdfozafqe53
        tTtVcLnUYsmfjzvM5s57Uq7EUpyRaKjFXFScCACXzUp1iwIAAA==
X-CMS-MailID: 20190521120107eucas1p1a56efaa0e7f2117063e70683276edc10
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521120107eucas1p1a56efaa0e7f2117063e70683276edc10
References: <20190521115849.9882-1-m.szyprowski@samsung.com>
        <CGME20190521120107eucas1p1a56efaa0e7f2117063e70683276edc10@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 69bec7259853 ("USB: core: let USB device know device node") added
support for attaching devicetree node for USB devices. Those nodes are
children of their USB host controller. However Exynos EHCI and OHCI
driver bindings already define child-nodes for each physical root hub
port and assigns respective PHY controller and parameters to them. This
leads to the conflict. A workaround for it has been merged as commit
01d4071486fe ("usb: exynos: add workaround for the USB device bindings
conflict"), but it disabled support for USB device binding for Exynos
EHCI/OHCI controllers.

To resolve it properly, lets move PHYs from the sub-nodes to a standard
array under the 'phys' property.

Suggested-by: Måns Rullgård <mans@mansr.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../devicetree/bindings/usb/exynos-usb.txt    | 41 +++++++------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index b7111f43fa59..66c394f9e11f 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -12,13 +12,11 @@ Required properties:
  - interrupts: interrupt number to the cpu.
  - clocks: from common clock binding: handle to usb clock.
  - clock-names: from common clock binding: Shall be "usbhost".
- - port: if in the SoC there are EHCI phys, they should be listed here.
-   One phy per port. Each port should have following entries:
-	- reg: port number on EHCI controller, e.g
-	       On Exynos5250, port 0 is USB2.0 otg phy
-			      port 1 is HSIC phy0
-			      port 2 is HSIC phy1
-	- phys: from the *Generic PHY* bindings; specifying phy used by port.
+ - phys: from the *Generic PHY* bindings; array specifying phy(s) used
+   by the root port.
+ - phy-names: from the *Generic PHY* bindings; array of the names for
+   each phy for the root ports, must be a subset of the following:
+   "host", "hsic0", "hsic1".
 
 Optional properties:
  - samsung,vbus-gpio:  if present, specifies the GPIO that
@@ -35,12 +33,8 @@ Example:
 		clocks = <&clock 285>;
 		clock-names = "usbhost";
 
-		#address-cells = <1>;
-		#size-cells = <0>;
-		port@0 {
-		    reg = <0>;
-		    phys = <&usb2phy 1>;
-		};
+		phys = <&usb2phy 1>;
+		phy-names = "host";
 	};
 
 OHCI
@@ -52,13 +46,11 @@ Required properties:
  - interrupts: interrupt number to the cpu.
  - clocks: from common clock binding: handle to usb clock.
  - clock-names: from common clock binding: Shall be "usbhost".
- - port: if in the SoC there are OHCI phys, they should be listed here.
-   One phy per port. Each port should have following entries:
-	- reg: port number on OHCI controller, e.g
-	       On Exynos5250, port 0 is USB2.0 otg phy
-			      port 1 is HSIC phy0
-			      port 2 is HSIC phy1
-	- phys: from the *Generic PHY* bindings, specifying phy used by port.
+ - phys: from the *Generic PHY* bindings; array specifying phy(s) used
+   by the root port.
+ - phy-names: from the *Generic PHY* bindings; array of the names for
+   each phy for the root ports, must be a subset of the following:
+   "host", "hsic0", "hsic1".
 
 Example:
 	usb@12120000 {
@@ -69,13 +61,8 @@ Example:
 		clocks = <&clock 285>;
 		clock-names = "usbhost";
 
-		#address-cells = <1>;
-		#size-cells = <0>;
-		port@0 {
-		    reg = <0>;
-		    phys = <&usb2phy 1>;
-		};
-
+		phys = <&usb2phy 1>;
+		phy-names = "host";
 	};
 
 DWC3
-- 
2.17.1

