Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19424C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8122133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PUDlMH4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDIJIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:08:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbfDIJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:08:15 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x398pQsH001060;
        Tue, 9 Apr 2019 11:07:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=jkfgwpcIxE3G9T/+cG0LX3XxLIdDI5N05EhqdeQSYdw=;
 b=PUDlMH4nhEevgFRinbNK7r8J4OUosjqAS9FXRFJeZkNB1fu5Usa04ty+83jXA6oppAMD
 lcqOrNeij99jMfA936W+kUXwvOMlO0EFYHynBf1p7CNvyiw3PWHrM89ZAJuiDz9cHJuF
 MIJ1FT4rehPk3rRYj9w5AVdQEXaq2uE6+Ze+JDfhj4SaSI7KjY3/gHhTMjWb8mLmv9/E
 eND8DNRvPmV3pZ0iTi+CgKEb/yZ2HxNuGQgTHK2TnxKiyL6W3/YB4T2Uqt1AAAzO0voo
 0X6DG1AbVAMsEHMUcdhg6vfUclmM2HrUgihlpUG8jBQN/F1o5pOQDkMJAUdSkdL6Iokk xA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprkdfn0h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:07:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D4813D;
        Tue,  9 Apr 2019 09:07:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E68C22745;
        Tue,  9 Apr 2019 09:07:02 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 9 Apr
 2019 11:07:02 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 9 Apr 2019 11:07:02 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/3] Add support for STPMIC1
Thread-Topic: [PATCH v2 0/3] Add support for STPMIC1
Thread-Index: AQHU7rOYVkXnqrCUTEutZ7thnCZs0g==
Date:   Tue, 9 Apr 2019 09:07:02 +0000
Message-ID: <1554800820-5412-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for STPMIC1 on:
- stm32mp157c ed1 board
- stm32mp157a dk1 board
- arm multi_v7_defconfig

Pascal Paillet (3):

changes in v2:
* Describe why we disable the DMAs for PMIC

  ARM: dts: stm32: add stpmic1 support on stm32mp157c ed1 board
  ARM: dts: stm32: add stpmic1 support on stm32mp157a dk1 board
  ARM: multi_v7_defconfig: Enable support for STPMIC1

 arch/arm/boot/dts/stm32mp157a-dk1.dts | 158 ++++++++++++++++++++++++++++++=
++--
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 156 +++++++++++++++++++++++++++++-=
---
 arch/arm/configs/multi_v7_defconfig   |   4 +
 3 files changed, 294 insertions(+), 24 deletions(-)

--=20
1.9.1
