Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D22C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7058D20722
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XiKZqm3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfK0Omj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:42:39 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:25152
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfK0Omj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:42:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv3s4kKOCrogkF1Ke6oj3/5ilKqWnRnmjHsNPI1YSXhCEhYJTJK/K3fCsZioDrB+md37X/yy74bvfF3+q39bLDdL6Adzfr4zZBDhsunlLVkhiiIoXfcJ0k47xzlWBwDmVoiktiIsI2+049RXPuuGTYnTKoT3kw7or5TfRB3FwbVRu3XeT03Gr2hz9aLoT3/9F2li5lzMCc5sz2t50I5EUAs6Xauitl1bMS/HXLdPxu02xGQOWM1LtIFaIyR8KVutIZzu+iBtbCvtK2gbjSK/ILp9sNjSaZAulfepaGNlRb0TcjAViW1wCsgGfKBvmfjVph+pEklNuPI8XCyo6CVGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KayS4GUJwO5YomZ8rA/bBaMzf0gTphpNMclyxGs/2oI=;
 b=A7SrBEroxaH0DCsXcKcFkBu2SG9V3Ouf7nu2OetymGNTGNdDGVw6pEHiAff9ZmrbVOUh8OZZ8cagIFHswb3LtRU983kFkt1dg1xOXGWGpEh/m1YxqwwnuJbchsxTp27sMtFN5DHa4BRoWyalyUcPji0NU8ghogbS4kCVmKx59D7FOsIUhTjBYsGS7neldrEvyExyCP+VtdLX36FFJT+JDISYKihk4JbK0Hr54w9BAzo1AOX0CAVIo7dAkCPtz9eqqXm53bMp0HuxQX6U7OinWoBUmJCb1wo3aiuvexaJQVXGgUPycL15WP2fJS3BRzqIXJBzhd6AvuA7TZnkvV3WTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KayS4GUJwO5YomZ8rA/bBaMzf0gTphpNMclyxGs/2oI=;
 b=XiKZqm3D517IUiteWT0ztHdlXiLUjFzEWuhlTedIaeN/WhIvyUDSfGN3pZWusI9ap2ymXNACpCV0k580LO9tv4I4rdGWWfMnHa1eXCc9n3G9rb8/OKBPaeZ6JkMktDwKc9aHMEDEizHy8ONTG2Gr5OiCt451uz887TaJSv6+sQQ=
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com (20.179.24.74) by
 VI1PR04MB4414.eurprd04.prod.outlook.com (20.177.54.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 27 Nov 2019 14:42:35 +0000
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::9056:3486:95b8:4eff]) by VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::9056:3486:95b8:4eff%4]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 14:42:35 +0000
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Uma Shankar <uma.shankar@intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>
Subject: [PATCH] drm: fix HDR static metadata type field numbering
Thread-Topic: [PATCH] drm: fix HDR static metadata type field numbering
Thread-Index: AQHVpTDonNbf5j/+IEiOiFgD+u80BQ==
Date:   Wed, 27 Nov 2019 14:42:35 +0000
Message-ID: <1574865719-24490-1-git-send-email-laurentiu.palcu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::15) To VI1PR04MB6237.eurprd04.prod.outlook.com
 (2603:10a6:803:f1::10)
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.palcu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3621371c-4f2c-4726-f908-08d773480adb
x-ms-traffictypediagnostic: VI1PR04MB4414:|VI1PR04MB4414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4414E070C18A38B2DBCD1C96FF440@VI1PR04MB4414.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(99286004)(36756003)(2501003)(8936002)(6486002)(25786009)(186003)(5660300002)(52116002)(86362001)(54906003)(110136005)(66446008)(7736002)(478600001)(14444005)(316002)(6512007)(8676002)(26005)(66066001)(81166006)(81156014)(14454004)(305945005)(4744005)(102836004)(386003)(2616005)(6506007)(6116002)(44832011)(71200400001)(64756008)(2906002)(66946007)(256004)(50226002)(66556008)(66476007)(6436002)(4326008)(3846002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4414;H:VI1PR04MB6237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXv6CvWGLahZQa3vCJ18RC7JHpVgybB0K2KsvbIPaxr0rvB35rytR5XAVkSqtlMlwKPXRNhoYcjSnYbXXga/cr5BAmQCdeP/X7G1sb3II/nIDUbUOEpXFbprFKmXLIRqO73vanNM16RDmyBLgdjQj7nL01GOTe9ahyXnM67femG8nIp9j6nGvYtmFtOLTBka0VnP3RNWkQjGde6ZjipHw/fYCgPmt0NMaR+eswv8lhozsD03aTjEgOsweJXo5ci4MK84pBi2DWhOhjHUVfHhzN94nluwX7DjKGTY3shHKlMXOXyPy35ovDdK/akcLF6NIM8rQ+oeJULPW65bOUpZSAbSLtHLrOBaKvQ5reurvIpz2OIdy3yXvxmo4yu71YVCtiU3qVf6wU/JJGz7Nczm0MbWdEX1qzknqMT8/nqX6qwXgUKFs/UAaPqdJLeh2eYd
Content-Type: text/plain; charset="us-ascii"
Content-ID: <938583A994C1FF498CFC1EC195F855A9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3621371c-4f2c-4726-f908-08d773480adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 14:42:35.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nLZqaSl3dLVlq2KhaGvfnXe+/quLwceyL3giABdPDhBUTNlD+FTmhP1cdefa1CBTSqx4Dpq4XleI7w8MPk5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to CTA-861 specification, HDR static metadata data block allows a
sink to indicate which HDR metadata types it supports by setting the SM_0 t=
o
SM_7 bits. Currently, only Static Metadata Type 1 is supported and this is
indicated by setting the SM_0 bit to 1.

However, the connector->hdr_sink_metadata.hdmi_type1.metadata_type is alway=
s
0, because hdr_metadata_type() in drm_edid.c checks the wrong bit.

This patch corrects the HDMI_STATIC_METADATA_TYPE1 bit position.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
---
 include/linux/hdmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 9918a6c..216e25e 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -155,7 +155,7 @@ enum hdmi_content_type {
 };
=20
 enum hdmi_metadata_type {
-	HDMI_STATIC_METADATA_TYPE1 =3D 1,
+	HDMI_STATIC_METADATA_TYPE1 =3D 0,
 };
=20
 enum hdmi_eotf {
--=20
2.7.4

