Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85AEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE292251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tE00SeRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfKTN0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:26:50 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:55198 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfKTN0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:26:49 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191120132646epoutp0306fd6f41c81e3427016c10b061d7ce06~Y4dxsnWe_1524415244epoutp03h
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 13:26:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191120132646epoutp0306fd6f41c81e3427016c10b061d7ce06~Y4dxsnWe_1524415244epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574256406;
        bh=2nnkY0zONHJBiKeXcYLEH25v+lVrMoEod+rtyzko/ZA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tE00SeRPw4zmXehy35iLWCTlbT55Z5dZFBXBMZ5t4oOGAP3iKI5Zm55ZDRrvHtSsN
         OgUw/KrCt/Ly1tYiasXO2o8VvquMkgz0D4T4m1VY0piNgFFeGBcbLdyFAgO7TqOY2K
         fjZ8HScN5i0TOvPdEI3GT9Q63L1/rsbwUHwvnO44=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191120132645epcas5p3310045e575780e18ec0f10f15a88b2b4~Y4dxIQAQV0125001250epcas5p30;
        Wed, 20 Nov 2019 13:26:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.71.04403.51F35DD5; Wed, 20 Nov 2019 22:26:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191120132645epcas5p29da16b1881e3da52fac0516a32e277d5~Y4dwirpH00633706337epcas5p2G;
        Wed, 20 Nov 2019 13:26:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191120132645epsmtrp1de900a5e26290f866382ec67d535c4d0~Y4dwh9gTw1339613396epsmtrp1V;
        Wed, 20 Nov 2019 13:26:45 +0000 (GMT)
X-AuditID: b6c32a4a-3b3ff70000001133-a3-5dd53f1579e2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.2B.03654.51F35DD5; Wed, 20 Nov 2019 22:26:45 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191120132643epsmtip203d4b9baaaeff6f0ac2f8b8cead9dbd5~Y4du-SPMg2397823978epsmtip2I;
        Wed, 20 Nov 2019 13:26:43 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        pankaj.dubey@samsung.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v3 0/2] Add support to handle ZRX-DC Compliant PHYs
Date:   Wed, 20 Nov 2019 18:56:09 +0530
Message-Id: <1574256371-617-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCmuq6o/dVYg9dLTC2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2Cze/H7BbrH0+kUmi0Vbv7BbtO49wu7A7bFm3hpG
        j52z7rJ7LNhU6rFpVSebR9+WVYweW/Z/ZvQ4fmM7k8fnTXIBHFFcNimpOZllqUX6dglcGesb
        jjAX7OKtOLj2M1MD43OuLkZODgkBE4nfB7cydTFycQgJ7GaU2Pt2EiOE84lRov/JIWYI5xuj
        xMarK1lgWjZeWcAGkdjLKHHz4yYWCKeFSeJv2zNGkCo2AW2Jn0f3soPYIgIKEpt7n7GCFDEL
        /GOUuPplHliRsICzxKbt51lBbBYBVYkHDbuZQWxeASeJmz8XsUKsk5O4ea4T7A4JgR1sEi+/
        7WKHSLhIbFxwhhHCFpZ4dXwLVFxK4mV/G5SdL9F7dymUXSMx5W4HVL29xIErc4DO5gC6SFNi
        /S59kDCzAJ9E7+8nTCBhCQFeiY42IQhTSaJtZjVEo4TE4vk3mSFsD4nexWvAhgsJxEr8+LqR
        fQKjzCyEmQsYGVcxSqYWFOempxabFhjlpZbrFSfmFpfmpesl5+duYgSnCC2vHYzLzvkcYhTg
        YFTi4c3QuBorxJpYVlyZe4hRgoNZSYR3z/UrsUK8KYmVValF+fFFpTmpxYcYpTlYlMR5J7Fe
        jRESSE8sSc1OTS1ILYLJMnFwSjUw+iftuPiupiFTVIlT5pPKjttTdu7RkPttz/BX5OHNhFwW
        Ay5DwV1G/w467xCR5nkQ+md5ZOYKPvV3gZkWc1IrF62eZ9DoZhwbnPxD0z15xft7q4/kJpcu
        3P9ozqwf5f/j05Z/2XbsxswG3tL7CyS+y346cfnpFNHzUgXrDhSncsYZHLeaceHzdiWW4oxE
        Qy3mouJEAFxQGB0NAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSvK6o/dVYg+Vz+C2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2Cze/H7BbrH0+kUmi0Vbv7BbtO49wu7A7bFm3hpG
        j52z7rJ7LNhU6rFpVSebR9+WVYweW/Z/ZvQ4fmM7k8fnTXIBHFFcNimpOZllqUX6dglcGesb
        jjAX7OKtOLj2M1MD43OuLkZODgkBE4mNVxawdTFycQgJ7GaUmDjxBxNEQkLiy96vbBC2sMTK
        f8/ZIYqamCQOHj4LVsQmoC3x8+hedhBbREBBYnPvM1aQImaBLiaJtae3gCWEBZwlNm0/zwpi
        swioSjxo2M0MYvMKOEnc/LmIFWKDnMTNc53MExh5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswt
        Ls1L10vOz93ECA5FLc0djJeXxB9iFOBgVOLhzdC4GivEmlhWXJl7iFGCg1lJhHfP9SuxQrwp
        iZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTAWptwV4q6yFzWU
        fFZ9cmmNdOjFgtzsJukdrI5lMVNf5nh+DSjjjr2V8vWDztZH/ixbDj6PqZlySdPi0BbjaYHy
        2uG83i+OC2j/vWN9anHyZT0HBf4vJypW5R+/p8N2+HEC54TY93dvFp/cxGdktJjn5bUOQ9aT
        W60Dvx29VJqc84BbhcueZbISS3FGoqEWc1FxIgDULIFbQQIAAA==
X-CMS-MailID: 20191120132645epcas5p29da16b1881e3da52fac0516a32e277d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191120132645epcas5p29da16b1881e3da52fac0516a32e277d5
References: <CGME20191120132645epcas5p29da16b1881e3da52fac0516a32e277d5@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the PCI Express base specification when PHY does not meet
ZRX-DC specification, after every 100ms timeout the link should
transition to recovery state when the link is in low power states. 

Ports that meet the ZRX-DC specification for 2.5 GT/s while in the
L1.Idle state and are therefore not required to implement the 100 ms
timeout and transition to Recovery should avoid implementing it, since
it will reduce the power savings expected from the L1 state.

DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.

We need to get the PHY property in controller driver. So, we are
proposing a new method phy_property_present() in the phy driver.

Platform specific phy drivers should implement the callback for
property_present which will return true if the property exists in
the PHY.

static bool xxxx_phy_property_present(struct phy *phy, const char *property)
{
       struct device *dev = &phy->dev;

       return of_property_read_bool(dev->of_node, property);
}

And controller platform driver should populate the phy_zrxdc_compliant
flag, which will be used by generic DesignWare driver.

pci->phy_zrxdc_compliant = phy_property_present(xxxx_ctrl->phy, "phy-zrxdc-compliant");

Anvesh Salveru (2):
  phy: core: add phy_property_present method
  PCI: dwc: add support to handle ZRX-DC Compliant PHYs

 drivers/pci/controller/dwc/pcie-designware.c |  6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 drivers/phy/phy-core.c                       | 26 ++++++++++++++++++++++++++
 include/linux/phy/phy.h                      |  8 ++++++++
 4 files changed, 44 insertions(+)

-- 
2.7.4

