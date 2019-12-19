Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4531FC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C162465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gXqqZMtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLSKgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:36:08 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21166 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfLSKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:36:07 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJAWcHB023188;
        Thu, 19 Dec 2019 11:35:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Iemh3RU/aIK2iehtIHFQuSP9XvVK+0CTJ21s2KN63yo=;
 b=gXqqZMtt1rmXVv8DSNqowaaZF4CP5ipsS+CfHYPDclIlhMGNjgvC3kxymw3NCIhfk0KE
 T5DvKrwgHt3a+8s7URBKXpykwiUPAMK3ND/B8JIsTjaSzhs11IldghDLHb7J32f4H0oV
 HN63TEwVe7Q/GTCM9a0I6k4LJw07OtB+vRgmRELcvlpDBuVwr2fFpheErYYIMNRwoMMf
 4yIAMuw+E/LXFw1zUPZjrMFDr9RzHyub6GyY0sk7hCH2k19PaQjA8M2hp1SQ6fAu+Ikb
 HA9Z9SBVGmO0SeWO6+dfv5mERJaEyTuUtbNucceK3ZAinG+jADU2H12If5VY7dmHL35H tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1s21e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 11:35:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 04B32100039;
        Thu, 19 Dec 2019 11:35:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C51142A467F;
        Thu, 19 Dec 2019 11:35:40 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 19 Dec 2019 11:35:40
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kgene@kernel.org>, <krzk@kernel.org>,
        <hminas@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <amelie.delaunay@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/2] Add yaml DWC2 bindings
Date:   Thu, 19 Dec 2019 11:35:34 +0100
Message-ID: <20191219103536.25485-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert DWC2 bindings to json-schema and fix issue in dtsi file.

Benjamin Gaignard (2):
  dt-bindings: usb: Convert DWC2 bindings to json-schema
  ARM: dts: exynos: Remove unneeded "snps,dwc2" from hsotg node

 Documentation/devicetree/bindings/usb/dwc2.txt  |  64 ----------
 Documentation/devicetree/bindings/usb/dwc2.yaml | 152 ++++++++++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi               |   2 +-
 3 files changed, 153 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/dwc2.yaml

-- 
2.15.0

