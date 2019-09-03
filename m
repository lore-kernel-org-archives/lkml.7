Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69285C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E76233A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="on/HiodS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfICLhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:37:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:23074 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728923AbfICLhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:37:11 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83B9tLw025014;
        Tue, 3 Sep 2019 04:14:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=2eShb8ZVlR1djqEtIBM+AQMVA3y9uR2hZbvS4ztCLHg=;
 b=on/HiodSAcBIsciVgR7gKP8YVp3yT9jvCkZebY0tkqiFvsy+xN8AxmZ60veK++wIpEuf
 AimbeuFr+hHbV8vrw6ma9LWFQnYOEHYHyQ0YpDNJglojcfU3xDWqNbNMEyllsSOVtYtX
 PEEiIXa08cczheNeFlQ8Twj9ihSLA6YQqpzKGkFIvlQfYjys5aW62Vexy1VUKK/yFXak
 h1vJQIf4R1WbwRn3pbGu88ZpM2gQC3ro0zzrtv1ODS5dheTEh9GWkrTr12xWoNN9wTAT
 GLBvHtLBhbbeGpiaobroUwleSUKZb4RRQkWe6senuzv3UWi4SREkyHIaThtNZLHZhz5K qw== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2055.outbound.protection.outlook.com [104.47.34.55])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2uqrexmqu1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 04:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPEYD2dNaiLQ5x9gAUC0JjmEyjygg+QnwsMDlhPnG7CWwmJzx1kkC4U7tGscnsgEx8IylEBn8+Pkfu2NXEoQEfzx1egty4BCZ/Z93VgpwfOmEDzfJiFsjb0+0gapJUMZ+O6CrkU+20bHQqqrTdK7bc35iXJF904eVSKwwfpA/SNzI3E515T6t8Bpy2mjq6+JvOOyjb7uVn6raXb+P4IEAUdssCHjYCOegwsj21V8viTreCUTOAxc0s62HvzYjzrs3oynOqjYfZyvKf45z4sGXMA8smPdYHWwbK6c6pApNwP5Bu60g9BRm/jcxaMIIO0RYkpW95MqJfQLgUgmmPw8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eShb8ZVlR1djqEtIBM+AQMVA3y9uR2hZbvS4ztCLHg=;
 b=Q+0yKo39AtYcy5xXYd/ToMje97sHgyU//SCSQOkFo/Xiw4NDqBfoFgSjGgwq/abq/g6YQSUUkrYQqLIuqLraIdLgvt/7/+EeYYN7NsDThObOhYvHG+udXtXiGITYM48W+ny00mAk0Y+IXHMPvZvui2d3fQzGBsm7Yz9UfvnpBNsr6IUGtfpEjlbbWN2xvuwP90Vhu1S2yaKEXtEwnO5ttQIlppg8zCgq7m79X2SX/DwT8hfxqNAD+1TmOjquGghlt7naSQXLR1Oq7TOyfr/NpTq/ap1xaP4QYmNr43xtH0HHnjDQ2sm8INteKhmV5S68zmddQHsUVgVyzWqp4Sbyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com (52.132.98.38) by
 CY4PR0201MB3409.namprd02.prod.outlook.com (52.132.98.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 3 Sep 2019 11:14:14 +0000
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737]) by CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737%6]) with mapi id 15.20.2199.021; Tue, 3 Sep 2019
 11:14:14 +0000
