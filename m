Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C8C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13DC21655
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EE+dGgKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfHVDLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:11:50 -0400
Received: from mail-eopbgr1300131.outbound.protection.outlook.com ([40.107.130.131]:27123
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727875AbfHVDLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4w71LLsE2uV286VjuTcPEBWaI0alm1VyW4r82nXRMLkgmlnIQEAkDAe78vkycqW2DVWWGELukvnCKMoWCvsyj7N8FV11r+jnKssK5WeFpryxOapCqnSkIrBHWVHiXhDE7DlQu6VWHtYZBGQ0H/ZiQn68TA8lRR5fNoOO2iqJ79s1p7S7NprYvPEsMEUbyEOZUO2MLIQxE2x02xwki0gwV4kRAUR5FYFgJfawUCj/k0iWdenERZPoy5qLbQ18QrmUUPTc44J5E+WVjjXoIgfJ1MDYtPCciAEHvHFjykcIOqyIWvStt1pu78cvpKlx354Nd4mrBmmnXRTpegL7ZtxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZhJaoRn7mEjTI9Bx8WrMHcrvjRy6GSTULHlrNXfMSc=;
 b=Pje+eeeoVMiX91ymLJZ6LrbJQYL1/0SYWEc8ZNHojFKUxgCoTzV/k2/rBW93Z7gRowrD0vhgA1zaT9fb7lMRy9dUUw693g1e4o9xHV2TFvohWeM2QrQBrZ6WE/VWBh/6453p2P/vHmMzflNlaeVbwgm8Dv1uScxC4bF6pMXyo13ydQrlKMhLrYthL0Gl7sd0HstGPSjEpSND3V58j/0MP/g/t15yK3vWlpQH6BuAtXZu39ogmD5xJD0Wtw0vq7uoPkk2BgF3j3MFy3AwFN7RNGgVZf/nHaZQUGH3qqoKRTMdwZXK7hPpqJ9CTQlH3sntIkzpjYbP28qF2338Nb3IqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZhJaoRn7mEjTI9Bx8WrMHcrvjRy6GSTULHlrNXfMSc=;
 b=EE+dGgKOfwMVE/9V1lribG0TiP7DpSfDx2WAKHUvm75X31bJW3k6NqBTbEdmNVQWvJAklRN8ZQpCkE3XIvm3aSiZIUATCPIsZFdANGIURQeNb4U4IuTuPwJq5dyvKZAonf3/ed1C7LJKar8zEp8M53UGsgHVmX2qXFTJx/3sfRI=
Received: from HK0P153MB0290.APCP153.PROD.OUTLOOK.COM (52.132.236.143) by
 HK0P153MB0113.APCP153.PROD.OUTLOOK.COM (52.133.156.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Thu, 22 Aug 2019 03:11:42 +0000
Received: from HK0P153MB0290.APCP153.PROD.OUTLOOK.COM
 ([fe80::4887:d3bf:30e9:235]) by HK0P153MB0290.APCP153.PROD.OUTLOOK.COM
 ([fe80::4887:d3bf:30e9:235%8]) with mapi id 15.20.2220.000; Thu, 22 Aug 2019
 03:11:42 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [tip:timers/core 34/34]
 drivers//clocksource/hyperv_timer.c:264:35: error: 'hv_sched_clock_offset'
 undeclared; did you mean 'sched_clock_register'?
Thread-Topic: [tip:timers/core 34/34]
 drivers//clocksource/hyperv_timer.c:264:35: error: 'hv_sched_clock_offset'
 undeclared; did you mean 'sched_clock_register'?
Thread-Index: AQHVWJGWqsbq2Q6vEkerx9hXlryP/6cGeylw
Date:   Thu, 22 Aug 2019 03:11:42 +0000
Message-ID: <HK0P153MB029006EDDB72EB2809C13E2492A50@HK0P153MB0290.APCP153.PROD.OUTLOOK.COM>
References: <201908221019.hX9jqUFa%lkp@intel.com>
In-Reply-To: <201908221019.hX9jqUFa%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-22T03:11:40.0812207Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ddba9fd2-f5a6-4548-a5bf-d73ac7840798;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [167.220.255.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b86d7aa-537a-4699-35c0-08d726ae750e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HK0P153MB0113;
x-ms-traffictypediagnostic: HK0P153MB0113:|HK0P153MB0113:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <HK0P153MB011313C62D28D02BA6123BD992A50@HK0P153MB0113.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(13464003)(53936002)(6436002)(8990500004)(54906003)(4326008)(9686003)(6916009)(498600001)(76176011)(66066001)(14454004)(86362001)(6116002)(2906002)(25786009)(6306002)(107886003)(6246003)(5660300002)(229853002)(3846002)(966005)(74316002)(7736002)(305945005)(66446008)(66556008)(186003)(10090500001)(66946007)(10290500003)(486006)(71200400001)(8936002)(8676002)(55016002)(476003)(52536014)(64756008)(99286004)(256004)(5024004)(14444005)(71190400001)(7696005)(6506007)(53546011)(102836004)(33656002)(22452003)(66476007)(76116006)(81156014)(81166006)(11346002)(26005)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0113;H:HK0P153MB0290.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K8h3wObruqdVhZZnZoXHRT5dbDIxXM6u5ts2ZAZXH9D+eJMpnshsRoAnIiAkkJhsM8Wc7V3ac4oUsxuA6VphVGzJODmlJ5BG8lfkCSqDcoLAhNjHC5H1qM3AvFcjBubLdVtsWMcUB4dmheAWUiNYQZg3ffpXv3JYkK+di8qk83tF3yoOOOIUPYldaXG/x2Izub6N4BqvrOCMP15Y6bFQrWl1QEF/kYczpRFxYxsf2QJ/vnisjoA7rcMb+x91aH8U+MqeWB5xed+VVMtdJ6z0ItkOjUVQeNM0sZtlUnLakmWsEMCD7MHDsd/LEVre9viJofWXyoLsPM655EkD2IksKrjV1fz7upLGd4dTeniLHpa/kn4NN+LEKvUSu1KDbW5YMCShNOddbZom289NFToWE7TEjSSBGV6eIAWcpYAImY4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b86d7aa-537a-4699-35c0-08d726ae750e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 03:11:42.1697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHLM1MqqOIq6MiSItlBogRocBNht+QAo5rMO8unbpCHvtLLRzbwHpw6FV1RU8Qs1D1Oet3WxB9uiWXdTfwlqsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reporting. I will send out fix patch.

-----Original Message-----
From: kbuild test robot <lkp@intel.com>=20
Sent: Thursday, August 22, 2019 10:25 AM
To: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: kbuild-all@01.org; linux-kernel@vger.kernel.org; tipbuild@zytor.com; Th=
omas Gleixner <tglx@linutronix.de>; Michael Kelley <mikelley@microsoft.com>
Subject: [tip:timers/core 34/34] drivers//clocksource/hyperv_timer.c:264:35=
: error: 'hv_sched_clock_offset' undeclared; did you mean 'sched_clock_regi=
ster'?

tree:   https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fkernel.googlesource.com%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git=
&amp;data=3D02%7C01%7CTianyu.Lan%40microsoft.com%7Cfa01680d45d1424cbbc308d7=
26a82122%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637020378361213701&am=
p;sdata=3D56fY4vgmkc4Nk3ZqCZhRyaA%2BmfKSd%2Fp9eYXZUahw5uo%3D&amp;reserved=
=3D0 timers/core
head:   b74e1d61dbc614ff35ef3ad9267c61ed06b09051
commit: b74e1d61dbc614ff35ef3ad9267c61ed06b09051 [34/34] clocksource/hyperv=
: Add Hyper-V specific sched clock function
config: i386-randconfig-g002-201933 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        git checkout b74e1d61dbc614ff35ef3ad9267c61ed06b09051
        # save the attached .config to linux build tree
        make ARCH=3Di386=20

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers//clocksource/hyperv_timer.c: In function 'read_hv_sched_clock_ms=
r':
>> drivers//clocksource/hyperv_timer.c:264:35: error: 'hv_sched_clock_offse=
t' undeclared (first use in this function); did you mean 'sched_clock_regis=
ter'?
     return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
                                      ^~~~~~~~~~~~~~~~~~~~~
                                      sched_clock_register
   drivers//clocksource/hyperv_timer.c:264:35: note: each undeclared identi=
fier is reported only once for each function it appears in
   drivers//clocksource/hyperv_timer.c: In function 'hv_init_clocksource':
   drivers//clocksource/hyperv_timer.c:334:2: error: 'hv_sched_clock_offset=
' undeclared (first use in this function); did you mean 'sched_clock_regist=
er'?
     hv_sched_clock_offset =3D hyperv_cs->read(hyperv_cs);
     ^~~~~~~~~~~~~~~~~~~~~
     sched_clock_register
   drivers//clocksource/hyperv_timer.c: In function 'read_hv_sched_clock_ms=
r':
>> drivers//clocksource/hyperv_timer.c:265:1: warning: control reaches end =
of non-void function [-Wreturn-type]
    }
    ^

vim +264 drivers//clocksource/hyperv_timer.c

   261=09
   262	static u64 read_hv_sched_clock_msr(void)
   263	{
 > 264		return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
 > 265	}
   266=09

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.0=
1.org%2Fpipermail%2Fkbuild-all&amp;data=3D02%7C01%7CTianyu.Lan%40microsoft.=
com%7Cfa01680d45d1424cbbc308d726a82122%7C72f988bf86f141af91ab2d7cd011db47%7=
C1%7C0%7C637020378361213701&amp;sdata=3DbmZV%2B2uKHUlwngubxhE2bZlfOqCRNYVDC=
XOs%2FWcy3f8%3D&amp;reserved=3D0                   Intel Corporation
