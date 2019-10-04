Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD47C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5655B205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="coyEnILW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbfJDNvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:51:17 -0400
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:65284
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388527AbfJDNvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:51:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5k8M1HYwQOdrGGvXHwhsHooJ+aGtONjp0t9gWMNUWpShL44WCHvADvEsQ5ky7UCsW2s78G2JdaPP9QF6jgJ6xkjah0QfNtLze74PXyJMmPou3C32sAW0DfZATON/WdBU/j2V07PXj7nymCQkDKuFLI188cuQE2xUnDh/HTFeSBU9s7qv0kaGDpKU45Gh5usQqVsXxWM8w3wZ5GCXGRP2eFhvFIH0ugbb5fAEYBdx14swewiG7cFz7mtZLXx4vZK5OUr63LDCPX0sZ7o/NP0SxvI6PQdpJE1DKhdzspW5el3dx5ExgvyYR+AFIontG/09MKl7Bx8VGw2Lw2RjeV7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9npxNhs88NFpxqoq756lV+eagp1ip6ql3PP5CAJXuyg=;
 b=gQ+yQyfT7uoTQEPMehpxKV1LLefFZs3VjVg1FBf9fRAfzCPt+GNZyV2k9FeWdiQvts3MhfhzJxMV5pr6mU3IrtsJLsJ5k+LTbZpfTkUUrJqzY+bmQ8LFHDdmG+emBJiBnfaH3VoRfCF2Y4dgYFKzGFvreaJs73vJj/E+BpG0jKjDzPueY4xurVOfrfUBTellOOlLIr2o4ei9IqGvoInJyC+rcZGwAOxKVHh25Fs31vWEUPAvCfIoL80qhaea8rvTr7g5bbWzybjI+rUAE5yoUrfciZaPTvCpIP7b52kQk48LXnxsGU4mABPc76uZX4eNxYjD1t7UcRhGVRFpzg9pww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9npxNhs88NFpxqoq756lV+eagp1ip6ql3PP5CAJXuyg=;
 b=coyEnILWcK0Fzc41t7WWbbVgH5pINuQVyKco7Dp9qNqXd7ew9pYEWKZ2/k/kFLE3PJmYFcHLGI0yhmBIn5jcTnbqcCE/IrvbQEFZ7xWK7SH6AfkYLBcsOFK4AFlIrj2xLCp/Q7+ZzU2+OF+bteEvI8KOtLvcQJB12hBmz/pI0hU=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3629.eurprd04.prod.outlook.com (52.134.5.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 13:51:14 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36%7]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 13:51:14 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty: serial: Fix PORT_LINFLEXUART definition
Thread-Topic: [PATCH] tty: serial: Fix PORT_LINFLEXUART definition
Thread-Index: AQHVerrJiuFF1uxZiE6Hq3Ub4oE5OQ==
Date:   Fri, 4 Oct 2019 13:51:13 +0000
Message-ID: <20191004135058.18007-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM5PR0201CA0017.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::27) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f7dbbb-190b-441b-70f2-08d748d1ebc0
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB3629:
x-microsoft-antispam-prvs: <VI1PR0402MB36299DFE3638CA29F7034DCBDF9E0@VI1PR0402MB3629.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(2501003)(386003)(4326008)(6506007)(6436002)(6486002)(102836004)(478600001)(3846002)(6116002)(110136005)(8936002)(8676002)(81156014)(52116002)(5660300002)(1076003)(2906002)(14454004)(54906003)(7736002)(66066001)(71190400001)(71200400001)(305945005)(4744005)(81166006)(6512007)(66446008)(316002)(186003)(486006)(64756008)(66476007)(2616005)(66556008)(256004)(14444005)(99286004)(476003)(66946007)(86362001)(26005)(25786009)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3629;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MV8JAl30gkCPLMQf90JUTWJ7Hy3kBNm1K5r39+NJLwcRQPmROIyxGQXkIHF+IQNBmnqoaSHdkzK2YLWXEdluc6MskjnM0rFdeUP6g1xy8tdb5UFM8sQhSJTO+Mohj0sr/D0lNly9tlC8AfanCEPy3OhSMM5EzaY/piMSB0Lz9dAYzSKyA9KuNVVETQsdHXP94qZ2FFrLSEyHQJEOmE0nvrZ+nxsvjA0H47WvuGy/aP6a9Z/l/xMmIQbqIB0BDa3QDuNgc6MKAkO3SAXPp8nMG0MNKMm+1DpqOj841Uq6CKMyAkgmQx85RO60Ha3BL+CgKyAfhcq9n9zlN9XHHujVXUflyHyZ+t66jhusq0QQJtg56W3fUDMsTwUovc6juAhNJans9c77ygD2x/wlIoRLP2u79CiqvxVTma/kGOa3sI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f7dbbb-190b-441b-70f2-08d748d1ebc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 13:51:13.9505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1BztDMatGZrjvRJdJe7CWITLQfwgCsQaNVVPLEfo7VgH1losVBxxox0x9sS3X4MscpQvwitEJOHKkQQt4t2qwoi8CerlzciVFRNZwTyB44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port type macros should have different values for different devices.
Currently, PORT_LINFLEXUART conflicts with PORT_SUNIX.

Fixes: 09864c1cdf5c ("tty: serial: Add linflexuart driver for S32V234")
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 include/uapi/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_c=
ore.h
index 0f4f87a6fd54..e7fe550b6038 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -291,6 +291,6 @@
 #define PORT_SUNIX	121
=20
 /* Freescale Linflex UART */
-#define PORT_LINFLEXUART	121
+#define PORT_LINFLEXUART	122
=20
 #endif /* _UAPILINUX_SERIAL_CORE_H */
--=20
2.22.0

