Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C98C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE4B214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="I32ezHny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfHAO25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:28:57 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com ([40.107.6.108]:15073
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbfHAO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLQvL+lyUfefr78OUwZIm3pWtgkvJQPBPSgdF/LTACF2vDQIMKWeSdgzi3UHJDvI1VG7NuFIUoM4LS/n5VV813OqwbuXyrXnlhNb8jy6wNK5TKsP2BNrqUumACZ1rIZZf7fMRngvnymKFx/9Ommsb4LxvPirSUqnPRQWrPPOtTecJz/Y1jMLNtEhdvkn9CyDKAnrr4h5rXnzBct09bP5zp39tf2r3UOsdPnmSmfPsOfaDnya74MLJrXF7lLdrD4v8/rTVTJGKCV43ggPukFd5f/0UsH8Nc5D0UWAW0te7C7GNUS4UX/4TodXK4DQq+kw+JjvTM+BGghR5V3DtSUk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxOVxAI2ZY6bScTypA33szMg0by1dMkN9PfpwcD/y0k=;
 b=VtzxNGWp/Ev9mrHNyfRGJWyi6jzymDNi4Xxa01o9wmO3+Y4aR0OsbVvUQuRQ0iCA8mBurmrYjQkBJC6wGNzF5V5Lfo3IoY5YIlxZvvx0zQqXfQJCHzitvSWXzp9gXRlwuzelQnMk7MTdqhRA6HzHtTMItSQgt3ZndIsJcl18edIUhZBo3IN0HQT85bRRk3sK9DvNzB/XIkNxzfPqYBMYQfuGfUEih5PJihdaWDeTttrnhbyIp0TuAn5WXVAfVSOviM73n+xhZtHarszkPxQxSq95hv1yaL74f3kYEApHWQKDAQPzUL7+t/UdeZc1i2Ucw60BkKz/dGHWzZu1c+MtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxOVxAI2ZY6bScTypA33szMg0by1dMkN9PfpwcD/y0k=;
 b=I32ezHny9/SMy/69Xi9OV84kCsZWLlZ0NXNqn3yoY6tkpyCiVHD3kESszO55rS2Cm2oqw8pD0HqrqE6Vc7W0K5p1ObXnTbgXKyyW6DM65GzsjwT8c62m2NmbI6nE0iZmjE/Cy3aDLKhzphP9x+tlkTiLu3W6LfYQCVYGJ1EWoek=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB3679.eurprd02.prod.outlook.com (52.134.26.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 14:28:46 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f%4]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 14:28:46 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] habanalabs: Add descriptive name to PSOC app status
 register
Thread-Topic: [PATCH 2/2] habanalabs: Add descriptive name to PSOC app status
 register
Thread-Index: AQHVSHVt1wARYllfWUqa6yCScOeJ0A==
Date:   Thu, 1 Aug 2019 14:28:45 +0000
Message-ID: <20190801142834.329-2-ttayar@habana.ai>
References: <20190801142834.329-1-ttayar@habana.ai>
In-Reply-To: <20190801142834.329-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::33) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da5d0fbc-5122-4779-b437-08d7168c8fb4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB3679;
x-ms-traffictypediagnostic: VI1PR02MB3679:
x-microsoft-antispam-prvs: <VI1PR02MB3679811117489A0F1848B97DD2DE0@VI1PR02MB3679.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39850400004)(199004)(189003)(66946007)(5640700003)(66446008)(8936002)(53936002)(81166006)(81156014)(71190400001)(71200400001)(50226002)(66476007)(66556008)(64756008)(6512007)(305945005)(86362001)(478600001)(6486002)(5660300002)(2906002)(1076003)(2351001)(2501003)(6436002)(6116002)(3846002)(36756003)(476003)(11346002)(486006)(446003)(4326008)(186003)(66066001)(102836004)(26005)(52116002)(76176011)(386003)(6506007)(99286004)(7736002)(2616005)(25786009)(6916009)(14454004)(316002)(1361003)(256004)(19627235002)(68736007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3679;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /LX+2WvuPmhDylRapMG3znktA9KisMeFxCpfJkoOS8TkC3CSirFI8jaOX8tRJXyllwnSWhXdsV11sBcnkU/y/tfBgDsbMyijZm3mXNkFC9JXmpzkAc30Ip1wOaEy/MLyMnB7uU6QD8o/dscPPA9BTT6Z54ysyS99yIOK7GQpz0LKkeFc0gxnhhQLbYMGjCWKKX4SQM7oqJT+pzuUx3y1LkwvR7uOSbX3lOzU/yl/aewmy9hMxmpWDWh2PuU8fYrzzUAc5lFV3GgTXPf5Y95V0SuEikw5ccFOgNGg6oF2WG5UtSwZGY7AKngkwmFPE4BzF93v+eubgluqYJDK1VDMQj3ETgQs03R2wcM+160S3qsnq7pPQBQBL95MpwHy8JR5fxeDpl1foLew156DPM+Y/WoYOQWWYThRwMFjC5AY2/0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: da5d0fbc-5122-4779-b437-08d7168c8fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 14:28:45.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a meaningful name to the general PSOC application status register
which better describes its usage in keeping the HW state.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c                 | 4 ++--
 drivers/misc/habanalabs/include/goya/goya_reg_map.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 9699e7d4903e..6acda363983f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2468,7 +2468,7 @@ static int goya_hw_init(struct hl_device *hdev)
 	 * we need to reset the chip before doing H/W init. This register is
 	 * cleared by the H/W upon H/W reset
 	 */
-	WREG32(mmPSOC_GLOBAL_CONF_APP_STATUS, HL_DEVICE_HW_STATE_DIRTY);
+	WREG32(mmHW_STATE, HL_DEVICE_HW_STATE_DIRTY);
=20
 	rc =3D goya_init_cpu(hdev, GOYA_CPU_TIMEOUT_USEC);
 	if (rc) {
@@ -5023,7 +5023,7 @@ static int goya_get_eeprom_data(struct hl_device *hde=
v, void *data,
=20
 static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
 {
-	return RREG32(mmPSOC_GLOBAL_CONF_APP_STATUS);
+	return RREG32(mmHW_STATE);
 }
=20
 static const struct hl_asic_funcs goya_funcs =3D {
diff --git a/drivers/misc/habanalabs/include/goya/goya_reg_map.h b/drivers/=
misc/habanalabs/include/goya/goya_reg_map.h
index 554034f47317..cd89723c7f61 100644
--- a/drivers/misc/habanalabs/include/goya/goya_reg_map.h
+++ b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
@@ -29,4 +29,6 @@
 #define mmUBOOT_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
 #define mmBTL_ID		mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
=20
+#define mmHW_STATE		mmPSOC_GLOBAL_CONF_APP_STATUS
+
 #endif /* GOYA_REG_MAP_H_ */
--=20
2.17.1

