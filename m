Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6E2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96FB208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q8r+Ddcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406448AbfHIL3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:29:16 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:49541
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405723AbfHIL3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:29:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtzaZxja+Dr9Q3wIpU6F5eUrklh+FizOe6fe0xz4WpG09egqNpwMTLDOcienV8vyNM82n2iIMHgwmbf/6/3XNCG/Xwa7u+FNFmLnrkPXEzZkntrFX94Mk/F6E+zNEGsKv7BvTr1MJ/jS16Y2D2vZzRRB12LW2B+LQDn3EK36RsUYfoCAoGupZKhVkp3IH99k517wTFSpp9IdV+fsEznedIOUomyIIexF3ZLIimDaABKjbWJa12IgWaFJ5j/PhbRQTHOiaxV4dur3W0rDkDQmIU12ykXNoB/lMjXjp+lpNagiB83JEaDQ56sn15lmxZcQXTbE80eTeAZ+tRpIxQP9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKjW5UtnTT3GBpJ6GvAa07sXmgQD7r0ymBXSxSCwx8U=;
 b=kUNPaxdUkpQgxZwKd5gp+aEZj+9brs0JabP79uNnDr1eCkdV9CtTy/hK2FTMq8KnDUIspq2cfWGEJppXDGddtdfWro2e0pONGQQsryYZjAvtBQuXXT/wfQ8vB6afJW134nX5WsZ4c/U/jFNnLbKOeGLB3oHBsVtsquJ8Cf5eysAXqLsyT23nZLDtDpQEuc5mA9esghjBfhDfMxJK01rBe/33zxml4SY6QNwAWMBj0PWABxDXHJ7mSSSQYLd51TGyVMuNhY5GT8FcMGxlMqfLylVToZFL2wMkg/8jguBFKefEwG4SFh3SaC0W7EadJFyyOhy/t9bh3K8naQv7H0qmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKjW5UtnTT3GBpJ6GvAa07sXmgQD7r0ymBXSxSCwx8U=;
 b=Q8r+DdcxCa9lweSWDEalRJp1ROfOLyY734Yfk7pTfuWwPeStdueVb21fstgA1Q+6RePlTFyQivF24BbkI4/Ih+qsd9yRPEniSIAiKUQ6NJbSfHEH0nZsg9JD8WWL9j7PkJglPbbCQwcAJIHZSL7m0FeamAC8sMGrlAS9piJ3dvE=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3359.eurprd04.prod.outlook.com (52.134.1.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Fri, 9 Aug 2019 11:29:08 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 11:29:08 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Eddy Petrisor <eddy.petrisor@nxp.com>
Subject: [PATCH v2 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB board
Thread-Topic: [PATCH v2 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB board
Thread-Index: AQHVTqWokwLnrOjveU+AMnEcXYSIEA==
Date:   Fri, 9 Aug 2019 11:29:08 +0000
Message-ID: <20190809112853.15846-2-stefan-gabriel.mirea@nxp.com>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM5PR06CA0024.eurprd06.prod.outlook.com
 (2603:10a6:206:2::37) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98e1032c-ff41-4069-98ec-08d71cbccb1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3359;
x-ms-traffictypediagnostic: VI1PR0402MB3359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB33595D9A337A0DEF66372988DFD60@VI1PR0402MB3359.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(66476007)(66446008)(66556008)(64756008)(5660300002)(6512007)(26005)(186003)(2201001)(52116002)(76176011)(8936002)(99286004)(14454004)(50226002)(4744005)(1076003)(86362001)(66946007)(71190400001)(71200400001)(4326008)(386003)(6506007)(53936002)(478600001)(102836004)(110136005)(2906002)(256004)(25786009)(8676002)(66066001)(476003)(2616005)(54906003)(2501003)(486006)(316002)(36756003)(6116002)(3846002)(6486002)(7736002)(6636002)(7416002)(6436002)(305945005)(81156014)(446003)(11346002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3359;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d5/G2lIYQdH0iNJbZzv97T3kH/Krk9d+pJ4MGLAE1/2SAtitTy/Vrv7RvsRT05bb2CuAb+C80QoPDoMCWeHnC4/dmFZIZOLMNwZURpIXGD5EMf7UExSCPOb/hywVMyNVMRjSplFg46TsfebRCB4r++7AsIs963s6vwD4jKBCWiXlExP2WkFpXE/am/9kEKiV4KMYkiWOVLJrHoNTBSu7K3bTdJhwiL9E3XEo+jf9Ai5iwV5eMzhc5NjvlBzyh+zfvVQmdtEgXuWdH/9ekXXnn5RV2wcNxsWWM6xYIJVMfBa3/1DIPt66kQvaFom3vG2d5eOPS13mK+YiqkHih896nnb4TKcqDUzW05obDGDz9fVy/rcqgpfGb7bPAXhmVh+W9u9Z/FpuduQ6qIucpI8zO45+/lD6aYQVxayuneXl840=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFD5A50DFD96F44EA7EE9C248A236DF0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e1032c-ff41-4069-98ec-08d71cbccb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 11:29:08.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJIOT03s4tDLQ4ixMCvIJME0tzZ0rxQIJcNjJ7YC//bmewlc+EePdPG2D4sBoGXtDJ2ooaCJiVKkD/al9edVMZtQzkzVrvwUSMWjUR4Cp6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRWRkeSBQZXRyaciZb3IgPGVkZHkucGV0cmlzb3JAbnhwLmNvbT4NCg0KQWRkIGVudHJ5
IGZvciB0aGUgTlhQIFMzMlYyMzQgQ3VzdG9tZXIgRXZhbHVhdGlvbiBCb2FyZCB0byB0aGUgYm9h
cmQvU29DDQpiaW5kaW5ncy4NCg0KU2lnbmVkLW9mZi1ieTogRWRkeSBQZXRyaciZb3IgPGVkZHku
cGV0cmlzb3JAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFN0ZWZhbi1HYWJyaWVsIE1pcmVhIDxz
dGVmYW4tZ2FicmllbC5taXJlYUBueHAuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbCB8IDYgKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9mc2wueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnNsLnlhbWwNCmluZGV4IDcyOTRhYzM2ZjRjMC4uNTk3YzU2M2JkZWM5IDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KQEAgLTMwOSw0
ICszMDksMTAgQEAgcHJvcGVydGllczoNCiAgICAgICAgICAgICAgIC0gZnNsLGxzMjA4OGEtcmRi
DQogICAgICAgICAgIC0gY29uc3Q6IGZzbCxsczIwODhhDQogDQorICAgICAgLSBkZXNjcmlwdGlv
bjogUzMyVjIzNCBiYXNlZCBCb2FyZHMNCisgICAgICAgIGl0ZW1zOg0KKyAgICAgICAgICAtIGVu
dW06DQorICAgICAgICAgICAgICAtIGZzbCxzMzJ2MjM0LWV2YiAgICAgICAgICAgIyBTMzJWMjM0
LUVWQjIgQ3VzdG9tZXIgRXZhbHVhdGlvbiBCb2FyZA0KKyAgICAgICAgICAtIGNvbnN0OiBmc2ws
czMydjIzNA0KKw0KIC4uLg0KLS0gDQoyLjIyLjANCg0K
