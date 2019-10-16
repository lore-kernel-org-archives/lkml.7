Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF52C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDC220872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="bJntLPzZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vGA+4IMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392003AbfJPJjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:39:09 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54282 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbfJPJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:39:09 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G9cv5O013413;
        Wed, 16 Oct 2019 02:38:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=dbu29BT+FjERBf1AFLMXAqVgakO3jLz/dx+DOJ4PaGs=;
 b=bJntLPzZfFHJvl8es8Dla7NVfF2MZDk7aJMEPdNFtiyrVTex9UlJYXpiWGKXzZPZd0tv
 DrieBbjQPRQad8XzZFC9EqRbLviQucK/3OTettl3Nc9z0/bIHAGxzFjUpbU44ZQckEes
 KY56DyTx5CeEkuI39WZt6IBqOJHosXITOqwJOom8PMu6kYmsQ5ib1RQQlj/KDfuEL2Er
 cjqWJUuiKtLybepPNDXDiwEF8n/fYLN1MAcoo35qTFSxqmzJlFaqH+FY1hdTG1kMkLKX
 xWjKRnvYvarrklGisAtRX/kfaW37+jyIu4HP9e76oO3+AJZ+CCu9mcmYlUPVp96juPwP nQ== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2054.outbound.protection.outlook.com [104.47.45.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vkadyehy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 02:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4Vm5Tx0W/nm6QlNvtDPZTGVAPzZtG19lswxvXeU8fxDIWsZ+eOBKObzgxWutTXNrY2aFN5+D5cIy7kEz1cSpEZ0fQyP6rgStwYNvzRT1RRZ/x9PRGVe2vLyRldWk+FKxrkgTsnY4kNk9gsmlwJeOJkuHincotYevIOYiYWKWfm9UNTJlguSaa3FyHBR4qWTTP+r3MlWWPuVy6ckzr6Ue5szOpFkI/edRhldpLkZBgKBax96LTd7RCVVg88mSkfAAif+M0lxs85FDMljFgCj43o7KgPYCwu/TRRM9Ov/T/gCqaZKYXklXGRTaivPLNpD4sPdJ4vxR4LeGDEcJIGOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbu29BT+FjERBf1AFLMXAqVgakO3jLz/dx+DOJ4PaGs=;
 b=GCYCIcsaBD3XzMMTpTergu8mzs/O6VoUd/3yufMx63OqmSAbJF+IDimHXwQuYXowU8KuMOROeIFJstCU2DMBuHe5VQjjIoi6iFUYZ6KBwg4+6LEvexptBTyObeBezClVvqmxedwQtC/CPCENjtz5dYtBAmvI7Cggw1vcGmjIYTz813mvTPayUVfmT3dYq/bjOmFOzQpCtQbC2fik6/xW5E2CPXpEsTY4I94pUOwwlrIYQb0Z3IXAO4dGglDwlmdlClgRnBVpPdWInzMzVYwak/HXTCLZld47AiG/uuzuNybXwf5t8bZmhGnw0xb5S+oou07ms+innMALIKAkgg2jeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbu29BT+FjERBf1AFLMXAqVgakO3jLz/dx+DOJ4PaGs=;
 b=vGA+4IMqhroESyOVz9EBhKce1Nn4t3g2VR/gDOQs3x9sI21W38bebDFDwU5zja2aKxMooPkdzkcC6KY3jwIZTa5MBo7trrltcNY8rYE9Ba2oOIzFQTQYviNe4gNKNZvt3bZ+U2SMtKw9cCpYUDdEJuymxrN7LaAhT2m2ZE45pq4=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5655.namprd07.prod.outlook.com (20.178.0.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 09:38:57 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 09:38:57 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] usb: cdns3: fix cdns3_core_init_role()
Thread-Topic: [PATCH 1/2] usb: cdns3: fix cdns3_core_init_role()
Thread-Index: AQHVfQkEuRq610s5UEaj9CRQS2FO1adctV7AgABWj4CAAACCEA==
Date:   Wed, 16 Oct 2019 09:38:57 +0000
Message-ID: <BYAPR07MB470923F80C4B49D26291B268DD920@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20191007121601.25996-1-rogerq@ti.com>
 <20191007121601.25996-2-rogerq@ti.com>
 <BYAPR07MB470974496C7C59FDE615E5F3DD920@BYAPR07MB4709.namprd07.prod.outlook.com>
 <715c8f74-2790-6546-66ae-c0aea53946ed@ti.com>
In-Reply-To: <715c8f74-2790-6546-66ae-c0aea53946ed@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYzRiYzViZWQtZWZmOC0xMWU5LTg3NGItYTQ0Y2M4YzMwYmQ0XGFtZS10ZXN0XGM0YmM1YmVlLWVmZjgtMTFlOS04NzRiLWE0NGNjOGMzMGJkNGJvZHkudHh0IiBzej0iMzMwMiIgdD0iMTMyMTU2OTIzMzUzNTg2MDQ0IiBoPSJjZFBpUjFUSE9yS0p0aHpWU2YzVUczZWQ3dWc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dbe3584-5477-4a22-bddf-08d7521caac7
x-ms-traffictypediagnostic: BYAPR07MB5655:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB56556FE2BC87E4DBA5BA9075DD920@BYAPR07MB5655.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(36092001)(199004)(189003)(229853002)(3846002)(55016002)(9686003)(446003)(11346002)(6306002)(5660300002)(6116002)(966005)(14454004)(71190400001)(71200400001)(52536014)(478600001)(8936002)(66946007)(186003)(14444005)(2906002)(6436002)(76176011)(64756008)(33656002)(26005)(81166006)(256004)(8676002)(86362001)(74316002)(25786009)(476003)(7736002)(4326008)(6246003)(305945005)(486006)(66556008)(316002)(102836004)(7696005)(54906003)(6506007)(99286004)(110136005)(2501003)(66446008)(2201001)(81156014)(76116006)(66476007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5655;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9GxiGtqsJesIMmx/q4wc2/nV9Tw8HouLQQKw5q5aFNY1XMAc8ugOzZAeTO95FAD6iFarN3hoP859CVZ2tkR7+4xT08jMcX6NhxwTyRpr7BA05sb0fpejBVlKmIKkAurbx0ZXhaWZt6MrwKxOA42e5rKUuotrLIeNLY+m1AiNwNRWrgBlDMbEcVPTWSZCXmhFjqZrDYbOb/aey4qXzSXVKWueO9FsGyEL0q6yJ6D8/oZ7pj8f8giBGVnDVGiHlQFiuUUPlx9guHATKhI02GHUlwl/4c59F9sGNE+BpDvyfJhRYWwnyFfy2s7RDGabQldM2VhE9weKEmrFihqusgDS2URInFs71jlrtsL/XB/DiLQFAcCSgzXifcEsQFVcmg+in+orf7NdvoMULYqv8G6EduNjajdRTK/nyzkdX8gplDZFyNNTcr4E6ILGTtRoQIDaLyj4a6rSUCe7DgkdO7yzw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbe3584-5477-4a22-bddf-08d7521caac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 09:38:57.1404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9W5DlzKu89MdXF/xAqStPNf7WTt90g0lXi+UQrEw56OWwhARWVW+zu9TDDnYoew3ftOht2i0cUBxrqscuMOnF049xA/2aP435f0nRDi+8eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5655
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910160086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPg0KPkhpIFBhd2VsLA0KPg0KPk9uIDE2LzEwLzIwMTkgMDc6MzIsIFBhd2VsIExhc3pjemFr
IHdyb3RlOg0KPj4gSGkgUm9nZXINCj4+DQo+Pj4NCj4+PiBBdCBzdGFydHVwIHdlIHNob3VsZCB0
cmlnZ2VyIHRoZSBIVyBzdGF0ZSBtYWNoaW5lDQo+Pj4gb25seSBpZiBpdCBpcyBPVEcgbW9kZS4g
T3RoZXJ3aXNlIHdlIHNob3VsZCBqdXN0DQo+Pj4gc3RhcnQgdGhlIHJlc3BlY3RpdmUgcm9sZS4N
Cj4+Pg0KPj4+IEluaXRpYWxpemUgaWRsZSByb2xlIGJ5IGRlZmF1bHQuIElmIHdlIGRvbid0IGRv
IHRoaXMgdGhlbg0KPj4+IGNkbnMzX2lkbGVfcm9sZV9zdG9wKCkgaXMgbm90IGNhbGxlZCB3aGVu
IHN3aXRjaGluZyB0bw0KPj4+IGhvc3QvZGV2aWNlIHJvbGUgYW5kIHNvIGxhbmUgc3dpdGNoIG1l
Y2hhbmlzbQ0KPj4+IGRvZXNuJ3Qgd29yay4gVGhpcyByZXN1bHRzIHRvIHN1cGVyLXNwZWVkIGRl
dmljZSBub3Qgd29ya2luZw0KPj4+IGluIG9uZSBvcmllbnRhdGlvbiBpZiBpdCB3YXMgcGx1Z2dl
ZCBiZWZvcmUgZHJpdmVyIHByb2JlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVh
ZHJvcyA8cm9nZXJxQHRpLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBTZWtoYXIgTm9yaSA8bnNl
a2hhckB0aS5jb20+DQo+Pj4gLS0tDQo+Pj4gZHJpdmVycy91c2IvY2RuczMvY29yZS5jIHwgMjAg
KysrKysrKysrKysrKysrKysrKy0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPj4+IGluZGV4IDA2ZjFlMTA1YmU0
ZS4uMTEwOWRjNWE0YzM5IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUu
Yw0KPj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPj4+IEBAIC0xNjAsMTAgKzE2
MCwyOCBAQCBzdGF0aWMgaW50IGNkbnMzX2NvcmVfaW5pdF9yb2xlKHN0cnVjdCBjZG5zMyAqY2Ru
cykNCj4+PiAJaWYgKHJldCkNCj4+PiAJCWdvdG8gZXJyOw0KPj4+DQo+Pj4gLQlpZiAoY2Rucy0+
ZHJfbW9kZSAhPSBVU0JfRFJfTU9ERV9PVEcpIHsNCj4+PiArCS8qIEluaXRpYWxpemUgaWRsZSBy
b2xlIHRvIHN0YXJ0IHdpdGggKi8NCj4+PiArCXJldCA9IGNkbnMzX3JvbGVfc3RhcnQoY2Rucywg
VVNCX1JPTEVfTk9ORSk7DQo+Pj4gKwlpZiAocmV0KQ0KPj4+ICsJCWdvdG8gZXJyOw0KPj4+ICsN
Cj4+PiArCXN3aXRjaCAoY2Rucy0+ZHJfbW9kZSkgew0KPj4+ICsJY2FzZSBVU0JfRFJfTU9ERV9V
TktOT1dOOg0KPj4NCj4+IE9uZSBub3RlIGluIHRoaXMgcGxhY2UuIFVTQl9EUl9NT0RFX1VOS05P
V04gaXMgbm90IHBvc3NpYmxlIGluIHRoaXMgcGxhY2UuDQo+PiBJZiBjZG5zLT5kcl9tb2RlIHdp
bGwgYmUgVVNCX0RSX01PREVfVU5LTk9XTiB0aGVuIGRyaXZlciByZXR1cm5zIC1FSU5WQUwNCj4N
Cj5BdCB3aGljaCBwbGFjZT8gSSBjb3VsZCBub3QgZmluZC4NCg0KSW4gdGhpcyBwYXRjaCB3ZSBj
YW4ndCBzZWUgdGhpcyBsaW5lOg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUu
NC1yYzIvc291cmNlL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYyNMMTU5IA0KVGhlcmUgaXMgY2Fs
bGVkICBjZG5zM19kcmRfdXBkYXRlX21vZGUoY2Rucyk7DQoNCmludCBjZG5zM19kcmRfdXBkYXRl
X21vZGUoc3RydWN0IGNkbnMzICpjZG5zKQ0Kew0KCWludCByZXQgPSAwOw0KDQoJc3dpdGNoIChj
ZG5zLT5kcl9tb2RlKSB7DQoJY2FzZSBVU0JfRFJfTU9ERV9QRVJJUEhFUkFMOg0KCQlyZXQgPSBj
ZG5zM19zZXRfbW9kZShjZG5zLCBVU0JfRFJfTU9ERV9QRVJJUEhFUkFMKTsNCgkJYnJlYWs7DQoJ
Y2FzZSBVU0JfRFJfTU9ERV9IT1NUOg0KCQlyZXQgPSBjZG5zM19zZXRfbW9kZShjZG5zLCBVU0Jf
RFJfTU9ERV9IT1NUKTsNCgkJYnJlYWs7DQoJY2FzZSBVU0JfRFJfTU9ERV9PVEc6DQoJCXJldCA9
IGNkbnMzX2luaXRfb3RnX21vZGUoY2Rucyk7DQoJCWJyZWFrOw0KCWRlZmF1bHQ6DQoJCWRldl9l
cnIoY2Rucy0+ZGV2LCAiVW5zdXBwb3J0ZWQgbW9kZSBvZiBvcGVyYXRpb24gJWRcbiIsDQoJCQlj
ZG5zLT5kcl9tb2RlKTsNCgkJcmV0dXJuIC1FSU5WQUw7DQoJfQ0KDQoJcmV0dXJuIHJldDsNCn0N
Cg0KQWZ0ZXIgY2FsbGluZyBjZG5zM19kcmRfdXBkYXRlX21vZGUgIHdlIGhhdmUgMiBmaXJzdCBs
aW5lcyBmcm9tIHRoaXMgcGF0Y2ggDQoJaWYgKHJldCkNCgkJZ290byBlcnI7DQoNClBhd2VsDQo+
DQo+PiBzb21lIGxpbmUgYmVmb3JlIGFmdGVyIHJldHVybmluZyBmb3JtIGNkbnMzX2RyZF91cGRh
dGVfbW9kZSBhbmQgaW4gY29uc2VxdWVuY2UNCj4+IGl0IGp1bXAgdG8gZXJyIGxhYmVsLg0KPj4N
Cj4+IE1heWJlIGZvciBiZXR0ZXIgcmVhZGFiaWxpdHkgaXQgdGhpcyBjb25kaXRpb24gc2hvdWxk
IGJlIHRyZWF0ZWQgaGVyZSBhbHNvIGFzIGVycm9yLg0KPj4NCj4+PiArCWNhc2UgVVNCX0RSX01P
REVfT1RHOg0KPj4+IAkJcmV0ID0gY2RuczNfaHdfcm9sZV9zd2l0Y2goY2Rucyk7DQo+Pj4gCQlp
ZiAocmV0KQ0KPj4+IAkJCWdvdG8gZXJyOw0KPj4+ICsJCWJyZWFrOw0KPj4+ICsJY2FzZSBVU0Jf
RFJfTU9ERV9QRVJJUEhFUkFMOg0KPj4+ICsJCXJldCA9IGNkbnMzX3JvbGVfc3RhcnQoY2Rucywg
VVNCX1JPTEVfREVWSUNFKTsNCj4+PiArCQlpZiAocmV0KQ0KPj4+ICsJCQlnb3RvIGVycjsNCj4+
PiArCQlicmVhazsNCj4+PiArCWNhc2UgVVNCX0RSX01PREVfSE9TVDoNCj4+PiArCQlyZXQgPSBj
ZG5zM19yb2xlX3N0YXJ0KGNkbnMsIFVTQl9ST0xFX0hPU1QpOw0KPj4+ICsJCWlmIChyZXQpDQo+
Pj4gKwkJCWdvdG8gZXJyOw0KPj4+ICsJCWJyZWFrOw0KPj4+IAl9DQo+Pj4NCj4+PiAJcmV0dXJu
IHJldDsNCj4+DQo+PiBSZXZpZXdlZC1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNl
LmNvbT4NCj4+IFRlc3RlZC1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4N
Cj4+DQo+PiAtLQ0KPj4gUmVnYXJkcywNCj4+IFBhd2VsDQo+Pg0KPg0KPi0tDQo+Y2hlZXJzLA0K
Pi1yb2dlcg0KPlRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIs
IDAwMTgwIEhlbHNpbmtpLg0KPlktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlw
YWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
