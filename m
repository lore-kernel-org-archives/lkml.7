Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF2DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED37921721
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oC/+wPIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfJNUGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:06:48 -0400
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:57766
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730668AbfJNUGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:06:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJW5MulbjQJfO9Zx1cBIvHehEduvC/M62wbz+tSvwRl9AlWx8HOJZtPmgjk62/N06Bu4OW6ueWG8ACfOxnG2JtQw5+54WJa5oHP/ZoJSfGovo+b6U4JDeSZqmOgrCUz0/kpsRv1cVMbfP6vXPSaknJCy5g75JNOeqtEl0muc2OyhUJXkEw3ySKJ7Y+IjboJg4TjQKRe5NATHLexJALidwN/E2xqvsEYDaIgIzosx1hJzIVBY83PDSwri/fUnuusRp+Zp9pekNVSW2oMBGz/S4Q8lpAAiLqBK0lRx9QFsT2teCVRpwU9CDvZXNcXuTkmiO5ViXe6CVOKh74QjBhDZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HPeyf/pa/E0MM6IT3y8kgR9rH5EtHJz0Oo0YluY5pU=;
 b=IT3rg+eDpOG9NirQgj6MNeKGMZ2NmXKWDzTDxIr2ZWe8IXfD+PsXF/lpHMXzBoQz5eqEM5bHyxGwSZGjBZjkNZDGHCeO/W9Bmmm0T+HZaWjN/Daun45PlDROV+6lF3qLn4IsVLde3utudVRMzLi1gTLfcugpCJw9REh5Bae7F3peFiPi4wVix4TM1PWJz4LMzdVKsHrf6yu5cC9ACMGRXjk5DfEjvYRkFHqBDPRWq0m+pfFlBKFbj54uzASIvgqR8fgWfDs1eaWdH4bwGPgf1p9Q3q1itdP2iPzWQQL3cUB1BB3viPKGaECZVhYRKqlHW2NpJz4WKOn4Tltj5WJk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HPeyf/pa/E0MM6IT3y8kgR9rH5EtHJz0Oo0YluY5pU=;
 b=oC/+wPIJ1M4FKCchofruXQ1dYxKJp1R47W1ctwc6yypNRTYcaOmpyB6qJQvfGDLV95wtjakZYV4UFt62aLyaUD9O6jrEHEvsNq7jSesyrGcgojEm8BdWDMNqwmRXmT5e+m+wUbE43eLvggC0n22DlvYH3Cy4pTF/Ot5dU8vj57E=
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.173.210) by
 DM6PR12MB4219.namprd12.prod.outlook.com (10.141.185.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 14 Oct 2019 20:06:05 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::bc68:3310:d894:b9f]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::bc68:3310:d894:b9f%6]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 20:06:05 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Hook, Gary" <Gary.Hook@amd.com>
Subject: iommu: amd: Fix incorrect PASID decoding from event log
Thread-Topic: iommu: amd: Fix incorrect PASID decoding from event log
Thread-Index: AQHVgsrPdl9GRCYLTU2HHFF53nj1jA==
Date:   Mon, 14 Oct 2019 20:06:05 +0000
Message-ID: <1571083556-105953-1-git-send-email-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.78.1]
x-clientproxiedby: SN4PR0501CA0138.namprd05.prod.outlook.com
 (2603:10b6:803:2c::16) To DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5ff6ee0-4790-450f-b1af-08d750e1f1f5
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB4219:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4219F7025D0FBD81A0D8BA12F3900@DM6PR12MB4219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(2906002)(2616005)(305945005)(476003)(4720700003)(486006)(5660300002)(2501003)(7736002)(26005)(186003)(6116002)(3846002)(110136005)(54906003)(316002)(102836004)(6512007)(6436002)(6486002)(86362001)(66066001)(386003)(478600001)(99286004)(52116002)(4326008)(14454004)(6506007)(25786009)(64756008)(66556008)(66946007)(66446008)(66476007)(8936002)(71200400001)(81166006)(14444005)(256004)(8676002)(81156014)(36756003)(71190400001)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4219;H:DM6PR12MB3865.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gibv7bejov2pDWa9l98z8NfwHOrRpyqSeF95EGSGgSrAEzber08M1MSaOmhQFR4etb2qfnVvbDbyP4PkK9sSG2SHhMyBnpialhCILmsHtA5k/A0kGGFPK7I/wuOH9zxVXWLdhkP30HAR7R4bubB9LJ/i8EdDH1Mrjom2sh3jUXHexNaF6iLluZ6oXzJFsJDaq3RF+AIdVqMqRjYAh6SOoPrt2Yha1vBShkR4+H76SutCBxbequCLZb9VHOR4kV0m0w/p1BonlYM/OX8tGKqKSGykGkMeKh5Sl9U/A6Zt/6eqE2E4m7walbkUa/dZQteEkkLtSyuDDtfzDe/b+GECdsg4hJCfwqy9uFVXhzLXnAlJZ1chaWVT2PCuCnCt01BetjbcCYdAc8m1z3pWWY5cZnTCg7cfs6uxNerBD8wUzsE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ff6ee0-4790-450f-b1af-08d750e1f1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 20:06:05.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cDm0DUo2AShycJiZ2y8/cUCJmJM2mGrMXIJi/zVKKAnE40EbR8xKMq4gKBPPERZN+A5aMhBrrgkVTQeuYNyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU Event Log encodes 20-bit PASID for events:
    ILLEGAL_DEV_TABLE_ENTRY
    IO_PAGE_FAULT
    PAGE_TAB_HARDWARE_ERROR
    INVALID_DEVICE_REQUEST
as:
    PASID[15:0]  =3D bit 47:32
    PASID[19:16] =3D bit 19:16

Note that INVALID_PPR_REQUEST event has different encoding
from the rest of the events as the following:
    PASID[15:0]  =3D bit 31:16
    PASID[19:16] =3D bit 45:42

So, fixes the decoding logic.

Fixes: d64c0486ed50 ("iommu/amd: Update the PASID information printed to th=
e system log")
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       | 5 +++--
 drivers/iommu/amd_iommu_types.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 61de819..c1cb759 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -560,7 +560,8 @@ static void iommu_print_event(struct amd_iommu *iommu, =
void *__evt)
 retry:
 	type    =3D (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
 	devid   =3D (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
-	pasid   =3D PPR_PASID(*(u64 *)&event[0]);
+	pasid   =3D (event[0] & EVENT_DOMID_MASK_HI) |
+		  (event[1] & EVENT_DOMID_MASK_LO);
 	flags   =3D (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	address =3D (u64)(((u64)event[3]) << 32) | event[2];
=20
@@ -593,7 +594,7 @@ static void iommu_print_event(struct amd_iommu *iommu, =
void *__evt)
 			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=3D%02x:%02x.%=
x domain=3D0x%04x address=3D0x%llx flags=3D0x%04x]\n",
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=3D%02x:%02x.%=
x pasid=3D0x%04x address=3D0x%llx flags=3D0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_type=
s.h
index 64edd5a..5a698ad 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -130,8 +130,8 @@
 #define EVENT_TYPE_INV_PPR_REQ	0x9
 #define EVENT_DEVID_MASK	0xffff
 #define EVENT_DEVID_SHIFT	0
-#define EVENT_DOMID_MASK	0xffff
-#define EVENT_DOMID_SHIFT	0
+#define EVENT_DOMID_MASK_LO	0xffff
+#define EVENT_DOMID_MASK_HI	0xf0000
 #define EVENT_FLAGS_MASK	0xfff
 #define EVENT_FLAGS_SHIFT	0x10
=20
--=20
1.8.3.1

