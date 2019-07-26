Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C37C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A621880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XInh940T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfGZIPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:15:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50632 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfGZIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:15:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190726081506euoutp01c132f4d23cc5c1115135a300e2f48df2~05vQjfvE-2569825698euoutp01P
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:15:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190726081506euoutp01c132f4d23cc5c1115135a300e2f48df2~05vQjfvE-2569825698euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564128906;
        bh=wEDUjZQ2UkeoX7Xa2YAqEXlb+2reqAVeBZifIn1wMqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XInh940TGzOUBA3uQmwuVH4O9Q8fsqLKcKd6IkpZ7hm73Z2Fyi0Bt1BAtYE/T3epc
         AD8G6kG/OfxIP7dtJHAiOzDJKXBMFqLrcZx04Ed/Jd9yZlaYCIMZM7T2IUHbSlnfHe
         6V5w+kvD2zSV1qFQ1/JV8UYkeoibVmB57E6uNQWM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190726081506eucas1p2493d67572ca7c1249973f9c0f1862008~05vP2OeTo2692026920eucas1p24;
        Fri, 26 Jul 2019 08:15:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A9.C1.04325.986BA3D5; Fri, 26
        Jul 2019 09:15:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190726081505eucas1p22472e5d1e81180b7bca4f0c0af302af5~05vPMA_q92703027030eucas1p2z;
        Fri, 26 Jul 2019 08:15:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190726081505eusmtrp2b1387fc73459937259fab67b07f3cc2e~05vO96tLU3187231872eusmtrp2q;
        Fri, 26 Jul 2019 08:15:05 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-40-5d3ab6890277
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.7C.04146.986BA3D5; Fri, 26
        Jul 2019 09:15:05 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726081504eusmtip295ae75f0a45ec3f08f0569134994123b~05vOZYZ2z3050030500eusmtip29;
        Fri, 26 Jul 2019 08:15:04 +0000 (GMT)
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
Subject: [PATCH v2 1/3] dt-bindings: switch Exynos EHCI/OHCI bindings to use
 array of generic PHYs
Date:   Fri, 26 Jul 2019 10:14:51 +0200
Message-Id: <20190726081453.9456-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726081453.9456-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7qd26xiDc7uMrLYOGM9q8X8I+dY
        LZoXr2ezOH9+A7vF5V1z2CxmnN/HZLFoWSuzxcsjPxgt1h65y27x4+F0Jos/9+6wWrTuPcJu
        MeH3BTYHXo9bd+o9Nq3qZPPYP3cNu8eb06fYPTa+28HkMfvuD0aPvi2rGD0+b5IL4IjisklJ
        zcksSy3St0vgyphyfg5rwVGZij1vNrI0MC4X62Lk5JAQMJF4vPQ9SxcjF4eQwApGif8vpzBC
        OF8YJf7O3MsO4XxmlNjS8Ym1i5EDrGXCjESI+HJGiT+PHrODjALruPkgBcRmEzCU6HrbxQZi
        iwg4SCxZeocNpIFZ4ByzxOKfHUwgCWGBFIkvz1tYQGwWAVWJ88duMoPYvAI2Et/bGpgg7pOX
        WL3hAFicU8BWovfZWiaIGkGJkzOfgPUyA9U0b53NDLJAQuARu8Seoy/YIJpdJI7N/swOYQtL
        vDq+BcqWkfi/cz4TREMzo8TDc2vZIZweRonLTTMYIaqsJQ4fvwj2M7OApsT6XfoQYUeJGTtv
        M0OCgk/ixltBiCP4JCZtmw4V5pXoaBOCqFaTmHV8HdzagxcuMUPYHhILO48yTmBUnIXknVlI
        3pmFsHcBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwCR2+t/xrzsY9/1JOsQowMGo
        xMOrscoyVog1say4MvcQowQHs5II79YdQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE
        0hNLUrNTUwtSi2CyTBycUg2Mnup7uVT2lwhIb+1RePUuxOzyKYnu+em9N2b6KiSoTb5aa7XW
        7nXSgY2XFj2cYfk0+aH6khLnwCkv+UqSmCI2L9gTrtPWFLo0Z7723mvHP3fabjxxz/aDi8Je
        te2JGcE7XJ6fNw+OLsndqmx30lSrMadoWpbLNIs2hfs/ejYtL8/exCDzrlRViaU4I9FQi7mo
        OBEAId5OdV4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7qd26xiDe7NYbXYOGM9q8X8I+dY
        LZoXr2ezOH9+A7vF5V1z2CxmnN/HZLFoWSuzxcsjPxgt1h65y27x4+F0Jos/9+6wWrTuPcJu
        MeH3BTYHXo9bd+o9Nq3qZPPYP3cNu8eb06fYPTa+28HkMfvuD0aPvi2rGD0+b5IL4IjSsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5hyfg5rwVGZ
        ij1vNrI0MC4X62Lk4JAQMJGYMCOxi5GLQ0hgKaPEsp5Z7F2MnEBxGYmT0xpYIWxhiT/Xutgg
        ij4xSlz8PhkswSZgKNH1FiTBySEi4CTRufY0WBGzwDVmiR0XO8ESwgJJEl07foA1sAioSpw/
        dpMZxOYVsJH43tbABLFBXmL1hgNgcU4BW4neZ2vB4kJANft/7WaDqBeUODnzCQvI1cwC6hLr
        5wmBhJmBWpu3zmaewCg4C0nVLISqWUiqFjAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM
        zG3Hfm7ewXhpY/AhRgEORiUe3gvLLWOFWBPLiitzDzFKcDArifBu3QEU4k1JrKxKLcqPLyrN
        SS0+xGgK9NpEZinR5Hxg0sgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPH
        xMEp1cDoZebCG6Fre1jd/te9XUoTOjOcXQprmgwVuv7f2SxzQ3n2vR81r6LmqhueTOaZ1qtl
        X8JZcSbyqM/WshkR9kueq9omp/5WOxb1/6BG0JKl3R8fM9l5LWFLvz7rEyP/1DVHwzbl5EZr
        9EzZvjrvtvHpjaVNzT5aT0vLdi3+xVH+V/j7sTvfzmoosRRnJBpqMRcVJwIA9RR7+uICAAA=
X-CMS-MailID: 20190726081505eucas1p22472e5d1e81180b7bca4f0c0af302af5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190726081505eucas1p22472e5d1e81180b7bca4f0c0af302af5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190726081505eucas1p22472e5d1e81180b7bca4f0c0af302af5
References: <20190726081453.9456-1-m.szyprowski@samsung.com>
        <CGME20190726081505eucas1p22472e5d1e81180b7bca4f0c0af302af5@eucas1p2.samsung.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

