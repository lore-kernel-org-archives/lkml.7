Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E2820663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="wflAJxXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCFXPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:15:35 -0500
Received: from mail-eopbgr50091.outbound.protection.outlook.com ([40.107.5.91]:17172
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfCFXPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekl+SfHEdP9Geaymnfug8W8FtYqWWTefWKNihda4/iA=;
 b=wflAJxXrG7VHNJwg7qB4eWL+iXd/pB/raYzqNyWRvIEh8Q1VuCBSxpr4w1NtGi3O0R66KbaCDgUZNOXSBf1ckIGMKsUSOG0ciOOFPxxy5psdc7ymvDcIp7jzvmq6aqEG6atoVQi6DtjewWIabf1FT25FrwFCx3xmqcj4aBMI7GI=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4592.eurprd02.prod.outlook.com (20.178.12.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 23:15:29 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 23:15:29 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
Subject: [PATCH v2 0/5] i2c: mux: pca9541: extend with support for pca9641
Thread-Topic: [PATCH v2 0/5] i2c: mux: pca9541: extend with support for
 pca9641
Thread-Index: AQHU1HJ9g/5N4w7KskmC+bc6ATGluw==
Date:   Wed, 6 Mar 2019 23:15:29 +0000
Message-ID: <20190306231521.29367-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b92ba39-52a6-4ed3-9fd0-08d6a2899fa8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4592;
x-ms-traffictypediagnostic: VI1PR02MB4592:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR02MB4592679199E17BF26EEE5DACBC730@VI1PR02MB4592.eurprd02.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(366004)(346002)(136003)(189003)(199004)(6306002)(5640700003)(53936002)(6486002)(71200400001)(6436002)(2501003)(71190400001)(99286004)(4326008)(6916009)(476003)(102836004)(256004)(486006)(52116002)(3846002)(86362001)(386003)(74482002)(6506007)(6512007)(26005)(6116002)(97736004)(66066001)(305945005)(7736002)(2351001)(186003)(2616005)(25786009)(106356001)(36756003)(8936002)(8676002)(68736007)(81156014)(81166006)(5660300002)(508600001)(2906002)(54906003)(1076003)(50226002)(316002)(14454004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4592;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR02MB4592;23:5uzJ+C9Mxu/JZd7bVDvIpHsps1d3/Hl+B8FBiEA?=
 =?iso-8859-1?Q?AK5kAKgtig8OPcOTgPKohKTVhOPn+xhV83XI6iCTnnytxlraVI2wbOig3m?=
 =?iso-8859-1?Q?nj8ikCN49DlC3qEqfupQ6cKPInv3RuJUmZXGEr3uVVedMwfoQuvadiWY3G?=
 =?iso-8859-1?Q?a0lLlDpmAqsMJgJIf4dC99aEY3SqmAzgPcHmn3K18GX8xRF2U8hMht38Mz?=
 =?iso-8859-1?Q?nn+Re1BXEc4nsIWE4HlBs47cs5MpAhlxRLs0ulKGL4mWx7EarokICyURCq?=
 =?iso-8859-1?Q?ErnxHQals/ghsHmjjhwWXW/O+GyQX7EVG+Wr05TUaR4dYH0UgxGYwAg00R?=
 =?iso-8859-1?Q?Y9M5Hkzt4/s6YW/NrQpu7CKdFznZjIBExw+x7RLQ5dJthvOhHeXTkZ/gSu?=
 =?iso-8859-1?Q?Hy5l/RFOTgdoys2GdEI8e8Bdjr+WRBTyUWEzFYb3xnMd3koXrLFfSBUEmd?=
 =?iso-8859-1?Q?uAm/7Ztw2R0Kg8LZnoOKZC+tOCMe6OngfaF8G5FdBzD54c/dOPLB09gQS9?=
 =?iso-8859-1?Q?jo9kPfyRMG50ut0jTjZHZdfMOPD5II6+F/4WX+9n4KgNdae+KVGfA6ZzOc?=
 =?iso-8859-1?Q?BCCnN6kBiFW5a2lst8hP1/OPvBdh+l4ju7WKEFC6Pb9zelLoV/4zd2Mibh?=
 =?iso-8859-1?Q?bNy4raG9+SthOQFElUcapsyVR33LTcMIZBc37AL2bfynv/jKc5tSbGREeL?=
 =?iso-8859-1?Q?FuYjR8o/2zu1Awb+kSa2FG3mk9ol7qobPXgMIHydTmhua6ApvyDNPDlipF?=
 =?iso-8859-1?Q?Ytg65eTUVIZ+q3JPejhL5Q6tHkqSd7X8ZvsrQEhvPKKaOO7qEtpTWAXIHy?=
 =?iso-8859-1?Q?+qlsKbpYxuUXvYzfthh8H4DPYFPwQIgvbj928FZWfEi2t6pLE/5sl3WZTF?=
 =?iso-8859-1?Q?zRPyF7DOy5KVWYLLIdciPmB4L0fzA75YEDI9iCN+N1bAukXsGXjvQtYNta?=
 =?iso-8859-1?Q?ifY8CKOKpq90jqRLE82HgbLPwlUaVTGgc6LFVTv7iPKIGNiZdFnF+VkIqX?=
 =?iso-8859-1?Q?EKAaPLupLYfHJ9s94cnCo3PuuwXmJnpy42/Hkk1HfYiaSQW/SY/APpXrhK?=
 =?iso-8859-1?Q?JJRWoRJ8epNogpOWVuaE4voc4DY9lgXmFFzXmpk0RvyPTJ6wqxh6zDtn+h?=
 =?iso-8859-1?Q?e4YreNB2TR06W8ln/bbS1X0bHlA6DV/NHK4lXCUOYHlc1L/VULL5b0blJE?=
 =?iso-8859-1?Q?yX2I2aWFBICyFeJWKDNXlGln8KMxbmNE9nRTNBBSUSMd5+Gwey6eD1j7qS?=
 =?iso-8859-1?Q?VTONh5zPm3IMDaiI8Hu8cPo7KsEUmyJNXAHPpFAvbCPHyUR7NC0pw/b97p?=
 =?iso-8859-1?Q?LA=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TkN7pB4coVo9OUnpMxjlipbUj0emCIiTYYBs3WBWz0x8vV4Gr37OdVRmgnOuy4ZITkcfd7V2XbGd+CHgZTiFKkvQ95oN92CbqUqBlZjtyia1l+ZFdOEhn8zXdh255B+E7oxqY7ow/ya9Y17LNSXH96y00IA/DmIgHqUVfvmueeHCfF5hee+Y1Eo5WkmnjLRfF2jOkxeY8Nfi768GpYvndrxzG4S32Lt3VXNQyrwwWJdRGQfOvG76yfBtRGXD8yqwt2wNoSwB31I+shlhh5wOrrssI8K68rt1q+ryso7aEZ0NXc7KIcmqFjnW2dA9WfLiWgyw/8mlxakXPcdA5QcEBRTTH503u3YbstK9jfRRPJGrcL7arYdBJFyWnF2SAZ5US1UxxD2V74LSpQ2HlUKrUoZLII69fr2qbC4cOqtJZ8w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b92ba39-52a6-4ed3-9fd0-08d6a2899fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 23:15:29.5283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So, it's been a year or so since this was last visited. Time flies.
At that time, Ken Chen gave up and I didn't want to add untested
code. However, Pradeep Srinivasan asked about PCA9641 and so I have
now rebased the preparatory patches to v5.0 and added the bits Ken
wrote on top of the framework I wrote.

Looking forward to some test results, this has only been build-tested.
The actual code that does anything remotely interesting with the
PCA9641 is all Kens work, and I have no knowledge if it works or not.

Changes since last year   (https://lkml.org/lkml/2018/3/20/205)
- rebased to v5.0
- changed a couple of helper functions to return bool instead of int 0/1
- added dt-bindings patch
- warped Kens patch to fit on top of the preparatory work in patches 1-3

Cheers,
Peter

Peter Rosin (5):
  i2c: mux: pca9541: use the BIT macro
  i2c: mux: pca9541: namespace cleanup
  i2c: mux: pca9541: prepare for PCA9641 support
  dt-bindings: i2c: pca9541: extend with compatible for PCA9641
  i2c: mux: pca9541: add support for PCA9641

 .../devicetree/bindings/i2c/nxp,pca9541.txt        |   6 +-
 drivers/i2c/muxes/Kconfig                          |   6 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                | 252 +++++++++++++++++=
----
 3 files changed, 218 insertions(+), 46 deletions(-)

--=20
2.11.0

