Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD49FC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BD42082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QzhmK3rA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfIKLMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:12:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:60104 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbfIKLMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:12:25 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BB9xqG016921;
        Wed, 11 Sep 2019 04:12:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=Sdp5YIcmyxIIoBAbO5HC0bGdKaDTIvgDHrBhvqj7J9k=;
 b=QzhmK3rArPQaeZlLQ8DZGQhskfsHwvFJ6t6XUvpPv5tKE2hTd16dxP68TOI8B6xQSrVX
 yweBuS0I65qmnvyfAnJbFjzLwoOYex2VjIwe3UPXnscgLICg7ew8rLEgemI0lW+8AHF7
 n9QhFIstOU+Mev3lgPtPOr+POw/6ZcHSaLm14H54Jefz9o/X6TXNTLFj6pBXbPd5heNj
 ABiM90QO7gp1fZdSlVji/sUqT5vK6dMA5aKDnErEmUJH0vGI9xmRcjcVDq0bjuLgzAv8
 9Sre13n1TWWW4CG+Rn37605j8lZUzEhQMnn0bzRh4HiSwp8PVBJtwV7V777Q1pvWarRK BQ== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2052.outbound.protection.outlook.com [104.47.33.52])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2uvanh82yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 04:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFYdGNL3BpN8xCneaK6tdJ5AThjMiWgjxr6GPrKp1GW1xGW/zcsMi2B1aI1QpMYcsnnXim33FQMLGPtNPEkdbnbVNrrOEAPAiLckXoeP68LErfqsPaX6nGHGdf6Z17RFz87G0Y3PLttp0JHUe8drOBsVCfpWvXRY3s0IP0uxuZAePgY3azoc4vNVcbtlZ39ZzTcH9+qOFxIP9/PyKJMPpXP6JQkG6SU2eLlre+xY010B/czVOAcxkLHUL4b6G6qyJPY78n/UN36mKMB1/KZqFFQrYZcuk7xjfcw/hxPkUinHznBT8Uvj3EEHKwbJC8fqWdQtanvY+oenBr+JwDmPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sdp5YIcmyxIIoBAbO5HC0bGdKaDTIvgDHrBhvqj7J9k=;
 b=VMRrfoSpErnoPzeUjmsy6HnGpcaQVFCfkU29Au9X6llYO2XM9vmS4CrU+HRqxjR4woWELQRb+UR9YJsf0QbEmcu3OXX7dPFNlkUzJa9TMZPsI/lyKz7a7MYpdWcTBnPJ6SX5z07oWauQaRuHm48kHFtBX7JeSQoy4k/BrlrNHWwLjtllmUiX9WB+ga00ZF1t5p2bM49hJF06Ot/HzLGDIBAomIbiyfw6uLXHJ/70qnoNUwXXBcV1UbqKWm/vhYM1kI6pFaq3UXjheERzFAcKo0ffASi6eYTRrWTWygAOr0hGqjVrJJWLoyxvESub8zRmAIfENZuenF5Ayz9ZQ4Y4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com (52.132.98.38) by
 CY4PR0201MB3475.namprd02.prod.outlook.com (52.132.99.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Wed, 11 Sep 2019 11:12:16 +0000
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737]) by CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737%6]) with mapi id 15.20.2199.027; Wed, 11 Sep 2019
 11:12:16 +0000
From:   Florian Schmidt <florian.schmidt@nutanix.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>
Subject: [PATCH v2 2/2] trace-vmscan-postprocess: fix output table spacing
Thread-Topic: [PATCH v2 2/2] trace-vmscan-postprocess: fix output table
 spacing
