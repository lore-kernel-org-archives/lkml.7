Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF406C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAA420657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ooG02jet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCFUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:55:10 -0500
Received: from mail-eopbgr790070.outbound.protection.outlook.com ([40.107.79.70]:60224
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbfCFUzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuj92goBFIvzQ7V310eBul33HXKbBu0qKXaX7OrSNVo=;
 b=ooG02jetOYHh4+OjurPJTNJNKySNUafb3NhKu3HVYkbPuwddJtOrsCnLtSInOXLt15mnDcx20FLazX2RaVjdINW4TKPNDJZD7tHlRsiY3TKWQCZHw2liBE4d+80LQY1+bwVTrJgoPly5zmzPwLn2fVtkmHGDgbN3dw2Y6vTtv4U=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1609.namprd12.prod.outlook.com (10.172.40.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 20:55:05 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::c80e:3bbb:bfc0:719e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::c80e:3bbb:bfc0:719e%3]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 20:55:05 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUwOxcI2L49msmtEaXEKYkdDAhPaXfaQSAgB/S4IA=
Date:   Wed, 6 Mar 2019 20:55:05 +0000
Message-ID: <39554157-d8ba-6483-20e0-08960edf5818@amd.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <20190214145615.GA116987@romley-ivt3.sc.intel.com>
In-Reply-To: <20190214145615.GA116987@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:805:f2::41) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e934160-86b1-4d91-b31e-08d6a2760294
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1609;
x-ms-traffictypediagnostic: DM5PR12MB1609:
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1609;20:bYelJE+1h/2jeeOZ9wEhbk7EWHSUFTSIHd4xln10G1iLrV6B8yMnSSIFyV6s7VI74XLj3ll0RvKeC1jBtGeFMcfnBscM8RAo+7mIAbq9oigEmAtn0oen8EG6mBQT2+LgbFEofQ8FkBHrCMZbt6gf7i/SzlWPgfcL5QD/MzWvXl17ER5+L15pxhmC2aT4H8ZsM5rksGOk5rMxTHidyI/xoqoIQEro1miwpjwOiln+ojDaqCngz5RL3mrPmYBgo18Q
x-microsoft-antispam-prvs: <DM5PR12MB1609640BAA9C4E4353ED58D795730@DM5PR12MB1609.namprd12.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(13464003)(189003)(199004)(5660300002)(316002)(110136005)(2906002)(36756003)(31686004)(105586002)(106356001)(102836004)(97736004)(486006)(26005)(72206003)(6246003)(478600001)(7416002)(305945005)(14454004)(186003)(7736002)(4744005)(99286004)(3846002)(6116002)(52116002)(446003)(11346002)(53546011)(386003)(6506007)(476003)(256004)(2616005)(14444005)(71190400001)(31696002)(229853002)(6512007)(6436002)(25786009)(6486002)(81156014)(68736007)(81166006)(8676002)(76176011)(4326008)(8936002)(66066001)(86362001)(71200400001)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1609;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WSkmYOmmcLBR0uR+hRZ+L77Ia9ptPZ8QWaphRZaCNxIcU4dVUbPoJCdOrR3hD9v9rZiF73Sq93x7+dB4tYjBGx7I/JiiWjxVCHVg+08+7yy4CFKrfdz/11pKJj95Wne+xcRmhOGxx+9lGVCiRCaCQAOH1i3QXcVVJ4xsGBl9tVd3+XoXo6obN1jp6T7YC69u2UQjoV3ystTN3NAGbfWWNysHDjEa/KkJ0vg1wIDXbrYmHh0QPqElOTeM640Etf3SHeryMrtwOaUTX5idRHJpioEh5jzQgVMfOd8Cn4jOAbBdUAVjKqG3Ih1E4fXLm2NYDoo2tw/S/UAwmxIudk1iLjp0YCvaf1LLRGcZdJ9g0XxKVPBwfRZw+EbpjGdvCtkRFPOUi6+Cde0ZqK0L6ffZEKQRyRqEYhS0mxzCbAt5iqs=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <272C2F4272A8144C976C61AD2F2875FB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e934160-86b1-4d91-b31e-08d6a2760294
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 20:55:05.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers,
  Ping again. Any concerns with these patches?
Thanks
Babu
> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Thursday, February 14, 2019 8:56 AM
> To: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin
> <hpa@zytor.com>; Tony Luck <tony.luck@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Ravi V Shankar <ravi.v.shankar@intel.com>;
> Xiaochen Shen <xiaochen.shen@intel.com>; Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>; Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com>; Moger, Babu <Babu.Moger@amd.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
>=20
> On Sat, Feb 09, 2019 at 06:50:29PM -0800, Fenghua Yu wrote:
> > With more and more resctrl features are being added by Intel, AMD
> > and ARM, a test tool is becoming more and more useful to validate
> > that both hardware and software functionalities work as expected.
>=20
> Hi, Thomas, Ingo, and Borislav,
>=20
> Do you have any comments on the resctrl selftest tool?
>=20
> Do you have any plan to push the patches to upstream?
>=20
> The tool has been tested on both Intel RDT and AMD QoS.
>=20
> Thanks.
>=20
> -Fenghua
