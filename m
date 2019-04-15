Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6E0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CqKws8Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDOJRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:17:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29106 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbfDOJRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:17:52 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3F9F8SD019506;
        Mon, 15 Apr 2019 11:17:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=WKcDVUt3eJxya8lvec0kpB+XZOCrE6KUNKvsxWE1Hxo=;
 b=CqKws8JxZPv4IZQ/c18aEPbYBi4WaucwEBk8at7l9u2kLGf1a5bIsEXpDVBJO8I9dewU
 n8Fk1Fjm0AGoTJ4SGxSpN+WGYap2fLkmF/pmoFJyeVo3rm21uALfCLqSF/UwN+Ai3q/O
 ZnMNSrwRniR9qjJD5kiodXbh3aWQdrTva9KFsv27Ja/dNqJ/V7You+8nwWkizLDlgFPw
 4AI+GFg1JAWTw8LRZlIE1y3HLQ8LoNKgKGNOENxuRFQ+tJSwFnHmc7SPIxHwIx+2Exfe
 3SA4YbMn1Yj+1XZt2U5JcDHFHEZ3fFnkWjaSwPT5HNNBXFdaCi4rXJduhLQgCcDFvbjQ ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ru4w81xt1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Apr 2019 11:17:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F188531;
        Mon, 15 Apr 2019 09:17:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E797145B;
        Mon, 15 Apr 2019 09:17:37 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Apr
 2019 11:17:37 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 15 Apr 2019 11:17:37 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/2] Add support for STM32MP1 power regulators
Thread-Topic: [PATCH v2 0/2] Add support for STM32MP1 power regulators
Thread-Index: AQHU82wRryk5xo81okmIoqW6eJ8QHw==
Date:   Mon, 15 Apr 2019 09:17:37 +0000
Message-ID: <1555319855-2982-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The POWER block of the STM32MP1 integrates 3 fixed regulators with a ready
status bit for each one. The goal of this patchset is to add support those
regulators.

Pascal Paillet (2):
changes in v2:
* add COMPILE_TEST switch
* do not test ready in is_enabled() callback
* remove of_regulator_match
* change author

  dt-bindings: regulator: Add stm32mp1 pwr regulators
  regulator: Add support for stm32 power regulators

 .../bindings/regulator/st,stm32mp1-pwr-reg.txt     |  43 +++++
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/stm32-pwr.c                      | 190 +++++++++++++++++=
++++
 4 files changed, 241 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1=
-pwr-reg.txt
 create mode 100644 drivers/regulator/stm32-pwr.c

--=20
1.9.1
