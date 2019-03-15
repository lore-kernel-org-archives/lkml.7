Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F9C21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rGwpaX+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfCOPui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:50:38 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:44175
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbfCOPui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McnWUx5P0lZX73kBeDgpWW7IU1xH/fVRcmX3Vz5ZDBk=;
 b=rGwpaX+1XxSEBzufOLK1brj2PuqE3hWtQATpyNdY7y7epWvKqja+rL8NcDnz4LqSnoJOm2fX/ihDExsELtvwLvqAVdwAnvm8DTGVLBkKTz5qLmbrEMaCsL9tdtRXgJG1h26AclmbI95V+t++cxnMzo2qOV9SFH1D+ONhKhlOBMo=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB4083.eurprd08.prod.outlook.com (20.178.202.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 15 Mar 2019 15:50:34 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c%4]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 15:50:34 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH] drm/selftest:- Adding a new format(whose cpp=0) to be tested
 by igt_check_drm_format_min_pitch
Thread-Topic: [PATCH] drm/selftest:- Adding a new format(whose cpp=0) to be
 tested by igt_check_drm_format_min_pitch
Thread-Index: AQHU20bT2e2rOQ5Tp06QwdbFY2juqg==
Date:   Fri, 15 Mar 2019 15:50:34 +0000
Message-ID: <1552665027-16457-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::32) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a89f911-cf90-4508-789e-08d6a95df60d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4083;
x-ms-traffictypediagnostic: AM0PR08MB4083:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB4083;20:eABuWzQqiH65j+ZUs6JWVe9PcdrQWGYlOSegD9G9LPyzWQLFLkWBfViGnK9QWq8FX+DkZjbi7P/5RsMxnvU98sDCcSG/T9hZWLM57tLtzgqC+TfTgazjvPAbvW4lJRzpM9v2CqFKglWRDAKfyAKtY3bvEe445lIaMBfHoQBo6MA=
x-microsoft-antispam-prvs: <AM0PR08MB408351C21CDC92966EFC8F4CE4440@AM0PR08MB4083.eurprd08.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(2616005)(966005)(71200400001)(476003)(316002)(26005)(36756003)(71190400001)(97736004)(2501003)(8676002)(8936002)(4326008)(110136005)(81156014)(3846002)(52116002)(5660300002)(66066001)(6486002)(102836004)(68736007)(386003)(7736002)(6506007)(81166006)(186003)(305945005)(106356001)(6116002)(99286004)(14454004)(72206003)(478600001)(2906002)(2201001)(256004)(25786009)(6436002)(50226002)(486006)(86362001)(6306002)(105586002)(44832011)(6512007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4083;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GlgfKTkx9dvjzcB5wCZr2Hci8KNALqyMl0DjmhfezH1NwyqnM1fA9Sb5d8pVcsgTier2qvOVvjoovBa5UuebkvtlBQJRGSACWbXTtcAABHXP0DradRMmXt4G7hRLwyeyUWfaxXPZ9cPdo87KP2qkeHOSLYcTaSSz/wNtfFtCW7RcGAekCTqBgI5HBjhBlY4dkXQwJxkiR2F5QLu0VW/kcmaGxiCADmW1mK0rmDNhEbNigv26FzZfG2fCfgE6xHxFk+QAdb23UXkhgBv0kYujdzVgXDCa1ZBpV+tjGZyQJ+EYbjCjQur0UfzIu0Nta54R3YTGwNXN0Szy7ecJeyjwNBHxHbA2jZoVCQGGygJG/YSz4lPvbMizVNmCGTGq8hi8RbE8ncwxwpu8surUGb3xX1uPO/eMXSb6RixP9zFFnpM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a89f911-cf90-4508-789e-08d6a95df60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 15:50:34.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have introduced some new formats DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420=
_8BIT,
and DRM_FORMAT_YUV420_10BIT whose cpp is 0 (as they are defined in bits per=
 pixel).
We need to ensure that the pitch returned by drm_format_info_min_pitch() fo=
r such
formats is always 0.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Depends on:- https://patchwork.freedesktop.org/patch/msgid/1552414556-5756-=
1-git-send-email-ayan.halder@arm.com
---
 drivers/gpu/drm/selftests/test-drm_format.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/selftests/test-drm_format.c b/drivers/gpu/drm/=
selftests/test-drm_format.c
index c5e212a..155e4ce 100644
--- a/drivers/gpu/drm/selftests/test-drm_format.c
+++ b/drivers/gpu/drm/selftests/test-drm_format.c
@@ -276,5 +276,14 @@ int igt_check_drm_format_min_pitch(void *ignored)
 	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX - 1) !=3D
 			(uint64_t)(UINT_MAX - 1) * 2);
=20
+	/* Test format with cpp/char_per_block 0 */
+	info =3D drm_format_info(DRM_FORMAT_VUY101010);
+	FAIL_ON(!info);
+	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) !=3D 0);
+	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) !=3D 0);
+	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) !=3D 0);
+	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) !=3D 0);
+	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=3D 0);
+
 	return 0;
 }
--=20
2.7.4

