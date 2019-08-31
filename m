Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABCCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F64A22D6D
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="eY/cvJkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfHaP33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:29:29 -0400
Received: from mail-eopbgr780133.outbound.protection.outlook.com ([40.107.78.133]:25504
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbfHaP33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKZUffk55mXxFeWNtOfbagtb7Jsxp8spVJcdNGreZDpjBMQyqtSbOisuY3/zvwIux8Fh/jvGKhInhoiMWmeUFWCttAS9uHIjWPY3xa0+5Xq8tNBCqeNJatgDRNGKAmu5G7X9PE/rVvUkTB29t/gaP4s+CvaCbmKFy53FQqaDr++5WMmR5K0Jvgu/UwbLRbMKCxZIbY8eh7BurPfbyeUaUUL0EiCPMj1ov2bG+zxZmEOQHzxI0L6bt7qxpMLNINgYlRfM5g43mro6brLoJfRljgpBkqBXTB8AtGqgJ5nVin4IuCnAj+Il66il/oxYaQ/f61lLFW7Z5a2HbeHQaXftug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYWK8bdzhApNKmWetQUwNAxxhMneGrP1n4JLyuQfN9M=;
 b=T5bd5SS51lOGp5gdl1VKIoqf5+axCPexekxXAxmpHe11QIKbq/xW65vG0yEWNSZvl1q7ULs2GgKUwhMSTFoA2Xw8CShb1INN+ndMPQ9KM7k56vUSRh7OwxNsIEs+mN87r+L+KAIS8vDSZvOJoerReFnoli750h8cCtkM4sUUIK9oOZaLPhoWeNE4xSK+DY3F64Y1RsO3xzZkYOYDDKE4BjPTo/gxSauu4VGA0bftXLl+CbgBsGMfjRRRX6oi9zHlNgEHZd7odQInvPMvGFLO1zhCFb0vIeUXc2o/zZ1iUbFfrtgFRygEK/ifpldD+P05OCiUNlOjFw72LYqE7PqMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYWK8bdzhApNKmWetQUwNAxxhMneGrP1n4JLyuQfN9M=;
 b=eY/cvJkR3nXlCRVpoC60YTUBKmfryJiWqKVls7IRKvNG4WBw+Jh8Tm857jDJqsjGfn0Gky/L637MHY5h60Hr2sChEUJpTywT2mm0cU/rHC4CdSRHSgDQkMDQZLRhGFIqfxbAw4/dZvGyIigCrKwAvXfYYEzC1K50TQuVQPS1QxY=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2345.namprd11.prod.outlook.com (10.173.172.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 31 Aug 2019 15:29:22 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::101c:56a0:673b:6410]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::101c:56a0:673b:6410%6]) with mapi id 15.20.2199.021; Sat, 31 Aug 2019
 15:29:22 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: intel-spi: add support for Intel Cannon
 Lake SPI flash
Thread-Topic: [PATCH 2/2] mtd: spi-nor: intel-spi: add support for Intel
 Cannon Lake SPI flash
Thread-Index: AQHVX8ABRdU28yqEZUSYr3dEEhcW0acVQqAAgAAfk4A=
Date:   Sat, 31 Aug 2019 15:29:21 +0000
Message-ID: <74545c4c-a9fc-77c8-cb54-6fbf747f0eea@fortanix.com>
References: <6cc18e41-82a6-942b-6d91-6297f73a33da@fortanix.com>
 <20190831133616.GQ3177@lahna.fi.intel.com>
In-Reply-To: <20190831133616.GQ3177@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:a03:117::19) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [76.236.28.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b62da9fc-d6a8-40e3-a91c-08d72e27ff21
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(49563074)(7193020);SRVR:DM5PR1101MB2345;
x-ms-traffictypediagnostic: DM5PR1101MB2345:
x-microsoft-antispam-prvs: <DM5PR1101MB234522EFFCD56CF58C45D2F1AABC0@DM5PR1101MB2345.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39830400003)(366004)(189003)(199004)(52116002)(102836004)(8676002)(76176011)(14454004)(2906002)(186003)(36756003)(305945005)(229853002)(6486002)(966005)(99286004)(486006)(5660300002)(3846002)(6116002)(4744005)(508600001)(99936001)(25786009)(6436002)(316002)(7736002)(6916009)(71200400001)(71190400001)(8936002)(66616009)(66946007)(53546011)(31696002)(66066001)(66476007)(7416002)(64756008)(26005)(66556008)(66446008)(4326008)(53936002)(54906003)(476003)(31686004)(256004)(2616005)(6246003)(6506007)(446003)(386003)(6512007)(81166006)(81156014)(86362001)(11346002)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2345;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y4GfR9/K0fz4tTBoufovE7kj9w52uyqQBrvba3p9nhKd5x4Mnk+TbIFmXzJVnRuXCam/tZ4Zkf8d/GojQ3iwirOH+ChQGrwM98vVLrRmG27ZBNiWFcj+lAGFVYPERKtFqoxyIMNfu8SitsyDwIBSIPl/mMZlDU23POPe6c0mzTq5RdwQQO++5OefMWp/g1+3ansGuqpAwcRMnY1MJTmxXNeZrMl3HX2s01foVd2B+9dgFripXgod0uczFDF1z3AG5q4Y5EJ5ShgjPLPvRNlYhsy1Mf7t6Ag9vuKB4shOxil4JCPuLj8lvHENd+j359txqpJCmLaIC52Yibp4e5z7aBhikV1a5CDyzZav9ppHXBnP3o9AgG17pB8IBW37cIU4iogEsRqPJLq70L9xVs1YcUccyQgdUpxSUelNl/oW1cU=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050204080808080401050302"
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62da9fc-d6a8-40e3-a91c-08d72e27ff21
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 15:29:22.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzd1uCdvyzOLiDU8VePtK/EQbhsJtZXUKUriMjVI21JCVufDlfqRdIWmvLvL65EEFtBij6v6MtuFV9SP00NQFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2345
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms050204080808080401050302
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-08-31 06:36, Mika Westerberg wrote:
> Looks like some white space damage. There are couple of similar below a=
s
> well.

