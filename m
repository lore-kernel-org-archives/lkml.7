Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE6AC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54A42075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QAJLln2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKYK1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:27:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9554 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbfKYK1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:27:21 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAPAR8Jf008268;
        Mon, 25 Nov 2019 11:27:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=JQQc+TZBsDysMWIa2Q9eivvaXwP3EA8yawln7WVtzwo=;
 b=QAJLln2KJAVwx3plWGTXdhZfpOLmJfkuxW/s0PWJ7QPNTdeuXsrF3NzSCVuLIpicpw2p
 dgi38Bt3m05T3PBg+VGkz7Sj9ki6IB93UsVcaQm0nGV+4a2Di8YvowxaBqfr0l3glKt2
 fUrK2qx/eGIqMBUJ4Yw3wDg1hgm1XsTQ7fl3VLdcBqOs9qZfcwYRl+hka9Np2T4VFqF+
 A9Vqbzrj3/SvL5cXIkcZkD1iZvSrwUxZADmPhqJkvuGRntIGPFshbaJAUgSkVJFOwOR9
 fEyMNI4oX17iXab0LIdstPazMFWiSM0m94fiPt0p6YLsm2TAkcA1R2SiOnTHe9lwBkw3 uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2weu428m9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 11:27:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDF08100034;
        Mon, 25 Nov 2019 11:27:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B86092B0115;
        Mon, 25 Nov 2019 11:27:10 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Nov 2019 11:27:10
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/2] USB DWC2 support for STM32MP15 SoCs USB OTG
Date:   Mon, 25 Nov 2019 11:26:57 +0100
Message-ID: <20191125102659.22853-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_02:2019-11-21,2019-11-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for STM32MP15 SoCs USB OTG HS and FS based on DWC2 IP.

STM32MP15 SoCs embeds a DWC2 IP that can be used in HS or in FS, and
uses an external Vbus and ID level detection to support OTG operations.

Amelie Delaunay (2):
  dt-bindings: usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and
    FS
  usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS

 .../devicetree/bindings/usb/dwc2.txt          |  5 +
 drivers/usb/dwc2/core.h                       |  8 ++
 drivers/usb/dwc2/hw.h                         |  8 ++
 drivers/usb/dwc2/params.c                     | 33 +++++++
 drivers/usb/dwc2/platform.c                   | 94 ++++++++++++++++++-
 5 files changed, 146 insertions(+), 2 deletions(-)

-- 
2.17.1

