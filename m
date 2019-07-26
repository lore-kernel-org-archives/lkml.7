Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A635CC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7448221880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rm9n3DMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfGZIPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:15:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40254 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:15:08 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190726081506euoutp024b5601171cbfdadcd94170f83ccb3d59~05vQGj46E0251102511euoutp02x
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:15:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190726081506euoutp024b5601171cbfdadcd94170f83ccb3d59~05vQGj46E0251102511euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564128906;
        bh=3R+Wre3FOCx6/iSnf7C3qlkiBEqiGVoT3ado/K8D+IQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Rm9n3DMMhVDkTbb3Mj59G+Qb0wOfWC4uyPv3OFvkI1xaxZ74UVXXUILSo53u6eF3k
         4BVheh0vfakq9fxwm4af+hiXhkWcST8K/fCEl3T23DcSw87j3RBW2BP3AIgQSxw2AW
         4s0wxtSybAlDDcc9ifTUkF5AmoJd4KoQKE6rw+34=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190726081505eucas1p1b960891bdc4f4c788ae2937176c128ef~05vPXCdcM2134621346eucas1p1-;
        Fri, 26 Jul 2019 08:15:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 88.C1.04325.986BA3D5; Fri, 26
        Jul 2019 09:15:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190726081504eucas1p1aea5376ff300f6baca21c5e1cb6e4b43~05vOpc28s2124521245eucas1p1h;
        Fri, 26 Jul 2019 08:15:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190726081504eusmtrp2f940047ea3b349df00ef1f066915c868~05vObRsaQ3187231872eusmtrp2p;
        Fri, 26 Jul 2019 08:15:04 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-3b-5d3ab6893376
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.7C.04146.886BA3D5; Fri, 26
        Jul 2019 09:15:04 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726081503eusmtip2cfd9407539630e3f2d0c0c6b0569c336~05vN2YGXV3050330503eusmtip2s;
        Fri, 26 Jul 2019 08:15:03 +0000 (GMT)
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
Subject: [PATCH v2 0/3] Exynos EHCI/OHCI: resolve conflict with the generic
 USB device bindings
Date:   Fri, 26 Jul 2019 10:14:50 +0200
Message-Id: <20190726081453.9456-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djPc7qd26xiDfoahS02zljPajH/yDlW
        i+bF69kszp/fwG5xedccNosZ5/cxWSxa1sps8fLID0aLtUfuslv8eDidyeLPvTusFq17j7Bb
        TPh9gc2B1+PWnXqPTas62Tz2z13D7vHm9Cl2j43vdjB5zL77g9Gjb8sqRo/Pm+QCOKK4bFJS
        czLLUov07RK4Mm5eP81YsEOk4uG9+4wNjCsFuhg5OSQETCTmtH1h7WLk4hASWMEosezXOxYI
        5wujRNPhSWwQzmdGiTUPvzPBtDQdfs8IkVjOKPFl7zl2kARYS9dNKRCbTcBQouttFxuILSLg
        ILFk6R2wScwC55glFv/sAJskLJAo8XF1A1gRi4CqxNzlt1hAbF4BG4lFOx4xQ2yTl1i94QAz
        RFxQ4uTMJ2A1zEDx5q2zmUGGSggcY5do77nOCtHgIrHmxUGoZmGJV8e3sEPYMhL/d85ngmho
        ZpR4eG4tO4TTwyhxuWkGI0SVtcTh4xeBJnEArdCUWL9LH8SUEHCUaNktDmHySdx4KwhxA5/E
        pG3TmSHCvBIdbUIQM9QkZh1fB7f14IVLUCUeEp0d5ZCgipVYeu8T+wRGhVlIHpuF5LFZCBcs
        YGRexSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZjCTv87/nUH474/SYcYBTgYlXh4NVZZ
        xgqxJpYVV+YeYpTgYFYS4d26AyjEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2
        ampBahFMlomDU6qB8foPj3n2v6Ptg2t3F3c+N7M2CLHLt4qoby4rYr107HUQ59lb2YxusWtn
        HhQUubtDpPOiUQH3oqt/julVG/uGWEex9XFcvWHOppG5qHG51/6KKWmHnf0Pbvy28Gboid/m
        sl/2ZLO5aLzjnLVCt//S43We/Bqbo1L3lP+SfxSxWf7BU4mHm1IqlFiKMxINtZiLihMBTjxv
        sl0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7od26xiDR49lLPYOGM9q8X8I+dY
        LZoXr2ezOH9+A7vF5V1z2CxmnN/HZLFoWSuzxcsjPxgt1h65y27x4+F0Jos/9+6wWrTuPcJu
        MeH3BTYHXo9bd+o9Nq3qZPPYP3cNu8eb06fYPTa+28HkMfvuD0aPvi2rGD0+b5IL4IjSsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7h5/TRjwQ6R
        iof37jM2MK4U6GLk5JAQMJFoOvyesYuRi0NIYCmjxK/5r9kgEjISJ6c1sELYwhJ/rnWxQRR9
        YpR4tvASI0iCTcBQouttF1iDiICTROfa02BFzALXmCV2XOwESwgLxEt8mb8AzGYRUJWYu/wW
        C4jNK2AjsWjHI2aIDfISqzccYIaIC0qcnPkEqIYDaJC6xPp5QiBhZqCS5q2zmScw8s9CUjUL
        oWoWkqoFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNt27Gfm3cwXtoYfIhRgINRiYf3
        wnLLWCHWxLLiytxDjBIczEoivFt3AIV4UxIrq1KL8uOLSnNSiw8xmgK9MJFZSjQ5H5gG8kri
        DU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MOq37Diz/Pleng2NC5zn
        Rrw58+ZJzY2aYx+vf79TpOYtLlLeYJDTxhXry3Y7ZIKFxdvMlUXsXKwhRYYe7bc/ffd9PKNZ
        e3Yjf/6aoH+WS++eDo7qye0zmHlB/qm4Z9ubjsvGvC8UfzDf8WP6dTzHc35qbD/znvJJ2Xo3
        A3eWbP8THFKy8s13TyWW4oxEQy3mouJEADR98rvLAgAA