Oops. I will fix this in a v2 or resend later.

>> +		ispi->sregs =3D NULL;
>> +		ispi->pregs =3D ispi->base + CNL_PR;
>> +		ispi->nregions =3D CNL_FREG_NUM;
>> +		ispi->pr_num =3D CNL_PR_NUM;
>=20
> Does CNL really have a different number of PR and FR regions than the
> previous generations?

I'm using this as a reference:=20
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/3=
00-series-chipset-pch-datasheet-vol-2.pdf=20
=2E If you have more accurate information, please let me know.

--
Jethro Beekman | Fortanix


--------------ms050204080808080401050302
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Cx8wggUxMIIEGaADAgECAhBdZC9mIseKJlmxx1xn+g00MA0GCSqGSIb3DQEBCwUAMIGXMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xODA5MTUwMDAw
MDBaFw0xOTA5MTUyMzU5NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2pldGhyb0Bmb3J0YW5peC5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDRQDOQsroKjy2xAQCXLyqryJt4
Xwj8hcweJCzOnjILKHIoWlOQ0b9yIbFLIWBRt/9zdxlE5ZabDVHnkIyhcVgtU/BA73e78Wx2
LOObdg0wfs9U2CVRYhz2EPHFjGvkYKihItt69ye91hj1w7RKCrYC8KZGSZ/+sbkJzQdXVy32
lxmiNEt17GNRebpkJCaFnznd6C2a8tBAS2Fa/UNyFdEs4eoRoYSKswclRhbe81aVhqY2hjcd
O6puyyaYp5hkmau2UPih6OpRSOhbe6Tuebceg1yvumoVX3OZtGPS1VdQ+p0bxB0RE6gNs140
ZKUhrvAJDETuGaaQD4A2/6ksLunjAgMBAAGjggHpMIIB5TAfBgNVHSMEGDAWgBSCr2yM+MX+
lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUsFUcmGtaJBU7/52LyTYHC/M+LscwDgYDVR0PAQH/
BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEBAwUC
MBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsG
AQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBL
hklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlv
bmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0
dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNv
bTAeBgNVHREEFzAVgRNqZXRocm9AZm9ydGFuaXguY29tMA0GCSqGSIb3DQEBCwUAA4IBAQB6
v3tFEUSGv9+yY4wUjvcMyz3126nJrX5LkfEvrnCEpEiImECuoYvxOYNLYYynell7BQGtTaZg
shMfDvwpy2isoi3w1AWAfbn6npnSKLzu0BMRvcCPWY8VPmePPizTqXoPkLwgTJfSaWkxMP1u
rfL9S5NeRdkjwjHklX5IWuwwDu1hsKVZrxSSY2unCtvq67UHWz+z6rG1JQrP2YDfb98xun3y
eLBNe/LFBNnGISbkT5q6D+e5c0bgzoH9nH4bsw3t8aDqJTfT3BqQdWr4pF05ODzzeOmEqeYE
qGlD9hIL2AbmTZLjunAnARr6Fv7Sfqt23ptsGkmoZ9ZQNjT3TlwvMIIF5jCCA86gAwIBAgIQ
apvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNV
BAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09N
T0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UE
ChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9
NEjk6vW7rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+Ul
NEQ1/5ErCsHq9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2
qvGlnHJvijjI03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZ
jrqck39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMBAAGj
ggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNVHQ4EFgQUgq9s
jPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAw
EQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29tb2Rv
Y2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEB
BGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRk
VHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkq
hkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+js
QgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDcZoFD
7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwpWZT89RY0wpJO
+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI4ZNMUH4Tam85S1j6
E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade2022O/tUU1gb4jfWCcyvB8czm12F
gX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiO
SEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz
/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSa
m9V1niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpO
UvxhcsjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIxggQ1MIIEMQIBATCB
rDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9E
TyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEF1kL2Yi
x4omWbHHXGf6DTQwDQYJYIZIAWUDBAIBBQCgggJZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDgzMTE1MjkxN1owLwYJKoZIhvcNAQkEMSIEIKAcrUP+
Bg7G+X3goGdc36740mLfi2rIHskfUfCzmvQkMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgb0GCSsGAQQBgjcQBDGBrzCBrDCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEF1kL2Yix4omWbHH
XGf6DTQwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8g
Q0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24g
YW5kIFNlY3VyZSBFbWFpbCBDQQIQXWQvZiLHiiZZscdcZ/oNNDANBgkqhkiG9w0BAQEFAASC
AQAFm4V+Fi5xt8LfitbvDyhONqauF7ARcq6FGawYNApBLmC9k96hvDVkNdPxt2bmRMhxBfDC
cyHfIlhJazxpMqr+wZHcT6UTQjM5f4nBqgi2NkUPLNkRz9AOMBoyxZT2Sdsu3ZKv6UI4wk+J
6hrQMVjObTU460GENOUDokBxXWa9QxpjWfyezsV4GHHX4z8I5O8LvyBCvdXrXiEVj+gRSuz2
sQVCn/UGXrPOs/BQiVVjaiITGabhytYWhkHtb06yObEA7d2k52EGiqHcrVy2kCVOPz2gPva3
I03ALcZXM22hR5l7urnUaVyoFPW7E6dsDKrCLU/z7H/9UCy6vPp6LfCmAAAAAAAA

--------------ms050204080808080401050302--
