Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47667C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A9220883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="APNP1Dza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDIGQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:16:27 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50509 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbfDIGQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:16:23 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3969APK007518;
        Tue, 9 Apr 2019 08:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=kh32B1OWRnn2BNOeOfNarSQ1pnPzxrLRQpzzeN+BeLw=;
 b=APNP1DzaavXRQWmNzMjYvx/OH+ep4gU2zppmIx+eek0jaAvrwzlOmbE8aSuCUagfBAMB
 J6HduaN68IQ9fk465/ACmYF9eSFIV0lO4hc8PCcsjguocLdN7fPbJs+JcCuP4MRvNurQ
 0GlNHWdrl7iP+6tW948nTVV88xTx8H6mO5taH0DvcZV1LpUQf7LeHL9pC2f4o+nMzGB1
 oLQ3bISU1C59PIk3Qqk3yKGSDV6zT0FaXXbXHPj1LjQAZmDC1mOEEPl5rMIuNV2BhHb+
 vZECviTkbgkPdynvPmnDbZP8cPpBZ1il+mOw5mSpz1a6IMXR04zRmmX+djlZUwKtF8kL yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprkdep54-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 08:15:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49E5C34;
        Tue,  9 Apr 2019 06:15:56 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F07FA2412;
        Tue,  9 Apr 2019 06:15:55 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 9 Apr 2019
 08:15:56 +0200
Received: from localhost (10.129.172.100) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 9 Apr 2019 08:15:55
 +0200
From:   Mickael Guene <mickael.guene@st.com>
To:     <linux-media@vger.kernel.org>
CC:     <hugues.fruchet@st.com>, Mickael Guene <mickael.guene@st.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        <devicetree@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Subject: [PATCH v5 0/3] Add support for MIPID02 CSI-2 to PARALLEL bridge I2C device
Date:   Tue, 9 Apr 2019 08:15:46 +0200
Message-ID: <1554790549-795-1-git-send-email-mickael.guene@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.129.172.100]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v5 of my MIPID02 series which introduces support of
STMicroelectronics MIPID02 CSI-2 to PARALLEL I2C bridge. It allows using a CSI-2
sensor with a PARALLEL interface. Current driver implementation doesn't support
CSI-2 second input port usage. It doesn't support also YUV420, RGB565 and RGB444
input formats.

Thanks to Sakari for review.

Changes in v5:
- Typo
- Remove useless MEDIA_CONTROLLER from Kconfig
- Replace v4l2_fwnode_endpoint_alloc_parse usage by v4l2_fwnode_endpoint_parse
  since not more variable size data usage
- Add missing mutex_destroy calls
- Switch to probe_new since I²C ID table is not used
- Add new patch to add MEDIA_BUS_FMT_BGR888_3X8 needed output format
- Add MEDIA_BUS_FMT_BGR888_3X8 usage in serial_to_parallel_code

Changes in v4:
- Fix and clarify endpoints properties documentation
- Add support of enum_mbus_code
- Only use V4L2_CID_PIXEL_RATE to compute link speed
- Use MEDIA_BUS_FMT_UYVY8_1X16 instead of MEDIA_BUS_FMT_UYVY8_2X8 for CSI-2 link
- Fix miscellaneous typos
- Fix wrong code behavior for set_fmt and get_fmt

Changes in v3:
- Fix potential wrong error code for mipid02_stream_disable and mipid02_stream_enable
- Remove useless memset for ep in mipid02_parse_rx_ep and mipid02_parse_tx_ep
- Add second CSI-2 input pad even if it's not yet supported
- Add support of get_fmt, set_fmt and link_validate and only access subdev connected to mipid02

Changes in v2:
- Add precision about first CSI-2 port data rate
- Document endpoints supported properties
- Rename 'mipid02@14' into generic 'csi2rx@14' in example
- Merge MAINTAINERS patch 3 into patch 1 and 2
- Fix line too long in Kconfig
- Add missing delay after reset release
- Various style fixes
- Fix mipid02_stream_enable returning no error when mipid02_find_sensor failed

Mickael Guene (3):
  media: uapi: Add MEDIA_BUS_FMT_BGR888_3X8 media bus format
  dt-bindings: Document MIPID02 bindings
  media: st-mipid02: MIPID02 CSI-2 to PARALLEL bridge driver

 .../bindings/media/i2c/st,st-mipid02.txt           |   82 ++
 Documentation/media/uapi/v4l/subdev-formats.rst    |  107 ++
 MAINTAINERS                                        |    8 +
 drivers/media/i2c/Kconfig                          |   13 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/st-mipid02.c                     | 1033 ++++++++++++++++++++
 include/uapi/linux/media-bus-format.h              |    3 +-
 7 files changed, 1246 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
 create mode 100644 drivers/media/i2c/st-mipid02.c

-- 
2.7.4

