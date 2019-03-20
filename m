Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD83CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6072146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XfSff+Pi";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="caLwdRjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfCTNFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:05:45 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43244 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727713AbfCTNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:05:44 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KD0pCs017944;
        Wed, 20 Mar 2019 06:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=5ALAM0VeOjtegeeW36Tu6N+b9c6M81OzJ/9z/OIpTa8=;
 b=XfSff+PiVsHPIPiMDj7BzGckZ8bbOU099550ojEdb+H5Gm4SpOwhdRau4DW7Mo+V9M2m
 HBcpEOO8MneAlEZNcTaOe9DZuf/8VhutMzKjBUwfPNFgAXjCfnlWaoetbAWl1Ap9RdEZ
 Niua6ME22xU01eDdvNKB2FmTRX/1qU7jKJFHONoBo/KQPE8oikzujVxSgvo/bywMQEug
 s+PUjv7IbPUfOcx9/1ME497LEIG4EB7jZXNxgwEUI3pYOc7LYEYxYg0eL7jPz/XZMC4e
 NFG71IN7q4/gMsV8sRT4rJReOpFJDob2pyuMNDIsEogVgLoN2sVrtVuIR6C+Z9toRTdU oA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2rbjvm0mnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 06:05:41 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Mar
 2019 06:05:41 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Mar 2019 06:05:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ALAM0VeOjtegeeW36Tu6N+b9c6M81OzJ/9z/OIpTa8=;
 b=caLwdRjz/bMEhcrieNq3aUIgTn0EGYrhtEF8KK9/HiQH+0RGsf7VmMaAyZtjqVZ568q/t22b6xzedZwJFB7YiP8WZKljp7wqOVZVpOtGZVDX3GjIxCzlyrbzbcjWD5AUmjPYE+P4HiKSjlkueat0yfy39oVsa0oG6cEn45iBCCQ=
Received: from BL0PR18MB2305.namprd18.prod.outlook.com (52.132.30.25) by
 BL0PR18MB2114.namprd18.prod.outlook.com (52.132.29.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 13:05:37 +0000
Received: from BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6]) by BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6%5]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 13:05:37 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Robert Richter <rrichter@marvell.com>,
        Marcin Benka <mbenka@marvell.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] efi/arm: Show SMBIOS bank/device location in cper and ghes
 error logs
Thread-Topic: [PATCH] efi/arm: Show SMBIOS bank/device location in cper and
 ghes error logs
Thread-Index: AQHU3x2cV70WfhNTtU+XgdynIdKhbw==
Date:   Wed, 20 Mar 2019 13:05:37 +0000
Message-ID: <20190320130502.16667-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0086.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::27) To BL0PR18MB2305.namprd18.prod.outlook.com
 (2603:10b6:207:43::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [77.191.24.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 293d1a14-247e-4432-d8c0-08d6ad34bea0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR18MB2114;
x-ms-traffictypediagnostic: BL0PR18MB2114:
x-microsoft-antispam-prvs: <BL0PR18MB211449D2319EAFE1B298FC47D9410@BL0PR18MB2114.namprd18.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(105586002)(53936002)(68736007)(5660300002)(26005)(71190400001)(36756003)(1076003)(478600001)(8936002)(2906002)(316002)(4326008)(186003)(50226002)(102836004)(71200400001)(25786009)(14454004)(6116002)(3846002)(66066001)(476003)(6506007)(486006)(386003)(54906003)(7736002)(2616005)(86362001)(99286004)(305945005)(6512007)(6916009)(256004)(106356001)(81156014)(6436002)(52116002)(4744005)(6486002)(81166006)(97736004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2114;H:BL0PR18MB2305.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tj2SoEWb5IoZnZhYdIDfsILKv445T8T1Fag4OzR+0xsS1aEt4GLGxzdTtu/uWKZupPzim4gD/egIeRKNz/IHof9DoLMKHRTRwwvkpx6t+za6q0aAYoyJz9/zYqcL4RKgH/Q6E/BL4WI/FKgFp1USBHj4lNqzM+jaNw2cHveQ0GBjBFyNtttZFCKgSuolBNz9JWmV+XKOPNAfPYPKHJuQ8hDIWopAabFy4pJaoVy92fVa49NXhffyccFdQzlRF4d/XCmfyThr2Yqyk86s/Ijbe6n7KmFT2zXjczUT7AkEhGMw5Qzjq2WF8JlWcLDV7E+nLz4h7/4s48BGmnUtg8sG3WTpNLKKDNZOFz+kjSeU7vWWZCKHzoq5JqVP27fXUjSizqGlcwhbSs68MV8wXB7NDRSI89+G5rEdg/oFuacV5x4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 293d1a14-247e-4432-d8c0-08d6ad34bea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 13:05:37.5376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2114
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run dmi_memdev_walk() for arch arm* as other archs do. This improves
error logging as the memory device handle is translated now to the
DIMM entry's name provided by the DMI handle.

Before:

 {1}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0038

After:

 {1}[Hardware Error]:   DIMM location: N0 DIMM_A0

Signed-off-by: Marcin Benka <mbenka@marvell.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/firmware/efi/arm-runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-=
runtime.c
index 0c1af675c338..4a0dfe4ab829 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
 	 * itself, depends on dmi_scan_machine() having been called already.
 	 */
 	dmi_scan_machine();
+	dmi_memdev_walk();
 	if (dmi_available)
 		dmi_set_dump_stack_arch_desc();
 	return 0;
--=20
2.20.1

