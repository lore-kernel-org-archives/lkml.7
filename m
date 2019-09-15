Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3CC4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101EA21479
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DpfGmWb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfIORHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:07:52 -0400
Received: from mail-eopbgr790088.outbound.protection.outlook.com ([40.107.79.88]:3756
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfIORHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:07:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCN1TMuWHykhw4NqoVOVPergJ2vhgYXNwDPB5jmLCIrkf4/RviwdZCJ3aLI0sr4kAAh9VAhUVCy+sSkCicMHGAt7MvekAMsCEu7CI8gaE4MzsNDe5I8Ft0bjnwiUyPeUfi0U013vmCODvGoauAUG7SThpL5XMnVKUf4e5YylVQ3ekSGPIebzfOoouG7VPVEPy6OgAKreEOoq1lEhFuojKvWBoEOk534H3qN94T6eFiAEiDOhffVEJsJ+hApOcR1RfuZ7j8yzYqHhg1U30rIk4GnmACnq88cIIr0VKn+hKjnXC/RVFhzBrC6i6gYzmJyQ/KfrSojF0hV6NhOhcHS8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DW0su9blBzZE5LiHq1P8zqfYeTGEHhK88zGeyL0e2Y=;
 b=Q0S3MAZ8/C72ikRq+abtZcqfaQbEyn7fdLCVaEQEhb9YfnIhQVm8mPHJdxAhVvWpPwQ6Stexeutj2dBbkgoaiJhN83qQwqwux0yzPOKOyL8xm/BZVR9krzKGhfpZcG0GcBmb+u5UL4xLiNUjL1pH3T8qvC5KA25vuX10DkVusl0jS2NJF6Ioc3wOMewApFz5L3kZRNvt4UgiR14gcTrrlZ9x2BJie9zr14wsjBWRjVcN4r8YtGvv9gXZnZK2FwLUylqNbfClALLNscDpbSjDoZ4M3q9zELxCROyJ7ewLa563+Db69gR9B2PpMTGGW8k9wJS5LL4UW+ouKi3csqj5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DW0su9blBzZE5LiHq1P8zqfYeTGEHhK88zGeyL0e2Y=;
 b=DpfGmWb6lfe5y+xK0mGGE7428X9uACrq5w9MQDudhGJRh7B4Fckj/SI9/nGczp2dLTQaVDNX8bGII4MXlPYhugYmxyKcbYk1i7Kx9OChRDr8gLxsxO+Z5jfeJma/2PAOZZZyWPr2bFbY7HaWZZpGyfPSiYxuRPtw0oZXBo770qI=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Sun, 15 Sep 2019 17:07:43 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2263.023; Sun, 15 Sep 2019
 17:07:43 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 1/2] ntb_hw_amd: Add a new NTB PCI device ID
Thread-Topic: [PATCH 1/2] ntb_hw_amd: Add a new NTB PCI device ID
Thread-Index: AQHVa+gW9+Bl/2VHLkO+yiE6eLNTog==
Date:   Sun, 15 Sep 2019 17:07:43 +0000
Message-ID: <1568567222-26810-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::16) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b058b68-e79e-428b-787b-08d739ff38d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3309;
x-ms-traffictypediagnostic: MN2PR12MB3309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33099C72D397BD8C578C1A6FE58D0@MN2PR12MB3309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 01613DFDC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(66476007)(66556008)(6436002)(36756003)(64756008)(66446008)(66946007)(7736002)(2616005)(186003)(2906002)(305945005)(14454004)(3846002)(6116002)(316002)(26005)(86362001)(2201001)(8676002)(50226002)(8936002)(81166006)(25786009)(81156014)(2501003)(71200400001)(476003)(71190400001)(54906003)(102836004)(110136005)(66066001)(6486002)(478600001)(5660300002)(486006)(6512007)(4326008)(6506007)(256004)(386003)(53936002)(99286004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3309;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jxNA6bIlbq3G1LTXhtyQq2vqMT1sDlkzaFoAFkleaQmGx5Sukv4o3jbgJeaCmhyA9KM3kbweoC8uLTbf7EgZt7mOIva3+DDk2j+dt1Ls36xg+dHdXx9Ix84UtXtmJKvhC6yTCNOJqvvGTEDVevLw4eI55hs7aJ8dtJJyadYmb0l6rJO7yUyk6oOvF+65tOh7Z8JaAWZRxk4iYK1bI8LT8npYxu3hEizBypK3jvy76I6WV+sCmbctdNXKflzeDpI8hb9eBrZFdcANp0padozOr9SB03Xvcurp/3BJbnceM653h8Djc+YCNDxz7RwcXdlmcbyOnNhokT+PPuQ2Sb8EwdIA8UaedL2cZzfnmwALzq7C3dOQO7zwGC4qHH1QxFWnU/+trkGwaH0VSd1DzhUsaZ4eWwEElj8aDo/qaXWCzCQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b058b68-e79e-428b-787b-08d739ff38d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2019 17:07:43.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dR1j+1TYHQLFh5RVc4aKlutNwJRDD3kViHoCtl+fJv0D3ZLPqD7fow4ArZcS1rIA6W3KLvESmgPGyyDvWpvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 3 ++-
 drivers/ntb/hw/amd/ntb_hw_amd.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_am=
d.c
index 2859cc9..e9286cf 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1124,7 +1124,8 @@ static const struct file_operations amd_ntb_debugfs_i=
nfo =3D {
 };
=20
 static const struct pci_device_id amd_ntb_pci_tbl[] =3D {
-	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NTB)},
+	{PCI_VDEVICE(AMD, 0x145b)},
+	{PCI_VDEVICE(AMD, 0x148b)},
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_am=
d.h
index 8f3617a..3aac994 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -52,7 +52,6 @@
 #include <linux/ntb.h>
 #include <linux/pci.h>
=20
-#define PCI_DEVICE_ID_AMD_NTB	0x145B
 #define AMD_LINK_HB_TIMEOUT	msecs_to_jiffies(1000)
 #define AMD_LINK_STATUS_OFFSET	0x68
 #define NTB_LIN_STA_ACTIVE_BIT	0x00000002
--=20
2.7.4

