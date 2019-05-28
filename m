Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05438C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B5420665
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NAk6MiRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfE1P0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:26:46 -0400
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:51079
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbfE1P0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9N+INspqF3yuSB+fVWCYtlVrBOD/hWx8ff0NpmT+VQ=;
 b=NAk6MiRshWSLt2uxBX2btimFlSurOTxdPH8CvhlxTr/DZr7kFbjrlFSG9rfQzqjOB7r5xUhrNxDF3nGfI4KUeIvQ0gkGPTLgHBM5aDiNa77QZHlFj1j1KImFYZeCn4I8LP3+NCH1Wouz+ndDgbtHNBV+lFAhZlQQVzkHjdujlqA=
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com (20.179.2.31) by
 AM6PR08MB3958.eurprd08.prod.outlook.com (20.179.1.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 15:26:44 +0000
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4]) by AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 15:26:44 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        nd <nd@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [PATCH] drm/komeda: Added AFBC support for komeda driver
Thread-Topic: [PATCH] drm/komeda: Added AFBC support for komeda driver
Thread-Index: AQHU6tZrSfGY2oLen0KpP248EWVF9aZuCQMAgAeEiACABN9HgIAAEWcAgARdRQCAAiJUgA==
Date:   Tue, 28 May 2019 15:26:43 +0000
Message-ID: <20190528152641.yljgau26hhd6mr2d@DESKTOP-E1NTVVP.localdomain>
References: <20190404110552.15778-1-james.qian.wang@arm.com>
 <20190516135748.GC1372@arm.com>
 <20190521084552.GA20625@james-ThinkStation-P300>
 <20190524111009.beddu67vvx66wvmk@DESKTOP-E1NTVVP.localdomain>
 <20190524121226.GD5942@intel.com>
 <20190527065110.GA29041@james-ThinkStation-P300>
In-Reply-To: <20190527065110.GA29041@james-ThinkStation-P300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::35) To AM6PR08MB4104.eurprd08.prod.outlook.com
 (2603:10a6:20b:a9::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cd0a941-1d96-4889-9d55-08d6e380e389
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB3958;
x-ms-traffictypediagnostic: AM6PR08MB3958:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB3958CC521DC43E60EE59BB31F01E0@AM6PR08MB3958.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(51914003)(26005)(186003)(44832011)(11346002)(8676002)(66946007)(6486002)(3846002)(446003)(71190400001)(71200400001)(86362001)(486006)(476003)(66446008)(73956011)(66476007)(66556008)(66066001)(6246003)(64756008)(6116002)(25786009)(316002)(53936002)(6436002)(229853002)(6862004)(4326008)(6636002)(256004)(81156014)(54906003)(4744005)(7736002)(52116002)(9686003)(6512007)(68736007)(72206003)(5660300002)(478600001)(8936002)(76176011)(14454004)(99286004)(305945005)(58126008)(2906002)(6506007)(386003)(102836004)(81166006)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3958;H:AM6PR08MB4104.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HVSmIwPTL7vXB63Hln6t9v0iAgRj3q34CZjArJcyv3SC7UJsSJ6JYjBR+6QleHcz0myQvqB1O9g+ZZR8MlTeZYwQ4LTx7sj+jJltmJfL5oqN5FosOox3tNPTLTljz5z4ldVyF4TQQRKvGtGtTRGQTv5hpgXSJGdRe2FYS2+isEpeMQlWEXYOkUsJ+/Dbh1Kq+XPQISxrjK4EolwaYncsBbTGIoNZyIYyQRzjbOfEshuqjvxO9Y7JzjBRvEoIStAcB42CaCCcbaZjb/gyIQNvExDsoQ9bkcitA2gcPobyAxmOlpPCHoNYVDS0y8lsCc9u4CPzWCmX2RVjQ24QQWDBgC4gYZ0Hl2ye1XeGIoFjEhSsb/3iAKusyVuwWp8sP50yBl0MKl1sPSzPhZxbRuWi6KWNKZB9sVotymKAEZ2cjVQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A0010D15580F254FAF72DE5257EF4B1C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd0a941-1d96-4889-9d55-08d6e380e389
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 15:26:44.2044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3958
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, May 27, 2019 at 07:51:18AM +0100, james qian wang (Arm Technology C=
hina) wrote:
> Hi Brian & Ville:
>=20
> komed has a format+modifier check before the fb size check.
> and for komeda_fb_create, the first step is do the format+modifier
> check, the size check is the furthur check after the such format
> valid check. and the detailed fb_create is like:

Thanks for the detail, it sounds good.

-Brian
