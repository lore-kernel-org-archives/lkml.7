Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66959C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE5320656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="iXayU/If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfGHLIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:08:48 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com ([40.107.8.94]:12006
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730246AbfGHLIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwx5LdNpTF+WqRAlUUVQvOtc5zydKj2+w1v2Lc+jfmo=;
 b=iXayU/IfvbNO4klYIat8KoHTjp0evyI6ZeYKj0ssqHvsRmnZfNI6TEH++/yvGhSX7yv2NxV3AtD5Z8Azi5yD928zAz6E+97PjYdnpQYeb7l+9lMGtXy5JE2Pao54ytCUcRe0SDEuiUGgsCfBPJgwVXesJWBzLuQ6swLn0W7LENU=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB5280.eurprd02.prod.outlook.com (20.178.80.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 11:08:44 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::f92b:de76:1404:8783]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::f92b:de76:1404:8783%7]) with mapi id 15.20.2032.019; Mon, 8 Jul 2019
 11:08:44 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: use correct variable to show fd open counter
Thread-Topic: [PATCH] habanalabs: use correct variable to show fd open counter
Thread-Index: AQHVNXoNlo+PFKCvb065eSaxqxaboqbAj3dw
Date:   Mon, 8 Jul 2019 11:08:44 +0000
Message-ID: <VI1PR02MB3054A333A1B5D22EE2F4DD64D2F60@VI1PR02MB3054.eurprd02.prod.outlook.com>
References: <20190708104355.32569-1-oded.gabbay@gmail.com>
In-Reply-To: <20190708104355.32569-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58a17fc3-b329-4f8f-a678-08d70394a4a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB5280;
x-ms-traffictypediagnostic: VI1PR02MB5280:
x-microsoft-antispam-prvs: <VI1PR02MB528048916B361C44B40FC960D2F60@VI1PR02MB5280.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39840400004)(136003)(346002)(189003)(199004)(66066001)(74482002)(53936002)(186003)(99286004)(7736002)(7696005)(6246003)(256004)(25786009)(110136005)(305945005)(14454004)(8936002)(316002)(6636002)(81156014)(81166006)(26005)(52536014)(5660300002)(4744005)(8676002)(86362001)(102836004)(55016002)(2906002)(2501003)(11346002)(74316002)(6506007)(66946007)(9686003)(66556008)(64756008)(76116006)(66476007)(66446008)(73956011)(6436002)(76176011)(6116002)(3846002)(33656002)(68736007)(486006)(71200400001)(478600001)(476003)(446003)(71190400001)(229853002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB5280;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mo76kPsnXHOQ5cFVv8gO+h+cnuFAABG6lhfrALEfGvJDbjmYZccQhBQLCXy9wM+L8QS+iHSPAZfs5Qruc8sduWP74aYWHyzaUBJos1btSH05xAvkM8M589AbjR3uGGtI0x65pYfuQdeT0Q/MmlMUPmze/1BfcbDfWmIYyqgl11HsW8OsvheBuRDALontvtLsqDIzsouw1xvjur/vi79pgln4CEGwkQt9s1UKtAQHTJDOjYgZQLqqzt14wil1p3hZE9LPG/OYQvhICbtkyzGtoGR9FoThWg0L2Jiv0Wv+mZdso8KJYqwxZCfM2WlUb7GRTRHjfBSFoL/Zk0kogrslcNz/52kAa7cFEq0IGzvAFNpKZgYsmhfmtAqQifbt+z8oUAVu6g+X890ulbmYxRabuLL0BTVx5md08dVSE0OVBKE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a17fc3-b329-4f8f-a678-08d70394a4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 11:08:44.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oded Gabbay <oded.gabbay@gmail.com>
Sent: Monday, 8 July 2019 13:44

> The current code checks if the user context pointer is NULL or not to
> display the number of open file descriptors of a device. However, that
> variable (user_ctx) will eventually go away as the driver will support
> multiple processes. Instead, the driver can use the atomic counter of
> the open file descriptors which the driver already maintains.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
