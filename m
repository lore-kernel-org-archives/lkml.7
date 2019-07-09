Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558BC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4338F216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="ncXc0bvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfGIHea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:34:30 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61820 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:29 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 03:34:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656767; x=1565248767;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IKnKR+7MnhE7QQSAv7QSA+JPPlLOOURTMuIT2GV5+rc=;
        b=ncXc0bvgabXx7oBwILfY/8GPH5ENCTnXxsnuJC3Vk+ePQik4u3MI8iGzSNYVFzPb
        OJRUPPpVPCj9iXX1+d8AVph1biit+rD5Q3mbChsDAcGlbMK9VLu/xy/jdL3epQWY
        u5VQGyaOwNnAJz5SA8CX8cfvdsNo9sx/iwKo2MG7RwU=;
X-AuditID: c39127d2-17dff70000001aee-ff-5d243fff46f1
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 17.B0.06894.FFF342D5; Tue,  9 Jul 2019 09:19:27 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192732-309703 ;
          Tue, 9 Jul 2019 09:19:27 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 00/10] Add further support for PHYTEC phyBOARD-Segin
Date:   Tue, 9 Jul 2019 09:19:17 +0200
Message-Id: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:27,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:27,
        Serialize complete at 09.07.2019 09:19:27
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWyRoCBS/e/vUqswfc+PYv5R86xWjy86m+x
        aupOFotNj6+xWnT9WslscXnXHDaLpdcvMlk8uNjFYtG69wi7xd/tm1gsXmwRd+D2WDNvDaPH
        jrtLGD12zrrL7rFpVSebx+Yl9R4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqRvl0CV8a3pkmM
        BS9EK75PecXcwHhKqIuRk0NCwERi/am1rF2MXBxCAjsYJTZNPsIO4VxglLiweTYLSBWbgJHE
        gmmNTCC2iECkxLvtv8GKmAX2MEpMu36dESQhLOAi8WfnajYQm0VARWL53BZ2EJtXwENi+8IP
        7BDr5CRunutkBmmWEGhkkmi/eoAVIiEkcXrxWeYJjDwLGBlWMQrlZiZnpxZlZusVZFSWpCbr
        paRuYgSG3uGJ6pd2MPbN8TjEyMTBeIhRgoNZSYR3n7tyrBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHeDbwlYUIC6YklqdmpqQWpRTBZJg5OqQbGtW9P/3e7v863II/94YeCo9uKNOXPJUlIiAcu
        39KsE6C2JjVR8pxk1vanUokGqmW/eFdrxLGseLDriiRDQNm/GSvO3cspv2pj8ueLr/aMA1Ir
        jp2Y+7/pXroh+zObCyEPP/wRSs6UO71DYrV9mWRfu/jqnv2HPz3QYZBrWXUjd8m6B596qs++
        VmIpzkg01GIuKk4EAF0Fd88rAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchstack adjusts the already existing naming for the PHYTEC
phyBOARD-Segin to the PHYTEC naming scheme that is already used with the
phyCORE-i.MX 6 and the phyBOARD-Mira.

Furthermore it introduces some small fixes and adds support for the PHYTEC
phyCORE-i.MX 6ULL which also comes with the phyBORAD-Segin. It comes in a
full featured option with either NAND flash or eMMC and a low cost option
only with NAND flash.

Stefan Riedmueller (10):
  ARM: dts: imx6ul: phyboard-segin: Rename dts to PHYTEC name scheme
  ARM: dts: imx6ul: segin: Add boot media to dts filename
  ARM: dts: imx6ul: segin: Reduce eth drive strength
  ARM: dts: imx6ul: segin: Fix LED naming for phyCORE and PEB-EVAL-01
  ARM: dts: imx6ul: segin: Make FEC and ethphy configurable in dts
  ARM: dts: imx6ul: segin: Only enable NAND if it is populated
  ARM: dts: imx6ul: phycore: Add eMMC at usdhc2
  ARM: dts: imx6ul: segin: Move ECSPI interface to board include file
  ARM: dts: imx6ul: segin: Move machine include to dts files
  ARM: dts: imx6ull: Add support for PHYTEC phyBOARD-Segin with i.MX
    6ULL

 arch/arm/boot/dts/Makefile                         |  5 +-
 ...-pcl063.dtsi => imx6ul-phytec-phycore-som.dtsi} | 51 ++++++++----
 ...ull.dts => imx6ul-phytec-segin-ff-rdk-nand.dts} | 42 +++++-----
 ...1.dtsi => imx6ul-phytec-segin-peb-eval-01.dtsi} | 16 ++--
 ...hyboard-segin.dtsi => imx6ul-phytec-segin.dtsi} | 31 ++++++--
 arch/arm/boot/dts/imx6ull-phytec-phycore-som.dtsi  | 24 ++++++
 .../boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dts  | 93 ++++++++++++++++++++++
 .../boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts  | 93 ++++++++++++++++++++++
 .../boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts  | 45 +++++++++++
 .../boot/dts/imx6ull-phytec-segin-peb-eval-01.dtsi | 19 +++++
 arch/arm/boot/dts/imx6ull-phytec-segin.dtsi        | 38 +++++++++
 11 files changed, 409 insertions(+), 48 deletions(-)
 rename arch/arm/boot/dts/{imx6ul-phytec-pcl063.dtsi => imx6ul-phytec-phycore-som.dtsi} (72%)
 rename arch/arm/boot/dts/{imx6ul-phytec-phyboard-segin-full.dts => imx6ul-phytec-segin-ff-rdk-nand.dts} (51%)
 rename arch/arm/boot/dts/{imx6ul-phytec-peb-eval-01.dtsi => imx6ul-phytec-segin-peb-eval-01.dtsi} (84%)
 rename arch/arm/boot/dts/{imx6ul-phytec-phyboard-segin.dtsi => imx6ul-phytec-segin.dtsi} (91%)
 create mode 100644 arch/arm/boot/dts/imx6ull-phytec-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-phytec-segin-peb-eval-01.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-phytec-segin.dtsi

-- 
2.7.4