X-CMS-MailID: 20190726081504eucas1p1aea5376ff300f6baca21c5e1cb6e4b43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190726081504eucas1p1aea5376ff300f6baca21c5e1cb6e4b43
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190726081504eucas1p1aea5376ff300f6baca21c5e1cb6e4b43
References: <CGME20190726081504eucas1p1aea5376ff300f6baca21c5e1cb6e4b43@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Commit 69bec7259853 ("USB: core: let USB device know device node") added
support for attaching devicetree node for USB devices. Those nodes are
children of their USB host controller. However Exynos EHCI and OHCI
driver bindings already define child-nodes for each physical root hub
port and assigns respective PHY controller and parameters to them. This
leads to the conflict. A workaround for it has been merged as commit
01d4071486fe ("usb: exynos: add workaround for the USB device bindings
conflict"), but it disabled support for USB device binding for Exynos
EHCI/OHCI controllers.

This patchset tries to resolve this binding conflict by changing Exynos
EHCI/OHCI bindings: PHYs are moved from the sub-nodes to a standard array
under the 'phys' property. Such solution has been suggested by Måns
Rullgård in the following thread: https://lkml.org/lkml/2019/5/13/228

To keep everything working during the transitional time, the changes has
been split into 2 steps. First the changes to Exynos OHCI and EHCI
drivers have to be merged, then in the next kernel release the DTS can be
finally updated to the new bindings.

This patchset has been tested on various Exynos boards with different
USB host controller configurations (Odroids family: X2, U3, XU3).

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v2:
- rearranged the code as suggested by Måns Rullgård, kept support for
  legacy bindings the Exynos EHCI/OHCI drivers

v1: https://patchwork.kernel.org/cover/10953495/
- initial version


Patch summary:

Marek Szyprowski (3):
  dt-bindings: switch Exynos EHCI/OHCI bindings to use array of generic
    PHYs
  usb: exynos: add support for getting PHYs from the standard dt array
  ARM: dts: exynos: Use standard arrays of generic PHYs for EHCI/OHCI
    devices

 .../devicetree/bindings/usb/exynos-usb.txt    | 41 +++++++------------
 arch/arm/boot/dts/exynos4.dtsi                | 28 ++-----------
 .../boot/dts/exynos4210-universal_c210.dts    |  8 +---
 arch/arm/boot/dts/exynos4412-itop-elite.dts   |  9 +---
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  8 +---
 arch/arm/boot/dts/exynos4412-odroidx.dts      |  5 +--
 arch/arm/boot/dts/exynos4412-origen.dts       |  9 +---
 arch/arm/boot/dts/exynos5250.dtsi             | 16 ++------
 arch/arm/boot/dts/exynos54xx.dtsi             | 18 ++------
 drivers/usb/host/ehci-exynos.c                | 23 +++++++++--
 drivers/usb/host/ohci-exynos.c                | 23 +++++++++--
 11 files changed, 74 insertions(+), 114 deletions(-)

-- 
2.17.1

