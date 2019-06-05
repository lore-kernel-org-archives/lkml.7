Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DCCC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEC22083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=unisys.com header.i=@unisys.com header.b="Rmb+UkWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfFEPwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:52:04 -0400
Received: from mail-eopbgr680074.outbound.protection.outlook.com ([40.107.68.74]:22499
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfFEPwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisys.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hOWp3oMXy65bHNjkhFaDRAfoDq0D8/IpbifcYW9zcU=;
 b=Rmb+UkWoNuSRaRexoQ/JgOBdVYQ7m0SNtr6A81JwCX05ciMsR1cBGU4HOZb91DT0tUoD0sn/4weiK+BOo5LUZkauwIjyF/8tDt9C47F5zcm1PaIMbf6cY7nRJYro4XQuPmnFq3n9x7TOx98iCu1Lma+mIcV9gYPnFs/hLDqwWKQ=
Received: from SN6PR07MB5518.namprd07.prod.outlook.com (20.177.250.12) by
 SN6PR07MB5518.namprd07.prod.outlook.com (20.177.250.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 15:51:54 +0000
Received: from SN6PR07MB5518.namprd07.prod.outlook.com
 ([fe80::fde7:5570:f162:def7]) by SN6PR07MB5518.namprd07.prod.outlook.com
 ([fe80::fde7:5570:f162:def7%7]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 15:51:54 +0000
From:   "Kershner, David A" <David.Kershner@unisys.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andreas Noever <andreas.noever@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Corey Minyard <minyard@acm.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Jamet <michael.jamet@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: RE: [PATCH 02/13] bus_find_device: Unify the match callback with
 class_find_device
Thread-Topic: [PATCH 02/13] bus_find_device: Unify the match callback with
 class_find_device
Thread-Index: AQHVG7Fem7RuLFrJ8kKXV5f02CM+1KaNNUqA
Date:   Wed, 5 Jun 2019 15:51:53 +0000
Message-ID: <SN6PR07MB5518CE33467B6E8FF2B77487F0160@SN6PR07MB5518.namprd07.prod.outlook.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-3-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559747630-28065-3-git-send-email-suzuki.poulose@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Kershner@unisys.com; 
x-originating-ip: [192.59.148.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a6b8724-c2cc-4536-6ad0-08d6e9cdbb6f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(49563074)(7193020);SRVR:SN6PR07MB5518;
x-ms-traffictypediagnostic: SN6PR07MB5518:
x-microsoft-antispam-prvs: <SN6PR07MB5518031AAF5DFA99F536E972F0160@SN6PR07MB5518.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(13464003)(189003)(4326008)(6506007)(33656002)(229853002)(76116006)(76176011)(66946007)(5660300002)(66556008)(64756008)(66446008)(7696005)(2501003)(66616009)(102836004)(55016002)(73956011)(6246003)(52536014)(25786009)(9686003)(53936002)(66476007)(66066001)(7416002)(72206003)(26005)(99936001)(316002)(2906002)(14454004)(7406005)(446003)(54906003)(6436002)(110136005)(8936002)(81156014)(7736002)(68736007)(6116002)(81166006)(305945005)(74316002)(14444005)(478600001)(71190400001)(71200400001)(486006)(11346002)(256004)(476003)(86362001)(186003)(99286004)(8676002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5518;H:SN6PR07MB5518.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: unisys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CEGibdNmoDYt7XuDKiAODe7xTXFFA9Exl6Z7m2KRSe5OvScuaRvnN6Ln0pksZSaobs2A5zSidYs9rZkX1T5ZBvrw3ncpnEAy8ydRYun4RvTr3MGatI5/EbmgibACsIsdLRjozMOjZ/YlBzBHxP3dvE+R2gljde7eBmO6xdPdqhRzZ7YuOc7CU2SltmSJLjSBOgdAxULLqdGfzOf5wkz9qdmOf+vnBM5RpGG6Fh/wu0qByKVl/m3r8AyoP1cQAeu4au7KhVzDECVZddlnLrkXxorc9pV5BHJ0c2TBcS4hV4aM49CLQMb3ZtaEp2BYuuiiSUZwHVb2KzFJylv/WWkqkSJaXR8eT6AyPkFcDLmU4LNnEcaWcIm+Srf/xiq7VYqmiZS3rqJgKVsQjAPXPeqCbBCPXJ8bPfbOiFfET2P0ogw=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_0018_01D51B95.10A762E0"
MIME-Version: 1.0
X-OriginatorOrg: unisys.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6b8724-c2cc-4536-6ad0-08d6e9cdbb6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 15:51:53.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8d894c2b-238f-490b-8dd1-d93898c5bf83
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: David.Kershner@unisys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0018_01D51B95.10A762E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Suzuki K Poulose [mailto:suzuki.poulose@arm.com]
> Subject: [PATCH 02/13] bus_find_device: Unify the match callback with
> class_find_device
> 
> There is an arbitrary difference between the prototypes of
> bus_find_device() and class_find_device() preventing their callers
> from passing the same pair of data and match() arguments to both of
> them, which is the const qualifier used in the prototype of
> class_find_device().  If that qualifier is also used in the
> bus_find_device() prototype, it will be possible to pass the same
> match() callback function to both bus_find_device() and
> class_find_device(), which will allow some optimizations to be made in
> order to avoid code duplication going forward.  Also with that, constify
> the "data" parameter as it is passed as a const to the match function.
> 
> For this reason, change the prototype of bus_find_device() to match
> the prototype of class_find_device() and adjust its callers to use the
> const qualifier in accordance with the new prototype of it.
> 

Visorbus portion looks ok.

Acked-by: David Kershner <david.kershner@unisys.com>

------=_NextPart_000_0018_01D51B95.10A762E0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCGuUw
ggSRMIIDeaADAgECAgRFa1BUMA0GCSqGSIb3DQEBBQUAMIGwMQswCQYDVQQGEwJVUzEWMBQGA1UE
ChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBv
cmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykgMjAwNiBFbnRydXN0LCBJbmMuMS0wKwYD
VQQDEyRFbnRydXN0IFJvb3QgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMDYxMTI3MjAyMzQy
WhcNMjYxMTI3MjA1MzQyWjCBsDELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4x
OTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5j
ZTEfMB0GA1UECxMWKGMpIDIwMDYgRW50cnVzdCwgSW5jLjEtMCsGA1UEAxMkRW50cnVzdCBSb290
IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpW2Q0L6xm0qb0jflEw5VwXuw3kRQWg27ez+mgGPoTgo/PcQRmYuTR4asRpOxtHAlYiwyf8xizMD
27eDez4ghF7tslYop/jguUBxN8XLRw6XKmjAIpViFdtH2fXQK/+CS8mtPt5M25CAUD8JioQA7DAK
PRjN+/0qWZojlRcsRZ4fbkN5bQxcmP5Ip8UjR1xe/W7nHrT2aEXRhoNbooqNseMpgP4lcYitvryP
rFKWS6pRjeQTMRnoTk2f26yzatW8OVRxynp6f5DdfR2A2YG7WSbCEf7mk+L3gORl+zQ3DimAcE2v
OIYunn9Xr54XruscyyghX7Yc2OeiBCL509rYywIDAQABo4GwMIGtMA4GA1UdDwEB/wQEAwIBBjAP
BgNVHRMBAf8EBTADAQH/MCsGA1UdEAQkMCKADzIwMDYxMTI3MjAyMzQyWoEPMjAyNjExMjcyMDUz
NDJaMB8GA1UdIwQYMBaAFGiQ5GekplOAx4ZmpPH3S0P7hL1tMB0GA1UdDgQWBBRokORnpKZTgMeG
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
HePi14Pa65WvLE4DTCRihFoKl3ZLNyJKdewueFVusBiGhq9k20pSNWlHOW73SpASCPrknlnhl8AJ
tJX7YE/B6HvYZSI9g9zrV+T6A9mwC4t9CvteHd9LmzeCkSsOhmSmip9XHyZg0M2CAk5Ao8Ij0W1L
1HV6U1GR5Cyq5kZqyD0Ym03/exeFGlVTxRacXe/q2P8s+aG2rRORieMf+fXELwCVoKkZb5ZoQoMp
3itxylQ4KXa3OWRqVKn7vA0x3BEMFbL6cIlaXD0sgruHUMPUzn7iHdbCuhJIZsyST3WkGYCXbp75
oyRe7L2Q8ZgAoIkd7jy2HpN0DwIDAQABo4IB7jCCAeowPgYJKwYBBAGCNxUHBDEwLwYnKwYBBAGC
NxUIh4TCFoO2tSmDmZkIhI2WLoGroiUxu97dEoSOvJATAgFkAgEUMBMGA1UdJQQMMAoGCCsGAQUF
BwMEMA4GA1UdDwEB/wQEAwIGwDBEBgNVHSAEPTA7MDkGCmCGSAGG/TABAQIwKzApBggrBgEFBQcC
ARYdaHR0cDovL3Vpc3BraS51bmlzeXMuY29tL3JlcC8wGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEF
BQcDBDAkBgNVHREEHTAbgRlEYXZpZC5LZXJzaG5lckB1bmlzeXMuY29tMB0GA1UdDgQWBBRGu21c
Q7Be8Y6HPQZA05Is3tm0JDAfBgNVHSMEGDAWgBTWbCYj2kRZguy25ImUbfD0PXKEVTBBBgNVHR8E
OjA4MDagNKAyhjBodHRwOi8vdWlzcGtpLnVuaXN5cy5jb20vcmVwL1VJUy1Jc3VCMS1DQSg3KS5j
cmwwdwYIKwYBBQUHAQEEazBpMDwGCCsGAQUFBzAChjBodHRwOi8vdWlzcGtpLnVuaXN5cy5jb20v
cmVwL1VJUy1Jc3VCMS1DQSg3KS5jcnQwKQYIKwYBBQUHMAGGHWh0dHA6Ly9wZWNzMS51bmlzeXMu
Y29tL29jc3AvMA0GCSqGSIb3DQEBCwUAA4IBAQCrhpe3H6DUJPqq1KJInpSe9V4AHaDR8dpNa9KO
e6LBDVjViBnNdzjfKtbVtqj3ZtU0faGP4qTEj8IL3bDAgP5ZyxoR5GNVZUaq/dKiH2KhtqWrn63Y
2fT75L2CIKvdqtI3FamnblrUNnE5iTTrDpesdKDkQXNlboE8V0mTGtKSHZnhNA9Hd5+w+nIC2Oee
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
L2h0dHA6Ly91aXNwa2kudW5pc3lzLmNvbS9yZXAvVUlTLUludEItQ0EoNikuY3Jshi9odHRwOi8v
cGtpcmVwLnVuaXN5cy5jb20vcmVwL1VJUy1JbnRCLUNBKDYpLmNybDCBtQYIKwYBBQUHAQEEgagw
gaUwOwYIKwYBBQUHMAKGL2h0dHA6Ly91aXNwa2kudW5pc3lzLmNvbS9yZXAvVUlTLUludEItQ0Eo
NikuY3J0MDsGCCsGAQUFBzAChi9odHRwOi8vcGtpcmVwLnVuaXN5cy5jb20vcmVwL1VJUy1JbnRC
LUNBKDYpLmNydDApBggrBgEFBQcwAYYdaHR0cDovL3BlY3MxLnVuaXN5cy5jb20vb2NzcC8wDQYJ
KoZIhvcNAQELBQADggEBAFiKh/3t8akpFyrh0BEuOS3CjrwhIi1P+NMGulv/I1VjQVJ6Qx9rpEsT
rFZa1w/TJ8CvhZJ+uVk74A02E1lKEdH/5UMa0jf4NEUb5tu+jvsxNxMVOLcu7vMyyI7HqIHIoMgj
ZD6p5RD2SbGGRjsUTOiteOQnG1dv7c0dq+Mln8Vex1vJ30BHLF1Q5WNYp3yGN7u5nH+rkwf951aw
Kk+hVXfRWUz/lYRoY6q/YIyLHzbzxiXheehVrSc+zjwBUE53I79BXDB7EPJOO+LwbdPSHQxGOtR0
pijjQeclqAlC6L6sALrxbUGlKnhbE22STJU2UuJ5C3K5LNAWVY/eMDF5uhMxggOjMIIDnwIBATBw
MFkxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZ1bmlzeXMxEzARBgoJkiaJ
k/IsZAEZFgN1aXMxFTATBgNVBAMTDFVJUy1Jc3VCMS1DQQITOQAK/cJqXR9VUmH4PAAHAAr9wjAN
BglghkgBZQMEAgEFAKCCAgQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMTkwNjA1MTU1MTUyWjAvBgkqhkiG9w0BCQQxIgQgNDLMXF2Lb5Woq3fwJF9I8cYBM5aleN36
xbSkbSKJvckwfwYJKwYBBAGCNxAEMXIwcDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZIm
iZPyLGQBGRYGdW5pc3lzMRMwEQYKCZImiZPyLGQBGRYDdWlzMRUwEwYDVQQDEwxVSVMtSXN1QjEt
Q0ECEzkAEPGBOCqIGBEHtBAABwAQ8YEwgYEGCyqGSIb3DQEJEAILMXKgcDBZMRMwEQYKCZImiZPy
LGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGdW5pc3lzMRMwEQYKCZImiZPyLGQBGRYDdWlzMRUw
EwYDVQQDEwxVSVMtSXN1QjEtQ0ECEzkAEPGBOCqIGBEHtBAABwAQ8YEwgZMGCSqGSIb3DQEJDzGB
hTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzAL
BglghkgBZQMEAgIwBwYFKw4DAhowDQYJKoZIhvcNAQEBBQAEggEABeOQtrwo+5I2zCpp4SVCLpKE
MbrXpUtGNmZb7xX9YkOmf0CEXdFlP7aLsAFP4tYKXmJE1nkUxV6izS+854Bjm1eIohUVUdSsGk70
ySUQX+sooPVwR6JGFuNLlrpDUfZr2WZpbUoB8VTpzW9okcRR8Ku+02JgY5IT8QJBPshe3nrJVXl8
SebyeUx6V3r8RFoH2fHp/U7BNaXOrXvFefVgK+QNlxd2i7m+DjtOqnIZD6pYGMpKB8AZfHm5r7Am
fcBUBFm57Bu6QSohyKyW/RUFiRbpCDonKGh3zGYY2ZPHd/GZNt3X3XGQpusbZRSc+NMbyvCjgaOt
5Hrbgy5UFuusVwAAAAAAAA==

------=_NextPart_000_0018_01D51B95.10A762E0--
