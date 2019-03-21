Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7418C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99508218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E0/kVBMA";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="tnx5BJ7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfCULJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:09:19 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43958 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727859AbfCULJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:09:18 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LB6IqD016262;
        Thu, 21 Mar 2019 04:09:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=yt6MkwNWcJjmCncKC6E3SKdNKUep+azFhJxre4WUDSA=;
 b=E0/kVBMArcw8mjvrXz4BeoWSajFeOXGr34XnDl+yRRV+B6g5hPTnYaNTMULlcHFrCmPT
 egZqxViGpVy3tHndTtLp700RZvnsL6v8f7LYtTsFgc6Jxb0keMyqmGlnIEE+Dp37NtpI
 im4N4Hcr9YQQRjtQDFpiuIvw63nZ6FeETIuOKrvwyEHnVOc18tzUT4gomX2/i7sAsuhm
 MPCWYBvh0HPvhnk+2o9M8mqodKr1lgH96EeE1B9tlb/eivGjN7kZUi8J4fdzfXmFjPfM
 jpXUrvgAIfjbnEWi+hx3ZmvXFbioPnA1YO5/pWqqSWmCC+o616WhjsHGHGN8MQp2gAbe 7A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rc051hanf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Mar 2019 04:09:08 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 21 Mar
 2019 04:09:01 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 21 Mar 2019 04:09:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt6MkwNWcJjmCncKC6E3SKdNKUep+azFhJxre4WUDSA=;
 b=tnx5BJ7tinIVrlcPC1UVKdJKuoXc+krXv8049P2eHJjtJEizvJEyiHvPLZYc8KJ34Dr9wLEP9lHNtySPYAsRAe8kEnAFkWwWTDTykMFx143LWY63WOnx/nklqSHR2FppXqK6//BwbAbB4xXcmDyFkOaOrqVEcaZBQoAZNs/8IwU=
Received: from BL0PR18MB2305.namprd18.prod.outlook.com (52.132.30.25) by
 BL0PR18MB2211.namprd18.prod.outlook.com (52.132.29.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 21 Mar 2019 11:08:59 +0000
Received: from BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6]) by BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6%5]) with mapi id 15.20.1709.017; Thu, 21 Mar 2019
 11:08:59 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Moving to @marvell.com addresses for Cavium
 ThunderX2
Thread-Topic: [PATCH] MAINTAINERS: Moving to @marvell.com addresses for Cavium
 ThunderX2
Thread-Index: AQHU39Z7ml8v/3ZEokigx4+LKvn4qA==
Date:   Thu, 21 Mar 2019 11:08:59 +0000
Message-ID: <20190321110741.19177-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:203:91::20) To BL0PR18MB2305.namprd18.prod.outlook.com
 (2603:10b6:207:43::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [77.183.166.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 685d279d-d079-424e-0285-08d6aded9dd3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR18MB2211;
x-ms-traffictypediagnostic: BL0PR18MB2211:
x-microsoft-antispam-prvs: <BL0PR18MB221110768FC148AA9CCAF03BD9420@BL0PR18MB2211.namprd18.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(386003)(5660300002)(81166006)(26005)(186003)(4744005)(8676002)(6436002)(316002)(110136005)(305945005)(25786009)(102836004)(52116002)(478600001)(1076003)(14454004)(86362001)(99286004)(54906003)(7736002)(256004)(71200400001)(106356001)(105586002)(6116002)(81156014)(71190400001)(4326008)(2906002)(6486002)(6506007)(50226002)(3846002)(6512007)(97736004)(68736007)(486006)(66066001)(2616005)(8936002)(53936002)(36756003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2211;H:BL0PR18MB2305.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UjlelECqpf/fuGk6iBE5lmK6ROuOV8irxl3YoT274gGQy8jhDyxWJttKUOIoS+hP6AYB/J5Bae4P0jdfMHhn5kAgHi97UGtAiujyddihHc9KnWTuD827RFPfTzg4Lk2P69qfpkEj++En/5fPO9sseujSejxL0197pFAFVcKX2wie2CMJM2YHxo9R5dgWIgETndtleLHdn2gM2tHHfBB4SRQ/KZ9QHjv4IvaN801Qb4JN/EpgbRmWS707dWc+88LxjDf07slgBQKmvZyDkV3e0s1N4tL6nanAkLRWAbAbsS5rrLj0tALqZ2Cv4vehPAQ1SICSx6nqBKoLPSfyyxGokwm/R+peFJBRUkCKIFkPoZ7Y2C02D/NC1B+/pIpkBMFEXIQblebF3k/2urGCBdE2KfXqR94qc28yFbPue0bDnHY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 685d279d-d079-424e-0285-08d6aded9dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 11:08:59.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2211
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our @cavium.com addresses will be switched off soon. Using
@marvell.com addresses from now on.

Cc: Jayachandran C <jnair@marvell.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7432224930b..37f0a2aed4bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3507,8 +3507,8 @@ S:	Supported
 F:	drivers/crypto/cavium/cpt/
=20
 CAVIUM THUNDERX2 ARM64 SOC
-M:	Robert Richter <rrichter@cavium.com>
-M:	Jayachandran C <jnair@caviumnetworks.com>
+M:	Robert Richter <rrichter@marvell.com>
+M:	Jayachandran C <jnair@marvell.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/cavium/thunder2-99xx*
--=20
2.20.1