From:   Florian Schmidt <florian.schmidt@nutanix.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>
Subject: [PATCH 2/2] trace-vmscan-postprocess: fix output table spacing
Thread-Topic: [PATCH 2/2] trace-vmscan-postprocess: fix output table spacing
Thread-Index: AQHVYki4LEg7lvV4zkeKLmneuY6/wg==
Date:   Tue, 3 Sep 2019 11:14:14 +0000
Message-ID: <20190903111342.17731-3-florian.schmidt@nutanix.com>
References: <20190903111342.17731-1-florian.schmidt@nutanix.com>
In-Reply-To: <20190903111342.17731-1-florian.schmidt@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To CY4PR0201MB3588.namprd02.prod.outlook.com
 (2603:10b6:910:8b::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a887a5f-f8bb-4bc6-54a5-08d7305fda69
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR0201MB3409;
x-ms-traffictypediagnostic: CY4PR0201MB3409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0201MB340965937AC7E4BC495C20FCF7B90@CY4PR0201MB3409.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(366004)(376002)(396003)(189003)(199004)(1076003)(36756003)(305945005)(476003)(6512007)(186003)(71190400001)(71200400001)(50226002)(107886003)(81166006)(66066001)(14454004)(52116002)(81156014)(8676002)(86362001)(7736002)(6486002)(54906003)(5660300002)(102836004)(66946007)(3846002)(6116002)(4326008)(66476007)(66556008)(316002)(8936002)(478600001)(76176011)(6916009)(26005)(2906002)(486006)(53936002)(44832011)(25786009)(446003)(6506007)(386003)(11346002)(64756008)(99286004)(2616005)(14444005)(256004)(6436002)(66446008)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0201MB3409;H:CY4PR0201MB3588.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /NtxLahfv5WOPbaoTJ56KEaBjTpy7PdQv9V8GspgXl55vh4JFYH49CwuP1KGl850za7K/oX6B44UsfiAdfLVy+uDeR5Lo+EfLRbNKGlseedlSzZQkm9KUc5lOiY75TksQwP/nFsCrKKC72RVSgOTNKAP5oCy8grO4x5MIDA/twlL8buCdVx4GI4e97FabfQKj6iUxzeIYW/2w5v80+jQbTKinVDk4I+17fbHItoBlbXhiE7lwReMss97JFK92I2CRHwdtohg25M5OIHc9R3dyiminEMJNwry1FTooQofvn0rDvveCSHoHGJCoYp4TaAsQVWgTL7W6ZmBKXARypIRWapuBDfujPxW84DJp4Gw0XBTkOPLk0GFNDV0AplRQjyVNelFt3KXNWF1vzLV5Rez9uswvVYUYAE9joWoqbqMyLQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a887a5f-f8bb-4bc6-54a5-08d7305fda69
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 11:14:14.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfyo57Mvz5ovwKCQxQv8GLkoHJCGoKsxzw29YA0vV+gWFRKcCZpJDwvDZxzeudfK1VgzM1YHCvsaJm2Y+zTq+WIbwuFkgLNJQL+O9Z3/nkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3409
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHNwYWNpbmcgc28gdGhhdCBib3RoIHRoZSBoZWFkZXJzIGluIHRoZW1zZWx2ZXMsIGFzIHdl
bGwgYXMgdGhlDQpvdXRwdXQgb2YgdGhlIHR3byB0YWJsZXMgcmVsYXRlZCB0byBlYWNoIG90aGVy
LCBhcmUgcHJvcGVybHkgYWxpZ25lZC4NCg0KU2lnbmVkLW9mZi1ieTogRmxvcmlhbiBTY2htaWR0
IDxmbG9yaWFuLnNjaG1pZHRAbnV0YW5peC5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL3RyYWNl
L3Bvc3Rwcm9jZXNzL3RyYWNlLXZtc2Nhbi1wb3N0cHJvY2Vzcy5wbCB8IDYgKysrLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vdHJhY2UvcG9zdHByb2Nlc3MvdHJhY2Utdm1zY2FuLXBvc3Rwcm9j
ZXNzLnBsIGIvRG9jdW1lbnRhdGlvbi90cmFjZS9wb3N0cHJvY2Vzcy90cmFjZS12bXNjYW4tcG9z
dHByb2Nlc3MucGwNCmluZGV4IDZjNGUzZmRlOTQ0Ny4uNWE1ZDcwMDI5YzQxIDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi90cmFjZS9wb3N0cHJvY2Vzcy90cmFjZS12bXNjYW4tcG9zdHByb2Nl
c3MucGwNCisrKyBiL0RvY3VtZW50YXRpb24vdHJhY2UvcG9zdHByb2Nlc3MvdHJhY2Utdm1zY2Fu
LXBvc3Rwcm9jZXNzLnBsDQpAQCAtNTc1LDggKzU3NSw4IEBAIHN1YiBkdW1wX3N0YXRzIHsNCiAN
CiAJIyBQcmludCBvdXQga3N3YXBkIGFjdGl2aXR5DQogCXByaW50ZigiXG4iKTsNCi0JcHJpbnRm
KCIlLSIgLiAkbWF4X3N0cmxlbiAuICJzICU4cyAlMTBzICAgJThzICAgJThzICU4cyAlOHNcbiIs
ICJLc3dhcGQiLCAgICJLc3dhcGQiLCAgIk9yZGVyIiwgICAgICJQYWdlcyIsICAgIlBhZ2VzIiwg
ICAiUGFnZXMiLCAgIlBhZ2VzIik7DQotCXByaW50ZigiJS0iIC4gJG1heF9zdHJsZW4gLiAicyAl
OHMgJTEwcyAgICU4cyAgICU4cyAlOHMgJThzXG4iLCAiSW5zdGFuY2UiLCAiV2FrZXVwcyIsICJS
ZS13YWtldXAiLCAiU2Nhbm5lZCIsICJSY2xtZWQiLCAgIlN5bmMtSU8iLCAiQVN5bmMtSU8iKTsN
CisJcHJpbnRmKCIlLSIgLiAkbWF4X3N0cmxlbiAuICJzICU4cyAlMTBzICAgJThzICAlOHMgJThz
ICU4c1xuIiwgIktzd2FwZCIsICAgIktzd2FwZCIsICAiT3JkZXIiLCAgICAgIlBhZ2VzIiwgICAi
UGFnZXMiLCAgICJQYWdlcyIsICAiUGFnZXMiKTsNCisJcHJpbnRmKCIlLSIgLiAkbWF4X3N0cmxl
biAuICJzICU4cyAlMTBzICAgJThzICAlOHMgJThzICU4c1xuIiwgIkluc3RhbmNlIiwgIldha2V1
cHMiLCAiUmUtd2FrZXVwIiwgIlNjYW5uZWQiLCAiUmNsbWVkIiwgICJTeW5jLUlPIiwgIkFTeW5j
LUlPIik7DQogCWZvcmVhY2ggJHByb2Nlc3NfcGlkIChrZXlzICVzdGF0cykgew0KIA0KIAkJaWYg
KCEkc3RhdHN7JHByb2Nlc3NfcGlkfS0+e01NX1ZNU0NBTl9LU1dBUERfV0FLRX0pIHsNCkBAIC01
OTUsNyArNTk1LDcgQEAgc3ViIGR1bXBfc3RhdHMgew0KIAkJJHRvdGFsX2tzd2FwZF93cml0ZXBh
Z2VfZmlsZV9hc3luYyArPSAkc3RhdHN7JHByb2Nlc3NfcGlkfS0+e01NX1ZNU0NBTl9XUklURVBB
R0VfRklMRV9BU1lOQ307DQogCQkkdG90YWxfa3N3YXBkX3dyaXRlcGFnZV9hbm9uX2FzeW5jICs9
ICRzdGF0c3skcHJvY2Vzc19waWR9LT57TU1fVk1TQ0FOX1dSSVRFUEFHRV9BTk9OX0FTWU5DfTsN
CiANCi0JCXByaW50ZigiJS0iIC4gJG1heF9zdHJsZW4gLiAicyAlOGQgJTEwZCAgICU4dSAlOHUg
ICU4aSAlOHUiLA0KKwkJcHJpbnRmKCIlLSIgLiAkbWF4X3N0cmxlbiAuICJzICU4ZCAlMTBkICAl
OHUgICAlOHUgJThpICU4dSAgICAgICAgICIsDQogCQkJJHByb2Nlc3NfcGlkLA0KIAkJCSRzdGF0
c3skcHJvY2Vzc19waWR9LT57TU1fVk1TQ0FOX0tTV0FQRF9XQUtFfSwNCiAJCQkkc3RhdHN7JHBy
b2Nlc3NfcGlkfS0+e0hJR0hfS1NXQVBEX1JFV0FLRVVQfSwNCi0tIA0KMi4yMy4wLnJjMQ0KDQo=
