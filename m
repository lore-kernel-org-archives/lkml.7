Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBBCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA46D2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VB5gGVZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404814AbfJWLbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:31:34 -0400
Received: from mail-eopbgr790085.outbound.protection.outlook.com ([40.107.79.85]:53228
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404623AbfJWLbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:31:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYp1szeCrdBX5D4WrdnbvovkYqT3GGaHiUmG/cIbiVFY+lgNMJJFux3gSGq3K63lQjevZSfxQUuFqJsa3Zjxp95oz0bXa0QYHuvQh2BuB046jVl5Zw2MRYchxYngrU84MtnheE7PfQk22N9eH70LIx81ESkgoY6LvBEuZhWKFXcNmAGftt1FNNJ3uJEBOg+8mwUFXOm6j24Ko23R5H7kAPfgT7KjvIg3emCFHGb5SP6VBVZP+M13IW2lY9Sdny/PsHaoLuWgWVyzeqrZKdt3MSJFzHqIITRlqzg3OtFrfTp4nZ4i873VeFNYnFCzDW12ZH1ONzeathEXUQXrzHmjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npmfE/tkZaYmvkD0n9DLvMUXircM9q1alJkrOdza/oI=;
 b=doYpJD1oQG5CCEjzgcG8fpKqxGtb0Vs0ZH+47xqrajm1l/CNiwgZw9NM87TS74RNw8gX58VWegAuYE59zW7qzg/Qv0AEGHrUeGfdVzNFYEnYVcM+AbcGM6rf566VEzhXmGrTYXzjYsK8CUn46VyT5mpVoiOazsDpN/lRbSe39IHFkUiL1DVpxuNOGwat4fflQBcXYuP1N9adlKrcKptTah0AMBVA99ZCAyL/iOcPDC+nxnwxUEL4q3xOJOnzAN/+s0Rpz0SPDXrzgOqTKeeuApI03XtViFhnucotOzHZwtzXP/9f2HVuvfD/UDyLZ0wGzQa9ORBb1QIm6w62hfxB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npmfE/tkZaYmvkD0n9DLvMUXircM9q1alJkrOdza/oI=;
 b=VB5gGVZLlD4oKbzou4Sv3LJKuk1n00uUuVsTFtw7K6JUFS0Tn/9Se9oZDvUeN5DJP3kacyiHCuv054CFeF7tX7Lfiu7sNRbHGK5qEqTl53w9cd1MHRpHs8miOqd95u0p338m3vecqLFDmwkghBVHTcvEIin78gbRNeX61UVIjN0=
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1527.namprd12.prod.outlook.com (10.172.66.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 11:30:59 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::a1f5:6f09:5c0d:78f1]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::a1f5:6f09:5c0d:78f1%11]) with mapi id 15.20.2387.019; Wed, 23 Oct
 2019 11:30:59 +0000
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>
Subject: [RFC PATCH 1/2] tee: allow compilation of tee subsystem for AMD CPUs
Thread-Topic: [RFC PATCH 1/2] tee: allow compilation of tee subsystem for AMD
 CPUs
Thread-Index: AQHViZVXYwPDZzKzU0iEL5F5XTGWbQ==
Date:   Wed, 23 Oct 2019 11:30:58 +0000
Message-ID: <030ac9242b6a3a6c2f529326a7c24cfd29a009ac.1571818136.git.Rijo-john.Thomas@amd.com>
References: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e984a883-f1b6-407d-0e9b-08d757ac79c2
x-ms-traffictypediagnostic: CY4PR12MB1527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB15273188EE6105E5BAD56DBCCF6B0@CY4PR12MB1527.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(99286004)(71200400001)(118296001)(6512007)(25786009)(71190400001)(66946007)(50226002)(3846002)(6116002)(6436002)(316002)(478600001)(66066001)(76176011)(52116002)(2201001)(66476007)(66556008)(64756008)(2501003)(36756003)(4326008)(66446008)(54906003)(110136005)(8676002)(486006)(8936002)(256004)(14444005)(2906002)(6506007)(6486002)(386003)(81156014)(14454004)(476003)(2616005)(5660300002)(305945005)(86362001)(102836004)(7736002)(186003)(11346002)(446003)(4744005)(81166006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1527;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hLCXJht8ibFy0Dhu5+gdCXkTFxWRM22GdYPF8vPlHu6laa82d7A+evseeXGKln5tmwy2iOkAHGoBgcYWox3lyAvuj67wTLOkIwiXJNtrY/WxkC5AyNacXcCvsxEl1yrey5NZ2fShFdF+Re9rlx1uCe7S0HxM4HHHby3NpAo5dTBYXQ5Cfs7vNcc8febY+1GXbKAwhrok8sonlnWKiowCF32da05UlS2GIwyq3ZB/6qJWXaIpLChMNd5woH9EjtSLAP7g+HlMGwKPfIU4UxD97Wf8hAIYLhJJqpXBm6nbSoay4IDWZfnn15xaE+n80DarGs626Ohyh3V6/v60KAw0BIpOyjLhg55qKpRsaxg9L76RVRrVQz9vMiC0gLYTbkQPOnxhIiAj8rA4xm2yen8cc4Ez4CHmIqTwS6jxuVaTRcqszMqsCiiNHb9dr/gDulKg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e984a883-f1b6-407d-0e9b-08d757ac79c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 11:30:58.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ov23O++FST7QDYf5Yg+J/GMOVM7pvd58iECFIrlBX+YZ1bOUogSrhcU7PXkoEuQA0BqOAacD5puJ4KvCKmPHDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow compilation of tee subsystem for AMD's CPUs which have a dedicated
AMD Secure Processor for Trusted Execution Environment (TEE).

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
---
 drivers/tee/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 676ffcb..4f3197d 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -2,7 +2,7 @@
 # Generic Trusted Execution Environment Configuration
 config TEE
 	tristate "Trusted Execution Environment support"
-	depends on HAVE_ARM_SMCCC || COMPILE_TEST
+	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
 	help
--=20
1.9.1