Thread-Index: AQHVaJHFMUwz7/YcjE+8L5yKTCQWHw==
Date:   Wed, 11 Sep 2019 11:12:16 +0000
Message-ID: <20190911111146.14799-3-florian.schmidt@nutanix.com>
References: <20190911111146.14799-1-florian.schmidt@nutanix.com>
In-Reply-To: <20190911111146.14799-1-florian.schmidt@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:207:1::19) To CY4PR0201MB3588.namprd02.prod.outlook.com
 (2603:10b6:910:8b::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c218a09-7a2e-469d-4bbc-08d736a8e793
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR0201MB3475;
x-ms-traffictypediagnostic: CY4PR0201MB3475:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0201MB34759DF88F63E408F6779ED0F7B10@CY4PR0201MB3475.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(6512007)(6506007)(386003)(256004)(446003)(44832011)(2616005)(66476007)(81156014)(81166006)(66946007)(64756008)(66446008)(66556008)(14444005)(11346002)(66066001)(476003)(8936002)(50226002)(102836004)(486006)(8676002)(186003)(71200400001)(54906003)(26005)(4326008)(71190400001)(478600001)(107886003)(6436002)(1076003)(316002)(52116002)(36756003)(6486002)(99286004)(5660300002)(305945005)(2906002)(14454004)(76176011)(53936002)(6916009)(25786009)(7736002)(3846002)(6116002)(86362001)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0201MB3475;H:CY4PR0201MB3588.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0MlMtqFAqhwgCdKr1U4odbv2UwzyeYzp5W7qMBtTz2qLrwcSGO+s0sbiQkx2puK4U9Go1XCVpuitjSAdh1nyV8tjZlm0D2+r9g7fms1qqBpB7K5jthTTZJU/SeYGMtg1muCSYaCtYzlVY/Llz7uVVyCk+b2P4UxhW9oKxCn4+1IqhVsJgE0qUhWlU8naGDHXvLDDEJZViDbyD1aujcstnAhlj/EhvuNRUMmFVW1rzbOIeCWNLvffxQaWSwQGKviQXA/mhAzZlvXD0JqfNIY9TvNbJaKUztn3IF7spXQ6E1uKYBtFeVKpYBi6qwu9tqdKNmhQc965cxcLjvbR0BhD2uy1EkzmK+1mGOvZzhCtr7zQHWCs8rzsX7RwVoNVQZQJ6RVD6DXVweFU6rNcXdrZo0+5Grk9EbmmuK36CuibQ8k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c218a09-7a2e-469d-4bbc-08d736a8e793
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 11:12:16.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uGGSR7m/pNg4uqtVAVD1Csl7yxX6k1ZJ6NH00N6RCqOUzCzF6cXNjuCVKfiTPqEJoTnSGkzIv8YXKl3UNgydVT+0VxY6Z5YxWTAzhxMJzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3475
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_07:2019-09-11,2019-09-11 signatures=0
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
dHByb2Nlc3MucGwNCmluZGV4IDZjNGUzZmRlOTQ0Ny4uZmE5ZGU1MWQ1ZjlmIDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi90cmFjZS9wb3N0cHJvY2Vzcy90cmFjZS12bXNjYW4tcG9zdHByb2Nl
c3MucGwNCisrKyBiL0RvY3VtZW50YXRpb24vdHJhY2UvcG9zdHByb2Nlc3MvdHJhY2Utdm1zY2Fu
LXBvc3Rwcm9jZXNzLnBsDQpAQCAtNTc1LDggKzU3NSw4IEBAIHN1YiBkdW1wX3N0YXRzIHsNCiAN
CiAJIyBQcmludCBvdXQga3N3YXBkIGFjdGl2aXR5DQogCXByaW50ZigiXG4iKTsNCi0JcHJpbnRm
KCIlLSIgLiAkbWF4X3N0cmxlbiAuICJzICU4cyAlMTBzICAgJThzICAgJThzICU4cyAlOHNcbiIs
ICJLc3dhcGQiLCAgICJLc3dhcGQiLCAgIk9yZGVyIiwgICAgICJQYWdlcyIsICAgIlBhZ2VzIiwg
ICAiUGFnZXMiLCAgIlBhZ2VzIik7DQotCXByaW50ZigiJS0iIC4gJG1heF9zdHJsZW4gLiAicyAl
OHMgJTEwcyAgICU4cyAgICU4cyAlOHMgJThzXG4iLCAiSW5zdGFuY2UiLCAiV2FrZXVwcyIsICJS
ZS13YWtldXAiLCAiU2Nhbm5lZCIsICJSY2xtZWQiLCAgIlN5bmMtSU8iLCAiQVN5bmMtSU8iKTsN
CisJcHJpbnRmKCIlLSIgLiAkbWF4X3N0cmxlbiAuICJzICU4cyAlMTBzICAgJThzICU4cyAgJThz
ICU4c1xuIiwgIktzd2FwZCIsICAgIktzd2FwZCIsICAiT3JkZXIiLCAgICAgIlBhZ2VzIiwgICAi
UGFnZXMiLCAgICJQYWdlcyIsICAiUGFnZXMiKTsNCisJcHJpbnRmKCIlLSIgLiAkbWF4X3N0cmxl
biAuICJzICU4cyAlMTBzICAgJThzICU4cyAgJThzICU4c1xuIiwgIkluc3RhbmNlIiwgIldha2V1
cHMiLCAiUmUtd2FrZXVwIiwgIlNjYW5uZWQiLCAiUmNsbWVkIiwgICJTeW5jLUlPIiwgIkFTeW5j
LUlPIik7DQogCWZvcmVhY2ggJHByb2Nlc3NfcGlkIChrZXlzICVzdGF0cykgew0KIA0KIAkJaWYg
KCEkc3RhdHN7JHByb2Nlc3NfcGlkfS0+e01NX1ZNU0NBTl9LU1dBUERfV0FLRX0pIHsNCkBAIC01
OTUsNyArNTk1LDcgQEAgc3ViIGR1bXBfc3RhdHMgew0KIAkJJHRvdGFsX2tzd2FwZF93cml0ZXBh
Z2VfZmlsZV9hc3luYyArPSAkc3RhdHN7JHByb2Nlc3NfcGlkfS0+e01NX1ZNU0NBTl9XUklURVBB
R0VfRklMRV9BU1lOQ307DQogCQkkdG90YWxfa3N3YXBkX3dyaXRlcGFnZV9hbm9uX2FzeW5jICs9
ICRzdGF0c3skcHJvY2Vzc19waWR9LT57TU1fVk1TQ0FOX1dSSVRFUEFHRV9BTk9OX0FTWU5DfTsN
CiANCi0JCXByaW50ZigiJS0iIC4gJG1heF9zdHJsZW4gLiAicyAlOGQgJTEwZCAgICU4dSAlOHUg
ICU4aSAlOHUiLA0KKwkJcHJpbnRmKCIlLSIgLiAkbWF4X3N0cmxlbiAuICJzICU4ZCAlMTBkICAg
JTh1ICU4dSAgJThpICU4dSAgICAgICAgICIsDQogCQkJJHByb2Nlc3NfcGlkLA0KIAkJCSRzdGF0
c3skcHJvY2Vzc19waWR9LT57TU1fVk1TQ0FOX0tTV0FQRF9XQUtFfSwNCiAJCQkkc3RhdHN7JHBy
b2Nlc3NfcGlkfS0+e0hJR0hfS1NXQVBEX1JFV0FLRVVQfSwNCi0tIA0KMi4yMy4wDQoNCg==
