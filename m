Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A831C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EF621897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="BKS+lS0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfICFcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:32:09 -0400
Received: from mail-eopbgr730051.outbound.protection.outlook.com ([40.107.73.51]:59520
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfICFcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:32:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFdwirp9YTFciIgf52X71/nZGL9776GdNuNsdev0RZKlxv2ZbHeQDT3ym0Er1PIiVB/OFgG9GfQVYOPv5nxScjqGtziOftJ2ZOOLyqubP4CZV/f8jnq5cJ0rfnl9IPLzQjimKV62w0WA9JRR5lEjUyQt5SYRmORwGpKYt1RbGCi0I6KULVDzoeRs1YBQMB2nlEZ2UrFFBTHk0VNFi9UO2EM7ipHz0kEJPv2zB2kq3DwRISAy3gTbBNJYy6FvQEAjPWHK9bOGiR25afTh4YxWrLFrI4V5MO0ql4mRqvPp4EnQW9VU6fwfdbIOXPoNY1OmwOCyMPOB3wgkYl9AcwS5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nr+mr+DHJUpaGjupUaqtLVWjGNgFr7lzEANrummtkQ=;
 b=R5Qyy8z4WPXwzgsA9iGWvx8jFnE2rQIGKB8ZOd3TTgI3gfEg3m/RqSfypWU3ZrP6ynd7crDpznoaAvjpG/9cCQml9ElmGxVX9UxpIjL5fQoey2gjKsfSMoQBmfgm/upK6vgKer61exgf9zGfXfTXsiW/ygDK/ihbXNfGJXtdU/pzejX6yfmGaHFtjZUlg08buEe72NshcnmT/TA4kJML47CWz3AFa9WaYJ5MvH1kMGGEDIKRTqdVY0RpL27PPvIOvfYmiGLNZ1Kfip7wT+WSPA7OzGuh0BBt2sSnIcV+L9LhMs670IKCJ3WbrWpvk3bmgFO1/C859kVDA/TZeg1NuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nr+mr+DHJUpaGjupUaqtLVWjGNgFr7lzEANrummtkQ=;
 b=BKS+lS0kc8aVx1TBJFIwA6DlHKyqbVmd8AlQHWtvdmbCoKi+HssBT/T9nxk5OK+sVi1IWVv7Y2KAJSziA6rdaOtsXLco1oVpcMggLxvVqKmxmLRsYRscuH6vClTsMeneWmGj0tK+0pXt2CQ3wdiE73eGdXzdAc6smcqi222jGfo=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3750.namprd03.prod.outlook.com (20.176.254.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Tue, 3 Sep 2019 05:32:04 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::391b:4d0f:a377:41c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::391b:4d0f:a377:41c%4]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 05:32:04 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>
Subject: Re: [PATCH] hwmon: fix devm_platform_ioremap_resource.cocci warnings
Thread-Topic: [PATCH] hwmon: fix devm_platform_ioremap_resource.cocci warnings
Thread-Index: AQHVYhLBpqXZSFWPR0mupR1mSjLCnKcZanSA
Date:   Tue, 3 Sep 2019 05:32:04 +0000
Message-ID: <20190903132008.38a992a6@xhacker.debian>
References: <alpine.DEB.2.21.1909030646180.3228@hadrien>
In-Reply-To: <alpine.DEB.2.21.1909030646180.3228@hadrien>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:404:a::20) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67cbaca4-baee-4dc1-40ed-08d730300d86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3750;
x-ms-traffictypediagnostic: BYAPR03MB3750:
x-microsoft-antispam-prvs: <BYAPR03MB3750DAEE23B529CFEE6D0E92EDB90@BYAPR03MB3750.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(305945005)(50226002)(6436002)(71200400001)(71190400001)(7736002)(186003)(26005)(6512007)(9686003)(86362001)(25786009)(102836004)(4326008)(446003)(52116002)(476003)(54906003)(6116002)(1076003)(386003)(6506007)(76176011)(256004)(486006)(66446008)(66476007)(66556008)(64756008)(66946007)(2906002)(99286004)(316002)(4744005)(3846002)(11346002)(8676002)(6916009)(8936002)(53936002)(5660300002)(229853002)(6246003)(478600001)(14454004)(66066001)(81156014)(81166006)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3750;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cIAni5UcanJcX7vPbNMrwcvqj1RcvIH6eFBZB2Dkfs8gEX4z9d5Asbb2fMwk1OiKZmd/Ilci4ac7plKkEmkJbc3s2P60IA8wfHjkomxIHqtW1v77hfVj38XvID4aknexCNkaCjJDQAFdECp+ql5NMs1W3u+l7qT8JrJ71PxOpXBi3lgfb8OBvgFDcewPY2kExKEmwD8O8XrTc2+vwWh2jevoP5qbaaO87SZf+PzW+XprDUllk9fke80MQhjJokG6u4b+STiLfwR9CplcxI6QZo1w4Skm6vY++plWJNsv6HMjhrr2NdKEJBZgQ4/cb9L1LHSDPfn+tf8Er3lRGy6e/gFiflc7p/XQm5ggEUUMZBrWi0Z/19NzC8aDZsqG0hNJPkcI7+oRQuSi9S6zopWsqbchsWby+9QpF1yRNE3JJpA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C904E69B4527ED4EA84EDFF04DE1111D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cbaca4-baee-4dc1-40ed-08d730300d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 05:32:04.3857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tU90jK37+mSDTFkSwjv0gNt3BP6UxYID/V4kj78tSytaOiXgUKt77pEOBHj/4+Fw/e8iFTueVJSUwznLhAGMpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 06:47:52 +0200 (CEST) Julia Lawall wrote:

>=20
>=20
> From: kbuild test robot <lkp@intel.com>
>=20
>  Use devm_platform_ioremap_resource helper which wraps
>  platform_get_resource() and devm_ioremap_resource() together.
>=20
> Generated by: scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
>=20
> Fixes: 658e687b4218 ("hwmon: Add Synaptics AS370 PVT sensor driver")
> CC: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>

Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Thanks
