Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A2FECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239A4217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yb7HnUNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfJNUGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:06:50 -0400
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:57766
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731587AbfJNUGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:06:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxjW+UcLbGwTq7lS+FQ7QbqEVlVvXDnk+QpGub0ETz3WDzXZ0EYkJ6HTRWF8DwzW/LioHJXcJ7Md5+SUdFh0iZJpFeRQL55HXI6m2Ot0s6fyayR0pIq1Y/Vxu501a21JuTL1AbZFU8rAwAbBdlrldmnn3ajwGrbnP6iMU30CduPR2aXGUZ24KZE+q9kXDu2+4l6Po1INGarZpyXEy5TuI6uEWTBV/wvCBTvJN/s6vNRUgt7A8Q2EEmrdHVTk5PJB6YN1x0G5XaUArB2sYmrwi8Q/8ZFycD6VzdEd35GBGyNTaxd9Dy4uqCdP+OCb84VIlzJY6lw9iM+l40RIVWZdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/KpP758CpRf1Fi28DghUz+s7y41AEStqVm+01oeXVM=;
 b=aU7pmR4foBlkpJCQ0fP9PMbJ4vwVwU6kz+ogLCsHNnUrKpvU5oD36qAOmajqChFHPlEA8/t3VgPjRYJqoIiGkMtymK/WB8260lc1zrUUmpliWtV7PB5PTgMRxwLOAaNZ22VYd/w9h8y4iqz1+Tt47khgakwFrnn9CHXgoFxGcEeZuuELb4sSN1C8H4nF5JfozgGX3KuCoXeFeklwd0XocyVT9faafvAzsfOt+yntG4sECocJdidIrTmG8KUvtFnvUQML+vW+E2mRozZNVYcac2hEEzZv3A7ALREXdB5Si/TfCIGnX9df2Or4vPVdwVedJVdMFTgUE2TRqShTJPA5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/KpP758CpRf1Fi28DghUz+s7y41AEStqVm+01oeXVM=;
 b=Yb7HnUNQ83/Xa7s8kwB41qr76pIH6HGDSQmRdTFWE6zCzn3s1OlKp8XKUGOw5FNgTNQ3ZJFGHZdQh2Wl8G7E54LkC1hOEW4ttDJwJALY4Lsfk0LUcOfGVDlb/j/V9P8uJdlryqEM3VgJz6PV1Ff/6+vMld7QKP4hCeCu4c36BEI=
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.173.210) by
 DM6PR12MB4219.namprd12.prod.outlook.com (10.141.185.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 14 Oct 2019 20:06:19 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::bc68:3310:d894:b9f]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::bc68:3310:d894:b9f%6]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 20:06:19 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Hook, Gary" <Gary.Hook@amd.com>
Subject: iommu: amd: Simpify decoding logic for INVALID_PPR_REQUEST event
Thread-Topic: iommu: amd: Simpify decoding logic for INVALID_PPR_REQUEST event
Thread-Index: AQHVgsrX2IfL/u/bTEWAs7DaX8bNqQ==
Date:   Mon, 14 Oct 2019 20:06:19 +0000
Message-ID: <1571083569-105988-1-git-send-email-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.78.1]
x-clientproxiedby: SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) To DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ed3db02-ba69-444d-8240-08d750e1fa25
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB4219:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42197F17B5FD5412179F9F94F3900@DM6PR12MB4219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(2906002)(2616005)(305945005)(476003)(4720700003)(486006)(5660300002)(4744005)(2501003)(7736002)(26005)(186003)(6116002)(3846002)(110136005)(54906003)(316002)(102836004)(6512007)(6436002)(6486002)(86362001)(66066001)(386003)(478600001)(99286004)(52116002)(4326008)(14454004)(6506007)(25786009)(64756008)(66556008)(66946007)(66446008)(66476007)(8936002)(71200400001)(81166006)(14444005)(256004)(8676002)(81156014)(36756003)(71190400001)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4219;H:DM6PR12MB3865.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNv3IbqPC4I8Z59TshlVLLTPeJUJpX999mNxqi/9zsZ+sSVga6a+ljCyl8JhAGJ6HLZXi7dqn5rCgYT7ymC3TJcwxjCgcOLzaek69GflXTHrF1ltZqeMj7CwTowvgljOg+H1/wW0oHofzYrlfvljrgxT9woO/UDYXRdx+iaexA5DFw8swzGz1CrIUB3405amvzKE/mPDQU9AGxSiJ/+Jcuz8a+WBjN85pvWRf/nsiU/xeJfR3rTTZNgcF+596JTgXrPgEtZ0R/dMjJndYbQHZ7KfqcwlJFCZiT/tntsn81bOLhrqXSnZIwv8o5uaaGKupsH9aYWos7VzR4gj5wwW6LgjWVYXFA/NV+cUEKMiOKZhkzucmyyNUaw74zABX3seweCWAo5CRJr+XtnQG+F8rDhoSh5GmA5lM6Tex4APPj4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed3db02-ba69-444d-8240-08d750e1fa25
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 20:06:19.2009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBCAOjjYi4zsM4krLKAs3gaZhVRdZ7vnhoZsrBORgH1XFOkyF88ZWF+ecMIN5bNS0RMOjkhGA1KikGBNWfLRrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse existing macro to simplify the code and improve readability.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c1cb759..b249aa7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -617,8 +617,7 @@ static void iommu_print_event(struct amd_iommu *iommu, =
void *__evt)
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_INV_PPR_REQ:
-		pasid =3D ((event[0] >> 16) & 0xFFFF)
-			| ((event[1] << 6) & 0xF0000);
+		pasid =3D PPR_PASID(*((u64 *)__evt));
 		tag =3D event[1] & 0x03FF;
 		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=3D%02x:%02x.%x pa=
sid=3D0x%05x address=3D0x%llx flags=3D0x%04x tag=3D0x%03x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
--=20
1.8.3.1

