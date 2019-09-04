Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C189BC3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D3F2339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="EY6TXI4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfIDG5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:57:22 -0400
Received: from mail-eopbgr1400105.outbound.protection.outlook.com ([40.107.140.105]:14422
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727787AbfIDG5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvN9IjsM9NnDfdzLNPo9W0p+Q0Y3wlhgacJ7krOhUNOuZYs24OOpOiK8NbTllM61Eqqmk9rmdTMq+xR0m05VQcx5wInPxRD7fzUnIOccuqRx6qD3Vhb1sRaanMsbnqJxofnX5e84Upno88pnnq90j2x7CybRBah8N1RqeSekvhJOYwPKG5FI2j9TPEkdLZRNpnEwj23dkP5mpOULEWVWHRr6Lvl6bwCRos53+ynq8zOEkaLQk/Z0iJDQMUuuKLCLAKddxpgPO7NA1G8+uK2T8bCUcMUafS3/BjLTrMtlK8OvSjg6B0HVyqYxN1hkD8BNPw2x1ETIi+nM3Xj1/a6TNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8/SVqB3zVIjTUTzBA+Br90P2vKm1bCrgH36IqRox3w=;
 b=BynOyQdSUJ20JY/ElvQw+6uW5kHE36L/8DGU1Xj/bTF/I8mS1DFEbPTMnivGJ78rc+HWby555yQzUk4/xBFUYecABtFI7bo2oGDx0iWeyecU5HJ+8FldfQjif746ODRj0kgaVa8sal2lvNF6od0QfyYFeOJiRkdOEiInVPkdOy4NpzvT+k4ORfO2MCf7AV+g/9ctxT/nceGrmxC8CaALwHU+pVOE0L62qTqrGx7q19sJ1RvGzyOTE2aqDOzY9+L1DrG49XQf87rFZwtSEFjS/2YlFjmiMvyMS7p41TuP+ZSiFpKIOJbocPJss4yfyvS6ipRTRWgnaYo+PSo8BvcK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8/SVqB3zVIjTUTzBA+Br90P2vKm1bCrgH36IqRox3w=;
 b=EY6TXI4YZkfKR318gCK2m0ESK1FCJn4+TnPe0HEnoBfcDf1T/SvuWn2lpFvmMU6oMd094480Us1mSPVfPz/Cs25RY8QjkcUiD5n4Kh3E9+SPZpTSPWeqLt56vyXsDph1vuLaLgh1jfYrfdVIaqMTE/GDPSti29UWWf6a6RSQb08=
Received: from OSAPR01MB4930.jpnprd01.prod.outlook.com (20.179.177.213) by
 OSAPR01MB3604.jpnprd01.prod.outlook.com (20.178.101.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 06:57:15 +0000
Received: from OSAPR01MB4930.jpnprd01.prod.outlook.com
 ([fe80::c4ca:b67c:1d3f:c71a]) by OSAPR01MB4930.jpnprd01.prod.outlook.com
 ([fe80::c4ca:b67c:1d3f:c71a%7]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 06:57:15 +0000
From:   "Kobayashi, Kento (Sony)" <Kento.A.Kobayashi@sony.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cao, Jacky" <Jacky.Cao@sony.com>
Subject: RE: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdUr4fO63YeCnMxgQdWlMpYcyadcJAOxqk0ACg+lZqAAAGJ3gAABLg8Q
Date:   Wed, 4 Sep 2019 06:57:15 +0000
Message-ID: <OSAPR01MB493088355B958DA6DC722D25C9B80@OSAPR01MB4930.jpnprd01.prod.outlook.com>
References: <16EA1F625E922C43B00B9D8225022050086ECF6A@APYOKXMS108.ap.sony.com>
 <16EA1F625E922C43B00B9D8225022050086F86B4@APYOKXMS108.ap.sony.com>
 <OSAPR01MB49300F8CA0956F031CA4B1ECC9B80@OSAPR01MB4930.jpnprd01.prod.outlook.com>
 <87v9u8mvlu.fsf@gmail.com>
In-Reply-To: <87v9u8mvlu.fsf@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kento.A.Kobayashi@sony.com; 
x-originating-ip: [211.125.130.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c58e64-e93d-428f-ed49-08d731051e8f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSAPR01MB3604;
x-ms-traffictypediagnostic: OSAPR01MB3604:
x-ld-processed: 66c65d8a-9158-4521-a2d8-664963db48e4,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB36046756F9EDDE124503276CC9B80@OSAPR01MB3604.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(13464003)(25786009)(4326008)(9686003)(3846002)(6116002)(6506007)(102836004)(2501003)(186003)(53546011)(26005)(74316002)(6436002)(55016002)(478600001)(52536014)(86362001)(5660300002)(107886003)(53936002)(6246003)(14454004)(8936002)(316002)(2906002)(66066001)(7736002)(11346002)(446003)(486006)(476003)(81166006)(81156014)(33656002)(99286004)(305945005)(256004)(14444005)(7696005)(76176011)(71190400001)(71200400001)(66946007)(76116006)(66446008)(229853002)(54906003)(110136005)(64756008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB3604;H:OSAPR01MB4930.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dhT1rI4JNdp5jXxAllH9286CEhm4ODDIbN+vMCBErB3jKlsVUKXBc4IeyVNbrXP6tt4oOsEDR6ekpKFXf5r5GtHdy9XSFtZRJGPtEhjqHGDguj9ayDS+cLTJjtwJ1woY/HXBAtf2lR/Jip6elKSctMd+RN7TjFf/qNvP5vnvC+Sf/JhqnpszXuhFLxCnLg5Q2AD3kXxs5aT2sKAmL0qslfYXiAYa55jd/nT4mUW0giOp24koECmsuR6LJbbgLWzY2y//8VvnjwDg7He2Bo1zMDXA/MvwxPn//SpXv3+pi34Q7INWiWCBhwkiHMuyuh/65DAg3sg1sYPX//6swQz0+cfLRkm3MPnFTVUY34dNRLYfpWR2XsJSY2D/xc9mwyyiG/bz/qRXjYG17qjgvgnDC6DSV7ADD6P2lVI6gPDbYWM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c58e64-e93d-428f-ed49-08d731051e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 06:57:15.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QNsH9q23C22/Jy6bH+n9+yQFtsFpbmidWjL++HwKse2X2bOBxh1K1jAPq+Vag98MB2QqNN0NDs10A7WYO5iBgamN0dWmD7kpYU5AIGI4qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Hi,
>>
>> My company's member, Mr.Jacky, sent patch in June 26th.
>> But we didn't receive comment about our patch.
>> Could you confirm and tell us this patch is needed or not?
>
>I can't find the original patch in my inbox, could you resend it using git=
 send-email?
>
>Patch seems necessary, indeed.
>
>best regards
>
>--
>balbi

Thank you for replying.
My company member, Mr.Jacky(Jacky.Cao@sony.com) sent again patch at Sep. 4t=
h 15:48(JST).
So could you confirm?
And in our environment,we can't send mail by git send mail.
So he sent by another mail application.

Regards,
Kento Kobayashi=20

-----Original Message-----
From: Felipe Balbi <balbi@kernel.org>=20
Sent: Wednesday, September 4, 2019 3:20 PM
To: Kobayashi, Kento (Sony) <Kento.A.Kobayashi@sony.com>; gregkh@linuxfound=
ation.org
Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Cao, Jacky <Ja=
cky.Cao@sony.com>
Subject: RE: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode


Hi,

"Kobayashi, Kento (Sony)" <Kento.A.Kobayashi@sony.com> writes:

> Hi,
>
> My company's member, Mr.Jacky, sent patch in June 26th.
> But we didn't receive comment about our patch.
> Could you confirm and tell us this patch is needed or not?

I can't find the original patch in my inbox, could you resend it using git =
send-email?

Patch seems necessary, indeed.

best regards

--
balbi
